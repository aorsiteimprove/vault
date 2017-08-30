#!/bin/bash

key_path="$1"

if [[ -n "$key_path" ]]; then
    curl --request PUT --data @$key_path http://$vault_address:8200/v1/sys/unseal
else
    echo "path to key file not provided"
fi