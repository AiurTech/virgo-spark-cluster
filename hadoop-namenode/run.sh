echo "Formatting Namenode..."
hdfs namenode -format -nonInteractive
echo "Starting Namenode on $(grep "hdfs://" /etc/hadoop/hdfs-site.xml)"
hdfs namenode