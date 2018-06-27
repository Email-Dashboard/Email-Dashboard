package models

type NotificationDeliver struct {
	ID uint `gorm:"primary_key"`
}

func FindNotificationDeliver(notification_id uint) NotificationDeliver {
	var deliver NotificationDeliver

	GetDB().Find(&deliver, "delivery_method = 'email' AND notification_id = ?", notification_id)

	return deliver
}
