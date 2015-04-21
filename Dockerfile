FROM ubuntu:14.04
MAINTAINER James Holder "james@thesquarefoot.com"
ENV REFRESHED_AT 2015-04-21
RUN apt-get update
RUN apt-get -y -q install rails
ADD rails/ /var/rails/
EXPOSE 80

