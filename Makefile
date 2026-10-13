.PHONY: help build up down logs restart ps health clean

SERVICE ?= site

help:
	@echo "Targets:"
	@echo "  make build     Build the Docker image via docker compose"
	@echo "  make up        Start the stack in the background"
	@echo "  make down      Stop the stack"
	@echo "  make logs      Follow logs"
	@echo "  make restart   Restart the stack"
	@echo "  make ps        Show containers"
	@echo "  make health    Check HTTP 200 from localhost"
	@echo "  make clean     Remove containers and volumes"

build:
	docker compose build --no-cache

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f --tail=200 $(SERVICE)

restart:
	docker compose restart $(SERVICE)

ps:
	docker compose ps

health:
	@curl -fsS -o /dev/null -w "HTTP %{http_code}\n" http://localhost:8080/

clean:
	docker compose down -v --remove-orphans
