package main

import (
    "github.com/garyburd/redigo/redis"
    "time"
)

// RPC over redis. LPUSH for call then SUBSCRIBE for reply
func RedisRPC(pool *redis.Pool, pushChan string, replyKey string, payload []byte, timeout time.Duration, cancel chan bool) (replyChan chan []byte, timeoutChan chan time.Time, errChan chan error) {
    replyChan = make(chan []byte, 1)
    errChan = make(chan error, 1)
    timeoutChan = make(chan time.Time, 1)

    subC := pool.Get()
    psc := redis.PubSubConn{subC}
    unsubscribed := make(chan bool)

    timeoutRPC := time.NewTimer(timeout)
    go func() {
        defer subC.Close()
        defer func() { unsubscribed <- true }()

        psc.Subscribe(replyKey)
        for {
            switch v := psc.Receive().(type) {
            case redis.Message:
                psc.Unsubscribe()
                replyChan <- v.Data
                return

            case redis.Subscription:
                if v.Count == 0 {
                    return
                }
            case error:
                errChan <- v
                return
            }
        }
    }()

    go func() {
        <-timeoutRPC.C
        psc.Unsubscribe()
        <-unsubscribed
        timeoutChan <- time.Now()
    }()

    pushC := pool.Get()
    defer pushC.Close()
    pushC.Do("LPUSH", pushChan, payload)

    return replyChan, timeoutChan, errChan
}
