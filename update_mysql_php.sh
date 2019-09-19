#!/bin/bash
yum -y update
yum -y install yum-utils
yum-config-manager --enable remi-php74
yum -y update
yum -y install php-opcache
service mysqld stop
yum -y remove mariadb mariadb-server
touch /etc/yum.repos.d/MariaDB.repo
cat <<EOT >> /etc/yum.repos.d/MariaDB.repo
# Used to install MariaDB 10 instead of default 5.5
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = https://yum.mariadb.org/10.2/centos7-amd64/
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOT
yum -y update
yum -y install mariadb mariadb-server
systemctl start mariadb
systemctl enable mariadb.service