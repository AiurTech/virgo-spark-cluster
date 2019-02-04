FROM aiurtech/hadoop-base:0.3.2

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

EXPOSE 8042

HEALTHCHECK CMD curl -f http://yarn-nodemanager:8042/ || exit 1

COPY run.sh /opt/run.sh
RUN chmod a+x /opt/run.sh

CMD /opt/run.sh