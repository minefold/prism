package main

import (
    "github.com/garyburd/redigo/redis"
    "testing"
    "time"
)

func DialTestRedis() redis.Conn {
    c, err := redis.Dial("tcp", "localhost:6379")
    if err != nil {
        panic(err)
    }
    if _, err := c.Do("SELECT", 7); err != nil {
        c.Close()
        panic(err)
    }
    return c
}

func TestRPC(t *testing.T) {
    pushConn := DialTestRedis()
    subConn := DialTestRedis()
    defer pushConn.Close()
    defer subConn.Close()

    go func() {
        time.Sleep(10 * time.Millisecond)
        DialTestRedis().Do("PUBLISH", "test:rpc:reply", "dawg")
    }()

    reply, err := RedisRPC(
        pushConn, "test:rpc:call", []byte("sup"),
        subConn, "test:rpc:reply",
        10*time.Second)

    if err != nil {
        t.Error(err)
    }

    if string(reply) != "dawg" {
        t.Fatalf("reply=%v, want %v", string(reply), "dawg")
    }
}

func TestRPCTimeout(t *testing.T) {
    pushConn := DialTestRedis()
    subConn := DialTestRedis()
    defer pushConn.Close()
    defer subConn.Close()

    _, err := RedisRPC(
        pushConn, "test:rpc:call", []byte("sup"),
        subConn, "test:rpc:reply",
        1*time.Millisecond)

    switch v := err.(type) {
    case error:
        if v.Error() != "Timeout" {
            t.Fatalf("Expected Timeout")
        }
    default:
        t.Error(err)
    }
}
