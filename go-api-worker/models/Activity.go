package models

import (
	"time"
)

// Activity content received from api
type Activity struct {
	ID                    uint `gorm:"primary_key"`
	NotificationDeliverID uint `gorm:"foreign_key"`
	RequestContent        []byte
	RequestModeIsLive     bool
	Status                string
	ErrorMessage          string
	MessageHeaderID       string
	SendAt                time.Time
	CreatedAt             *time.Time
	UpdatedAt             *time.Time
}

// RawContent for request json
type RawContent struct {
	Variables interface{} `json:"variables"`

	Email struct {
		To      []string `json:"to"`
		Cc      []string `json:"cc"`
		Bcc     []string `json:"bcc"`
		ReplyTo []string `json:"reply_to"`
		From    string   `json:"from"`
	} `json:"email"`

	Delivery struct {
		Time string `json:"time"`
		Date string `json:"date"`
		Zone string `json:"zone"`
	} `json:"delivery"`
}
