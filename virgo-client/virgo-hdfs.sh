#!/usr/bin/env bash

CMD=$1
ARG1=$2
ARG2=$3

export HADOOP_CONF_DIR="$(pwd)"

export HADOOP_USER_NAME=${2:-virgo}

NAMENODE=hdfs://hadoop-namenode:8020

declare -a run=()

if [[ "$CMD" == "ls" ]]; then
 declare -a run=("-ls" "$ARG1")
elif [[ "$CMD" == "copyFromLocal" ]]; then
 declare -a run=("-copyFromLocal" "$ARG1" "${NAMENODE}$ARG2")
elif [[ "$CMD" == "rm" ]]; then
 declare -a run=("-rm" "-skipTrash" "$ARG1")
else
 echo "Wrong command: $1 $2 $3"
 exit -1
fi

echo "Executing: hdfs dfs ${run[@]}"

docker-compose exec hadoop-datanode "hdfs" "dfs" ${run[@]}
