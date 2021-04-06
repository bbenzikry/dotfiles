# if this session isn't interactive, then we don't want to allocate a
# TTY, which would fail, but if it is interactive, we do want to attach
# so that the user can send e.g. ^C through.
INTERACTIVE := $(shell [ -t 0 ] && echo 1 || echo 0)
ifeq ($(INTERACTIVE), 1)
	DOCKER_FLAGS += -t
endif

# .PHONY: shellcheck
# shellcheck: ## Runs shellcheck tests on the scripts.

	# run shellcheck tests on image
	# docker run --rm -i $(DOCKER_FLAGS) \
	# 	--name df-shellcheck \
	# 	-v $(CURDIR):/usr/src:ro \
	# 	--workdir /usr/src \
	# 	repo/shellcheck ./test/main.sh

.PHONY: help 
help: ## This screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: test
test: ## Runs all tests
	@./test/main.sh

.PHONY: install  
install: ## Initializes dotfiles into home directory, creating backup at ~/.dotfiles_backup/TIMESTAMP
	@./src/setup.sh


.PHONY: silent 
silent: ## Run tests and a silent installation(-y)
	@./test/main.sh
	@./src/setup.sh -y

.PHONY: refresh
refresh: ## Refreshes existing submodules
	noop

# .PHONY: docker  
# docker: ## Runs dotfile installation(quiet) on ubuntu docker container
# 	docker build -t dotrunner . 
# 	docker run --rm -i $(DOCKER_FLAGS) \
# 	 -e NO_SUDO=true -v $(CURDIR):/home/docker/.dotfiles --workdir /home/docker/.dotfiles dotrunner ./src/setup.sh -y