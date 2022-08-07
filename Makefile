# Database commands
migrate:
	@docker exec -it php-app php artisan migrate:fresh --seed

fresh:
	@docker exec -it php-app php artisan migrate:fresh

seed:
	@docker exec -it php-app php artisan db:seed


# test commands
test:
	@docker exec -it php-app php artisan test
