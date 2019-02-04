FROM aiurtech/hadoop-base:0.4.0

ENV SPARK_HOME=/opt/spark-$SPARK_VERSION

ARG SPARK_URL=https://archive.apache.org/dist/spark/spark-$SPARK_VERSION/spark-${SPARK_VERSION}-bin-without-hadoop.tgz
RUN set -x \
    && curl -fSL "$SPARK_URL" -o /tmp/spark.tgz \    
    && tar -xvf /tmp/spark.tgz -C /opt/ \
    && mv /opt/spark-${SPARK_VERSION}-bin-without-hadoop $SPARK_HOME \
    && mkdir -p $SPARK_HOME/logs \
    && rm /tmp/spark.tgz*

ENV PATH $SPARK_HOME/bin/:$PATH

COPY hdfs-site.xml $SPARK_HOME/conf/hdfs-site.xml
COPY core-site.xml $SPARK_HOME/conf/core-site.xml
COPY spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf

ENV SPARK_DIST_CLASSPATH="$(hadoop classpath)"
RUN echo "export SPARK_DIST_CLASSPATH=$SPARK_DIST_CLASSPATH" >> ${SPARK_HOME}/conf/spark-env.sh

ENV SPARK_MASTER_URL=spark://spark-master:7077