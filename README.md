# Simple CRUD API in Go
This is an example of a minimalist api that might be ideal for prototyping.

Read the walkthrough on my blog at:http://cgrant.io/tutorials/go/simple-crud-api-with-go-gin-and-gorm/




## Dynamic Model - Simply update the struct
It has AutoMigrate enabled in the main function which allows the model struct to me changed as needed during development phases.

## Simplified Data Persistence with GORM
In general I'm not a fan of ORM solutions, and in practice I would recommend manually coding the persistence logic. This code however is intended to shorten the cycle and focus on prototyping in as little code as possible. I’ve found GORM to be a popular and flexible ORM. It seems to be pretty good in this space.

## Simplified route handling with Gin
Previously I worked with gorilla and negroni for my web handling. I stumble across Gin and didn't want yet another new framework but it turned out to be just want I needed here. It's straightforward and simple with some built in features ideal for API work

## Favorite Parts
In general I like that I can get a working solution with just 80 lines of code.

Also I liked the parsing and mapping from the request to persistence. You're able to pass in one field or the entire model and the system correctly updates. No need to specify the exact input.

Streamlined update. There a bit of code in the upsert method that gets a model from the db, and the maps the PUT body onto it, then saves it in three simple lines. It was just refreshingly simple.  

```
db.Where("id = ?", id).First(&person)
c.BindJSON(&person)
db.Save(&person)
```

## Wrap up
Any rate I'll probably use this for simple prototyping and tutorials. Clearly needs more code before production use.
