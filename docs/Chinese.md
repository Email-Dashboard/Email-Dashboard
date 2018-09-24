# Email Dashboard

这个服务可以帮助您管理要发送给用户的通知。这是一个很棒的工具，可以管理您应用中的外发电子邮件。

![](https://github.com/Email-Dashboard/Email-Dashboard/blob/master/docs/assets/intro.gif?raw=true)

## 演示 & 文档

演示： https://dashboard.pigon.ws

文档： https://email-dashboard.readthedocs.io/en/latest

## 代码概述
* REST API使用超高速语言[golang](https://github.com/golang/go)构建。
* 仪表盘使用最快的开发框架[Rails](https://github.com/rails/rails)构建。
* 仪表盘使用的前端框架为[uikit](https://github.com/uikit/uikit)。


## 特性
- [x] 监控服务发送的电子邮件活动。
- [x] 交互式模板。
- [x] 多个SMTP支持。
- [x] 根据时区计划发送。
- [x] 可选择执行/取消预定活动。
- [ ] 跟踪。
- [ ] A/B测试。


## 使用方法
### 在仪表盘中
* 添加你的SMTP设置。
* 使用[handlebars](http://handlebarsjs.com/)变量创建电子邮件模板。
* 创建通知

### 发布到REST API

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

## 安装

### 安装 Docker

#### Linux
点击[official Docker releases](http://docs.docker.com/engine/installation/)为您的平台安装最新版本的Docker Engine，也可以使用以下命令安装：

```bash
wget -qO- https://get.docker.com/ | sh
```

执行这一行以允许Docker不是在root账户下运行
```bash
sudo usermod -aG docker ${USER}
```
注销后再次登录，就有权限运行了。

#### MacOS
按照安装说明进行操作：https://store.docker.com/editions/community/docker-ce-desktop-mac

### 安装 Docker Compose
从[official page](https://docs.docker.com/compose/install/)安装下载docker compose，或手动执行：

```bash
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### 创建数据文件夹

##### Ubuntu
```bash
 mkdir -p /datadrive/mysql && mkdir -p /datadrive/data/redis
```

##### macOS
```bash
 mkdir -p ~/datadrive/mysql && mkdir -p ~/datadrive/data/redis
```

### 克隆该仓库

```bash
 git clone https://github.com/Email-Dashboard/Email-Dashboard.git
```

* 使用你的变量更新环境变量https://github.com/Email-Dashboard/Email-Dashboard/blob/master/.env

* 如果您在macOS上运行，请取消在`docker-compose.yml`中对应的注释

## 部署运行

```bash
  docker-compose build
  docker-compose run web rake db:migrate
  docker-compose up -d
```

## 参与贡献
参考[contributing](https://email-dashboard.readthedocs.io/en/latest/Contributing/)指南。

1. Fork 该仓库
2. 创建一个新的分支 (`git checkout -b my-new-feature`)
3. 提交你的修改 (`git commit -am 'Add some feature'`)
4. 上传到远程分支 (`git push origin my-new-feature`)
5. 创建 Pull Request

## 开发者
| [<img src="https://pbs.twimg.com/profile_images/508440350495485952/U1VH52UZ_200x200.jpeg" width="100px;"/>](https://twitter.com/sahinboydas)   | [Sahin Boydas](https://twitter.com/sahinboydas)<br/><br/><sub>Co-Founder @ [LeoApp](https://leoapp.com)</sub><br/> [![LinkedIn][1.1]][1]| [<img src="https://avatars1.githubusercontent.com/u/989759?s=460&v=4" width="100px;"/>](https://github.com/muhammet)   | [Muhammet](https://github.com/muhammet)<br/><br/><sub>Developer @ [LeoApp](https://leoapp.com)</sub><br/> [![Github][2.1]][2] | [<img src="https://avatars1.githubusercontent.com/u/8470005?s=460&v=4" width="100px;"/>](https://github.com/sadikay)   | [Sadik](https://github.com/sadikay)<br/><br/><sub>Developer @ [LeoApp](http://leoapp.com)</sub><br/> [![Github][3.1]][3]
| - | :- | - | :- | - | :- |

[1.1]: https://www.kingsfund.org.uk/themes/custom/kingsfund/dist/img/svg/sprite-icon-linkedin.svg (linkedin icon)
[1]: https://www.linkedin.com/in/sahinboydas
[2.1]: http://i.imgur.com/9I6NRUm.png (github.com/muhammet)
[2]: http://www.github.com/muhammet
[3.1]: http://i.imgur.com/9I6NRUm.png (github.com/sadikay)
[3]: http://www.github.com/sadikay

## 开源协议

使用本软件须遵守[LICENSE](LICENSE)中所规定的重要条款和条件。
