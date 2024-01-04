#####################
# WEI Configuration	#
#####################

# Adjust these parameters to meet your needs
# You can override these at run time by running `make <target> <VARIABLE>="..."`

# Project Configuration
MODULE_NAME := sleep_module
PROJECT_DIR := $(abspath $(MAKEFILE_DIR))
WORKCELLS_DIR := $(PROJECT_DIR)/tests/workcell_defs
WORKCELL_FILENAME := test_workcell.yaml

# Python Configuration
PYPROJECT_TOML := $(PROJECT_DIR)/pyproject.toml
PROJECT_VERSION := $(shell grep -oP '(?<=version = ")[^"]+' $(PYPROJECT_TOML) | head -n 1)

# Docker Configuration
COMPOSE_FILE := $(PROJECT_DIR)/compose.yaml
DOCKERFILE := $(PROJECT_DIR)/Dockerfile
# Make sure ENV_FILE is in .gitignore or equivalent
ENV_FILE := $(PROJECT_DIR)/.env
REGISTRY := ghcr.io
ORGANIZATION := ad-sdl
IMAGE_NAME := $(MODULE_NAME)
IMAGE := $(REGISTRY)/$(ORGANIZATION)/$(IMAGE_NAME)

# APP_NAME needs to match the name of the module's service in the compose file
APP_NAME := $(MODULE_NAME)
# This is where the data from the workcell and your application will be stored
# If these directories don't exist, they will be created
WEI_DATA_DIR := $(PROJECT_DIR)/.wei
REDIS_DIR := $(WEI_DATA_DIR)/redis
# Whether or not to send events to Diaspora (set to true to turn on)
USE_DIASPORA := false
# This is the default target to run when you run `make` with no arguments
.DEFAULT_GOAL := help

########################
# Config-related Rules #
########################

init: .env $(WEI_DATA_DIR) $(REDIS_DIR) # Do the initial configuration of the project

# Generate our .env whenever we change our config
# If you depend on files besides the makefiles to generate config,
# add them as dependencies to the .env rule
NOT_PHONY += .env
.env: $(MAKEFILE_LIST)
	@echo Generating .env...
	@echo "# THIS FILE IS AUTOGENERATED, CHANGE THE VALUES IN THE MAKEFILE" > $(ENV_FILE)
	@echo "USER_ID=$(shell id -u)" >> $(ENV_FILE)
	@echo "GROUP_ID=$(shell id -g)" >> $(ENV_FILE)
	@echo "MHF_HOST_UID=$(shell id -u)" >> $(ENV_FILE)
	@echo "MHF_HOST_GID=$(shell id -g)" >> $(ENV_FILE)
# The following adds every variable in the Makefiles to the .env file,
# except for everything in ENV_FILTER and ENV_FILTER itself
	@$(foreach v,\
		$(filter-out $(ENV_FILTER) ENV_FILTER,$(.VARIABLES)),\
		echo "$(v)=$($(v))" >> $(ENV_FILE);)

$(WEI_DATA_DIR):
	mkdir -p $(WEI_DATA_DIR)

$(REDIS_DIR):
	mkdir -p $(REDIS_DIR)
