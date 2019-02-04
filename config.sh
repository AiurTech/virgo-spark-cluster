#!/usr/bin/env bash

#USER Config 
VERSION=0.3.2
NETWORK_NAME=virgo
NETWORK_SUBNET=172.15.0.0/16

# Defaults
REPO=aiurtech
base_containers=(virgo-base hadoop-base)
containers=(hadoop-namenode hadoop-datanode hive-metastore-postgresql hive-metastore yarn-resourcemanager yarn-nodemanager)
declare -a all_containers=(${base_containers[@]} ${containers[@]})
