package main

import (
    "time"
)

func Every(duration time.Duration, work func() bool) chan bool {
    ticker := time.NewTicker(duration)
    stop := make(chan bool, 1)

    go func() {
        for {
            select {
            case <-ticker.C:
                if !work() {
                    stop <- true
                }
            case <-stop:
                return
            }
        }
    }()

    return stop
}
