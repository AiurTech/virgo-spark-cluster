FROM aiurtech/hadoop-base:0.4.7

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

EXPOSE 8042

HEALTHCHECK CMD curl -f http://yarn-nodemanager:8042/ || exit 1

ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV YARN_ROOT_LOGGER="DEBUG,RFA"
ENV HADOOP_DAEMON_ROOT_LOGGER=DEBUG,RFA

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh