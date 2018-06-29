package models

type NotificationDeliver struct {
	ID             uint `gorm:"primary_key"`
	NotificationID uint `gorm:"foreign_key"`
	IsActive       bool
}

// FindDeliverByNotificationID func
func FindDeliverByNotificationID(notification_id uint) NotificationDeliver {
	var deliver NotificationDeliver

	GetDB().Find(&deliver, "delivery_method = 'email' AND notification_id = ?", notification_id)
	return deliver
}

// FindDeliverByID from db
func FindDeliverByID(id uint) NotificationDeliver {
	var deliver NotificationDeliver

	GetDB().Find(&deliver, "id = ?", id)
	return deliver
}
