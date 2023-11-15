# Webflow Udesly Deploy Makefile

### Defensive settings for make:
#     https://tech.davis-hansson.com/p/make/
SHELL:=bash
.ONESHELL:
.SHELLFLAGS:=-xeu -o pipefail -O inherit_errexit -c
.SILENT:
.DELETE_ON_ERROR:
MAKEFLAGS+=--warn-undefined-variables
MAKEFLAGS+=--no-builtin-rules

# Project settings
REPONAME=`basename $(CURDIR)`
SOURCE=~/Downloads/$(REPONAME).zip 


# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`


# Top-level targets

.PHONY: all
all: update

# Add the following 'help' target to your Makefile
# And add help text after each target name starting with '\#\#'
.PHONY: help
help: .SHELLFLAGS:=-eu -o pipefail -O inherit_errexit -c
help: ## This help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: update
update:
	make pull
	make unzip
	make reset_articles_from_netlify

.PHONY: pull
pull:
	@echo "$(GREEN)==> Pulling the stuff $(RESET)"
	git pull

       
        

.PHONY: unzip
unzip:  ## unzip the source
	@echo "$(GREEN) ==> unpacking $(REPONAME).zip $(RESET)"
	unzip -o $(SOURCE)


.PHONY: reset_articles_from_netlify
reset_articles_from_netlify: ## articles from the repo are more up to date
	@echo "$(GREEN)==> reseting articles from netlify $(RESET)"
	git checkout cms/articles
	git checkout netlify.toml

