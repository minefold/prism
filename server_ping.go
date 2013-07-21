package main

import (
    "fmt"
    "io"
)

func handleServerPing(r *McReader, w *McWriter) {
    defer w.Close()

    pkt, err := r.PingPacket()
    if err != nil && err != io.EOF {
        log.Error(err, map[string]interface{}{
            "event": "read_ping",
        })
        return
    }

    kickPkt := &KickPacket{
        Reason: reason(pkt.ProtocolVersion, "minefold.com", -1, -1),
    }

    server, err := GetServerInfo(pkt.Host)
    if err == nil {
        kickPkt.Reason = reason(pkt.ProtocolVersion, server.Motd, server.PlayersOnline, server.MaxPlayers)
    }

    w.KickPacket(kickPkt)
}

func reason(protocolVersion byte, motd string, onlinePlayers, maxPlayers int) string {
    return fmt.Sprintf(
        "§1\000%s\000%s\000%s\000%d\000%d",
        protocolVersion,
        "",
        motd,
        onlinePlayers,
        maxPlayers)
}
