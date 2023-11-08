#!/bin/bash

# create the directory to use in nginx container later and also to setup the wordpress conf
mkdir /var/www/
mkdir /var/www/hmtl

cd /var/www/html

# remove all the wordpress files if there is something from the volumes to install it again
rm -rf *

# the commands are for installing and using the WP-CLI tool.

# downloads the WP-CLI PHAR (PHP archive) file from the github repository. The -O flag tells curl to save the file with the same name as it has on the server.
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# makes the WP-CLI PHAR file executable.
chmod +x wp-cli.phar

# moves the WP-CLI PHAR file to the /usr/local/bin directory, wich is in the system's PATH, and renames it to wp. This allows you to run the wp command from any directory
mv wp-cli.phar /usr/local/bin/wp

# downloads the latest version of wordpress to the current directory.
# The --allow-root flag allows the command to be run as the root user, wich is necessary if you're logged in as the root user or if you are using WP-CLI with a system-level installation of wordpress
wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# change those lines in qp-config.php file to connect with database

# line 23
sed -i -r "s/database/$db_name/1" wp-config.php
# line 26
sed -i -r "s/database_user/$db_user/1" wp-config.php
# line 29
sed -i -r "s/password/$db_pwd/1" wp-config.php
# line 32
sed -i -r "s/localhost/mariadb/1" wp-config.php

# installs wordpress and sets up the basic configuration for the site. the --url option specifies the URL of the site, --title sets the site's title, --admin_password set the username and password for the site's admin account
# and --admin_email sets the email address for the admin. the --skip-email flag prevents WP-CLI from sending an email to the admin with the login details
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMINEMAIL --skip-email --allow-root

# creates a new user account with the specified username, email address, and password. the --role sets the user's role to author, wich gives the user the ability to publish and manage their own posts.
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# installs the astra theme and activates it for the site. the --activate flag tells WP_CLI to make the theme the active theme for the site
wp theme install astra --activate --allow-root

wp plugin install redis-cache --activate --allow-root

# uses the sed command to modify the www.conf file in the /etc/php/7.3/fpm/pool.d directory. the s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g command substitutes the value 9000 for /run.php.php7.3-fpm.sock throughout the file.
# this changes the socket that PHP-FPM listens on from a Unix domain socket to a TCP port.
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# creates the /run/php directory, wich is used by PHP-FPM to store Unix domain sockets.
mkdir /run/php

wp redis enable --allow-root

# starts the PHP-FPM service in the foreground. The -F flag tells PHP-FPM to run in the foreground, rather than as a daemon in the background.
/usr/sbin/php-fpm7.3 -F