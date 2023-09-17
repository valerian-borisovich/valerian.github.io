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

net: ### sudo netstat -ntlp ; sudo ss -tulpn | grep :9000
	netstat -ntlp
	ss -tulpn | grep :9000


build: ### Build docker compose file in this directory
	@if [ ! -f "compose.yml" ]; then COMPOSE_FILE="docker-compose.yml"; fi
#	@if [ ! -d $(APP_BASE_DIR) ]; then @mkdir $(APP_BASE_DIR); fi
	DOCKER_BUILDKIT=1 docker-compose -f $(COMPOSE_FILE) up -d --build $(c)
#	docker-compose -f $(COMPOSE_FILE) build $(c)

setup: ### Setup


start: ### Start project
	npm run start

r: ### run
	npm run start

clean:
	rm -rf ./dist
	rm -rf ./node_modules

deploy:
	mkdocs gh-deploy --strict --force

dev: ### Run devel project
	npm run dev

#if grep -q "${search_word}" <<< "$my_quote" then
b: ### Run build:
	@$(MAKE) -s clean
	npm run clear
	npm i --save-dev
	npm audit fix --force
	npm run build

# ###   "Hugo Quickstart"   "https://michaelcurrin.github.io/hugo-quickstart"
#
hugo-build:
	hugo --gc --minify

hs hugo-serve:
	hugo server
