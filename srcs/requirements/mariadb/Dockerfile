FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install mariadb

RUN mysql

RUN REATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

RUN CREATE USER 'wp_pwuser'@'localhost' IDENTIFIED BY 'password';

RUN GRANT ALL ON wordpress.* TO 'wp_pwuser'@'localhost';

RUN CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'password';

RUN FLUSH PRIVILEGES;

RUN EXIT
