all: build up

build:
	docker-compose -f ./srcs/docker-compose.yml build

up:
	docker-compose -f ./srcs/docker-compose.yml up

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean: down
	docker-compose -f ./srcs/docker-compose.yml down  --volumes
	docker system prune -a
	docker network prune 
	docker volume prune -a
	docker image prune -a

re: clean all