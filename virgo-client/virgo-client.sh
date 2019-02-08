
export YARN_CONF_DIR="$(pwd)"

echo "Submitting job to YARN cluster"

NAMENODE=hdfs://hadoop-namenode:8020

export HADOOP_USER_NAME=${1:-virgo}

$SPARK_HOME/bin/spark-submit \
  --master yarn \
  --deploy-mode cluster \
  --executor-cores 8 \
  --executor-memory 4G \
  --queue test \
  --conf "spark.yarn.appMasterEnv.HADOOP_USER_NAME=${HADDOP_USER_NAME}" \
  --conf "spark.yarn.jars=$NAMENODE/apps/spark/jars/*.jar:$NAMENODE/apps/spark-examples_2.11-2.2.3.jar" \
  --class org.apache.spark.examples.SparkPi \
  $NAMENODE/apps/spark-examples_2.11-2.2.3.jar \
  1000

 # --jars $NAMENODE/apps/spark-examples_2.11-2.2.3.jar \
