package main

import (
    "fmt"
    "github.com/garyburd/redigo/redis"
    "net"
    "net/url"
    "os"
    "runtime"
    "time"
)

type Init func(net.Conn)
type Approved func(net.Conn, Init, string, string, string)
type Denied func(net.Conn, string)
type Timeout func(net.Conn)

var mfRedisPool *redis.Pool
var pcRedisPool *redis.Pool

var log *Logger
var prismId string

func handleConnection(c net.Conn) {
    r := NewMcReader(c)
    w := NewMcWriter(c)

    header, err := r.Header()
    if err != nil {
        log.Warn(map[string]interface{}{
            "event": "header read failed",
        })
    }

    if header == 0xFE {
        handleServerPing(r, w)
    } else if header == 0x02 {
        if !MaintenanceModeHandler(r, w) {
            handleLogin(r, w, c)
        }
    }
}

func RedisDial(urlString string) func() (redis.Conn, error) {
    return func() (redis.Conn, error) {
        if urlString == "" {
            urlString = "redis://localhost:6379/"
        }
        redisUrl, err := url.Parse(urlString)
        if err != nil {
            panic(err)
        }

        password := ""
        if redisUrl.User != nil {
            password, _ = redisUrl.User.Password()
        }

        c, err := redis.Dial("tcp", redisUrl.Host)
        if err != nil {
            return nil, err
        }
        if password != "" {
            if _, err := c.Do("AUTH", password); err != nil {
                c.Close()
                return nil, err
            }
        }
        return c, err
    }
}

func testOnBorrow(c redis.Conn, t time.Time) error {
    _, err := c.Do("PING")
    return err
}

func dumpGoroutines() {
    buf := make([]byte, 1<<16)
    runtime.Stack(buf, true)
    fmt.Println(string(buf))
    fmt.Println("DEBUG goroutines:", runtime.NumGoroutine())
}

func debugGoroutines() {
    for _ = range time.Tick(15 * time.Second) {
        dumpGoroutines()
    }
}

func main() {
    runtime.GOMAXPROCS(runtime.NumCPU())
    // go debugGoroutines()
    prismId = os.Args[1]

    port := os.Getenv("PORT")
    if port == "" {
        port = "25565"
    }
    log = NewLog(map[string]interface{}{
        "prism": prismId,
    })

    ln, err := net.Listen("tcp", ":"+port)
    if err != nil {
        panic(err)
    }

    mfRedisPool = &redis.Pool{
        MaxIdle:      3,
        IdleTimeout:  240 * time.Second,
        Dial:         RedisDial(os.Getenv("MINEFOLD_REDIS")),
        TestOnBorrow: testOnBorrow,
    }
    pcRedisPool = &redis.Pool{
        MaxIdle:      3,
        IdleTimeout:  240 * time.Second,
        Dial:         RedisDial(os.Getenv("PARTY_CLOUD_REDIS")),
        TestOnBorrow: testOnBorrow,
    }

    ClearPlayerSet()

    log.Info(map[string]interface{}{
        "event":      "listening",
        "port":       port,
        "gomaxprocs": runtime.GOMAXPROCS(-1),
    })
    for {
        conn, err := ln.Accept()
        if err != nil {
            log.Error(err, map[string]interface{}{
                "event": "socket_accept",
            })
            continue
        }
        go handleConnection(conn)
    }
}
