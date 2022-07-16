create:
	docker compose build --no-cache
	docker compose run web rails db:create

run:
	docker compose up -d
