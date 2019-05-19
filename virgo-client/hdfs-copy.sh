SRC_FILE=$1

#Pausing due to sec vulnerability
docker pause hadoop-datanode
docker cp $SRC_FILE hadoop-datanode:/tmp/.
docker unpause hadoop-datanode
