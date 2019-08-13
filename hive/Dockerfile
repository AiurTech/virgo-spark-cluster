FROM aiurtech/hive-metastore:0.7.5

EXPOSE 10001

HEALTHCHECK --interval=2m --timeout=15s --start-period=40s \ 
    CMD curl -f http://hive:10001/ || exit 1

COPY hive-site.xml $HADOOP_CONF_DIR/hive-site.xml

COPY --chown=virgo:hadoop *.sh $VIRGO_HOME/

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh