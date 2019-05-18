
SRC_FILE=$1
DEST_PATH=${2-"/apps"}
FILE=$(basename $SRC_FILE)

echo "Uploading $FILE to $DEST_PATH"
./hdfs-copy.sh $SRC_FILE
./virgo-hdfs.sh copyFromLocal "/tmp/$FILE" "$DEST_PATH/$FILE"
