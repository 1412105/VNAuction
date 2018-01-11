FROM ruby:2.3.3
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /ibid
WORKDIR /ibid
ADD Gemfile /ibid/Gemfile
ADD Gemfile.lock /ibid/Gemfile.lock
ADD . /ibid