package redisconf

import "github.com/gomodule/redigo/redis"

// RedisPool : exported redis pool conf
var RedisPool = &redis.Pool{
	MaxActive: 5,
	MaxIdle:   5,
	Wait:      true,
	Dial: func() (redis.Conn, error) {
		return redis.Dial("tcp", ":6379")
	},
}
