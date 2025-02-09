FROM alpine:latest

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Copy initialization script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Expose port 3306 for MariaDB
EXPOSE 3306

# Start MariaDB
CMD ["mysqld", "--user=mysql"]