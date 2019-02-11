FROM aiurtech/hadoop-base:0.4.7

RUN mkdir -p /hadoop/namenode && chown -R virgo:hadoop /hadoop/namenode

COPY hdfs-site.xml $HADOOP_CONF_DIR/hdfs-site.xml

EXPOSE 8020 50070

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh