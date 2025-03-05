FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    php-fpm \
    php-mysql \
    && apt-get clean

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem -subj "/CN=olamrabt.42.fr"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
