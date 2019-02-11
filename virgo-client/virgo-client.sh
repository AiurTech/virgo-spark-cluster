
export YARN_CONF_DIR="$(pwd)"

SPARK_VERSION=2.2.3

DEPLOY_MODE=${1:-cluster}
export HADOOP_USER_NAME=${2:-virgo}

if [[ $(spark-submit --version 2> out) && $(cat out | grep -o $SPARK_VERSION out | head -n 1) != $SPARK_VESRION ]]; then  
	echo "Wrong Version for Spark binaries. Expected Spark version: $SPARK_VERSION"; 
else 
	echo "using SPARK $SPARK_VERSION"; 
fi

NAMENODE=hdfs://hadoop-namenode:8020
echo "Submitting job as YARN $DEPLOY_MODE to $NAMENODE"

if [ "$DEPLOY_MODE" == "cluster" ]; then 

$SPARK_HOME/bin/spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --executor-cores 8 \
  --executor-memory 4G \
  --queue test \
  --conf "spark.yarn.appMasterEnv.HADOOP_USER_NAME=${HADDOP_USER_NAME}" \
  --conf spark.yarn.am.extraJavaOptions="-XX:ReservedCodeCacheSize=100M -XX:MaxMetaspaceSize=256m -XX:CompressedClassSpaceSize=256m" \
  --class org.apache.spark.examples.SparkPi \
  $SPARK_HOME/examples/jars/spark-examples_2.11-$SPARK_VERSION.jar \
1000

else 

$SPARK_HOME/bin/spark-submit \
  --master yarn \
  --deploy-mode client \
  --executor-cores 8 \
  --executor-memory 4G \
  --queue test \
  --conf "spark.yarn.appMasterEnv.HADOOP_USER_NAME=${HADDOP_USER_NAME}" \
  --conf spark.driver.extraJavaOptions="-XX:ReservedCodeCacheSize=100M -XX:MaxMetaspaceSize=256m -XX:CompressedClassSpaceSize=256m" \
  --class org.apache.spark.examples.SparkPi \
  $SPARK_HOME/examples/jars/spark-examples_2.11-$SPARK_VERSION.jar \
1000

fi 
