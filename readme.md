## init

After Vault server has been setup and started using the Ansible playbook it needs to be initialized. 
Running the api/init/init.sh script will send a request to the server and initialize it. 
The output of the script will be saved as 'output.json'.
It will include the keys as well as the root token
Running the process.py script afterwards will read the output.json file, split the keys into different files so they can be distributed.
After the keys are distributed don't forget to clean up and delete the output.json file.

## unseal

The api/unseal/unseal.sh script takes a path to a key file as a parameter. 
Depending on the configuration the individuals with keys need to run the script and provide a path to the key file.
After the configured amount of keys are submitted Vault will be unsealed. 