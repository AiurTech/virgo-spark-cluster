FROM aiurtech/hadoop-base:0.5.0

ENV HADOOP_OPTS "-Ddfs.data.dir=/hadoop/datanode -Dfs.defaultFS=hdfs://hadoop-namenode:8020"

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml

RUN mkdir -p /hadoop/datanode && chown -R virgo:hadoop /hadoop/datanode

EXPOSE 50075

HEALTHCHECK --interval=10m --timeout=15s --start-period=30s \ 
    CMD nc -vz hadoop-datanode 50010 || exit 1

USER virgo

ENTRYPOINT ["hdfs", "datanode"]