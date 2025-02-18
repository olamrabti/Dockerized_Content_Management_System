#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for database connection..."
# until mariadb -h"mariadb" -u"${MYSQL_USER}" -p"${MYSQL_PASSWORD}" -e "SELECT 1;" &>/dev/null; do
# until mariadb -h"mariadb" -u"wp_user" -p"1234" -e "SELECT 1;" &>/dev/null; do
  sleep 5
# done
# echo "Database ready!"

#---------------------------------------------------wp installation---------------------------------------------------#
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
#---------------------------------------------------wp installation---------------------------------------------------##---------------------------------------------------wp installation---------------------------------------------------#

if [ ! -f /var/www/wordpress/wp-config.php ]; then
    echo "Installing WordPress..."
    wp core download  --allow-root
    # create wp-config.php file with database details
    wp config create --dbhost="mariadb" --dbname="wordpress" --dbuser="wp_user" --dbpass="1234" --allow-root
    # install wordpress with the given title, admin username, password and email
    wp core install --url="localhost" --title="My WP Site" --admin_user="admin" --admin_password="adminpassword" --admin_email="admin@example.com" --allow-root
    #create a new user with the given username, email, password and role
    wp user create "editor" "editor@example.com" --user_pass="editorpassword" --role="editor" --allow-root
    echo "WordPress installation complete!"
else
    echo "WordPress is already installed."
fi

#---------------------------------------------------php config---------------------------------------------------#

# change listen port from unix socket to 9000
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# # create a directory for php-fpm
mkdir -p /run/php

# start php-fpm service in the foreground to keep the container running
php-fpm7.4 -F