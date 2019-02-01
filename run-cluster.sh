
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

echo "Starting Hive..."
docker run -d --name hive-metastore-postgresql -h hive-metastore-postgresql --net $NETWORK_NAME \
	-p 5432:5432 \
	$REPO/hive-metastore-postgresql:$CLUSTER_VERSION

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

docker ps
wait 

# psql -U hive -h hive-metastore-postgresql -d metastore -t -c 'select * from "VERSION"' | grep "2.1.0"
