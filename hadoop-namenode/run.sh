#!/usr/bin/env bash

source /opt/virgo-utils.sh

echo "Formatting Namenode..."
hdfs namenode -format -nonInteractive
echo "Starting Namenode on $(grep "fs.default.name" "$HADOOP_CONF_DIR/hdfs-site.xml")"
hdfs namenode