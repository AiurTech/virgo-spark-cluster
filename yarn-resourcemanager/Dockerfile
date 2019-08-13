FROM aiurtech/hadoop-base:0.7.5

COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY capacity-scheduler.xml $HADOOP_CONF_DIR/capacity-scheduler.xml

EXPOSE 8030 8031 8032 8033 8088

HEALTHCHECK --interval=1m --timeout=15s --start-period=30s \ 
    CMD curl -f http://yarn-resourcemanager:8088/ || exit 1

ENV HADOOP_YARN_HOME=$HADOOP_HOME
ENV YARN_ROOT_LOGGER="DEBUG,RFA"
ENV HADOOP_DAEMON_ROOT_LOGGER=DEBUG,RFA

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh