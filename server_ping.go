package main

import (
  "encoding/json"
  "fmt"
  "net"
  "net/http"
)

type ServerInfo struct {
  Name          string
  PlayersOnline int
  MaxPlayers    int
}

type MinefoldServerInfo struct {
  Name         string   `json:"name"`
  PartyCloudId string   `json:"partyCloudId"`
  MaxPlayers   int      `json:"maxPlayers"`
  Players      []string `json:"players"`
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

  server, err := getMinefoldServerInfo(pkt.Host)
  if err != nil {
    log.Error(err, map[string]interface{}{
      "event": "minefold_server_info",
    })
    return
  }

  w := NewMcWriter(c)
  kickPkt := &KickPacket{
    Reason: fmt.Sprintf(
      "§1\000%s\000%s\000%s\000%d\000%d",
      pkt.ProtocolVersion,
      "",
      server.Name,
      len(server.Players),
      50),
  }
  fmt.Println(kickPkt)
  w.KickPacket(kickPkt)
}

func getMinefoldServerInfo(host string) (*MinefoldServerInfo, error) {
  client := &http.Client{
    CheckRedirect: redirectPolicyFunc,
  }
  req, err := http.NewRequest("GET", "http://"+host, nil)
  req.Header.Add("Accept", "application/json")
  resp, err := client.Do(req)
  if err != nil {
    return nil, err
  }

  defer resp.Body.Close()
  dec := json.NewDecoder(resp.Body)

  var server MinefoldServerInfo
  err = dec.Decode(&server)
  if err != nil {
    return nil, err
  }

  return &server, err
}

func redirectPolicyFunc(req *http.Request, via []*http.Request) error {
  // copy headers to redirected urls (so application/json is present)
  // when blah.folderver.com redirects to /server/1234
  req.Header = via[0].Header
  return nil
}
