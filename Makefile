SRCS=./srcs
BINDM=/your/folder/path
RM= rm -r -f
all: create build
	
create:
	@if ! [ -d ${BINDM} ]; then\
		mkdir ${BINDM};\
		mkdir ${BINDM}/database;\
		mkdir ${BINDM}/wordpress;\
	fi

build:
	docker compose -f ${SRCS}/docker-compose.yml build
up:
	docker compose -f ${SRCS}/docker-compose.yml up --detach
down:
	docker compose -f ${SRCS}/docker-compose.yml down
start:
	docker compose -f ${SRCS}/docker-compose.yml start
stop:
	docker compose -f ${SRCS}/docker-compose.yml stop
restart: stop start

cprune:
	docker container prune -f
vprune:
	docker volume rm wordpress db
iprune:
	docker image prune -a -f

clean: cprune iprune vprune

fclean:
	${RM} ${BINDM}/database/* && ${RM} ${BINDM}/wordpress/*



.PHONY: create build up down start stop restart vprune cprune iprune clean fclean
