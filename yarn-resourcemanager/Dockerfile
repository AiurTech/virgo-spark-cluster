FROM aiurtech/hadoop-base:0.4.5

COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml
COPY capacity-scheduler.xml $HADOOP_CONF_DIR/capacity-scheduler.xml

EXPOSE 8030 8031 8032 8033 8088

HEALTHCHECK --interval=1m --timeout=15s --start-period=30s \ 
    CMD curl -f http://yarn-resourcemanager:8088/ || exit 1

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh