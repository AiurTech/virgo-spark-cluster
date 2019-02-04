#!/usr/bin/env bash

function keyValueSearch() {
	local key="$1"
	local file="$2"

	grep -A 2 $key $file | grep -oP '(?<=<value>).*?(?=</value>)'' 
}