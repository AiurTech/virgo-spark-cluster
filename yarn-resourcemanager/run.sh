#!/bin/bash

echo "Starting YARN Resource Manager..."
echo "Using 'test' queue on capacity-scheduler.xml"

yarn --config $HADOOP_CONF_DIR resourcemanager