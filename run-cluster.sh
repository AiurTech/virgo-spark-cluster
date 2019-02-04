#!/usr/bin/env bash

source config.sh

CLUSTER_VERSION=${1:-$VERSION}

docker network create $NETWORK_NAME --subnet $NETWORK_SUBNET
echo "Starting Hadoop..."
docker run -d --name hadoop-namenode -h hadoop-namenode --net $NETWORK_NAME \
	-p 8020:8020 -p 50070:50070 \
	$REPO/hadoop-namenode:$CLUSTER_VERSION
docker run -d --name hadoop-datanode -h hadoop-datanode --net $NETWORK_NAME \
	-p 50075:50075 \
	--link hadoop-namenode:hadoop-namenode \
	$REPO/hadoop-datanode:$CLUSTER_VERSION

docker run -d --name yarn-resourcemanager -h yarn-resourcemanager --net $NETWORK_NAME \
	-p 8030:8030 -p 8031:8031 -p 8032:8032 -p 8033:8033 -p 8088:8088 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	$REPO/yarn-resourcemanager:$CLUSTER_VERSION

docker run -d --name yarn-nodemanager -h yarn-nodemanager --net $NETWORK_NAME \
	-p 8042:8042 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	$REPO/yarn-nodemanager:$CLUSTER_VERSION	

echo "Starting Hive..."
docker run -d --name hive-metastore-postgresql -h hive-metastore-postgresql --net $NETWORK_NAME \
	-p 5432:5432 \
	$REPO/hive-metastore-postgresql:$CLUSTER_VERSION

docker run -d --name hive-metastore -h hive-metastore --net $NETWORK_NAME \
        -p 10000:10000 \
		--link hive-metastore-postgresql:hive-metastore-postgresql \
        $REPO/hive-metastore:$CLUSTER_VERSION

echo "Starting Spark..."
docker run -d --name spark-master -h spark-master --net $NETWORK_NAME \
	-p 6066:6066 -p 7077:7077 -p 9090:9090 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	--link hive-metastore:hive-metastore \
	$REPO/spark-master:$CLUSTER_VERSION

docker run -d --name spark-worker -h spark-worker --net $NETWORK_NAME \
	-p 9091:9091 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	--link hive-metastore-postgresql:hive-metastore-postgresql \
	--link hive-metastore:hive-metastore \
	--link spark-master:spark-master \
	$REPO/spark-worker:$CLUSTER_VERSION

echo "Virgo Cluster Starting..."
echo -e "\033[1;36m$(cat virgo.sh)\033[0m"

function check() {
	local container="$1"
	local expr="$2"
	docker logs $container 2>&1 | grep "$expr"
}

function wait() {
for i in 1 2 3 4 5 6 7 8 9 10
do
	check "hadoop-namenode" "NameNode RPC up" 
	check "hadoop-datanode" "DataNode: Successfully sent block report"
	if [[ $? == 1 ]]; then
		sleep 10 
	else 
		echo "Started"	
	fi
done
}

sleep 30 
docker ps