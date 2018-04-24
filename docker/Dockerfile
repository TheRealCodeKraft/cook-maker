FROM ubuntu:14.04

FROM ruby:2.4.2
MAINTAINER arnaud@codekraft.fr

RUN apt-get update && apt-get install -y \
  git 

RUN gem install rails

ADD https://api.github.com/repos/TheRealCodeKraft/cook-maker/git/refs/heads/master version.json
RUN git clone https://github.com/TheRealCodeKraft/cook-maker.git

RUN mkdir -p /build

WORKDIR /build
CMD ["/bin/sh", "-c", "../cook-maker/docker-cook -a ${name} -d \"Description of ${name}\" -v 1.1.17"]
