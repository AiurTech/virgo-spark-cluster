echo "Spark HDFS setup..."
hdfs dfsadmin -safemode wait
hdfs dfs -ls /
hdfs dfs -mkdir -p /apps/livy/upload
echo "Livy HDFS setup complete"