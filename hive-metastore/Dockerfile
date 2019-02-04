FROM aiurtech/hadoop-base:0.2.8

ENV HIVE_URL https://www-eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

ENV HIVE_HOME=/opt/apache-hive-$HIVE_VERSION
ENV PATH $HIVE_HOME/bin:$PATH

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz \    
    && tar -xvf /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz -C /opt/ \
    && mv /opt/apache-hive-$HIVE_VERSION-bin ${HIVE_HOME} \
    && rm /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz*

COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY hive-site.xml $HADOOP_CONF_DIR/hive-site.xml

ADD https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar $HIVE_HOME/lib/

EXPOSE 10000

CMD hive --service metastore