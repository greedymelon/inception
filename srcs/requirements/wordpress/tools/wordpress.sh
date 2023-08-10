if ! [[ -d "./var/www/html/wordpress" ]]; then 
wget http://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz && mv wordpress ./var/www/html/
mv wp-config.php ./var/www/html/wordpress 
fi

chown -R www-data:www-data /var/www/html/wordpress

php-fpm7.4 -R -F

#service php7.4-fpm restart

