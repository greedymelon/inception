FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install nginx -y

RUN service nginx start

#COPY ./tools/nginx.sh .

EXPOSE 443

COPY ./conf/nginx.conf ./etc/nginx/nginx.conf


# CMD ["nginx", "-g", "daemon off;"]


