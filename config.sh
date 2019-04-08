#!/usr/bin/env bash

#USER Config 
VERSION=0.6.2
NETWORK_NAME=virgo
NETWORK_SUBNET=172.15.0.0/16

# Defaults
REPO=aiurtech
base_containers=(virgo-base hadoop-base spark-base)
containers=(hadoop-namenode hadoop-datanode hive-metastore-postgresql hive-metastore yarn-resourcemanager yarn-nodemanager spark-master hive spark-worker spark-historyserver spark-livy)
declare -a all_containers=(${base_containers[@]} ${containers[@]})
