FROM aiurtech/hadoop-base:0.7.4

RUN mkdir -p /hadoop/namenode && chown -R virgo:hadoop /hadoop/namenode

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml

EXPOSE 8020 50070

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh