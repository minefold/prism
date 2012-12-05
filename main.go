package main

import (
	"bytes"
	"encoding/json"
	"errors"
	"fmt"
	"github.com/simonz05/godis/redis"
	"io"
	"net"
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

var redisClient *redis.Client
var log *Logger

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
	msg, _ := redisClient.Get("prism:maintenance")
	if msg.String() == "" {
		return false
	}

	defer c.Close()
	w := NewMcWriter(c)
	w.KickPacket(KickPacket{
		Reason: msg.String(),
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

func (req *ConnectionRequest) Process(c net.Conn, init Init) {
	req.Log.Info(map[string]interface{}{
		"event": "login_request",
	})

	go func() {
		conn := NewRedisConnection()
		defer conn.Quit()
		sub, err := conn.Subscribe("players:connection_request:" + req.Username)
		defer sub.Close()
		if err != nil {
			req.Log.Error(err, map[string]interface{}{
				"event": "redis_subscribe",
			})
			return
		}

		w := NewMcWriter(c)

		timeoutCb := time.After(240 * time.Second)
		keepalive := time.NewTicker(15 * time.Second)
		defer keepalive.Stop()
		go func() {
			for _ = range keepalive.C {
				w.KeepAlivePacket(KeepAlivePacket{
					Id: 1337,
				})
			}
		}()

		select {
		case message := <-sub.Messages:
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

	reqJson, _ := json.Marshal(req)
	redisClient.Lpush("players:connection_request", reqJson)
}

func (req *ConnectionRequest) Approved(c net.Conn, init Init, remoteAddr string) {
	req.Log.Info(map[string]interface{}{
		"event":  "login_request_approved",
		"remote": remoteAddr,
	})

	go proxyConnection(c, remoteAddr, init)
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

func proxyConnection(client net.Conn, remoteAddr string, init Init) {
	remote, err := net.Dial("tcp", remoteAddr)
	if remote == nil || err != nil {
		defer client.Close()

		log.Error(err, map[string]interface{}{
			"event":  "failed_connection",
			"remote": remoteAddr,
		})
		return
	}

	init(remote)

	go io.Copy(client, remote)
	go io.Copy(remote, client)
}

func main() {
	log = NewLog(map[string]interface{}{})

	ln, err := net.Listen("tcp", ":25565")
	if err != nil {
		panic(err)
	}

	redisClient = NewRedisConnection()

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
