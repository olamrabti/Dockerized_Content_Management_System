#!/bin/bash

# Start MariaDB service to run initialization
service mariadb start

# Wait until MariaDB is ready
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB to start..."
    sleep 2
done



# Run initialization commands directly
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS wordpress;"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppassword';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';"

# TODO check the subject

# mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS 'superuser'@'%' IDENTIFIED BY 'superpassword';"
# mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON *.* TO 'superuser'@'%';"
mysql -u root -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

# Stop MariaDB service to switch to `mysqld_safe`
service mariadb stop

# Start MariaDB in the foreground
exec mysqld_safe
