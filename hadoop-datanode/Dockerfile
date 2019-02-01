FROM aiurtech/hadoop-base:0.1.5

MAINTAINER Aiur Tech <cto+docker@aiurtech.co.uk>

ENV HADOOP_OPTS "-Ddfs.data.dir=/hadoop/datanode -Dfs.defaultFS=hdfs://hadoop-namenode:8020"
COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY core-site.xml $HADOOP_CONF_DIRcore-site.xml

RUN mkdir -p /hadoop/datanode 

CMD hdfs datanode 