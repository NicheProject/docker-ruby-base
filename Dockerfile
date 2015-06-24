# This docker file sets up the rails app container
#
# https://docs.docker.com/reference/builder/

FROM phusion/passenger-ruby22:0.9.15
MAINTAINER Mike Heijmans <mheijmans@twitter.com>

# Fix issue relating to bogus debconf error messages
# https://github.com/phusion/baseimage-docker/issues/58
ENV TERM linux
ENV DEBIAN_FRONTEND noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Fix a problem in config file handling by pulling nginx conflict packages
RUN apt-get purge nginx-common -y

# update the apt repo before we start
RUN apt-get update && apt-get dist-upgrade -qq -y

# install base packages
RUN apt-get install -qq -y imagemagick \
  curl wget nodejs apt-transport-https \
  ca-certificates libav-tools libpq-dev \
  libxml2-dev libxslt1-dev libqt4-webkit \
  libqt4-dev xvfb nginx-extras nginx-common

ENV TERM xterm

ENV APP_HOME /webapp
ENV GEM_HOME /.bundle

RUN mkdir $GEM_HOME
RUN mkdir $APP_HOME
