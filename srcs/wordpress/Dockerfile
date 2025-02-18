FROM debian:bullseye

# Update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# Install the required packages
RUN apt-get install -y \
    curl \
    php \
    php7.4-fpm \
    php-mysql \
    mariadb-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

WORKDIR /var/www/html

# Start PHP-FPM 7.4 using the entrypoint script
ENTRYPOINT [ "/entrypoint.sh" ]