#!/bin/bash
dependencies="hadoop-namenode:8020 hadoop-datanode:50075 hive-metastore-postgresql:5432 hive-metastore:9083"

source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "hive" $dependencies

$VIRGO_HOME/setup.sh

echo "==============================="
mkdir -p /tmp/virgo
touch /tmp/virgo/hive.log
ln -sf /dev/stdout /tmp/virgo/hive.log

echo "Starting Hive in HTTP Mode"
hive --service hiveserver2 