# Email Dashboard

Uygulamalarından kullanıcılara gönderdiğin emailleri görüntüleyebilmek ve bu emailleri tek bir yerde toplayıp yönetmeyi sağlar.


![](https://github.com/Email-Dashboard/Email-Dashboard/blob/master/docs/assets/intro.gif?raw=true)

## Demo & Dokuman

Demo: https://dashboard.pigon.ws

Dokumanlar: https://email-dashboard.readthedocs.io/en/latest

## Kod Özeti
* REST API en hızlı dillerden biri olan [golang](https://github.com/golang/go) ile geliştirildi.
* Dashboard esnek ve hızlı uygulama geliştirme frameworkü [Rails](https://github.com/rails/rails) ile geliştirildi.
* Front-end kısmında [uikit](https://github.com/uikit/uikit) css frameworkü kullanıldı.


## Features
- [x] Servisinden gönderdiğin emailleri görüntüleme.
- [x] Değişken destekli email şablonları.
- [x] Çoklu SMTP desteği.
- [x] Saat dilimi belirterek ileri zamanlı email gönderimi.
- [x] İleri zamanlı emailleri anlık gönderme / iptal etme.
- [ ] Email takibi.
- [ ] A/B testi.


## Kullanım
### Dashboard
* SMTP Ayarlarını ekle
* Email şablonu ([handlebars](http://handlebarsjs.com/) destekli) oluştur.
* Yeni bildirim oluştur

### REST API'ya istek at

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
   "delivery": { # isteğe bağlı
     "time": "21:00",
     "date": "2018-09-22",
     "zone": "Europe/Istanbul"
   }
}
```

## Kurulum

### Docker Kurulumu

#### Linux
Docker'ın en son sürümünü [resmi sayfasından](http://docs.docker.com/engine/installation/) yükleyebilir veya terminalinizden şu komutu çalıştırabilirsiniz:

```bash
wget -qO- https://get.docker.com/ | sh
```

Docker'ı root kullanıcı olmadan çalıştırabilmek için şu komututu run edin.
```bash
sudo usermod -aG docker ${USER}

newgrp docker
```

#### MacOS
Buradaki yönlendirmeleri takip edebilirsiniz: https://store.docker.com/editions/community/docker-ce-desktop-mac

### Docker Compose Kurulumu
Docker Compose'u [resmi sayfasından](https://docs.docker.com/compose/install/) yükleyebilir, veya terminalinizden şu komutu çalıştırabilirsiniz:

```bash
curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

### Veri Klasörlerini Oluşturma

##### Ubuntu
```bash
 mkdir -p /datadrive/mysql && mkdir -p /datadrive/data/redis
```

##### macOS
```bash
 mkdir -p ~/datadrive/mysql && mkdir -p ~/datadrive/data/redis
```

### Repoyu Clonla

```bash
 git clone https://github.com/Email-Dashboard/Email-Dashboard.git
```

* Buradaki değişkenleri kendi sistemine göre ayarla https://github.com/Email-Dashboard/Email-Dashboard/blob/master/.env

* Eğer macOS üzerinde çalıştıryorsan: `docker-compose.yml` daki ilgili satırları aktif edebilirsin.

## Deploy Et

```bash
  docker-compose build
  docker-compose run web rake db:migrate
  docker-compose up -d
```

## Katıkıda Bulun
Katkıda bulunmak için bu [dökümana](https://email-dashboard.readthedocs.io/en/latest/Contributing/) göz at.

1. Projeyi forkla
2. Kendi branchini yarat (`git checkout -b my-new-feature`)
3. Değişikliklerini commitle (`git commit -am 'Add some feature'`)
4. Branchini gönder (`git push origin my-new-feature`)
5. Yeni Pull Request yarat

## Ekip
| [<img src="https://pbs.twimg.com/profile_images/508440350495485952/U1VH52UZ_200x200.jpeg" width="100px;"/>](https://twitter.com/sahinboydas)   | [Sahin Boydas](https://twitter.com/sahinboydas)<br/><br/><sub>Co-Founder @ [LeoApp](https://leoapp.com)</sub><br/> [![LinkedIn][1.1]][1]| [<img src="https://avatars1.githubusercontent.com/u/989759?s=460&v=4" width="100px;"/>](https://github.com/muhammet)   | [Muhammet](https://github.com/muhammet)<br/><br/><sub>Developer @ [LeoApp](https://leoapp.com)</sub><br/> [![Github][2.1]][2] | [<img src="https://avatars1.githubusercontent.com/u/8470005?s=460&v=4" width="100px;"/>](https://github.com/sadikay)   | [Sadik](https://github.com/sadikay)<br/><br/><sub>Developer @ [LeoApp](http://leoapp.com)</sub><br/> [![Github][3.1]][3]
| - | :- | - | :- | - | :- |

[1.1]: https://www.kingsfund.org.uk/themes/custom/kingsfund/dist/img/svg/sprite-icon-linkedin.svg (linkedin icon)
[1]: https://www.linkedin.com/in/sahinboydas
[2.1]: http://i.imgur.com/9I6NRUm.png (github.com/muhammet)
[2]: http://www.github.com/muhammet
[3.1]: http://i.imgur.com/9I6NRUm.png (github.com/sadikay)
[3]: http://www.github.com/sadikay

## Lisans

Bu yazılımın kullanımı, [LICENSE](LICENSE) dosyasında belirtilen şartlara ve koşullara tabidir

