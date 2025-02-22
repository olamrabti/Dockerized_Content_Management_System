FROM debian:bookworm

# Install MariaDB
RUN apt-get update && apt-get install -y mariadb-server expect && rm -rf /var/lib/apt/lists/

# # Create necessary directories
RUN mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Copy initialization script
COPY maria.sh /maria.sh

# Set script permissions
RUN chmod 777 /maria.sh


# Expose MariaDB port
EXPOSE 3306

CMD [ "./maria.sh" ]


