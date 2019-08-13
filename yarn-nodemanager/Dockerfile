FROM aiurtech/hadoop-base:0.7.5

COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

EXPOSE 8042

HEALTHCHECK CMD curl -f http://yarn-nodemanager:8042/ || exit 1

ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV YARN_ROOT_LOGGER="DEBUG,RFA"
ENV HADOOP_DAEMON_ROOT_LOGGER=DEBUG,RFA

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh