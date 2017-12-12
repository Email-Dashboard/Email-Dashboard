# Notification Center

## User

* `has_and_belongs_to_many :accounts`


## AccountUser

* role

## Account

* `has_and_belongs_to_many :accounts`


## Notification

* name
* max deliver in a day 

## Delivery Method

* email
* sms
* channels (slack, teams)
* push notification
* ...

## EmailMethod

* receiver
* content
* smpt settings
* ....

## SmsMethod

* receiver
* content
* api settings (twillio, aws, ...)

## Receiver

* time_zone
* emails
* phones