#!/bin/bash

#if not wordpress in the bind mount
if ! [[ -f "/var/www/html/wp-config.php" ]]; then
#download, configure the wordpress in the bind mount
wp core download --allow-root --locale=en_GB
wp config create --allow-root --dbname=$DATAB_NAME --dbuser=$USERDB_NAME --dbpass=$USERDB_PASS --dbhost="mariadb:3306" --skip-check
# sleep to wait for the database and avoiding installing extra tool
sleep 3
wp core install --allow-root --url=$DOMAIN_NAME --title=Inception --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL
wp user create --allow-root $NOPOW_NAME $NOPOW_EMAIL --user_pass=$NOPOW_PASS
wp option update --allow-root comment_registration 1
wp post create --allow-root --post_type=page --post_title='Leave a comment' --post_content='leave a comment as user' --post_status='publish' \
--comment_status='open' 
echo "New website createrd"
fi

#gives right to php
chown -R www-data:www-data /var/www/html/
chmod -R 775 /var/www/html/

echo "php listening"
# exec ensure the main docker process remain at PID 1 to catch unix signal
exec ${@}
