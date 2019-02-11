FROM aiurtech/spark-base:0.4.7

ENV SPARK_WORKER_UI_PORT 8081

EXPOSE 8081

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh