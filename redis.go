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
	playersKey     string
	maintenanceKey string
}

func NewRedisConnection(prismId string) *RedisClient {
	urlString := os.Getenv("REDIS_URL")
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

	return &RedisClient{
		c:              redis.New("tcp:"+redisUrl.Host, 0, password),
		playersKey:     fmt.Sprintf("prism:%s:players", prismId),
		maintenanceKey: fmt.Sprintf("prism:%s:maintenance", prismId),
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

func (r *RedisClient) PushConnectionReq(req *ConnectionRequest) {
	reqJson, _ := json.Marshal(req)
	r.c.Lpush("players:connection_request", reqJson)
}

func (r *RedisClient) ConnectionReqReply(replyKey string) (*redis.Sub, error) {
	return r.c.Subscribe("players:connection_request:" + replyKey)
}
