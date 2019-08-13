FROM aiurtech/hadoop-base:0.7.5

ENV HADOOP_OPTS "-Ddfs.data.dir=/hadoop/datanode -Dfs.defaultFS=hdfs://hadoop-namenode:8020"

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml

RUN mkdir -p /hadoop/datanode && chown -R virgo:hadoop /hadoop/datanode

EXPOSE 50010 50075

HEALTHCHECK --interval=2m --timeout=15s --start-period=30s \ 
    CMD curl -f http://hadoop-datanode:50075  || exit 1
    
COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh