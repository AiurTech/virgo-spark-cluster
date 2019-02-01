#!/bin/bash -e

source config.sh

PUBLISH=${1:-N}
TAG=${2:-$VERSION}

function buildAndPublish() {
    local img=$1
    local group=$2
    local tag=$3
    local imageName=$group/$img
    cd $img
    echo "Building image: $imageName:$tag"
    docker build -t $imageName:$tag .
    if [ $PUBLISH == "Y" ]; then
    	docker push $imageName:$tag
    fi
    cd ..
}

for i in "${all_containers[@]}"
do
    buildAndPublish $i $REPO $TAG
done
