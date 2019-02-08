FROM aiurtech/hadoop-base:0.4.5

ENV HIVE_URL https://www-eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz

ENV HIVE_HOME=$VIRGO_HOME/apache-hive-$HIVE_VERSION
ENV PATH $HIVE_HOME/bin:$PATH

RUN set -x \
    && curl -fSL "$HIVE_URL" -o /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz \    
    && tar -xf /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz -C $VIRGO_HOME \
    && mv $VIRGO_HOME/apache-hive-$HIVE_VERSION-bin ${HIVE_HOME} \
    && chown -R virgo:hadoop $HIVE_HOME \
    && rm /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz*

COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY hive-site.xml $HADOOP_CONF_DIR/hive-site.xml

RUN mkdir -p /usr/share/man/man1 \
&& mkdir -p /usr/share/man/man7 \
&& apt-get update \
&& apt-get install --no-install-recommends --no-install-suggests -y apt-utils postgresql-client-9.6 \
&& rm -rf /var/lib/apt/lists/*

ADD https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar $HIVE_HOME/lib/

EXPOSE 10000

HEALTHCHECK --interval=10m --timeout=15s --start-period=30s \ 
    CMD nc -vz hive-metastore 10000 || exit 1

COPY run.sh $VIRGO_HOME/run.sh
RUN chown virgo $VIRGO_HOME/run.sh && chmod u+x $VIRGO_HOME/run.sh && chown -R virgo:hadoop ${HIVE_HOME}
USER virgo

CMD $VIRGO_HOME/run.sh