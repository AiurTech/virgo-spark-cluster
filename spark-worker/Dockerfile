FROM aiurtech/spark-base:0.4.0

ENV SPARK_WORKER_UI_PORT 9091

EXPOSE 9091

HEALTHCHECK CMD curl -f http://spark-worker:9091/ || exit 1

COPY run.sh /opt/run.sh
RUN chmod a+x /opt/run.sh

CMD /opt/run.sh