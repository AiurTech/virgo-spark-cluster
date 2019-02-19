#!/usr/bin/env bash

source $VIRGO_HOME/virgo-utils.sh

HIVE_USER="$(keyValueSearch "javax.jdo.option.ConnectionUserName" "$HADOOP_CONF_DIR/hive-site.xml")"
HIVE_PASS="$(keyValueSearch "javax.jdo.option.ConnectionPassword" "$HADOOP_CONF_DIR/hive-site.xml")"

HIVE_HOST="$(keyValueSearch "hive.server2.thrift.bind.host" "$HADOOP_CONF_DIR/hive-site.xml")"
HIVE_PORT=10001

HIVE_DB="default"

echo "Beeline with: U:$HIVE_USER, p: ###, Host: $HIVE_HOST:$HIVE_PORT/$HIVE_DB"

beeline -n $HIVE_USER -p $HIVE_PASS -u \
    "jdbc:hive2://${HIVE_HOST}:${HIVE_PORT}/$HIVE_DB;transportMode=http;httpPath=cliservice" \
    --outputformat=table --color=true --showDbInPrompt=true