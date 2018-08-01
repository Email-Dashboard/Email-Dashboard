package models

import (
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jinzhu/gorm"
)

// db
var db *gorm.DB

// init
func init() {
	// connect db
	// dbConn, err := gorm.Open("mysql", "root@tcp(127.0.0.1:3306)/notification_dashboard_development?charset=utf8&parseTime=True&loc=Local")
	dbConn, err := gorm.Open("mysql", "nc_db_user:nc_db_user_pwd@tcp(db)/notification_center_prod?charset=utf8&parseTime=True&loc=Local")
	if err != nil {
		log.Fatal(err.Error())
	}
	db = dbConn
}

// GetDB call in other packages
func GetDB() *gorm.DB {
	return db
}
