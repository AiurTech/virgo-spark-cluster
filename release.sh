#!/usr/bin/env bash

if [ $# -ne 2 ]; then echo "args: $0 <version> <comment>"; exit; fi

TAG_VERSION="$1"
COMMENT=${2}

echo "Tag: $TAG_VERSION "
echo "Tag comment: Release version $TAG_VERSION - $COMMENT"

git tag -a $TAG_VERSION -m "Release version $TAG_VERSION - $COMMENT"
git push origin $TAG_VERSION