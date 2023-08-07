#!/bin/bash

service mariadb start

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

mysql -e "CREATE USER ${ADMIN_NAME}@'localhost' IDENTIFIED BY ${ADMIN_PASS};"

mysql -e "GRANT ALL ON wordpress.* TO ${ADMIN_NAME}@'localhost';"

mysql -e "CREATE USER ${NOPOW_NAME}@'localhost' IDENTIFIED BY ${NOPOW_PASS};"

mysql -e "FLUSH PRIVILEGES;"

mariadb