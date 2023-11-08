all: clean up

up:
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes

stop:
	docker compose -f ./srcs/docker-compose.yml stop

.PHONY: up down stop clean