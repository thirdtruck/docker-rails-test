FROM ubuntu:14.04
MAINTAINER James Holder "james@thesquarefoot.com"
ENV REFRESHED_AT 2015-04-21
RUN apt-get update
RUN apt-get -y -q install build-essential
RUN apt-get -y -q install zlib1g zlib1g-dev
RUN apt-get -y -q install sqlite3 libsqlite3-dev
RUN apt-get -y -q install ruby2.0 ruby2.0-dev
RUN apt-get -y -q install nodejs

# Make sure that /usr/bni/ruby et al point to v2.0
# TODO: Combine the parts below into a shell script.
RUN sudo rm /usr/bin/ruby /usr/bin/gem /usr/bin/irb /usr/bin/rdoc /usr/bin/erb
RUN sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby
RUN sudo ln -s /usr/bin/gem2.0 /usr/bin/gem
RUN sudo ln -s /usr/bin/irb2.0 /usr/bin/irb
RUN sudo ln -s /usr/bin/rdoc2.0 /usr/bin/rdoc
RUN sudo ln -s /usr/bin/erb2.0 /usr/bin/erb
RUN sudo gem update --system
RUN sudo gem pristine --all

ADD blog/ /var/rails/
WORKDIR /var/rails/

RUN gem install --no-rdoc --no-ri bundler
RUN bundler install

EXPOSE 80

# Bind to an explicit host, since Rails binds to "localhost" by default and this clashes with how Docker exposes services.
CMD [ "/var/rails/bin/rails", "server", "-p", "80", "-b", "0.0.0.0" ]

