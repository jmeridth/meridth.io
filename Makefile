.PHONY : deploy

help: # Display help
	@awk -F ':|##' \
		'/^[^\t].+?:.*?##/ {\
			printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
		}' $(MAKEFILE_LIST)

all: deploy

deploy: ## deploy the website
	ansible-playbook deploy.yml -i hosts -vvvv
