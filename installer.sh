#!/bin/bash

echo_message() {
  echo -e "\033[1;32m$1\033[0m"
}

PHP_VERSION=$1
SERVER_TYPE=$2
DB_TYPE=$3

if [ -z "$PHP_VERSION" ] || [ -z "$SERVER_TYPE" ] || [ -z "$DB_TYPE" ]; then
  echo_message "Error: Empty parameters. Please provide PHP version, server type, and database type."
  echo_message "Use: $0 <php_version> <server_type> <db_type>"
  exit 1
fi

echo_message "Installing dependencies ..."
sudo apt update && sudo apt upgrade -y
sudo apt install -y zip unzip

echo_message "Add repository PHP ..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update && sudo apt upgrade -y

echo_message "Installing PHP $PHP_VERSION ..."
sudo apt install -y php$PHP_VERSION php$PHP_VERSION-redis php$PHP_VERSION-cli php$PHP_VERSION-fpm php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-mbstring php$PHP_VERSION-curl php$PHP_VERSION-zip php$PHP_VERSION-bcmath php$PHP_VERSION-soap php$PHP_VERSION-intl php$PHP_VERSION-gd php$PHP_VERSION-opcache
sudo systemctl enable php$PHP_VERSION-fpm

echo_message "Installing Server web: $SERVER_TYPE ..."
if [ "$SERVER_TYPE" == "apache" ]; then
  sudo apt install -y apache2 libapache2-mod-fastcgi
  sudo systemctl enable apache2
elif [ "$SERVER_TYPE" == "nginx" ]; then
  sudo apt install -y nginx
  sudo systemctl enable nginx
fi

echo_message "Installing Database: $DB_TYPE ..."
if [ "$DB_TYPE" == "mysql" ]; then
  sudo apt install -y mysql-server
  sudo systemctl enable mysql
elif [ "$DB_TYPE" == "mariadb" ]; then
  sudo apt install -y mariadb-server
  sudo systemctl enable mariadb
fi

echo_message "Installing Redis ..."
sudo apt install -y redis-server
sudo systemctl enable redis-server

echo_message "Installing Supervisor ..."
sudo apt install -y supervisor
sudo systemctl enable supervisor

echo_message "Installing composer ..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

echo_message "Installing NodeJS ..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
\. "$HOME/.nvm/nvm.sh"
nvm install 23
node -v
nvm current
npm -v
sudo npm -g update

sudo apt update && sudo apt upgrade -y

echo_message "Installation completed successfully!"