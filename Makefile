default:
	if [ ! -f ./home/id_rsa ]; then \
	  ssh-keygen -b 2048 -t rsa -f home/id_rsa -q -N "" ; \
	fi \
	&& chmod -R 600 ./home/id_rsa* \
	&& docker-compose up --build -d \
	&& docker exec -it r-host-1 rm /run/nologin \
	&& docker exec -it r-host-2 rm /run/nologin
stop:
	docker-compose down
