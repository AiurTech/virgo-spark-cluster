FROM aiurtech/spark-base:0.7.4

ENV LIVY_VERSION "0.4.0-incubating"
ENV LIVY_SERVER_PORT 8998
ENV LIVY_HOME $VIRGO_HOME/livy

EXPOSE 8998

RUN set -x \
    && curl -fSL "http://archive.apache.org/dist/incubator/livy/${LIVY_VERSION}/livy-${LIVY_VERSION}-bin.zip" -o /tmp/livy.zip \    
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y unzip \
    && unzip /tmp/livy.zip -d ${VIRGO_HOME} \
    && ln -s $VIRGO_HOME/livy-${LIVY_VERSION}-bin $LIVY_HOME \
    && mkdir -p ${LIVY_HOME}/logs \
    && mkdir -p ${LIVY_HOME}/upload \
    && mv ${LIVY_HOME}/conf/log4j.properties.template ${LIVY_HOME}/conf/log4j.properties \ 
    && chown -R virgo:hadoop $VIRGO_HOME/livy-${LIVY_VERSION}-bin \
    && chown virgo:hadoop $LIVY_HOME \
    && rm /tmp/livy.zip

HEALTHCHECK CMD curl -f http://spark-livy:8998/ || exit 1

COPY --chown=virgo:hadoop livy.conf $LIVY_HOME/conf/livy.conf

COPY --chown=virgo:hadoop setup.sh $VIRGO_HOME/setup.sh
COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh