#!/bin/bash

yum update -y --exclude=kernel

# tools
yum install -y nano git unzip screen yum-utils

# apache2
yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

# Setup Symlink to shared folder hosting WWW files
rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# enable repositories for php 5.6
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum-config-manager --enable remi-php56

# php
yum install -y php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo

# mysql
yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on

service mysqld start

mysql -u root -e "SHOW DATABASES";

# Download Starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/afeets/centos65-lamp/master/files/index.html
sudo -u vagrant wget -q https://raw.githubusercontent.com/afeets/centos65-lamp/master/files/info.php

service httpd restart
