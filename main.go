package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net"
	"os"
	"strings"
	"time"
)

type ConnectionRequest struct {
	Log        *Logger `json:"-"`
	Client     string  `json:"client"`
	ClientAddr string  `json:"client_address"`
	Version    string  `json:"version"`
	Username   string  `json:"username"`
	TargetHost string  `json:"target_host"`
}

type ConnectionRequestReply struct {
	Host   string `json:"host"`
	Port   int    `json:"port"`
	Failed string `json:"failed"`
}

type Init func(net.Conn)
type Approved func(net.Conn, Init, string, string, string)
type Denied func(net.Conn, string)
type Timeout func(net.Conn)

var redisClient *RedisClient
var log *Logger
var prismId string

func handleConnection(c net.Conn) {
	r := NewMcReader(c)
	header, err := r.Header()
	if err != nil {
		log.Error(err, map[string]interface{}{
			"event": "header read failed",
		})
	}

	if header == 0xFE {
		handleServerPing(c)
	} else if header == 0x02 {
		if !maintenanceMode(c) {
			handleLogin(c)
		}
	}
}

func maintenanceMode(c net.Conn) bool {
	msg := redisClient.GetMaintenenceMsg()
	if msg == "" {
		return false
	}

	defer c.Close()
	w := NewMcWriter(c)
	w.KickPacket(KickPacket{
		Reason: msg,
	})
	return true
}

func handleLogin(c net.Conn) {
	buf := new(bytes.Buffer)

	tee := io.TeeReader(c, buf)

	client := "minecraft"
	var version string
	var username string
	var targetHost string
	var connInit Init

	r := NewMcReader(tee)
	pkt, err := r.HandshakePacket()
	if err != nil {
		// try old handshake packet
		r = NewMcReader(buf)
		oldPkt, err := r.OldHandshakePacket()
		if err != nil {
			log.Error(err, map[string]interface{}{
				"event": "bad handshake",
			})
			c.Close()
			return
		}
		version = "1.2.5"
		// username in old packet looks like this: 
		// whatupdave;4.foldserver.com:25565
		parts := strings.Split(oldPkt.Username, ";")
		username = parts[0]
		parts = strings.Split(parts[1], ":")
		targetHost = parts[0]
		connInit = func(remote net.Conn) {
			w := NewMcWriter(remote)
			w.OldHandshakePacket(*oldPkt)
		}
	} else {
		version = fmt.Sprintf("%v", pkt.ProtocolVersion)
		username = pkt.Username
		targetHost = pkt.Host
		connInit = func(remote net.Conn) {
			w := NewMcWriter(remote)
			w.HandshakePacket(*pkt)
		}
	}

	clientAddr := c.RemoteAddr().String()
	req := NewConnectionRequest(client, version, clientAddr, username, targetHost)
	req.Process(c, connInit)
}

func NewConnectionRequest(client, version, clientAddr, username, targetHost string) *ConnectionRequest {
	req := &ConnectionRequest{
		Client:     client,
		Version:    version,
		ClientAddr: clientAddr,
		Username:   username,
		TargetHost: targetHost,
	}
	req.Log = NewLog(map[string]interface{}{
		"client":      req.Username,
		"version":     req.Version,
		"client_addr": req.ClientAddr,
		"username":    req.Username,
		"target_host": req.TargetHost,
	})
	return req
}

func sendKeepAlive(c net.Conn) error {
	w := NewMcWriter(c)
	w.KeepAlivePacket(KeepAlivePacket{
		Id: 1337,
	})

	// read keepalive response from client to get it off the
	// connection
	r := NewMcReader(c)
	_, err := r.Header()
	if err != nil {
		return err
	}
	_, err = r.KeepAlive()
	return err
}

