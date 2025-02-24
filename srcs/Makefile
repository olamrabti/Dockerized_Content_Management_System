all: build up

build:
	docker-compose build

up:
	docker-compose up

down:
	docker-compose down

clean: down
	docker-compose down --volumes
	docker network prune
	docker volume prune
	docker system prune

fclean: clean
	rm -rf /Users/olamrabt/Desktop/1337-Inception/srcs/data/wp/*

re: clean all