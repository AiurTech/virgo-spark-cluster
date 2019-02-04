#!/usr/bin/env bash

source config.sh

REMOVE=${1:-Y}

for i in "${containers[@]}" 
do
	docker stop $i
	if [ $REMOVE == "Y" ]; then
		docker rm $i
	fi
done
docker network rm $NETWORK_NAME
