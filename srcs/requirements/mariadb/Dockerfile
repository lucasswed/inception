FROM debian:buster

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install mariadb-server

COPY ./tools/script.sh /home

RUN chmod 755 /home/script.sh

RUN mysql_install_db

EXPOSE 3306

ENTRYPOINT [ "/home/script.sh" ]

#CMD [ "mysqld", "--bind-address=0.0.0.0" ]