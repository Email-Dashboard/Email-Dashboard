package main

import (
	"Email-Dashboard/go-api-worker/graphql/relay"
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
	"github.com/graphql-go/graphql"
	"github.com/graphql-go/handler"
)

func main() {
	runGin()
}

func runGin() {
	router := gin.Default()
	gin.SetMode(gin.DebugMode)
	router.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, fmt.Sprintf("Hello from Email Dashboard API!"))
	})

	api := router.Group("/api/v3")
	//api.Use(middlewares.JWTAuth())

	relay.Init()
	schema := relay.Schema

	api.POST("/graphql", GraphqlHandler(schema))
	api.GET("/graphql", GraphqlHandler(schema))

	router.Run(":8080")
}

//GraphqlHandler func
func GraphqlHandler(schema graphql.Schema) gin.HandlerFunc {
	h := handler.New(&handler.Config{
		Schema: &schema,
	})

	return func(c *gin.Context) {
		h.ServeHTTP(c.Writer, c.Request)
	}
}
