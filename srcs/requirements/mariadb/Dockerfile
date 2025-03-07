FROM debian:bullseye

RUN apt-get update && apt-get install -y mariadb-server expect && rm -rf /var/lib/apt/lists/

RUN mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld


COPY maria.sh /maria.sh

RUN chmod 777 /maria.sh

EXPOSE 3306

CMD [ "./maria.sh" ]


