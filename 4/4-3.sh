#!/bin/bash

vault list auth/approle/role | sed '1,2d' | while read line; do echo $line; vault read auth/approle/role/${line}/role-id; done;