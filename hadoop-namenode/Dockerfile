FROM aiurtech/hadoop-base:0.3.2

RUN mkdir -p /hadoop/namenode

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml

RUN adduser --system yarn
RUN groupadd supergroup
RUN usermod -a -G supergroup yarn

EXPOSE 8020
EXPOSE 50070

COPY run.sh /opt/run.sh
RUN chmod u+x /opt/run.sh

CMD /opt/run.sh