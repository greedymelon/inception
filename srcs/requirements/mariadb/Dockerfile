FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    mariadb-server \
    && sed -i "s+bind-address+#bind-address+g" /etc/mysql/mariadb.conf.d/50-server.cnf \
    && sed -i "s+#port+port+g" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/database_init.sh .

ENTRYPOINT [ "bash", "database_init.sh"]

CMD [ "mariadbd-safe" ]
