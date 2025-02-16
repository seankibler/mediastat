FROM ruby:3.1 AS base

RUN apt-get update -y && \
  apt-get install -y ffmpeg && \
  apt-get clean

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile.lock .

RUN bundle install

COPY mediastat /usr/local/bin/

ENTRYPOINT ["mediastat"]
