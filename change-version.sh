#!/bin/bash

[ "$#" -eq 1 ] || echo "1 argument required, $# provided"; exit -1;

OLD_VERSION=$1

source config.sh
find . -name Dockerfile -type f -exec sed -i 's/$OLD_VERSION/$VERSION/g' {} \;

echo "Changed from $OLD_VERSION to $VERSION"
find . -name Dockerfile | xargs grep $VERSION

