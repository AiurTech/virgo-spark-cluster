
source config.sh

CLUSTER_VERSION=$VERSION
NETWORK_SUBNET=${1:-172.15.0.0/16}

docker network create $NETWORK_NAME --subnet $NETWORK_SUBNET
docker run -d --name hadoop-namenode -h hadoop-namenode --net $NETWORK_NAME -p 8020:8020 -p 50070:50070 $REPO/hadoop-namenode:$CLUSTER_VERSION
docker run -d --name hadoop-datanode -h hadoop-datanode --net $NETWORK_NAME -p 50075:50075 $REPO/hadoop-datanode:$CLUSTER_VERSION

