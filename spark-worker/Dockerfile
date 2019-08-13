FROM aiurtech/spark-base:0.7.5

ENV SPARK_WORKER_UI_PORT 8081

EXPOSE 8081

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh