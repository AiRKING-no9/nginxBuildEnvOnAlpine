build:
	docker-compose up -d --build
	docker exec -i custom_alpine /bin/sh -c "composer create-project laravel/laravel=5.5 laravelProject"
	docker exec -i custom_alpine /bin/sh -c "../wake.sh"
up:
	docker-compose up -d
	docker exec -it custom_alpine /bin/sh wake.sh
down:
	docker-compose down --rmi all --volumes --remove-orphans
in:
	docker exec -it custom_alpine /bin/sh
status: 
	docker-compose ps -a
start:
	docker-compose start
	docker exec -i custom_alpine /bin/sh -c "../wake.sh"
stop:
	docker-compose stop