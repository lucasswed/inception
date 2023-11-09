FROM debian:buster

RUN apt -y update && apt -y upgrade

RUN apt install -y curl php-fpm php-mysql php-curl php-gd php-mbstring php-xml \
	php-xmlrpc php-soap php-intl php-zip mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php/ && chmod 755 /run/php/

RUN sed -i 's#listen = /run/php/php7.3-fpm.sock#listen = 9000#g' /etc/php/7.3/fpm/pool.d/www.conf

COPY ./tools/script.sh /home

RUN chmod 755 /home/script.sh

EXPOSE 9000

ENTRYPOINT [ "/home/script.sh" ]

CMD [ "php-fpm7.3", "-F", "-R" ]