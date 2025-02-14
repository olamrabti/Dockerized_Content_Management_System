FROM debian:latest

# Add PHP 7.4 repository
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    ca-certificates \
    lsb-release \
    apt-transport-https

RUN curl -sSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

# Install PHP 7.4 and extensions
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    php7.4-curl \
    php7.4-dom \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP-FPM
RUN sed -i 's/;daemonize = yes/daemonize = no/' /etc/php/7.4/fpm/php-fpm.conf
RUN sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 0.0.0.0:9000/' /etc/php/7.4/fpm/pool.d/www.conf

# Create directory and set permissions
RUN mkdir -p /var/www/html \
    && chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Install WordPress
WORKDIR /var/www/html
RUN wget https://wordpress.org/latest.tar.gz \
    && tar -xvzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz

# Environment variables
ENV WORDPRESS_DB_HOST=${WORDPRESS_DB_HOST}
ENV WORDPRESS_DB_USER=${MYSQL_USER}
ENV WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}
ENV WORDPRESS_DB_NAME=${MYSQL_DATABASE}

EXPOSE 9000

# Start PHP-FPM 7.4
CMD ["php-fpm7.4", "-F"]