#!/usr/bin/env bash

# Redirect port 80 to 3000
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000

sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8

sudo apt-get update
sudo apt-get install -y build-essential git curl libxslt1-dev libxml2-dev libssl-dev nodejs

# postgres
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main " | sudo tee -a /etc/apt/sources.list.d/pgdg.list
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.3 libpq-dev
echo '# "local" is for Unix domain socket connections only
local   all             all                                  trust
# IPv4 local connections:
host    all             all             0.0.0.0/0            trust
# IPv6 local connections:
host    all             all             ::/0                 trust' | sudo tee /etc/postgresql/9.3/main/pg_hba.conf
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.3/main/postgresql.conf
sudo /etc/init.d/postgresql restart
sudo su - postgres -c 'createuser -s vagrant'
psql -U postgres -c "create role $1 with superuser login"
psql -U postgres -c "create database $1_development with owner=$1;"
# pg_restore --verbose --clean --no-acl --no-owner -h localhost -U $1 -d $1_development /$1/latest.dump


# redirects 3000 to 80 to run zeus server on 3000, while accepting connections
# on 80
sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 3000
# do the same on localhost/loopback, so i don't go crazy trying to figure out
# why something won't work in the future
sudo iptables -t nat -I OUTPUT -p tcp -d 127.0.0.1 --dport 80 -j REDIRECT --to-ports 3000

# redis
sudo apt-get install -y python-software-properties
sudo add-apt-repository -y ppa:rwky/redis
sudo apt-get update
sudo apt-get install -y redis-server

# rvm and ruby
su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
su - vagrant -c 'rvm rvmrc warning ignore allGemfiles'

# node
# su - vagrant -c 'curl https://raw.githubusercontent.com/creationix/nvm/v0.14.0/install.sh | sh'
# su - vagrant -c 'nvm install 0.10'
# su - vagrant -c 'nvm alias default 0.10'

adduser --uid 510  --disabled-password --gecos "" pragone
echo 'pragone ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers

sudo -i -u pragone /bin/sh <<\DEVOPS_BLOCK
mkdir ~/.ssh
touch ~/.ssh/authorized_keys
chmod 600 ~/.ssh/authorized_keys
\curl -sSL https://raw.githubusercontent.com/pcragone/dotfiles/master/install.sh | bash
DEVOPS_BLOCK

sudo -i -u pragone /bin/bash <<\DEVOPS_BLOCK
source $HOME/.rvm/scripts/rvm
gem install tmuxinator
rvm install ruby-2.4.0
rvm use ruby-2.4.0@$1 --create
rvm @global do gem install bundler
gem install eventmachine -v '1.0.8'
gem install unf_ext -v '0.0.7.1'
gem install nokogiri -v '1.6.7'
gem install zeus
cd /$1
bundle install
DEVOPS_BLOCK

sudo chsh -s $(which zsh) pragone


echo "All done installing!"
