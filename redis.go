package main

import (
  "encoding/json"
  "fmt"
  "github.com/whatupdave/godis/redis"
  "net/url"
)

type RedisClient struct {
  C              *redis.Client
  respPrefix     string
  connReqKey     string
  playersKey     string
  maintenanceKey string
}

func NewRedisConnection(urlString string) *redis.Client {
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

  return redis.New("tcp:"+redisUrl.Host, 0, password)
}

func NewRedisClient(c *redis.Client, prismId string) *RedisClient {
  respPrefix := fmt.Sprintf("prism:%s", prismId)

  return &RedisClient{
    C:              c,
    respPrefix:     respPrefix,
    connReqKey:     fmt.Sprintf("%s:connection_request", respPrefix),
    playersKey:     fmt.Sprintf("%s:players", respPrefix),
    maintenanceKey: fmt.Sprintf("%s:maintenance", respPrefix),
  }
}

func (r *RedisClient) Quit() {
  r.C.Quit()
}

func (r *RedisClient) ClearPlayerSet() {
  r.C.Del(r.playersKey)
}

func (r *RedisClient) AddPlayer(username string) {
  r.C.Sadd(r.playersKey, username)
}

func (r *RedisClient) RemovePlayer(username string) {
  r.C.Srem(r.playersKey, username)
}

func (r *RedisClient) GetMaintenenceMsg() string {
  msg, _ := r.C.Get(r.maintenanceKey)
  return msg.String()
}

func (r *RedisClient) PartyCloudId(host string) string {
  val, _ := r.C.Hget("minefold:servers:partycloudid", host)
  return val.String()
}

func (r *RedisClient) ReplyKey(username string) string {
  return fmt.Sprintf("%s:%s", r.connReqKey, username)
}

func (r *RedisClient) PushConnectionReq(req *ConnectionRequest) {
  req.ReplyKey = r.ReplyKey(req.Username)
  reqJson, _ := json.Marshal(req)
  r.C.Lpush("players:connection_request", reqJson)
}

func (r *RedisClient) ConnectionReqReply(username string) (*redis.Sub, error) {
  return r.C.Subscribe(r.ReplyKey(username))
}
