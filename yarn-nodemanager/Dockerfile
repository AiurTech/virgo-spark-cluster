FROM aiurtech/hadoop-base:0.4.5

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml
COPY yarn-site.xml $HADOOP_CONF_DIR/yarn-site.xml

EXPOSE 8042

HEALTHCHECK CMD curl -f http://yarn-nodemanager:8042/ || exit 1

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh