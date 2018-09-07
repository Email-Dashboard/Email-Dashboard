package main

import (
	"encoding/json"
	"fmt"
	"os"
	"io"
	"go-api-worker/middlewares"
	"go-api-worker/models"
	"go-api-worker/workers/consumer"
	"go-api-worker/workers/producer"
	"net/http"
	"time"

	"github.com/gin-gonic/gin"
)

func main() {
	// Enable logging
	startGinLogger()

	// Start worker
	go consumer.Start()
	go producer.Start()

	router := gin.Default()

	// get request to base url
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, fmt.Sprintf("Hello from Email Dashboard API!"))
	})

	api := router.Group("/api/v3")
	api.Use(middlewares.JWTAuth())
	api.POST("notifications/:id", CreateActivity)

	router.Run(":80")
}

// CreateActivity Handle activity request
func CreateActivity(c *gin.Context) {

	var notification models.Notification
	id := c.Params.ByName("id")
	models.GetDB().Where("slug = ?", id).First(&notification)

	deliver := models.FindDeliverByNotificationID(notification.ID)

	if deliver.ID != 0 {

		// Parse request contet
		var content models.RawContent
		c.BindJSON(&content)

		data, _ := json.Marshal(content)

		if content.Delivery.Date == "" {
			var activity = models.Activity{NotificationDeliverID: deliver.ID, Status: "pending", SendAt: time.Now(), RequestContent: data}
			models.GetDB().Create(&activity)
		} else {
			layout := "2006-01-02 15:04"
			loc, _ := time.LoadLocation(content.Delivery.Zone)
			sendTime := content.Delivery.Date + " " + content.Delivery.Time

			toSendAt, err := time.ParseInLocation(layout, sendTime, loc)

			if err != nil {
				c.JSON(422, gin.H{"error": err})
				return
			} else {
				var activity = models.Activity{NotificationDeliverID: deliver.ID, Status: "scheduled", SendAt: toSendAt, RequestContent: data}
				models.GetDB().Create(&activity)
			}
		}

		c.JSON(200, gin.H{"info": "Success!"})
	} else {
		c.JSON(422, gin.H{"error": "Email type deliver not found!"})
	}
}

func startGinLogger() {
	// Disable Console Color
	gin.DisableConsoleColor()

	// Logging to a file.
	f, _ := os.Create("gin.log")
	gin.DefaultWriter = io.MultiWriter(f)
}
