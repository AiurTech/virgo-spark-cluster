#!/usr/bin/env bash

#USER Config 
VERSION=0.5.0
NETWORK_NAME=virgo
NETWORK_SUBNET=172.15.0.0/16

# Defaults
REPO=aiurtech
base_containers=(virgo-base hadoop-base spark-base)
containers=(hadoop-namenode hadoop-datanode hive-metastore-postgresql hive-metastore yarn-resourcemanager yarn-nodemanager spark-master spark-worker)
declare -a all_containers=(${base_containers[@]} ${containers[@]})
