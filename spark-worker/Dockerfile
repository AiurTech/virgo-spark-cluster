FROM aiurtech/spark-base:0.4.5

ENV SPARK_WORKER_UI_PORT 8081

EXPOSE 8081

#HEALTHCHECK CMD curl -f http://spark-worker:8081/ || exit 1

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh
USER virgo

CMD $VIRGO_HOME/run.sh