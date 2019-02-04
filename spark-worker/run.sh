#!/bin/bash

ln -sf /dev/stdout $SPARK_HOME/logs/spark-worker.out

echo "Starting Spark Worker for $SPARK_MASTER_URL "
spark-class org.apache.spark.deploy.worker.Worker $SPARK_MASTER_URL >> $SPARK_HOME/logs/spark-worker.out