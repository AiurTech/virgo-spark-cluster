#!/usr/bin/env bash

declare -a dependencies=(hadoop-namenode:50070)

source $VIRGO_HOME/virgo-utils.sh
source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "hadoop-datanode" "${dependencies[*]}"

source $VIRGO_HOME/virgo-utils.sh

echo "Starting Datanode on $(keyValueSearch "fs.default.name" "$HADOOP_CONF_DIR/hdfs-site.xml")"
hdfs datanode