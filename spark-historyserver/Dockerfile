FROM aiurtech/spark-base:0.7.5

ENV SPARK_HISTORYSERVER_UI_PORT 18080

EXPOSE 18080

HEALTHCHECK CMD curl -f http://spark-historyserver:18080/ || exit 1

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh