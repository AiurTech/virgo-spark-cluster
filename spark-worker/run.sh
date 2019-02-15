#!/bin/bash

dependencies="hadoop-namenode:50070 hadoop-datanode:50075 hive-metastore:10000 yarn-resourcemanager:8088 yarn-nodemanager:8042"

source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "spark-worker" $dependencies

ln -sf /dev/stdout $SPARK_HOME/logs/spark-worker.out

echo "Starting Spark Worker for $SPARK_MASTER_URL "
spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER_URL >> $SPARK_HOME/logs/spark-worker.out