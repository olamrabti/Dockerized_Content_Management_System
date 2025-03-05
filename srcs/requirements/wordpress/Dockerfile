FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
    curl \
    php \
    php7.4-fpm \
    php-mysql \
    mariadb-client \
    sendmail\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 9000

RUN mkdir -p /var/www/wordpress/

WORKDIR /var/www/wordpress


ENTRYPOINT [ "/entrypoint.sh" ]