#!/bin/bash

# Start MariaDB in the background
mysqld --user=mysql --skip-networking --socket=/run/mysqld/mysqld.sock &

echo "Initializing MariaDB database..."
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Wait until MariaDB is ready
sleep 5


# Run database initialization commands

mariadb -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"

# Stop the temporary MariaDB process
killall mysqld

# Start MariaDB in the foreground to keep the container running
exec mysqld --user=mysql --socket=/run/mysqld/mysqld.sock --bind-address=0.0.0.0