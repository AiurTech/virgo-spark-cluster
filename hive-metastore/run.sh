#!/usr/bin/env bash

# Enable Job Control
set -m

source $VIRGO_HOME/virgo-utils.sh

echo "==============================="

while ! nc -z hive-metastore-postgresql 5432; do 
    echo "PostgresSQL Port not open..."
    sleep 3
done

mkdir -p /tmp/virgo
touch /tmp/virgo/hive.log
ln -sf /dev/stdout /tmp/virgo/hive.log

echo "Starting Hive Metastore..."
echo "Hive Schema creation: $(keyValueSearch "datanucleus.autoCreateTables" "$HADOOP_CONF_DIR/hive-site.xml")"
hive --service metastore &

sleep 10

function validateHive() {
    psql -U hive -h hive-metastore-postgresql -d metastore -t -c 'select * from "VERSION"' 2> /dev/null | wc -l
}

echo "Waiting for PostgreSQL metastore to initialize schema"
while [ "$(validateHive)" != "2" ]; do 
    echo "Hive schema setup in progress"
    sleep 3
done
echo "PostgreSQL is ready to go for hive@hive-metastore-postgresql/metastore"

touch $VIRGO_HOME/initialized

fg %1