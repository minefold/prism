package main

import (
    "github.com/garyburd/redigo/redis"
)

func MaintenanceModeHandler(r *McReader, w *McWriter) bool {
    
    msg := MaintenanceMessage()
    if msg == "" {
        return false
    }

    defer w.Close()
    w.KickPacket(&KickPacket{
        Reason: msg,
    })
    return true
}

func MaintenanceMessage() string {
    c := pcRedisPool.Get()
    defer c.Close()

    msg, err := redis.String(c.Do("GET", prismId+":maintenance"))
    if err != nil {
        return ""
    }
    return msg
}
