#!/bin/bash


if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    # wp-cli installation
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    # wp-cli permission
    chmod +x wp-cli.phar
    # wp-cli move to bin
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --path=/var/www/wordpress/ --force  --allow-root
    # Set SENDMAIL to false to disable email notifications
    export SENDMAIL=false
    # create wp-config.php file with database details
    wp config create --dbhost="${WORDPRESS_DB_HOST}" --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --allow-root
    # install wordpress with the given title, admin username, password and email
    wp core install --url="$DOMAIN_NAME" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_N}" --admin_password="${WP_ADMIN_P}" --admin_email="${WP_ADMIN_E}" --allow-root
    #create a new user with the given username, email, password and role
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --role="$WP_U_ROLE" --user_pass="$WP_U_PASS" --allow-root
    # give permission to wordpress directory
    chmod -R 755 /var/www/wordpress/
    # change owner of wordpress directory to www-data
    chown -R www-data:www-data /var/www/wordpress/

    echo "WordPress installation complete!"
else
    echo "WordPress is already installed."
fi


# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# # create a directory for php-fpm
mkdir -p /run/php
# start php-fpm service in the foreground to keep the container running
php-fpm7.4 -F