FROM debian:bookworm

# Install Nginx and PHP-FPM
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    php-fpm \
    php-mysql \
    && apt-get clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem -subj "/CN=localhost"

# Copy Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /var/www/html/

# Expose port 443
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
