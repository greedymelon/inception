FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install mariadb-server -y


COPY ./tools/db.sh .

# RUN  bash db.sh

# RUN rm db.sh
CMD [ "bash", "db.sh"]

#RUN mariadb -h  127.0.0.1
#RUN mariadb



#RUN mysql -e "DROP USER IF EXISTS ''@'hostname'"

#RUN mysql -e "CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"

#CMD [ "ls", "-a", "./etc/mysql/mariadb.conf.d"]
#CMD [ "cat", "../etc/mysql/mariadb.conf.d/"]

# RUN mariadb -u wp_user -ppassword wordpress

# CMD ["service", "--status-all"]

# CMD [""]

# RUN mysql -u root
#

# RUN mysql -e "CREATE USER ${ADMIN_NAME}@'localhost' IDENTIFIED BY ${ADMIN_PASS};"

# RUN mysql -e "GRANT ALL ON wordpress.* TO ${ADMIN_NAME}@'localhost';"

# RUN mysql -e "CREATE USER $(USER_NAME)'@'localhost' IDENTIFIED BY ${ADMIN_PASS};"

# RUN mysql -e "FLUSH PRIVILEGES;"

# RUN EXIT
