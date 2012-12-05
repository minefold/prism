package main

import (
	"bytes"
	"encoding/binary"
	"encoding/json"
	"fmt"
	"github.com/djimenez/iconv-go"
	"github.com/simonz05/godis/redis"
	"io"
	"net"
	"strings"
	"time"
)

type ConnectionRequest struct {
	Username   string `json:"username"`
	TargetHost string `json:"target_host"`
}

type ConnectionRequestReply struct {
	Host   string `json:"host"`
	Port   int    `json:"port"`
	Failed string `json:"failed"`
}

var redisClient *redis.Client

func handleConnection(c net.Conn) {
	r := NewMcReader(c)
	header, err := r.Header()
	if err != nil {
		fmt.Println("header read failed:", err)
	}

	if header == 0xFE {
		handleServerPing(c)
	} else if header == 0x02 {
		handleLogin(c)
	} else {
		fmt.Println(err, header)
	}
}

func handleLogin(c net.Conn) {
	buf := new(bytes.Buffer)

	tee := io.TeeReader(c, buf)

	r := NewMcReader(tee)
	pkt, err := r.HandshakePacket()
	if err != nil {
		// try old handshake packet
		r = NewMcReader(buf)
		oldPkt, err := r.OldHandshakePacket()
		if err != nil {
			fmt.Println("bad handshake", err)
			c.Close()
			return
		}
		// username in old packet looks like this: 
		// whatupdave;4.foldserver.com:25565
		parts := strings.Split(oldPkt.Username, ";")
		username := parts[0]
		parts = strings.Split(parts[1], ":")
		host := parts[0]

		processLogin(c, username, host, func(remote net.Conn) {
			w := NewMcWriter(remote)
			w.OldHandshakePacket(*oldPkt)
		})
	} else {
		processLogin(c, pkt.Username, pkt.Host, func(remote net.Conn) {
			w := NewMcWriter(remote)
			w.HandshakePacket(*pkt)
		})
	}
}

func processLogin(c net.Conn, username string, host string, init func(net.Conn)) {
	fmt.Println("connection:", username, host)

	go func() {
		conn := NewRedisConnection()
		defer conn.Quit()
		sub, err := conn.Subscribe("players:connection_request:" + username)
		defer sub.Close()
		if err != nil {
			fmt.Println("redis subscribe error", err)
			return
		}

		timeout := time.After(180 * time.Second)
		keepalive := time.NewTicker(15 * time.Second)
		w := NewMcWriter(c)

		select {
		case <-timeout:
			fmt.Println("connection request timed out")

		case <-keepalive.C:
			w.KeepAlivePacket(KeepAlivePacket{
				Id: 1337,
			})

		case message := <-sub.Messages:
			var reply ConnectionRequestReply
			err := json.Unmarshal(message.Elem.Bytes(), &reply)
			if err != nil {
				fmt.Println("bad message:", message.Elem.String())
				return
			}

			if reply.Failed != "" {
				w.KickPacket(KickPacket{
					Reason: reply.Failed,
				})
				c.Close()
			} else {
				remoteAddr := fmt.Sprintf("%s:%d", reply.Host, reply.Port)
				go proxyConnection(c, remoteAddr, init)
			}
		}
	}()

	req := &ConnectionRequest{
		Username:   username,
		TargetHost: host,
	}

	reqJson, _ := json.Marshal(req)
	redisClient.Lpush("players:connection_request", reqJson)
}

func handleServerPing(c net.Conn) {
	defer c.Close()
	err := binary.Write(c, binary.BigEndian, byte(0xFF))
	if err != nil {
		fmt.Println("1 failed:", err)
	}

	msg := "§1\00049\0001_4_5\000minefold.com\0005\000-1"

	err = binary.Write(c, binary.BigEndian, int16(len(msg)))
	if err != nil {
		fmt.Println("2 failed:", err)
	}

	ucs2 := make([]byte, len(msg)*2)
	r, w, err := iconv.Convert([]byte(msg), ucs2, "utf-8", "ucs-2")
	if err != nil {
		fmt.Println("failed to convert string to ucs-2", err, r, w)
	}

	err = binary.Write(c, binary.BigEndian, ucs2)
	if err != nil {
		fmt.Println("3 failed:", err)
	}
}

func proxyConnection(client net.Conn, remoteAddr string, init func(net.Conn)) {
	fmt.Println("connecting to " + remoteAddr)

	remote, err := net.Dial("tcp", remoteAddr)
	if remote == nil || err != nil {
		fmt.Println("Can't connect to " + remoteAddr)
		return
	}
	fmt.Println("connected. Sending handshake")

	init(remote)

	fmt.Println("sent")

	go io.Copy(remote, client)
	go io.Copy(client, remote)
}

func main() {
	ln, err := net.Listen("tcp", ":25565")
	if err != nil {
		panic(err)
	}

	redisClient = NewRedisConnection()

	for {
		conn, err := ln.Accept()
		if err != nil {
			fmt.Println("error:", err)
			continue
		}
		go handleConnection(conn)
	}
}
