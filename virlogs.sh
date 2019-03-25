#!/usr/bin/env bash

if [ $# -ne 1 ]; then echo "args: $0 <container>"; exit; fi

docker-compose logs -f $1 
