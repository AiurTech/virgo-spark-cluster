#!/bin/bash

ln -sf /dev/stdout $SPARK_HOME/logs/spark-master.out

echo "Starting Spark Master on UI port $SPARK_MASTER_UI_PORT..."
spark-class org.apache.spark.deploy.master.Master \
 --webui-port $SPARK_MASTER_UI_PORT >> $SPARK_HOME/logs/spark-master.out