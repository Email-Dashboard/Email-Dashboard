# Email Dashboard

This service helps you to manage notifications that you are sending to your users. It's an amazing tool to manage your outgoing emails from your apps.

![](https://github.com/Email-Dashboard/Email-Dashboard/blob/master/docs/activities.png?raw=true)

<br/>


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


```
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
   "delivery": { # optional
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

### Clone repo

```bash
 git clone https://github.com/Email-Dashboard/Email-Dashboard.git
```

* Update environment variables with your variables https://github.com/Email-Dashboard/Email-Dashboard/blob/master/.env

## Deployment

```bash
  sudo docker-compose build
  sudo docker-compose run web rake db:migrate
  sudo docker-compose up -d
```

## Authors
| [<img src="https://pbs.twimg.com/profile_images/508440350495485952/U1VH52UZ_200x200.jpeg" width="100px;"/>](https://twitter.com/sahinboydas)   | [Sahin Boydas](https://twitter.com/sahinboydas)<br/><br/><sub>Co-Founder @ [LeoApp](https://leoapp.com)</sub><br/> [![LinkedIn][1.1]][1]| [<img src="https://avatars1.githubusercontent.com/u/989759?s=460&v=4" width="100px;"/>](https://github.com/muhammet)   | [Muhammet](https://github.com/muhammet)<br/><br/><sub>Developer @ [LeoApp](https://leoapp.com)</sub><br/> [![Github][2.1]][2] | [<img src="https://avatars1.githubusercontent.com/u/8470005?s=460&v=4" width="100px;"/>](https://github.com/sadikay)   | [Sadik](https://github.com/sadikay)<br/><br/><sub>Developer @ [LeoApp](http://leoapp.com)</sub><br/> [![Github][3.1]][3]
| - | :- | - | :- | - | :- |

[1.1]: https://www.kingsfund.org.uk/themes/custom/kingsfund/dist/img/svg/sprite-icon-linkedin.svg (linkedin icon)
[1]: https://www.linkedin.com/in/sahinboydas
[2.1]: http://i.imgur.com/9I6NRUm.png (github.com/muhammet)
[2]: http://www.github.com/muhammet
[3.1]: http://i.imgur.com/9I6NRUm.png (github.com/sadikay)
[3]: http://www.github.com/sadikay
