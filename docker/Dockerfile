FROM ubuntu:14.04

FROM ruby:2.4.2
MAINTAINER arnaud@codekraft.fr

RUN apt-get update && apt-get install -y \
  git 

RUN gem install rails

# Make ssh dir
RUN mkdir /root/.ssh/

VOLUME .:/build

# Copy over private key, and set permissions
#ADD id_rsa /root/.ssh/id_rsa

# Create known_hosts
#RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
#RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN git clone https://github.com/TheRealCodeKraft/cook-maker.git

RUN mkdir -p /build
WORKDIR /build
CMD ["../cook-maker/docker/cook-example"]
