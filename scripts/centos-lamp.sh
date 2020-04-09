#!/bin/bash

sudo yum update -y --exclude=kernel

# tools
sudo yum install -y nano git unzip screen

# apache2
sudo yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

# Setup Symlink to shared folder hosting WWW files
rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# php
sudo yum install -y php php-cli php-common php-devel php-mysql

# mysql
sudo yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on

service mysqld start

mysql -u root -e "SHOW DATABASES";

# Download Starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/afeets/vagrant/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/afeets/vagrant/master/files/info.php

service httpd restart
