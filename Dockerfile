FROM ruby:3.0.0

ENV APP_HOME /app
ENV HOME /root

RUN apt-get install imagemagick libmagickcore-dev libmagickwand-dev

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME