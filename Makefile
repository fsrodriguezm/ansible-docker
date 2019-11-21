default:
	docker-compose up --build -d \
	&& docker exec -it r-host-1 rm /run/nologin \
	&& docker exec -it r-host-2 rm /run/nologin
stop:
	docker-compose down
