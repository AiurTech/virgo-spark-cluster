#!/bin/bash

source $HADOOP_CONF_DIR/yarn-env.sh

echo "Starting YARN Node Manager..."
yarn --config $HADOOP_CONF_DIR nodemanager