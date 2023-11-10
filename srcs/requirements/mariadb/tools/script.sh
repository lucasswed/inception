#!/bin/bash

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

/etc/init.d/mysql start;

sleep 3;


echo "Creating admin user"
mysql -u root -e "CREATE DATABASE $DB_NAME;"
mysql -u root -e "CREATE USER '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

echo "Setting password for root user"
mysqladmin -u root password "$DB_PASS"

/etc/init.d/mysql stop;
else

/etc/init.d/mysql start;

sleep 3;

/etc/init.d/mysql stop;
fi
#mariadb-data  | Usage: /etc/init.d/mysql start|stop|restart|reload|force-reload|status|bootstrap

exec "$@"