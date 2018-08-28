# Email Dashboard

This service helps you to manage notifications that you are sending to your users. It's an amazing tool to manage your outgoing emails from your apps.


## Features
- [x] Monitor email activies that your service sent.
- [x] Interactive tempates.
- [x] Multiple SMTP support.
- [x] Scheduled delivery with time zone.
- [ ] Tracking.
- [ ] A/B testing.


## Usage

Posting to REST API.

`/POST https://api.{{yourhost}}/api/v3/notifications/{{notification-slug}}`

`Authorization: Token {{AccountToken}}`


```json
{
   "variables":{
      "button_name": "Click me!",
      "name": "John"
   },
   "email": {
      "to": ["test@example.com", "second-to@example.com"],
      "cc": ["cc-test@example.com"],
      "reply_to": ["reply-to@example.com"],
      "from": "myapp@example.com"
   },
   // optional
   "delivery": {
     "time": "21:00",
     "date": "2018-09-22",
     "zone": "Europe/Istanbul"
   }
}
```

## Installation

### Install Docker
Install the most recent version of the Docker Engine for your platform using the [official Docker releases](http://docs.docker.com/engine/installation/), which can also be installed using:

```bash
wget -qO- https://get.docker.com/ | sh
```

### Install Docker Compose
Install docker compose from the [official page](https://docs.docker.com/compose/install/).

```bash
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### Create data folders
```bash
  mkdir -p /datadrive/mysql && mkdir -p /datadrive/data/redis
```

* Update environment variables with your variables https://github.com/Email-Dashboard/Email-Dashboard/blob/master/.env

## Deployment

```bash
  sudo docker-compose build
  sudo docker-compose run web rake db:migrate
  sudo docker-compose up -d
```
