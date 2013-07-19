package main

import (
  "fmt"
  // "github.com/whatupdave/godis/redis"
  "net"
)

type ServerInfo struct {
  Motd          string
  PlayersOnline int
  MaxPlayers    int
}

func handleServerPing(c net.Conn) {
  defer c.Close()

  r := NewMcReader(c)
  pkt, err := r.PingPacket()
  if err != nil {
    log.Error(err, map[string]interface{}{
      "event": "read_ping",
    })
    return
  }

  kickPkt := &KickPacket{
    Reason: reason(pkt.ProtocolVersion, "minefold.com", -1, -1),
  }

  server, err := getServerInfo(pkt.Host)
  if err == nil {
    kickPkt.Reason = reason(pkt.ProtocolVersion, server.Motd, server.PlayersOnline, server.MaxPlayers)
  }

  w := NewMcWriter(c)
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

func getServerInfo(host string) (server *ServerInfo, err error) {
  motdEl, err := mfRedis.Hget("server-info:motd", host)
  if err != nil {
    return
  }
  pcIdEl, err := mfRedis.Hget("server-info:party-cloud-id", host)
  if err != nil {
    return
  }
  pcId := pcIdEl.String()

  onlinePlayersEl, err := pcRedis.Scard("server:" + pcId + ":players")

  server = &ServerInfo{
    Motd:          motdEl.String(),
    PlayersOnline: int(onlinePlayersEl),
    MaxPlayers:    50,
  }
  return
}
