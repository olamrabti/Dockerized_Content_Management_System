#!/bin/bash


if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp


    wp core download --path=/var/www/wordpress/ --force  --allow-root
    wp config create --dbhost="${WORDPRESS_DB_HOST}" --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_N}" --admin_password="${WP_ADMIN_P}" --admin_email="${WP_ADMIN_E}" --allow-root
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --role="$WP_U_ROLE" --user_pass="$WP_U_PASS" --allow-root
    
    chmod -R 755 /var/www/wordpress/
    chown -R www-data:www-data /var/www/wordpress/

    echo "WordPress installation complete!"
else
    echo "WordPress is already installed."
fi

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php

php-fpm7.4 -F