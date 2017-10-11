FROM ubuntu:14.04

FROM ruby:2.4.2
MAINTAINER arnaud@codekraft.fr

RUN apt-get update && apt-get install -y \
  git 

RUN gem install rails

#RUN curl -sSo /usr/local/bin/n https://raw.githubusercontent.com/visionmedia/n/master/bin/n
#RUN chmod +x /usr/local/bin/n
#RUN n stable

ARG CACHE_DATE=2016-01-01

ADD https://api.github.com/repos/TheRealCodeKraft/cook-maker/git/refs/heads/master version.json
RUN git clone https://github.com/TheRealCodeKraft/cook-maker.git

RUN mkdir -p /build

WORKDIR /build
CMD ["../cook-maker/docker-cook-example"]
