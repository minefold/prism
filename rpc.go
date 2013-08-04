package main

import (
    "errors"
    "fmt"
    "github.com/garyburd/redigo/redis"
    "time"
)

func RedisRPC(pushConn redis.Conn, pushKey string, payload []byte, subConn redis.Conn, replyKey string, timeout time.Duration) ([]byte, error) {
    psc := redis.PubSubConn{subConn}
    psc.Subscribe(replyKey)
    defer psc.Unsubscribe()

    replyChan := make(chan []byte, 1)
    go func() {
        for {
            switch v := psc.Receive().(type) {
            case redis.Message:
                replyChan <- v.Data

            case redis.Subscription:
                if v.Count == 0 {
                    replyChan <- nil
                }

            case error:
                replyChan <- nil
            }
        }
        fmt.Println("for exited")
    }()

    pushConn.Do("LPUSH", pushKey, payload)

    select {
    case reply := <-replyChan:
        return reply, nil
    case <-time.After(timeout):
        return nil, errors.New("Timeout")
    }
}
