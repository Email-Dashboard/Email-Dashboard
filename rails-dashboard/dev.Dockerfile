FROM ruby:2.4.2

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN apt-get install -y wget
RUN apt-get install -y libc6-dev
RUN apt-get install -y libevent-dev

# Yarn requirements
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -qq -y build-essential libpq-dev nodejs yarn

# Mysql requirements
RUN apt-get install -y libmysqlclient-dev

RUN mkdir /build && mkdir /dashboard

COPY Gemfile /var/app/Gemfile
COPY Gemfile.lock /var/app/Gemfile.lock
COPY package.json /var/app/package.json

WORKDIR /var/app

RUN bundle install
RUN yarn install

COPY . /var/app

ENV RAILS_ENV development
ENV RACK_ENV development
CMD  rake db:migrate
