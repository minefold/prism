package main

import (
    "encoding/json"
    "fmt"
    "net"
    "os"
    "time"
)

type ConnectionRequest struct {
    ReplyKey   string  `json:"reply_key"`
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

func (req *ConnectionRequest) Process(c net.Conn, init Init) {
    req.Log.Info(map[string]interface{}{
        "event": "login_request",
    })

    req.ReplyKey = prismId + ":connection_request:" + req.Username
    payload, err := json.Marshal(req)
    if err != nil {
        c.Close()
        req.Log.Error(err, map[string]interface{}{
            "event": "rpc_marshal",
        })
        return
    }

    // send keepalive packets to client every 15 seconds
    stopKeepalive := Every(15*time.Second, func() bool {
        err := sendKeepAlive(c)
        if err != nil {
            req.Log.Info(map[string]interface{}{
                "event": "disconnected",
            })
            return false
        }
        return true
    })
    defer func() { stopKeepalive <- true }()

    dial := RedisDial(os.Getenv("PARTY_CLOUD_REDIS"))

    pushConn, err := dial()
    if err != nil {
        req.Log.Error(err, map[string]interface{}{
            "event": "redis_dial",
        })
        return
    }
    defer pushConn.Close()
    subConn, err := dial()
    if err != nil {
        req.Log.Error(err, map[string]interface{}{
            "event": "redis_dial",
        })
        return
    }
    defer subConn.Close()

    message, err := RedisRPC(
        pushConn, "players:connection_request", payload,
        subConn, req.ReplyKey,
        5*time.Minute)

    if err != nil {
        req.Log.Error(err, map[string]interface{}{
            "event": "rpc",
        })
        return
    }

    var reply ConnectionRequestReply
    err = json.Unmarshal(message, &reply)
    if err != nil {
        req.Log.Error(err, map[string]interface{}{
            "event":   "rpc_reply_unmarshal",
            "message": string(message),
        })
        return
    }

    if reply.Failed != "" {
        go req.Denied(c, reply.Failed)
    } else {
        remoteAddr := fmt.Sprintf("%s:%d", reply.Host, reply.Port)
        go req.Approved(c, init, remoteAddr)
    }
}
