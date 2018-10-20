FROM ruby:2.4.2

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN apt-get install -y wget
RUN apt-get install -y libc6-dev
RUN apt-get install -y libevent-dev

# Yarn requirements
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

# Mysql requirements
RUN apt-get install -y libmysqlclient-dev

RUN mkdir -p /rails-dashboard/tmp/pids

WORKDIR /rails-dashboard

RUN mkdir /var/db

ADD Gemfile /rails-dashboard/Gemfile
ADD Gemfile.lock /rails-dashboard/Gemfile.lock
RUN bundle install

ENV RAILS_ENV development
ENV RACK_ENV development

ADD . /rails-dashboard

RUN yarn install

RUN chown -R root:root /rails-dashboard

CMD ["rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
