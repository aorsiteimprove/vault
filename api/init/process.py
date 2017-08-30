#!/usr/bin/env python3

import json

with open('output.json') as f:
    data = json.load(f)

    keys = data['keys']

    for i, val in enumerate(keys): 
        key = {'key': val}
        with open('key{0}'.format(i), 'w') as out:
            json.dump(key, out)

    root_token = {'root_token': data['root_token']}
    with open('root_token', 'w') as out:
            json.dump(root_token, out)