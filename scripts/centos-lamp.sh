#!/usr/bin/env bash

yum update -y --exclude=kernel
yum install -y nano git unzip screen

# apache2
yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

# Setup Symlink to shared folder hosting WWW files
rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# php
yum install -y php php-cli php-common php-devel php-mysql

# mysql
yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on

service mysqld start

mysql -u root -e "SHOW DATABASES";

# Download Starter content

service httpd restart
