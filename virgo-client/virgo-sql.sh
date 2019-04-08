export YARN_CONF_DIR="$(pwd)"

export HADOOP_USER_NAME=${1:-virgo}

if [[ $(uname) -eq "Linux" ]]; then 
	SPARK_LOCAL_IP=$(ip route get 1 | awk '{print $7}' | head -n 1)
else
	SPARK_LOCAL_IP=${2:-127.0.0.1}
fi

echo "Using Spark Local IP: $SPARK_LOCAL_IP connecting to remote YARN service as $HADOOP_USER_NAME"

$SPARK_HOME/bin/spark-sql \
  --master yarn \
  --queue test \
  --conf "spark.yarn.appMasterEnv.HADOOP_USER_NAME=${HADDOP_USER_NAME}" \
  --conf spark.driver.bindAddress=$SPARK_LOCAL_IP
