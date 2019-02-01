#USER Config 
VERSION=0.2.6
NETWORK_NAME=virgo
NETWORK_SUBNET=172.15.0.0/16

# Defaults
REPO=aiurtech
base_containers=(virgo-base hadoop-base)
containers=(hadoop-namenode hadoop-datanode hive-metastore-postgresql)
declare -a all_containers=(${base_containers[@]} ${containers[@]})
