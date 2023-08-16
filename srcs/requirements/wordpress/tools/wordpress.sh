#!/bin/bash

#if not wordpre in the bind mount
if ! [[ "$(ls -A /var/www/html/)" ]]; then
#download, configure the wordpress in the bind mount
wp core download --allow-root --locale=nl_NL
wp core install --allow-root --url=$DOMAIN_NAME --title=Inception --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL
wp wp config create --allow-root --dbname=$DATAB_NAME --dbuser=$USERDB_NAME --dbpass=$USERDB_PASS --dbhost=mariadb
fi

#give right to php
chown -R www-data:www-data /var/www/html/
chmod -R 775 /var/www/html/
