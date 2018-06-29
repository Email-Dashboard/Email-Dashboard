package main

import (
	"log"
	"time"

	"notification-center-go-api/models"
	"notification-center-go-api/workers/conf"

	"github.com/gocraft/work"
)

// Make an enqueuer with a particular namespace
var enqueuer = work.NewEnqueuer("notification_center_work", redisconf.RedisPool)

func main() {
	var activities []models.Activity
	models.GetDB().Where("status = 'pending' OR status = 'scheduled' AND send_at < ?", time.Now()).Find(&activities)
	// models.GetDB().Where("send_at < ?", time.Now()).Find(&activities)

	for _, act := range activities {
		// Enqueue a job named "send_email" with the specified parameters.
		_, err := enqueuer.Enqueue("send_email", work.Q{"activity_id": act.ID})
		if err != nil {
			log.Fatal(err)
		}
	}

}
