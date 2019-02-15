#!/usr/bin/env bash

source $VIRGO_HOME/virgo-utils.sh

echo "Formatting Namenode..."
hdfs namenode -format -nonInteractive
echo "Starting Namenode on $(keyValueSearch "fs.default.name" "$HADOOP_CONF_DIR/hdfs-site.xml")"
hdfs namenode