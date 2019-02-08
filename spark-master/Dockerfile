FROM aiurtech/spark-base:0.4.5

ENV SPARK_MASTER_UI_PORT 9090

EXPOSE 6066 7077 9090

HEALTHCHECK CMD curl -f http://spark-master:9090/ || exit 1

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh