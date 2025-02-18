all: build up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean: down
	docker-compose down --volumes
	docker network prune
	docker volume prune
	docker system prune

re: clean all