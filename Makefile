NAME=mblog

build:
	docker build -t $(NAME) .

run:
	docker run --rm \
		--name $(NAME) \
		-p 3000:3000 \
		-e DATABASE_HOST=host.docker.internal \
		-d \
		$(NAME)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME) -f
