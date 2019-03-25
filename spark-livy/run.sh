#!/bin/bash

declare -a dependencies=(hadoop-namenode:8020 hadoop-datanode:50075 yarn-resourcemanager:8088 yarn-nodemanager:8042 spark-master:7077)

source $VIRGO_HOME/virgo-utils.sh
source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "spark-livy" "${dependencies[*]}"

$VIRGO_HOME/setup.sh

echo "[Start] $(timestamp)"

ln -sf /dev/stdout $LIVY_HOME/logs/livy.out

echo "Starting Spark Livy Server on port $LIVY_SERVER_PORT..."
$LIVY_HOME/bin/livy-server $@ >> $LIVY_HOME/logs/livy.out
