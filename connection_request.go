package main

import (
    "encoding/json"
    "errors"
    "fmt"
    "net"
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

    connEnded := make(chan bool, 1)
    rpcCancel := make(chan bool, 2)

    // send keepalive packets to client every 15 seconds
    stopKeepalive := Every(15*time.Second, func() bool {
        err := sendKeepAlive(c)
        if err != nil {
            connEnded <- true
            req.Log.Info(map[string]interface{}{
                "event": "disconnected",
            })
            return false
        }
        return true
    })
    defer func() { stopKeepalive <- true }()

    replyChan, timeoutChan, errChan := RedisRPC(
        pcRedisPool,
        "players:connection_request",
        req.ReplyKey,
        payload,
        5*time.Minute,
        rpcCancel)

    select {
    case <-connEnded:
        // Connection hung up before RPC response
        rpcCancel <- true

    case <-timeoutChan:
        // RPC timed out
        req.Log.Error(errors.New("Timeout"), map[string]interface{}{
            "event": "rpc_timeout",
        })
        c.Close()

    case err := <-errChan:
        // RPC Error
        req.Log.Error(err, map[string]interface{}{
            "event": "rpc",
        })
        c.Close()

    case message := <-replyChan:
        var reply ConnectionRequestReply
        err := json.Unmarshal(message, &reply)
        if err != nil {
            c.Close()
            req.Log.Error(err, map[string]interface{}{
                "event":   "rpc_reply_unmarshal",
                "message": string(message),
            })
        } else if reply.Failed != "" {
            go req.Denied(c, reply.Failed)
        } else {
            remoteAddr := fmt.Sprintf("%s:%d", reply.Host, reply.Port)
            go req.Approved(c, init, remoteAddr)
        }
    }
}
