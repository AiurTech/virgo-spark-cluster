FROM aiurtech/hadoop-base:0.1.5

MAINTAINER Aiur Tech <cto+docker@aiurtech.co.uk>

RUN mkdir -p /hadoop/namenode

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY run.sh /opt

RUN chmod u+x /opt/run.sh
RUN adduser --system yarn
RUN groupadd supergroup
RUN usermod -a -G supergroup yarn

EXPOSE 8020
EXPOSE 50070

CMD /opt/run.sh