FROM ubuntu:14.04
MAINTAINER James Holder "james@thesquarefoot.com"
ENV REFRESHED_AT 2015-04-21
RUN apt-get update
run apt-get -y -q install zlib1g zlib1g-dev
run apt-get -y -q install sqlite3 libsqlite3-dev
RUN apt-get -y -q install ruby2.0 ruby2.0-dev
RUN apt-get -y -q install nodejs

# Make sure that /usr/bni/ruby et al point to v2.0
sudo rm /usr/bin/ruby /usr/bin/gem /usr/bin/irb /usr/bin/rdoc /usr/bin/erb
sudo ln -s /usr/bin/ruby2.0 /usr/bin/ruby
sudo ln -s /usr/bin/gem2.0 /usr/bin/gem
sudo ln -s /usr/bin/irb2.0 /usr/bin/irb
sudo ln -s /usr/bin/rdoc2.0 /usr/bin/rdoc
sudo ln -s /usr/bin/erb2.0 /usr/bin/erb
sudo gem update --system
sudo gem pristine --all

RUN gem install --no-rdoc --no-ri bundler rails

ADD blog/ /var/rails/

ENTRYPOINT [ "/var/rails/bin/rails server" ]

EXPOSE 80

