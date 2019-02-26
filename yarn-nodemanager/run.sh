#!/bin/bash

declare -a dependencies=(hadoop-namenode:50070 hadoop-datanode:50075)

source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "yarn-nodemanager" "${dependencies[*]}"

source $HADOOP_CONF_DIR/yarn-env.sh

echo "Starting YARN Node Manager..."
yarn --config $HADOOP_CONF_DIR nodemanager