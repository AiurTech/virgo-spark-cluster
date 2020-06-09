#!/bin/bash

#[[ "$#" -eq 1 ]] && echo "1 argument required, $# provided"; exit -1;

OLD_VERSION=$1

source config.sh
echo "Changing from $OLD_VERSION to $VERSION"
find . -name Dockerfile -type f -exec sed -i "s/${OLD_VERSION}/${VERSION}/g" {} \;
sed -i "s/${OLD_VERSION}/${VERSION}/g" docker-compose.yml

# YAMLs
find "k8s/" -name "*.yaml" -type f -exec sed -i "s/${OLD_VERSION}/${VERSION}/g" {} \;

echo "Changes:"
find . -name Dockerfile | xargs grep $VERSION
grep $VERSION docker-compose.yml
