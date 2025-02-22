#!/bin/bash
# Wait for MariaDB to be ready
echo "Waiting for database connection..."
sleep 10
# mariadb -h"${WORDPRESS_DB_HOST}" -u"${WORDPRESS_DB_USER}" -p"${WORDPRESS_DB_PASSWORD}" -e "SELECT 1;";
# mariadb -h"mariadb" -u"wp_user" -p"1234" -e "SELECT 1;"
# done
# echo "Database ready!"

# wp-cli installation
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# wp-cli permission
chmod +x wp-cli.phar
# wp-cli move to bin
mv wp-cli.phar /usr/local/bin/wp

# go to wordpress directory
mkdir -p /var/www/wordpress

cd /var/www/wordpress

# give permission to wordpress directory
chmod -R 755 /var/www/wordpress/
# change owner of wordpress directory to www-data
chown -R www-data:www-data /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download  --allow-root
    # create wp-config.php file with database details
    wp config create --dbhost="${WORDPRESS_DB_HOST}" --dbname="${WORDPRESS_DB_NAME}" --dbuser="${WORDPRESS_DB_USER}" --dbpass="${WORDPRESS_DB_PASSWORD}" --allow-root
    # install wordpress with the given title, admin username, password and email
    wp core install --url="$DOMAIN_NAME" --title="${WP_TITLE}" --admin_user="${WP_ADMIN_N}" --admin_password="${WP_ADMIN_P}" --admin_email="${WP_ADMIN_E}" --allow-root
    #create a new user with the given username, email, password and role
    # mnb3d
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