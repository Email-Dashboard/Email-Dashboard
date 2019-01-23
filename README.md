
<h3 align="center">
   Email Dashboard
   <br>
</h3>

<p align="center">
   An interactive emailing management service<br> 
   with scheduling, templating, tracking and A/B testing.<br>
   <a href="https://email-dashboard.github.io/guide/">
   <strong>Explore Email Dashboard docs »</strong>
   </a>
 </p>
 
 <p align="center">
   <a href="https://github.com/Email-Dashboard/Email-Dashboard/labels/bug">
      <strong>Report bug </strong></a>|
      
   <a href="https://github.com/Email-Dashboard/Email-Dashboard/labels/enhancement">
      <strong>Request feature </strong></a>|
   
   <a href="https://github.com/Email-Dashboard/Email-Dashboard/labels/help%20wanted">
      <strong>Help issues</strong></a>
   </a><br><br>
   
   <a href="./README-zh_CN.md">
       🇨🇳[简体中文]</a>
   </a> 
 </p>
 
# Description

![](https://img.shields.io/github/stars/Email-Dashboard/Email-Dashboard.svg) ![](https://img.shields.io/github/forks/Email-Dashboard/Email-Dashboard.svg) ![](https://img.shields.io/github/tag/Email-Dashboard/Email-Dashboard.svg) ![](https://img.shields.io/github/issues/Email-Dashboard/Email-Dashboard.svg) ![](https://img.shields.io/github/contributors/Email-Dashboard/Email-Dashboard.svg) ![](https://img.shields.io/bower/Email-Dashboard/Email-Dashboard.svg) [![Go Report Card](https://goreportcard.com/badge/github.com/Email-Dashboard/Email-Dashboard)](https://goreportcard.com/report/github.com/Email-Dashboard/Email-Dashboard) ![](https://img.shields.io/github/license/Email-Dashboard/Email-Dashboard.svg) 

Email-Dashboard is an easy way to manage your outgoing emails from your apps. From creating and sending your emails to monitoring and managing their stats, you can do really useful things with Email-Dashboard without worried about **time zone** disaverage. You can reach free live version of Email-Dashboard on [here](https://dashboard.pigon.ws). 

<p>
   <a target="_blank" rel="noopener noreferrer" href="https://github.com/Email-Dashboard/Email-Dashboard/blob/master/docs/assets/intro.gif?raw=true"><img src="https://github.com/Email-Dashboard/Email-Dashboard/raw/master/docs/assets/intro.gif?raw=true" alt="" style="max-width:100%;"></a>
</p>

# Table of content
   
- [For whom?](https://github.com/mesutgulecen/Email-Dashboard#for-whom)
- [Code overview](https://github.com/mesutgulecen/Email-Dashboard#code-overview)
- [Features](https://github.com/mesutgulecen/Email-Dashboard#features)
- [Installation](https://github.com/mesutgulecen/Email-Dashboard#installation)
   * [1- Ubuntu Production](https://github.com/mesutgulecen/Email-Dashboard#1--ubuntu-production)
   * [2- Deployment](https://github.com/mesutgulecen/Email-Dashboard#2--deployment)
   * [3- Development Installation](https://github.com/mesutgulecen/Email-Dashboard#3--development-installation)
- [Usage](https://github.com/mesutgulecen/Email-Dashboard#usage)
   * [1- In Dashboard](https://github.com/Email-Dashboard/Email-Dashboard#in-dashboard)
   * [2- Posting to REST API](https://github.com/Email-Dashboard/Email-Dashboard#posting-to-rest-api)
- [Contributing](https://github.com/mesutgulecen/Email-Dashboard#contributing)
- [Authors](https://github.com/mesutgulecen/Email-Dashboard#authors)
- [License](https://github.com/mesutgulecen/Email-Dashboard#license)
- [Acknowledgement](https://github.com/mesutgulecen/Email-Dashboard#acknowledgement)
   
# For whom?

* :earth_asia: If you need to send automatic emails without worried about **time zone**,
* 🔍 If you need to **track** your emails and **analyse** your results to follow better strategies,
* 📊 If you need to **monitoring** your activities,
* 📑 If you want to use email **templates**,
* 🕵️ If you need to **A/B testing**,
* 💯 And if you want to do all of this **easily**,
 
Then you're at the right place. **Email Dashboard builded for you!** :tada:

# Code overview

* The REST API builded with superfast language [golang](https://github.com/golang/go).
* The Dashboard builded with fastest development framework [Rails](https://github.com/rails/rails)
* Front-end framework [uikit](https://github.com/uikit/uikit) using in the dashboard.

# Features
- [x] Monitor email activities that your service sent.
- [x] Interactive templates.
- [x] Multiple SMTP support.
- [x] Scheduled delivery with time zone.
- [x] Perform / Cancel scheduled activities optionally.
- [x] Mobile UI
- [ ] Email tracking.
- [ ] A/B testing.
   
# Installation

### 1- Ubuntu Production
   
- Install the most recent version of the Docker Engine for your platform using the [official Docker releases](http://docs.docker.com/engine/installation/), which can also be installed using:

```bash
wget -qO- https://get.docker.com/ | sh
```

- Execute this line to allow docker to execute without being root

```bash
sudo usermod -aG docker ${USER}
```
- Logout, then login again. Permissions should be applied.

- Install Docker Compose from the [official page](https://docs.docker.com/compose/install/), or manually run:

```bash
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

- Create data folders

```bash
 mkdir -p /datadrive/mysql && mkdir -p /datadrive/data/redis
```

- Clone repo

```bash
 git clone https://github.com/Email-Dashboard/Email-Dashboard.git
```

- Update environment variables with your variables https://github.com/Email-Dashboard/Email-Dashboard/blob/master/.env

- If you are running on macOS enable commented lines in `docker-compose.yml`

### 2- Deployment
   
You can read our [deployment doc](https://email-dashboard.github.io/guide/deployment.html#ubuntu-production) for Ubuntu production. Also you can read [offical Docker guild](https://docs.docker.com/get-started/) for usage of Docker.

```bash
  docker-compose build
  docker-compose up -d
```
### 3- Development Installation
   
:small_red_triangle_down: <strong>For macOS</strong>

- Install and start Docker, check [docker-ce-desktop-mac](https://store.docker.com/editions/community/docker-ce-desktop-mac).

- Create Datafolders

```mkdir -p ~/datadrive/ed/mysql && mkdir -p ~/datadrive/ed/redis```

- Clone the repo

```git clone https://github.com/Email-Dashboard/Email-Dashboard.git```

- Update mac username in ```docker-compose-dev.yml``` in ```line 7``` and ```line 27```

```/Users/MacUserName/datadrive/ed/mysql:/var/lib/mysql # update MacUserName with yours```

- Start

```
docker-compose -f docker-compose-dev.yml build
docker-compose -f docker-compose-dev.yml run web rake db:migrate
docker-compose -f docker-compose-dev.yml up
```

- Dashboard url: http://localhost:3000
- Make API requests to http://localhost:8080

:small_red_triangle_down: <strong>For Ubuntu</strong>

- installed using:

```wget -qO- https://get.docker.com/ | sh```

- Execute this line to allow docker to execute without being root

```sudo usermod -aG docker ${USER} # Logout, then login again. Permissions should be applied.```

- Create Datafolders

```mkdir -p /datadrive/data/mysql && mkdir -p /datadrive/data/redis```

- Clone the repo

```git clone https://github.com/Email-Dashboard/Email-Dashboard.git```

- Update ```line 7``` and ```line 27``` in ```docker-compose-dev.yml``` to:

```-'/datadrive/data/mysql:/var/lib/mysql'```<br>
```...```<br>
```- '/datadrive/data/redis:/data'```

- Start

```
docker-compose -f docker-compose-dev.yml build
docker-compose -f docker-compose-dev.yml run web rake db:migrate
docker-compose -f docker-compose-dev.yml up
```

- Dashboard url: http://localhost:3000
- Make API requests to http://localhost:8080

# Usage

### 1- In Dashboard

Using dashboard is really easy, like playing PUBG! You can do it any time without any effort. Because our first aim is make some time for our users with our dashboard. So, UI and dashboard is friendly as much as and we will make it better.

* Add your SMTP Settings
* Create email template with [handlebars](http://handlebarsjs.com/) variables.
* Create notification. See, easy peasy!

| Column | Description |
| ------------- | ------------- |
| Activities | You can track your email activities. |
| Notifications | You can create notifications, change their settings, or destroy them. |
| SMTP | You can create new SMTP with multiple choice. |
| Templates | You can create new email templates, edit or destroy them. |
| Accounts | You can create sub accounts and manage them easily. |


### 2- Posting to REST API

`POST` `https://api.{{yourhost}}/api/v3/notifications/{{notification-slug}}`

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
# Contributing
Please read our [contribution guidelines](https://email-dashboard.readthedocs.io/en/latest/Contributing/). We are grateful for all contributions! :pray: With following our [rules of the discussions](https://github.com/Email-Dashboard/Email-Dashboard/blob/master/CONTRIBUTING.md), you can contribute many of way. Our [issue tracker](https://github.com/Email-Dashboard/Email-Dashboard/issues) is the preferred channel for bug reports, features requests and submitting pull requests. We utilized several [labels](https://github.com/Email-Dashboard/Email-Dashboard/labels) to help organize and identify issues. You can start with there! Also if you want to add some new feature:

1. Clone or fork the project (`git clone https://github.com/Email-Dashboard/Email-Dashboard`)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

:mag_right: But before opening a feature request, please take a moment to find out whether your idea fits with the scope and aims of the project. It's up to you to make a strong case to convince the project's developers of the merits of this feature. So, you can provide as much detail and context as possible.

---------------------------

# Authors
| [<img src="https://pbs.twimg.com/profile_images/508440350495485952/U1VH52UZ_200x200.jpeg" width="100px;"/>](https://twitter.com/sahinboydas) <br/> [Sahin Boydas](https://twitter.com/sahinboydas)<br/><sub>Co-Founder @ [LeoApp](https://leoapp.com)</sub><br/> [![LinkedIn][1.1]][1] | [<img src="https://avatars1.githubusercontent.com/u/989759?s=460&v=4" width="100px;"/>](https://github.com/muhammet) <br/>[Muhammet](https://github.com/muhammet)<br/><sub>Developer @ [LeoApp](https://leoapp.com)</sub><br/> [![Github][2.1]][2] | [<img src="https://avatars1.githubusercontent.com/u/8470005?s=460&v=4" width="100px;"/>](https://github.com/sadikay)  <br/>[Sadik](https://github.com/sadikay)<br/><sub>Developer @ [LeoApp](http://leoapp.com)</sub><br/> [![Github][3.1]][3] | [<img src="https://avatars0.githubusercontent.com/u/7591815?s=460&v=4" width="100px;"/>](http://blog.tommyyang.cn/) <br/> [Tommy Yang](https://github.com/joyang1)<br/><sub>Developer</sub><br/> [![Github][4.1]][4] [blog](https://blog.tommyyang.cn)
| - | - | - | - |

[1.1]: https://www.kingsfund.org.uk/themes/custom/kingsfund/dist/img/svg/sprite-icon-linkedin.svg (linkedin icon)
[1]: https://www.linkedin.com/in/sahinboydas
[2.1]: http://i.imgur.com/9I6NRUm.png (github.com/muhammet)
[2]: http://www.github.com/muhammet
[3.1]: http://i.imgur.com/9I6NRUm.png (github.com/sadikay)
[3]: http://www.github.com/sadikay

[4.1]: http://i.imgur.com/9I6NRUm.png (github.com/joyang1)
[4]: http://www.github.com/joyang1

[5.1]: Blog
[5]: https://blog.tommyyang.cn

# License

This program is a free and open source software. You can redistribute it and/or modify it under the terms of the license provided in the [LICENSE](LICENSE) file. Use of this software is subject to important terms and conditions as set forth in the [LICENSE](LICENSE) file.

# Acknowledgement

If you liked our dashboard, please give us a "**Star**" :star:. Your support is what keep us moving forward and delivering happiness to you! Thank's a million, you're our Clark Kent/Kara Danvers! In case of any questions or concerns, feel free to contact us anytime.:blush:
