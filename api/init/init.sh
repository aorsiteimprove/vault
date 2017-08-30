
#!/bin/bash

config_path="$1"

curl --request PUT --data @$config_path http://$vault_address:8200/v1/sys/init > output.json