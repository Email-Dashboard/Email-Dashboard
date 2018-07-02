package models

// NotificationDeliver type of notification
type NotificationDeliver struct {
	ID                    uint `gorm:"primary_key"`
	NotificationID        uint `gorm:"foreign_key"`
	NotificationContentID uint `gorm:"foreign_key"`
	SMTPSettingID         uint `gorm:"foreign_key"`
	IsActive              bool
	NotificationContent   *NotificationContent
	SMTPSetting           *SMTPSetting
}

// NotificationContent of message
type NotificationContent struct {
	ID      uint `gorm:"primary_key"`
	Subject string
	Content string
}

// SMTPSetting for mailer
type SMTPSetting struct {
	Address  string
	Port     string
	Username string
	Password string
}

// FindDeliverByNotificationID func
func FindDeliverByNotificationID(notificationID uint) NotificationDeliver {
	var deliver NotificationDeliver

	GetDB().Find(&deliver, "delivery_method = 'email' AND notification_id = ?", notificationID)
	return deliver
}

// FindDeliverByID from db
func FindDeliverByID(id uint) NotificationDeliver {
	var deliver NotificationDeliver

	GetDB().Find(&deliver, "id = ?", id)
	return deliver
}
