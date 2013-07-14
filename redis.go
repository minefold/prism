package main

import (
  "encoding/json"
  "fmt"
  "github.com/simonz05/godis/redis"
  "net/url"
  "os"
)

type RedisClient struct {
  c              *redis.Client
  respPrefix     string
  connReqKey     string
  playersKey     string
  maintenanceKey string
  protocolKey    string
  badProtocolKey string
  motdKey        string
}

func NewRedisConnection(prismId string) *RedisClient {
  urlString := os.Getenv("PARTY_CLOUD_REDIS")
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

  respPrefix := fmt.Sprintf("prism:%s", prismId)

  return &RedisClient{
    c:              redis.New("tcp:"+redisUrl.Host, 0, password),
    respPrefix:     respPrefix,
    connReqKey:     fmt.Sprintf("%s:connection_request", respPrefix),
    playersKey:     fmt.Sprintf("%s:players", respPrefix),
    maintenanceKey: fmt.Sprintf("%s:maintenance", respPrefix),
    motdKey:        fmt.Sprintf("%s:motd", respPrefix),
  }
}

func (r *RedisClient) Quit() {
  r.c.Quit()
}

func (r *RedisClient) ClearPlayerSet() {
  r.c.Del(r.playersKey)
}

func (r *RedisClient) AddPlayer(username string) {
  r.c.Sadd(r.playersKey, username)
}

func (r *RedisClient) RemovePlayer(username string) {
  r.c.Srem(r.playersKey, username)
}

func (r *RedisClient) GetMaintenenceMsg() string {
  msg, _ := r.c.Get(r.maintenanceKey)
  return msg.String()
}

func (r *RedisClient) Motd() string {
  val, _ := r.c.Get(r.motdKey)
  return val.String()
}

func (r *RedisClient) PartyCloudId(host string) string {
  val, _ := r.c.Hget("minefold:servers:partycloudid", host)
  return val.String()
}

func (r *RedisClient) ReplyKey(username string) string {
  return fmt.Sprintf("%s:%s", r.connReqKey, username)
}

func (r *RedisClient) PushConnectionReq(req *ConnectionRequest) {
  req.ReplyKey = r.ReplyKey(req.Username)
  reqJson, _ := json.Marshal(req)
  r.c.Lpush("players:connection_request", reqJson)
}

func (r *RedisClient) ConnectionReqReply(username string) (*redis.Sub, error) {
  return r.c.Subscribe(r.ReplyKey(username))
}
