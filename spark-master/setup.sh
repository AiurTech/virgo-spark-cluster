echo "Spark HDFS setup..."
hdfs dfsadmin -safemode wait
hdfs dfs -ls /
hdfs dfs -mkdir /virgo
hdfs dfs -mkdir -p /logs/spark
hdfs dfs -mkdir -p /apps/spark/jars
hdfs dfs -copyFromLocal $SPARK_HOME/jars /apps/spark/
hdfs dfs -copyFromLocal $SPARK_HOME/examples/jars/spark-examples_2.11-$SPARK_VERSION.jar /apps/spark-examples_2.11-$SPARK_VERSION.jar
echo "Spark HDFS setup complete"