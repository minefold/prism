package main

import (
    "errors"
    "fmt"
    "io"
    "net"
)

func handleLogin(cr *McReader, cw *McWriter, client net.Conn) {
    pkt, err := cr.HandshakePacket()
    if err != nil {
        log.Error(err, map[string]interface{}{
            "event": "bad handshake",
        })
        cw.Close()
        return
    }

    version := fmt.Sprintf("%v", pkt.ProtocolVersion)
    clientAddr := client.RemoteAddr().String()

    req := &ConnectionRequest{
        Client:     "minecraft",
        Version:    version,
        ClientAddr: clientAddr,
        Username:   pkt.Username,
        TargetHost: pkt.Host,
        Log: NewLog(map[string]interface{}{
            "version":     version,
            "client_addr": clientAddr,
            "username":    pkt.Username,
            "target_host": pkt.Host,
        }),
    }

    req.Process(client, func(server net.Conn) {
        sw := NewMcWriter(server)
        err := sw.HandshakePacket(pkt)

        if err != nil {
            req.Log.Error(err, map[string]interface{}{
                "event":  "handshake",
                "packet": pkt,
            })
        }
    })
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
    w.KickPacket(&KickPacket{
        Reason: reason,
    })
}

func (req *ConnectionRequest) Timeout(c net.Conn) {
    defer c.Close()

    req.Log.Error(errors.New("timeout"), map[string]interface{}{
        "event": "login_request_timeout",
    })

    w := NewMcWriter(c)
    w.KickPacket(&KickPacket{
        Reason: "Minefold is having some technical difficulties! Please try again",
    })
}

func (req *ConnectionRequest) ProxyConnection(client net.Conn, remoteAddr string, init Init) {
    defer client.Close()
    defer RemovePlayerFromSet(req.Username)
    AddPlayerToSet(req.Username)

    remote, err := net.Dial("tcp", remoteAddr)
    if remote == nil || err != nil {
        req.Log.Error(err, map[string]interface{}{
            "event":  "failed_connection",
            "remote": remoteAddr,
        })
        return
    }

    req.Log.Info(map[string]interface{}{
        "event":  "start_proxy",
        "remote": remoteAddr,
    })

    init(remote)

    go io.Copy(client, remote)
    io.Copy(remote, client)

    req.Log.Info(map[string]interface{}{
        "event":  "stop_proxy",
        "remote": remoteAddr,
    })
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
