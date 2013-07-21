package main

import (
    "fmt"
)

func ClearPlayerSet() {
    c := pcRedisPool.Get()
    defer c.Close()

    c.Do("DEL", playerSetKey())
}

func AddPlayerToSet(username string) {
    c := pcRedisPool.Get()
    defer c.Close()

    c.Do("SADD", playerSetKey(), username)
}

func RemovePlayerFromSet(username string) {
    c := pcRedisPool.Get()
    defer c.Close()

    c.Do("SREM", playerSetKey(), username)
}

func playerSetKey() string {
    return fmt.Sprintf("prism:%s:players", prismId)
}
