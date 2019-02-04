FROM aiurtech/spark-base:0.4.0

ENV SPARK_MASTER_UI_PORT 9090

EXPOSE 6066 7077 9090

HEALTHCHECK CMD curl -f http://spark-master:9090/ || exit 1

COPY run.sh /opt/run.sh
RUN chmod a+x /opt/run.sh

CMD /opt/run.sh