#!/bin/bash

if ! [[ -d  "/var/lib/mysql/$DATAB_NAME" ]]; then
    #create users and wordpress database
    service mariadb start
    sleep 2
    mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DATAB_NAME;"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$USERDB_NAME'@'%' IDENTIFIED BY '$USERDB_PASS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATAB_NAME.* TO '$USERDB_NAME'@'%';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORDS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$NOPOW_NAME'@'%' IDENTIFIED BY '$NOPOW_PASS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALTER PRIVILEGES ON $DATAB_NAME.* TO '$NOPOW_NAME'@'%';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    mysqladmin -uroot --password=$MYSQL_ROOT_PASSWORD shutdown
    echo "Wordpress database created"
fi

exec ${@}
