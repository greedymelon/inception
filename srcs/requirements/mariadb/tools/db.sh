#!/bin/bash
# chmod -R 755 /var/lib/mysql/ #
service mariadb start #
# mariadb -h 127.0.0.11 --port=3306 --protocol=tcp #
# mysql -h 127.0.0.1 -P 3306 --protocol=TCP -u root -p${ROOT_PASS}
# mysql -e "UPDATE mysql.user SET Password=PASSWORD('$ROOT_PASS') WHERE User='root';" #
# Kill the anonymous users
# mysql -e "DELETE FROM mysql.user WHERE User='';" #
# Because our hostname varies we'll use some Bash magic here.
# mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');" #
# Kill off the demo database
# mysql -e "DROP DATABASE test" #
# mysql -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%'" #
# Make our changes take effect
# mysql -e "FLUSH PRIVILEGES" #
#service mariadb status #
mysql -uroot -e "CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" #
mysql -uroot -e "CREATE USER IF NOT EXIST ${ADMIN_NAME}@'%' IDENTIFIED BY ${ADMIN_PASS};" #
mysql -uroot -e "GRANT ALL ON wordpress.* TO ${ADMIN_NAME}@'%';" #
mysql -uroot -e "FLUSH PRIVILEGES;" #
mariadb #
# mysql -uroot -h 127.0.0.1 -P 3306 #