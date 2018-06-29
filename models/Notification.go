package models

type Notification struct {
	ID        uint `gorm:"primary_key"`
	Name      string
	Slug      string
	AccountID uint `gorm:"foreign_key"`
}

// FindBySlug
func FindBySlug(slug string) Notification {
	var notification Notification

	GetDB().Find(&notification, "slug = ?", slug)

	return notification
}
