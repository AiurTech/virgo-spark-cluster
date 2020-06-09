#!/bin/bash
declare -a dependencies=(hadoop-namenode:8020 hadoop-datanode:50075 hive-metastore-postgresql:5432 hive-metastore:9083)

source $VIRGO_HOME/coordinator.sh

wait_for_dependencies "hive" "${dependencies[*]}"

echo "Wait for other services to initialize..."
sleep 15

$VIRGO_HOME/setup.sh

echo "==============================="
mkdir -p /tmp/virgo
touch /tmp/virgo/hive.log
ln -sf /dev/stdout /tmp/virgo/hive.log

function validateHive() {
    PGPASSWORD=hive psql -U hive -h hive-metastore-postgresql -d metastore -t -c 'select * from "VERSION"' 2> /dev/null | wc -l
}

echo "Waiting for Hive metastore to initialize schema"
while [ "$(validateHive)" != "2" ]; do 
    echo "Hive schema setup in progress"
    sleep 3
done

echo "Starting Hive in HTTP Mode"
hive --service hiveserver2 