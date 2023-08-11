FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install nginx -y

RUN service nginx start

#COPY ./tools/nginx.sh .
RUN rm -r /etc/nginx/sites-enabled

RUN rm -r /etc/nginx/sites-available

RUN sed 's+ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;+ssl_protocols TLSv1.2;+g' etc/nginx/nginx.conf

EXPOSE 443

COPY ./conf/nginx.conf ./etc/nginx/conf.d/


CMD ["nginx", "-g", "daemon off;"]


