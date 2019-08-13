FROM aiurtech/hadoop-base:0.7.5

ENV SPARK_HOME=$VIRGO_HOME/spark-$SPARK_VERSION

RUN set -x \
    && curl -fSL "https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" -o /tmp/spark.tgz \    
    && tar -xf /tmp/spark.tgz -C $VIRGO_HOME \
    && mv $VIRGO_HOME/spark-${SPARK_VERSION}-bin-hadoop2.7 $SPARK_HOME \
    && mkdir -p $SPARK_HOME/logs \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -o $SPARK_HOME/jars/postgresql-9.4.1212.jar \
    && chown -R virgo:hadoop $SPARK_HOME \
    && rm /tmp/spark.tgz*

ENV PATH $SPARK_HOME/bin/:$PATH

COPY core-site.xml $SPARK_HOME/conf/core-site.xml
COPY hdfs-site.xml $SPARK_HOME/conf/hdfs-site.xml
COPY hive-site.xml $SPARK_HOME/conf/hive-site.xml
COPY yarn-site.xml $SPARK_HOME/conf/yarn-site.xml
COPY spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

ENV SPARK_DIST_CLASSPATH="$(hadoop classpath)"
RUN echo "export SPARK_DIST_CLASSPATH=$SPARK_DIST_CLASSPATH" >> ${SPARK_HOME}/conf/spark-env.sh
ENV HADOOP_CONF_DIR=$SPARK_HOME/conf
ENV SPARK_MASTER_URL=spark://spark-master:7077

RUN chown -R virgo:hadoop $SPARK_HOME