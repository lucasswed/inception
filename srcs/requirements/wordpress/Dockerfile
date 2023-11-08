FROM debian:buster

RUN apt -y update && apt -y upgrade

RUN apt install -y curl php-fpm php-mysql php-curl php-gd php-mbstring php-xml \
	php-xmlrpc php-soap php-intl php-zip mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN wp-cli.phar /usr/local/bin/wp

RUN mkdir /run/php/ && chmod 755 /run/php/

