.ONESHELL:
SHELL := /usr/bin/bash
.DEFAULT_GOAL = help
# ###
# #####################################################################################################################
# ###    Full path of the current script
THIS=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null || echo $0);
# ### The directory where current script resides
DIR=$(dirname "${THIS}")
# ###
PWD=$(pwd)
# ###
#

default:
	@$(MAKE) -s help

h: ### Commands list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# This will output the help for each task. thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Show this help
	@printf "\033[33m%s:\033[0m\n" 'Available commands'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[32m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ### Build docker compose file in this directory
	@if [ ! -f "compose.yml" ]; then COMPOSE_FILE="docker-compose.yml"; fi
#	@if [ ! -d $(APP_BASE_DIR) ]; then @mkdir $(APP_BASE_DIR); fi
	DOCKER_BUILDKIT=1 docker-compose -f $(COMPOSE_FILE) up -d --build $(c)
#	docker-compose -f $(COMPOSE_FILE) build $(c)

setup: ### Setup project
	@cd ./backend
	npm install graphql ccxt graphql-ccxt --force && npm install && npm audit fix --force
	@$(MAKE) -s start
	@cd ..
	@cd ./backend-prisma
	npm i --save-dev prisma@latest && npm i @prisma/client@latest
	npm run build
	@cd ..

start: ### Start project
	npm run start

r: ### run
	cd users-application
	npm run start
	cd ..
	cd posts-application
	npm run start
	cd ..
	cd exchanges-application
	npm run start
	cd ..
	cd gateway
	npm run start
	cd ..
	echo -e "Access the graph You can reach the gateway under http://localhost:3001/graphql"

clean:
	rm -rf ./users-application/dist
	rm -rf ./users-application/node_modules
	rm -rf ./posts-application/dist
	rm -rf ./posts-application/node_modules
	rm -rf ./exchanges-application/dist
	rm -rf ./exchanges-application/node_modules
	rm -rf ./gateway/dist
	rm -rf ./gateway/node_modules

dev: ### Run devel project
	npm run dev

net: ### sudo netstat -ntlp ; sudo ss -tulpn | grep :9000
	netstat -ntlp
	ss -tulpn | grep :9000

#if grep -q "${search_word}" <<< "$my_quote" then
b: ### Run build:
ifneq (,$(findstring backend-prisma,$(filter-out $@,$(MAKECMDGOALS))))
ifneq (,$(findstring backend,$(filter-out $@,$(MAKECMDGOALS))))
else
	@cd ./backend
	npm install graphql ccxt graphql-ccxt --force && npm install && npm audit fix --force
	npm i
	npm run build
	@cd ..
endif
else
	@cd ./backend-prisma
	npm i --save-dev prisma@latest && npm i @prisma/client@latest
	npm run build
	@cd ..
endif
ifneq (,$(findstring frontend-quasar,$(filter-out $@,$(MAKECMDGOALS))))
ifneq (,$(findstring frontend,$(filter-out $@,$(MAKECMDGOALS))))
else
	@cd ./frontend
	npm i
	npm run build
	@cd ..
endif
else
	@cd ./frontend-quasar
	npm i
	npm run build
	@cd ..
endif
