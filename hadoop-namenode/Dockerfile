FROM aiurtech/hadoop-base:0.4.0

RUN mkdir -p /hadoop/namenode

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml

RUN adduser --system yarn
RUN groupadd supergroup
RUN usermod -a -G supergroup yarn

EXPOSE 8020 50070

COPY run.sh /opt/run.sh
RUN chmod u+x /opt/run.sh

CMD /opt/run.sh