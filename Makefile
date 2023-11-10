all: up

up:
	mkdir -p /home/lucas-ma/data/mysql
	mkdir -p /home/lucas-ma/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	docker compose -f ./srcs/docker-compose.yml down --rmi all --volumes

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean: down
		cd /home/lucas-ma/; sudo rm -rf data;

logs:
	docker compose -f ./srcs/docker-compose.yml logs

re: clean up

.PHONY: up down stop clean