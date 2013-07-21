package main

import (
    "github.com/garyburd/redigo/redis"
    "testing"
    "time"
)

func TestRPC(t *testing.T) {
    pool := &redis.Pool{
        MaxIdle:     3,
        IdleTimeout: 10 * time.Second,
        Dial: func() (redis.Conn, error) {
            c, err := redis.Dial("tcp", "localhost:6379")
            if err != nil {
                return nil, err
            }
            if _, err := c.Do("SELECT", 7); err != nil {
                c.Close()
                return nil, err
            }
            return c, err
        },
    }

    t.Logf("Pool actives: %d\n", pool.ActiveCount())
    defer t.Logf("Pool actives: %d\n", pool.ActiveCount())

    rpcCancel := make(chan bool)
    replyChan, timeoutChan, errChan := RedisRPC(
        pool,
        "test:rpc:call",
        "test:rpc:reply",
        []byte("sup"),
        1*time.Second,
        rpcCancel)

    go func() {
        c := pool.Get()
        defer c.Close()

        c.Do("PUBLISH", "test:rpc:reply", "dawg")
    }()

    select {
    case err := <-errChan:
        t.Fatalf("Error:", err)

    case <-timeoutChan:
        t.Fatalf("timeout RPC")

    case reply := <-replyChan:
        if string(reply) != "dawg" {
            t.Fatalf("expected dawg was %s", string(reply))
        }
    }



}
