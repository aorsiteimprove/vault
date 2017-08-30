## usage

Use the Makefile to setup the vault server. 

`make apply` will run terraform and provision AWS resources as well as generate the inventory file for Ansible.

`make ansible` will run the ansible playbook to configure the AWS instance. 

`make init` will initialize Vault. It will also parse the response and split it into key* files to be distributed. A root_token file will be also created.

`make all` will run apply ansible init.

After the keys and the root_token are distributed don't forget to clean up and delete the key* files and the root_token file. `cleanup.sh` will do this.

## unseal

The api/unseal/unseal.sh script takes a path to a key file as a parameter. 
Depending on the configuration the individuals with keys need to run the script and provide a path to the key file.
After the configured amount of keys are submitted Vault will be unsealed. 