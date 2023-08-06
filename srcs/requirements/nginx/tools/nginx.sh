#!bin/bash

apt update && apt upgrade -y

apt install nginx -y

mv ./nginx.conf ./etc/nginx/

service nginx start

service nginx status

cat ./etc/nginx/nginx.conf

nginx -g 'daemon off;'

#apt install nginx -y

