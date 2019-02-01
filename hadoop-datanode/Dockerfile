FROM aiurtech/hadoop-base:0.2.6

MAINTAINER Aiur Tech <cto+docker@aiurtech.co.uk>

ENV HADOOP_OPTS "-Ddfs.data.dir=/hadoop/datanode -Dfs.defaultFS=hdfs://hadoop-namenode:8020"
COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml

RUN mkdir -p /hadoop/datanode 

EXPOSE 50075

ENTRYPOINT ["/opt/coordinator.sh"]

HEALTHCHECK --interval=10m --timeout=15s --start-period=30s \ 
    CMD curl -f http://localhost:50075/ || exit 1

CMD ["hdfs", "datanode"]