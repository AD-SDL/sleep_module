################################################################################
# AD-SDL WEI Template Makefile
################################################################################
MAKEFILE := $(lastword $(MAKEFILE_LIST))
MAKEFILE_DIR := $(dir $(MAKEFILE))
INCLUDE_DIR := $(MAKEFILE_DIR)/make

include $(INCLUDE_DIR)/boilerplate.mk # Boilerplate, can probably leave as-is
include $(INCLUDE_DIR)/config.mk # Project-specific configuration
include $(INCLUDE_DIR)/docker.mk # Docker-related rules

################################################################################
# Rules: Add anything you want to be able to run with `make <target>` below

checks: # Runs all the pre-commit checks
	@pre-commit install
	@pre-commit run --all-files || { echo "Checking fixes\n" ; pre-commit run --all-files; }

test: init # Runs all the tests
	docker compose -f $(COMPOSE_FILE) exec -u app $(APP_NAME) pytest ${MODULE_NAME} $(args)

################################################################################

# Determine which rules don't correspond to actual files (add rules to NOT_PHONY to exclude)
.PHONY: $(filter-out $(NOT_PHONY), $(RULES))
