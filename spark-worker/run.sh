#!/bin/bash

declare -a dependencies=(hadoop-namenode:50070 hadoop-datanode:50075 hive-metastore:9083 yarn-resourcemanager:8088 yarn-nodemanager:8042 spark-master:9090 spark-master:7077)

source $VIRGO_HOME/virgo-utils.sh
source $VIRGO_HOME/coordinator.sh

echo "[Init] $(timestamp)"

wait_for_dependencies "spark-worker" "${dependencies[*]}"

echo "Waiting HDFS to initialize..."
hdfs dfsadmin -safemode wait
hdfs dfs -ls /

echo "[Start] $(timestamp)"

ln -sf /dev/stdout $SPARK_HOME/logs/spark-worker.out

echo "Starting Spark Worker for $SPARK_MASTER_URL "
spark-class $JVM_DOCKER_OPTS org.apache.spark.deploy.worker.Worker $SPARK_MASTER_URL >> $SPARK_HOME/logs/spark-worker.out