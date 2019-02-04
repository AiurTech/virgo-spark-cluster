FROM aiurtech/hadoop-base:0.4.0

COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY capacity-scheduler.xml $HADOOP_CONF_DIR/capacity-scheduler.xml

EXPOSE 8030 8031 8032 8033 8088

HEALTHCHECK CMD curl -f http://yarn-resourcemanager:8088/ || exit 1

COPY run.sh /opt/run.sh
RUN chmod a+x /opt/run.sh

CMD /opt/run.sh