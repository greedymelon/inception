FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y \
    php-cgi \
    php-common \
    php-fpm \
    php-mysql\
    curl \
    sendmail \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \ 
    && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp \
    && sed -i "s+listen = /run/php/php7.4-fpm.sock+listen = wordpress:9000+g" /etc/php/7.4/fpm/pool.d/www.conf \
    && mkdir -p ./run/php

# debugging
# RUN sed -i "s+display_errors = Off+display_errors = On+g" /etc/php/7.4/fpm/php.ini \
#     sed -i "s+display_startup_errors = Off+display_startup_errors = On+g" /etc/php/7.4/fpm/php.ini


COPY ./tools/wordpress.sh /tmp/

WORKDIR /var/www/html

ENTRYPOINT [ "bash", "/tmp/wordpress.sh"]

# run php-fpm int the foreground
CMD [ "php-fpm7.4", "-R", "-F" ]
