package models

import (
  "log"

  _ "github.com/go-sql-driver/mysql"
  "github.com/jinzhu/gorm"
)

// db
var db *gorm.DB
var err error
// init
func init() {
  if err != nil {
    log.Fatal("Error loading .env file")
  }

  // connect db
  dbConn, err := gorm.Open("mysql", "root@tcp(127.0.0.1:3306)/notification_dashboard_development?charset=utf8&parseTime=True&loc=Local")
  if err != nil {
    log.Fatal(err.Error())
  }
  db = dbConn
}

// get db
func GetDB() *gorm.DB {
  return db
}
