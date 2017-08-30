#!/usr/bin/env python3

import json

with open('output.json') as f:
    keys = json.load(f)['keys']

    for i, val in enumerate(keys): 
        key = {'key': val}

        with open('key{0}'.format(i), 'w') as out:
            json.dump(key, out)