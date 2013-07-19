package main

import (
  "testing"
  // "github.com/whatupdave/godis/redis"
)

func TestGetServerInfo(t *testing.T) {
  mfRedis = NewRedisConnection("redis://localhost:6379/6")
  pcRedis = NewRedisConnection("redis://localhost:6379/7")

  mfRedis.Hset("server-info:party-cloud-id", "server-1.minefold.com", "party-1")
  mfRedis.Hset("server-info:motd", "server-1.minefold.com", "Oh hai")

  pcRedis.Sadd("server:party-1:players", "whatupdave")

  server, err := getServerInfo("server-1.minefold.com")
  if err != nil {
    t.Fatal(err)
  }

  if server.PlayersOnline != 1 {
    t.Fatalf("expected 1 was %d", server.PlayersOnline)
  }
  if server.MaxPlayers != 50 {
    t.Fatalf("expected 50 was %d", server.MaxPlayers)
  }
  if server.Motd != "Oh hai" {
    t.Fatalf("expected 'Oh hai' was %s", server.Motd)
  }
}
