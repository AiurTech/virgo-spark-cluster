FROM aiurtech/spark-base:0.4.7

ENV SPARK_MASTER_UI_PORT 9090

EXPOSE 6066 7077 9090

HEALTHCHECK CMD curl -f http://spark-master:9090/ || exit 1

COPY run.sh $VIRGO_HOME/run.sh
COPY setup.sh $VIRGO_HOME/setup.sh

RUN chown virgo:hadoop $VIRGO_HOME/*.sh && chmod u+x $VIRGO_HOME/*.sh
USER virgo

CMD $VIRGO_HOME/run.sh