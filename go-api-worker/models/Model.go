package models

import (
	"log"
	"os"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

// db
var db *gorm.DB

// init
func init() {
	// connect db
	// dbConn, err := gorm.Open("mysql", "root@tcp(127.0.0.1:3306)/notification_dashboard_development?charset=utf8&parseTime=True&loc=Local")
	dbConn, err := gorm.Open("mysql", os.Getenv("ED_DB_USERNAME")+":"+os.Getenv("ED_DB_PASSWORD")+"@tcp(db)/"+os.Getenv("ED_DB_NAME")+"?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatal(err.Error())
	}
	db = dbConn
}

// GetDB call in other packages
func GetDB() *gorm.DB {
	return db
}
