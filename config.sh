

#USER Config 
VERSION=0.2.1
NETWORK_NAME=virgo

# Defaults
REPO=aiurtech
base_containers=(virgo-base hadoop-base)
containers=(hadoop-namenode hadoop-datanode)
declare -a all_containers=(${base_containers[@]} ${containers[@]})
