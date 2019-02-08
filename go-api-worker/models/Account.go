package models

type Account struct {
	ID             uint `gorm:"primary_key"`
	Name           string
	Email          string
	LiveMode       bool
	ToEmailForTest string
	ApiKey         string
	TestApiKey     string
}

// FindAccountByID func
func FindAccountByID(id uint) Account {
	var account Account

	GetDB().Find(&account, "id = ?", id)
	return account
}
