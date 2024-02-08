# Python Configuration
PYPROJECT_TOML := pyproject.toml
PROJECT_VERSION := $(shell grep -oP '(?<=version = ")[^"]+' $(PYPROJECT_TOML) | head -n 1)

.DEFAULT_GOAL := init

.PHONY += init paths checks test
init: # Do the initial configuration of the project
	@test -e .env || cp example.env .env
	@sed -i 's/^USER_ID=.*/USER_ID=$(shell id -u)/' .env
	@sed -i 's/^GROUP_ID=.*/GROUP_ID=$(shell id -g)/' .env
	@sed -i 's/^PROJECT_VERSION=.*/PROJECT_VERSION=$(PROJECT_VERSION)/' .env
	@sed -i 's/^PROJECT_PATH=.*/PROJECT_PATH=$(shell pwd | sed 's/\//\\\//g')/' .env

paths: # Create the necessary data directories
	@. .env && mkdir -p $$WEI_DATA_DIR && mkdir -p $$REDIS_DIR

checks: # Runs all the pre-commit checks
	@pre-commit install
	@pre-commit run --all-files || { echo "Checking fixes\n" ; pre-commit run --all-files; }

test: init paths # Runs all the tests
	@docker compose -f wei_core.compose.yaml up --build -d
	@docker compose -f wei_core.compose.yaml exec sleep_module pytest -p no:cacheprovider sleep_module
	@docker compose -f wei_core.compose.yaml down
