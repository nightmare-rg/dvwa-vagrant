#!/bin/bash - 
#===============================================================================
#
#          FILE: bootstrap.sh
# 
#         USAGE: ./bootstrap.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 24.02.2014 09:23
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

apt-get update

sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password vmdev'
sudo debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password vmdev'
sudo apt-get update
sudo apt-get -y install mysql-server-5.5 php5-mysql apache2 php5 vim

rm -rf /var/www
ln -s /vagrant/dvwa-1.0.8 /var/www

mysql -u root -pvmdev < /vagrant/dvwa.sql

ln -s /vagrant/z_custom.ini /etc/php5/conf.d/z_custom.ini

sudo service apache2 restart
