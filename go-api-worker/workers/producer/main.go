package producer

import (
	"fmt"
	"log"
	"os"
	"os/signal"
	"time"

	"Email-Dashboard/go-api-worker/models"
	"Email-Dashboard/go-api-worker/workers/conf"

	"github.com/gocraft/work"
	"github.com/robfig/cron"
)

// Make an enqueuer with a particular namespace
var enqueuer = work.NewEnqueuer("notification_center_work", redisconf.RedisPool)

// Start producer : consumer.Start()
func Start() {
	fmt.Println("Producer has started...")
	c := cron.New()
	c.AddFunc("0 * * * * *", enqueueJobs)
	c.Start()
	sig := make(chan os.Signal)
	signal.Notify(sig, os.Interrupt, os.Kill)
	<-sig
	c.Stop()
}

func enqueueJobs() {
	var activities []models.Activity
	models.GetDB().Where("status = 'pending' OR status = 'scheduled' AND send_at < ?", time.Now()).Find(&activities)

	for _, act := range activities {
		// Enqueue a job named "send_email" with the specified parameters.
		_, err := enqueuer.EnqueueUnique("send_email", work.Q{"activity_id": act.ID})
		if err != nil {
			log.Fatal(err)
		}
	}
}
