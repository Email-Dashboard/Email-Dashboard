FROM ruby:2.4.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev apt-transport-https apt-utils

RUN apt-get install -y libxml2-dev libxslt1-dev

RUN apt-get install -y wget
RUN apt-get install -y libc6-dev
RUN apt-get install -y libevent-dev

# for a JS runtime
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y yarn

# Mysql requirements
RUN apt-get install -y libmysqlclient-dev

RUN mkdir -p /notification-center/tmp/pids

WORKDIR /notification-center

RUN mkdir /var/db

ADD Gemfile /notification-center/Gemfile
ADD Gemfile.lock /notification-center/Gemfile.lock
RUN /bin/bash -l -c "bundle install --without development test"

ENV RAILS_ENV production
ENV RACK_ENV production

ADD . /notification-center

EXPOSE 8080

RUN bundle exec rake RAILS_ENV=production assets:precompile
RUN NODE_ENV=production yarn install
RUN NODE_ENV=production RAILS_ENV=production bundle exec rake webpacker:compile

RUN chown -R root:root /notification-center

CMD ["puma","-C","config/puma_production.rb", "-e production"]