#!/usr/bin/env bash

source config.sh

CLUSTER_VERSION=${1:-$VERSION}

docker network create $NETWORK_NAME --subnet $NETWORK_SUBNET
echo "Starting Hadoop..."
docker run -d --name hadoop-namenode -h hadoop-namenode --net $NETWORK_NAME \
	-p 8020:8020 -p 50070:50070 \
	$REPO/hadoop-namenode:$CLUSTER_VERSION
docker run -d --name hadoop-datanode -h hadoop-datanode --net $NETWORK_NAME \
	-p 50010:50010 \
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

echo "Starting Hive Metastore..."
docker run -d --name hive-metastore-postgresql -h hive-metastore-postgresql --net $NETWORK_NAME \
	-p 5432:5432 \
	$REPO/hive-metastore-postgresql:$CLUSTER_VERSION

docker run -d --name hive-metastore -h hive-metastore --net $NETWORK_NAME \
        -p 9083:9083 \
		--link hive-metastore-postgresql:hive-metastore-postgresql \
        $REPO/hive-metastore:$CLUSTER_VERSION

echo "Starting Spark Master..."
docker run -d --name spark-master -h spark-master --net $NETWORK_NAME \
	-p 6066:6066 -p 7077:7077 -p 9090:9090 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	--link hive-metastore:hive-metastore \
	$REPO/spark-master:$CLUSTER_VERSION

echo "Starting Hive..."
docker run -d --name hive -h hive --net $NETWORK_NAME \
	-p 10001:10001 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link hive-metastore-postgresql:hive-metastore-postgresql \
	--link hive-metastore:hive-metastore \
	--link spark-master:spark-master \
	$REPO/hive:$CLUSTER_VERSION

echo "Starting Spark History Server..."
docker run -d --name spark-historyserver -h spark-historyserver --net $NETWORK_NAME \
	-p 18080:18080 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	--link yarn-nodemanager:yarn-nodemanager \
	--link spark-master:spark-master \
	$REPO/spark-historyserver:$CLUSTER_VERSION

echo "Starting Spark Workers..."
docker run -d --name spark-worker -h spark-worker --net $NETWORK_NAME \
	-p 8081:8081 \
	--link hadoop-namenode:hadoop-namenode \
	--link hadoop-datanode:hadoop-datanode \
	--link yarn-resourcemanager:yarn-resourcemanager \
	--link hive-metastore-postgresql:hive-metastore-postgresql \
	--link hive-metastore:hive-metastore \
	--link hive:hive \
	--link spark-master:spark-master \
	--link spark-historyserver:spark-historyserver \
	$REPO/spark-worker:$CLUSTER_VERSION

echo "Virgo Cluster Starting..."
echo -e "\033[1;36m$(cat virgo.sh)\033[0m"

function check() {
	local container="$1"
	local expr="$2"
        output=$(docker logs $container 2>&1 | tail -n 10 | grep -P "$expr")
	match=$(echo "$output" | grep -o "$expr")

	if [[ $match == $expr ]]; then
		return 0
	else
		return 1 
	fi
}

source virgo-base/coordinator.sh

declare -a dependencies=(hadoop-namenode:8020 hadoop-datanode:50075 hive-metastore:9083 spark-master:9090)

wait_for_dependencies "virgo" "${dependencies[*]}"

function is_ready() {
	local container="$1"
	local expr="$2"
	wait_time=5

    local ready=1

	for i in {1..10}; do
		check $container "$expr"
		
		if [[ $? == 1 ]]; then
			sleep $wait_time
		else
            ready=0
			break
		fi 
	done
        if [[ $ready -eq 1 ]]; then
                echo "$container was not ready in expected time."
        fi
}

is_ready "hadoop-namenode" "NameNode RPC up" 
is_ready "hadoop-datanode" "DataNode: Successfully sent block report"
is_ready "hive-metastore" "PostgreSQL is ready to go"
is_ready "spark-master" "Master: I have been elected leader! New state: ALIVE"
is_ready "hive" "Service:HiveServer2 is started."

docker ps