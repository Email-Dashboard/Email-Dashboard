package relay

import (
	"Email-Dashboard/go-api-worker/models"
	"context"
	"strconv"

	"github.com/graphql-go/graphql"
	"github.com/graphql-go/relay"
)

var noteDefinitions *relay.NodeDefinitions
var notificationType *graphql.Object

// Schema schema of go-api
var Schema graphql.Schema

//Init schama init
func Init() {
	noteDefinitions = relay.NewNodeDefinitions(relay.NodeDefinitionsConfig{
		IDFetcher: func(id string, info graphql.ResolveInfo, ctx context.Context) (interface{}, error) {
			resolvedID := relay.FromGlobalID(id)

			switch resolvedID.Type {
			case "Notification":
				id, _ := strconv.Atoi(resolvedID.ID)
				return models.FindNotificationByID(uint(id)), nil
			default:
				return nil, nil
			}
		},
		TypeResolve: func(p graphql.ResolveTypeParams) *graphql.Object {
			switch p.Value.(type) {
			case *models.Notification:
				return notificationType
			default:
				return nil
			}
		},
	})

	notificationType = graphql.NewObject(graphql.ObjectConfig{
		Name:        "Notification",
		Description: "A notification of email-dashboard",
		Fields: graphql.Fields{
			"id": relay.GlobalIDField("Notification", nil),
			"name": &graphql.Field{
				Type:        graphql.NewNonNull(graphql.String),
				Description: "the name of the notification",
			},
			"slug": &graphql.Field{
				Type: graphql.NewNonNull(graphql.String),
			},
			"accountId": &graphql.Field{
				Type: graphql.NewNonNull(graphql.Int),
			},
		},
		Interfaces: []*graphql.Interface{
			noteDefinitions.NodeInterface,
		},
	})

	// nfConnDefinition := relay.ConnectionDefinitions(relay.ConnectionConfig{
	// 	Name:     "Notification",
	// 	NodeType: notificationType,
	// })

	rootQuery := graphql.ObjectConfig{
		Name: "Query",
		Fields: graphql.Fields{
			"notification":  CreateNotificationQueray(notificationType),
			"notifications": CreateNotificationsQueray(notificationType),
			"node":          noteDefinitions.NodeField,
		}}

	queryType := graphql.NewObject(rootQuery)

	var err error
	Schema, err = graphql.NewSchema(graphql.SchemaConfig{
		Query: queryType,
	})

	if err != nil {
		panic(err)
	}
}

//CreateNotificationsQueray func
func CreateNotificationsQueray(notificationType *graphql.Object) *graphql.Field {
	return &graphql.Field{
		Type: graphql.NewList(notificationType),
		Resolve: func(p graphql.ResolveParams) (interface{}, error) {
			return models.GetNotificationList(), nil
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
			return models.FindNotificationByID(uint(v)), nil
		},
	}
}
