FROM aiurtech/hadoop-base:0.4.5

ENV SPARK_HOME=$VIRGO_HOME/spark-$SPARK_VERSION

ARG SPARK_URL=https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-${SPARK_VERSION}-bin-without-hadoop.tgz
RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tgz \    
    && tar -xvf /tmp/spark.tgz -C $VIRGO_HOME \
    && mv $VIRGO_HOME/spark-${SPARK_VERSION}-bin-without-hadoop $SPARK_HOME \
    && mkdir -p $SPARK_HOME/logs \
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

ADD https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar $SPARK_HOME/jars/
RUN chown -R virgo:hadoop $SPARK_HOME