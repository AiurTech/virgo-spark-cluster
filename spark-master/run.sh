#!/bin/bash

ln -sf /dev/stdout $SPARK_HOME/logs/spark-master.out

hdfs dfs -mkdir -p /apps/spark/jars
hdfs dfs -copyFromLocal $SPARK_HOME/jars /apps/spark/
hdfs dfs -copyFromLocal $SPARK_HOME/examples/jars/spark-examples_2.11-$SPARK_VERSION.jar /apps/spark-examples_2.11-$SPARK_VERSION.jar
hdfs dfs -mkdir -p /virgo

echo "Starting Spark Master on UI port $SPARK_MASTER_UI_PORT..."
spark-class org.apache.spark.deploy.master.Master \
 --webui-port $SPARK_MASTER_UI_PORT >> $SPARK_HOME/logs/spark-master.out