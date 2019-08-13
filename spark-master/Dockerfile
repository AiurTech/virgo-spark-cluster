FROM aiurtech/spark-base:0.7.5

ENV SPARK_MASTER_UI_PORT 9090

EXPOSE 6066 7077 9090

HEALTHCHECK CMD curl -f http://spark-master:9090/ || exit 1

COPY --chown=virgo:hadoop *.sh $VIRGO_HOME/

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh