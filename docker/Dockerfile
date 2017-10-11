FROM ubuntu:14.04

FROM ruby:2.4.2
MAINTAINER arnaud@codekraft.fr

RUN apt-get update && apt-get install -y \
  git 

RUN gem install rails

RUN curl -sSo /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
RUN chmod +x /usr/local/bin/n
RUN n stable

VOLUME .:/build

RUN git clone https://github.com/TheRealCodeKraft/cook-maker.git

RUN mkdir -p /build
WORKDIR /build
CMD ["../cook-maker/docker-cook-example"]
