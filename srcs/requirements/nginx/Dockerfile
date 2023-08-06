FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt install nginx -y

RUN service nginx start

#COPY ./tools/nginx.sh .

EXPOSE 433

COPY ./conf/nginx.conf ./etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

# FROM alpine:3.14

# # Install nginx and openssl
# RUN apk update && \
# 	apk add nginx openssl && \
#     mkdir -p /run/nginx

# Create self-signed SSL certificate
# RUN mkdir -p /etc/nginx/certs && \
# 	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt -subj "/CN=yagnaou.42.fr"

# # Copy nginx configuration
# COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf

# # Start nginx
# CMD ["nginx", "-g", "daemon off;"]