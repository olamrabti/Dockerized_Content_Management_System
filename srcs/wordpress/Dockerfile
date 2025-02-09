FROM debian:latest

# Install PHP-FPM explicitly with version and dependencies
RUN apt-get update && apt-get install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-soap \
    php-intl \
    php-zip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


# Copy WordPress config
COPY wp-config.php /var/www/html/

# Fix permissions
RUN chown -R www-data:www-data /var/www/html

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -O /tmp/wordpress.tar.gz \
    && tar -xzf /tmp/wordpress.tar.gz -C /var/www/html --strip-components=1 \
    && rm /tmp/wordpress.tar.gz


# # Configure PHP-FPM to use TCP port
# RUN echo "listen = 0.0.0.0:9000" >> /etc/php/*/fpm/pool.d/www.conf

# Add PHP-FPM binary location to PATH
ENV PATH="/usr/sbin:${PATH}"

# Start PHP-FPM
CMD ["php-fpm", "-F"]