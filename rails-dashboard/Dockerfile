FROM ruby:2.4.2

LABEL maintainer="Sadik Ay <sadikay2@gmail.com>"

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs wget libc6-dev libevent-dev



# Yarn requirements
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# WITH MYSQL
RUN apt-get update && apt-get install -y yarn libmysqlclient-dev


RUN mkdir -p /rails-dashboard/tmp/pids

WORKDIR /rails-dashboard

RUN mkdir /var/db

ADD Gemfile /rails-dashboard/Gemfile
ADD Gemfile.lock /rails-dashboard/Gemfile.lock
RUN bundle install --without development test

ENV RAILS_ENV production
ENV RACK_ENV production

ADD . /rails-dashboard

RUN bundle exec rake RAILS_ENV=production assets:precompile
RUN yarn install
RUN NODE_ENV=production RAILS_ENV=production bundle exec rake webpacker:compile

RUN chown -R root:root /rails-dashboard

CMD ["sh","-c","rake db:migrate && puma -C config/puma.rb -e production "]

EXPOSE 80
