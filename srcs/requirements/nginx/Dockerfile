FROM debian:bullseye

EXPOSE 443

RUN apt update && apt upgrade -y && install -y \ 
    nginx \
    openssl \
    && rm -r /etc/nginx/sites-enabled && rm -r /etc/nginx/sites-available \
    && sed -i "s+TLSv1 TLSv1.1++g" etc/nginx/nginx.conf \
    && openssl req -x509 -nodes -newkey rsa:2048 -keyout /etc/ssl/private/nginx.key \
    -out /etc/ssl/certs/nginx.crt -subj "/CN=dmonfrin.43.fr"

COPY ./conf/nginx.conf ./etc/nginx/conf.d/

# run nginx in the foreground
ENTRYPOINT ["nginx", "-g", "daemon off;"]
