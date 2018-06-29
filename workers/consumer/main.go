package main

import (
	"encoding/json"
	"log"
	"os"
	"os/signal"

	"notification-center-go-api/mailer"
	"notification-center-go-api/models"
	"notification-center-go-api/workers/conf"

	"github.com/gocraft/work"
)

// Context is a struct that will be the context for the request.
type Context struct {
	activityID int64
}

func main() {
	// 10 is the max concurrency
	// "notification_center_work" is the Redis namespace
	pool := work.NewWorkerPool(Context{}, 10, "notification_center_work", redisconf.RedisPool)

	// Add middleware that will be executed for each job
	pool.Middleware((*Context).Log)
	pool.Middleware((*Context).CheckParams)

	// Map the name of jobs to handler functions
	pool.Job("send_email", (*Context).SendEmail)

	// Customize options:
	pool.JobWithOptions("export", work.JobOptions{Priority: 10, MaxFails: 1}, (*Context).Export)

	// Start processing jobs
	pool.Start()

	// Wait for a signal to quit:
	signalChan := make(chan os.Signal, 1)
	signal.Notify(signalChan, os.Interrupt, os.Kill)
	<-signalChan

	// Stop the pool
	pool.Stop()
}

// CheckParams is checking expecting params params from pool
func (c *Context) CheckParams(job *work.Job, next work.NextMiddlewareFunc) error {
	// If there's a activity_id param, set it in the context for future middleware and handlers to use.
	if _, ok := job.Args["activity_id"]; ok {
		c.activityID = job.ArgInt64("activity_id")
		if err := job.ArgError(); err != nil {
			return err
		}
	}

	return next()
}

// SendEmail activity email sender
func (c *Context) SendEmail(job *work.Job) error {
	var activity models.Activity
	models.GetDB().Find(&activity, "id = ?", c.activityID)

	if activity.Status == "pending" || activity.Status == "scheduled" {
		var data models.RawContent
		if err := json.Unmarshal(activity.RequestContent, &data); err != nil {
			panic(err)
		}

		var deliver models.NotificationDeliver

		deliver = models.FindDeliverByID(activity.NotificationDeliverID)

		log.Println(deliver.ID)

		mailer.SendEmail(activity, data)
	}

	return nil
}

// Export job
func (c *Context) Export(job *work.Job) error {
	return nil
}

// Log is a simple job logger
func (c *Context) Log(job *work.Job, next work.NextMiddlewareFunc) error {
	log.Println("Starting job: ", job.Name)
	return next()
}
