package main

import (
    "github.com/garyburd/redigo/redis"
)

type ServerInfo struct {
    Motd          string
    PlayersOnline int
    MaxPlayers    int
}

func GetServerInfo(host string) (server *ServerInfo, err error) {
    c := mfRedisPool.Get()
    defer c.Close()

    motd, err := redis.String(c.Do("HGET", "server-info:motd", host))
    if err != nil {
        return
    }
    pcId, err := redis.String(c.Do("HGET", "server-info:party-cloud-id", host))
    if err != nil {
        return
    }

    onlinePlayers, err := redis.Int(c.Do("SCARD", "server:"+pcId+":players"))

    server = &ServerInfo{
        Motd:          motd,
        PlayersOnline: onlinePlayers,
        MaxPlayers:    50,
    }
    return
}
