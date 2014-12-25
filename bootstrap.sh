#!/bin/bash - 
#===============================================================================
#
#          FILE: bootstrap.sh
# 
#         USAGE: ./bootstrap.sh 
# 
#   DESCRIPTION: runs at boot in vagrant to provision server with preinstalled software
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 25.12.2014 11:29
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

apt-get update

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vmdev'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vmdev'
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5 vim

rm -rf /var/www/*
mkdir -p /var/www
ln -s /vagrant/dvwa-1.0.8 /var/www/html

mysql -u root -pvmdev < /vagrant/dvwa.sql

mkdir -p /etc/php5/conf.d
ln -s /vagrant/z_custom.ini /etc/php5/conf.d/z_custom.ini

sudo service apache2 restart
