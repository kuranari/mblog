NAME=mblog

build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose stop

restart:
	docker-compose restart
