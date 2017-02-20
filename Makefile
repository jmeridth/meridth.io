.PHONY : deploy

all : deploy
deploy :
	ansible-playbook deploy.yml -i hosts -vvvv
