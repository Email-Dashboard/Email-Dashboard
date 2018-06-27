package models

type Account struct {
	ID            uint `gorm:"primary_key"`
	Name          string
	Email         string
	ApiKey        string
}

// is auth by token
func IsAuthByToken(token string) bool {
	if token == "" {
		return false
	}

	var account Account

	GetDB().Find(&account, "api_key = ?", token)
	if account.ID == 0 {
		return false
	}
	return true
}
