FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install mariadb-server -y

RUN service mariadb start

# RUN mysql -e "UPDATE mysql.user SET Password = PASSWORD('$ROOT_PASS') WHERE User = 'root'"

RUN mysql -e "DROP USER IF EXISTS ''@'$(hostname)'"

RUN mysql -e "CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

RUN 


# CMD [ "cat", "./etc/mysql/mariadb.cnf"]

# RUN mariadb -u wp_user -ppassword wordpress

CMD ["service", "--status-all"]

# RUN mysql -u root
#

# RUN CREATE USER 'wp_pwuser'@'localhost' IDENTIFIED BY 'password';

# RUN GRANT ALL ON wordpress.* TO 'wp_pwuser'@'localhost';

# RUN CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';

# RUN FLUSH PRIVILEGES;

# RUN EXIT
