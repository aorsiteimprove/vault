apply:
	terraform apply

destroy:
	terraform destroy

ansible:
	ansible-playbook -i vault.inv -u ubuntu vault-playbook.yml

init:
	api/init/init.sh init-config.json
	api/init/process.py
	api/init/clean.sh

all:
	apply ansible init
