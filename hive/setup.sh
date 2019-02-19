echo "Hive setup..."
hdfs dfsadmin -safemode wait
hdfs dfs -ls /
hdfs dfs -mkdir       /tmp
hdfs dfs -mkdir -p    /user/virgo/warehouse
hdfs dfs -chmod g+w   /tmp
hdfs dfs -chmod g+w /user/virgo/warehouse
echo "Hive setup complete"