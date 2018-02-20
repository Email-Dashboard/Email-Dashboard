# Notification Center


## Development
```bash
git clone git@gitlab.com:rails-auth/auth.git
cd auth
git checkout feature/notification
rails s webrick
# http://lvh.me:3000/

cd ..
git clone git@gitlab.com:notification-center/dashboard.git
cd dashboard
rails s webrick -p 3001
# http://lvh.me:3001
```

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
