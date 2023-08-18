#!/bin/bash

# if the database is not in the binf mount create it
if ! [[ "$(ls -A /var/lib/mysql)" ]]; then
    chown -R mysql:mysql /var/lib/mysql
    chmod -R 755 /var/lib/mysql/
    # installing a database in a specific diretory sometimes needed because of the bind mount
    mariadb-install-db --datadir=/var/lib/mysql 
    echo "MYSQL initialized"
fi 
if ! [[ -d  /var/lib/mysql/wordpress ]]; then
    service mariadb start
     # faking myysql_secure_installation.sh
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "DROP DATABASE test;"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $DATAB_NAME;"
    
    #create users and wordpress database
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$USERDB_NAME'@'%' IDENTIFIED BY '$USERDB_PASS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON $DATAB_NAME.* TO '$USERDB_NAME'@'%';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALL PRIVILEGES ON * . * TO 'root'@'localhost' IDENTIFIED BY '$ROOT_PASS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS '$NOPOW_NAME'@'%' IDENTIFIED BY '$NOPOW_PASS';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "GRANT ALTER PRIVILEGES ON $DATAB_NAME.* TO '$NOPOW_NAME'@'%';"
    mariadb -uroot --password=$MYSQL_ROOT_PASSWORD -e "FLUSH PRIVILEGES;"
    mysqladmin -uroot --password=$MYSQL_ROOT_PASSWORD shutdown
    echo "Wordpress database created"
fi

exec ${@}
