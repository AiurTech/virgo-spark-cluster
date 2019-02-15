#!/bin/bash

dependencies="hadoop-namenode:50070 hadoop-datanode:50075 hive-metastore:10000 yarn-resourcemanager:8088 yarn-nodemanager:8042"

source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "spark-master" $dependencies

#$VIRGO_HOME/setup.sh

ln -sf /dev/stdout $SPARK_HOME/logs/spark-master.out

echo "Starting Spark Master on UI port $SPARK_MASTER_UI_PORT..."
spark-class org.apache.spark.deploy.master.Master \
 --webui-port $SPARK_MASTER_UI_PORT >> $SPARK_HOME/logs/spark-master.out