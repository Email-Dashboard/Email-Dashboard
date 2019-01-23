package middlewares

import (
	"net/http"
	"strings"

	"Email-Dashboard/go-api-worker/models"

	"github.com/gin-gonic/gin"
)

func JWTAuth() gin.HandlerFunc {
	return func(c *gin.Context) {
		token := c.Request.Header.Get("Authorization")
		token = strings.TrimPrefix(token, "Token ")

		var notif models.Notification
		models.GetDB().Find(&notif, "slug = ?", c.Params.ByName("id"))

		var account models.Account
		models.GetDB().Find(&account, "api_key = ?", token)

		if notif.AccountID != account.ID || notif.AccountID == 0 {
			c.JSON(http.StatusUnauthorized, gin.H{
				"statusCode": http.StatusUnauthorized,
				"message":    "Unauthorized Error",
			})
			c.Abort()
			return
		}
		c.Next()
		return
	}
}
