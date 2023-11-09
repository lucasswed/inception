#!/bin/bash

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then

/etc/init.d/mysql start;

mysql_secure_installation <<_EOF_

Y
$DB_ADMIN
$DB_PASS
Y
n
Y
Y
_EOF_

sleep 3;

echo "Creating admin user"
mysql -u root -e "CREATE DATABASE $DB_NAME;"
mysql -u root -e "CREATE USER '$DB_ADMIN'@'%' IDENTIFIED BY '$DB_PASS';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '$DB_ADMIN'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

/etc/init.d/mysql stop;
fi

exec "$@"