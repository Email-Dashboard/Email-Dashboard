package models

import (
	"github.com/graphql-go/graphql"
)

type Notification struct {
	ID        uint `gorm:"primary_key"`
	Name      string
	Slug      string
	AccountID uint `gorm:"foreign_key"`
}

// FindBySlug func
func FindBySlug(slug string) Notification {
	var notification Notification

	GetDB().Find(&notification, "slug = ?", slug)

	return notification
}

// FindNotificationByID func
func FindNotificationByID(id uint) Notification {
	var notification Notification

	GetDB().Find(&notification, "id = ?", id)
	return notification
}

// GetNotificationList func
func GetNotificationList() []Notification {
	var notifications []Notification

	GetDB().Find(&notifications)
	return notifications
}

//CreateNotificationsQueray func
func CreateNotificationsQueray(notificationType *graphql.Object) *graphql.Field {
	return &graphql.Field{
		Type: graphql.NewList(notificationType),
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			return GetNotificationList(), nil
		},
	}
}

//CreateNotificationQueray func
func CreateNotificationQueray(notificationType *graphql.Object) *graphql.Field {
	return &graphql.Field{
		Type: notificationType,
		Args: graphql.FieldConfigArgument{
			"id": &graphql.ArgumentConfig{
				Type: graphql.NewNonNull(graphql.Int),
			},
		},
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			id := p.Args["id"]
			v, _ := id.(int)
			return FindNotificationByID(uint(v)), nil
		},
	}
}

//CreateNotificationType func
func CreateNotificationType() *graphql.Object {
	return graphql.NewObject(graphql.ObjectConfig{
		Name: "Notification",
		Fields: graphql.Fields{
			"id": &graphql.Field{
				Type: graphql.NewNonNull(graphql.Int),
			},
			"name": &graphql.Field{
				Type: graphql.NewNonNull(graphql.String),
			},
			"slug": &graphql.Field{
				Type: graphql.NewNonNull(graphql.String),
			},
			"accountId": &graphql.Field{
				Type: graphql.NewNonNull(graphql.Int),
			},
		},
	})
}
