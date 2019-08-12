#!/bin/bash

declare -a dependencies=(hadoop-namenode:8020 hadoop-datanode:50075 yarn-resourcemanager:8088 yarn-nodemanager:8042 spark-master:7077)

source $VIRGO_HOME/virgo-utils.sh
source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "spark-historyserver" "${dependencies[*]}"

hdfs dfs -mkdir -p /logs/spark

ln -sf /dev/stdout $SPARK_HOME/logs/spark-historyserver.out

echo "Starting Spark History Server on UI port $SPARK_HISTORYSERVER_UI_PORT..."
spark-class $JVM_DOCKER_OPTS org.apache.spark.deploy.history.HistoryServer >> $SPARK_HOME/logs/spark-historyserver.out