func (req *ConnectionRequest) Process(c net.Conn, init Init) {
	req.Log.Info(map[string]interface{}{
		"event": "login_request",
	})

	go func() {
		conn := NewRedisConnection(prismId)
		defer conn.Quit()
		sub, err := conn.ConnectionReqReply(req.Username)
		defer sub.Close()
		if err != nil {
			req.Log.Error(err, map[string]interface{}{
				"event": "redis_subscribe",
			})
			return
		}

		// keep connection alive for 5 minute
		timeoutCb := time.After(5 * time.Minute)

		// send keepalive packets to client every 15 seconds
		keepalive := time.NewTicker(15 * time.Second)
		defer keepalive.Stop()
		go func() {
			for _ = range keepalive.C {
				err := sendKeepAlive(c)
				if err != nil {
					keepalive.Stop()
					req.Log.Info(map[string]interface{}{
						"event": "disconnected",
					})
				}
			}
		}()

		select {
		case message := <-sub.Messages:
			// connection request reply from brain/prism-buddy
			// will have failed: reason if bad
			// otherwise it's approved
			var reply ConnectionRequestReply
			err := json.Unmarshal(message.Elem.Bytes(), &reply)
			if err != nil {
				req.Log.Error(err, map[string]interface{}{
					"event": "bad_req_reply",
					"reply": message.Elem.String(),
				})
				c.Close()
			} else if reply.Failed != "" {
				req.Denied(c, reply.Failed)
			} else {
				remoteAddr := fmt.Sprintf("%s:%d", reply.Host, reply.Port)
				req.Approved(c, init, remoteAddr)
			}

		case <-timeoutCb:
			req.Timeout(c)
		}
	}()

	// send connection request to brain/prism-buddy
	redisClient.PushConnectionReq(req)
}

func (req *ConnectionRequest) Approved(c net.Conn, init Init, remoteAddr string) {
	req.Log.Info(map[string]interface{}{
		"event":  "login_request_approved",
		"remote": remoteAddr,
	})

	// send keepalive to see if the client is still connected
	err := sendKeepAlive(c)
	if err != nil {
		return
	}

	go req.ProxyConnection(c, remoteAddr, init)
}

func (req *ConnectionRequest) Denied(c net.Conn, reason string) {
	defer c.Close()

	req.Log.Info(map[string]interface{}{
		"event":  "login_request_denied",
		"reason": reason,
	})

	w := NewMcWriter(c)
	w.KickPacket(KickPacket{
		Reason: reason,
	})
}

func (req *ConnectionRequest) Timeout(c net.Conn) {
	defer c.Close()

	req.Log.Error(errors.New("timeout"), map[string]interface{}{
		"event": "login_request_timeout",
	})

	w := NewMcWriter(c)
	w.KickPacket(KickPacket{
		Reason: "Minefold is having some technical difficulties! Please try again",
	})
}

func handleServerPing(c net.Conn) {
	defer c.Close()

	w := NewMcWriter(c)
	w.KickPacket(KickPacket{
		Reason: "§1\00049\0001_4_5\000minefold.com\0005\000-1",
	})
}

func (req *ConnectionRequest) ProxyConnection(client net.Conn, remoteAddr string, init Init) {
	defer client.Close()
	defer redisClient.RemovePlayer(req.Username)
	redisClient.AddPlayer(req.Username)

	remote, err := net.Dial("tcp", remoteAddr)
	if remote == nil || err != nil {
		req.Log.Error(err, map[string]interface{}{
			"event":  "failed_connection",
			"remote": remoteAddr,
		})
		return
	}
	
	req.Log.Info(map[string]interface{}{
		"event": "start_proxy",
		"remote": remoteAddr,
	})

	init(remote)

	go io.Copy(client, remote)
	io.Copy(remote, client)

	req.Log.Info(map[string]interface{}{
		"event": "stop_proxy",
		"remote": remoteAddr,
	})
}

func main() {
	prismId = os.Args[1]
	log = NewLog(map[string]interface{}{
		"prism_id": prismId,
	})

	redisClient = NewRedisConnection(prismId)
	redisClient.ClearPlayerSet()

	ln, err := net.Listen("tcp", ":25565")
	if err != nil {
		panic(err)
	}

	log.Info(map[string]interface{}{
		"event": "listening",
		"port":  "25565",
	})
	for {
		conn, err := ln.Accept()
		if err != nil {
			log.Error(err, map[string]interface{}{
				"event": "socket_accept",
			})
			continue
		}
		go handleConnection(conn)
	}
}
