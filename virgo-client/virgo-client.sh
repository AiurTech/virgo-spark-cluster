
export YARN_CONF_DIR="$(pwd)"

echo "Submitting job as YARN client"


export HADOOP_USER_NAME=${1:-virgo}

$SPARK_HOME/bin/spark-submit \
  --master yarn \
  --deploy-mode client \
  --executor-cores 8 \
  --executor-memory 4G \
  --queue test \
  --conf "spark.yarn.appMasterEnv.HADOOP_USER_NAME=${HADDOP_USER_NAME}" \
  --conf spark.yarn.am.extraJavaOptions="-XX:ReservedCodeCacheSize=100M -XX:MaxMetaspaceSize=256m -XX:CompressedClassSpaceSize=256m" \
  --class org.apache.spark.examples.SparkPi \
  $SPARK_HOME/examples/jars/spark-examples_2.11-2.2.3.jar \
  1000

# NAMENODE=hdfs://hadoop-namenode:8020

#  --conf "spark.yarn.jars=$NAMENODE/apps/spark/jars/*.jar:$NAMENODE/apps/spark-examples_2.11-2.2.3.jar" \
#   --conf spark.driver.extraJavaOptions
#   $NAMENODE/apps/spark-examples_2.11-2.2.3.jar \

