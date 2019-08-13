FROM aiurtech/hadoop-base:0.7.5

ENV HIVE_HOME=$VIRGO_HOME/apache-hive-$HIVE_VERSION
ENV PATH $HIVE_HOME/bin:$PATH

RUN set -x \
    && curl -fSL "https://www-eu.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz" -o /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz \    
    && tar -xf /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz -C $VIRGO_HOME \
    && mv $VIRGO_HOME/apache-hive-$HIVE_VERSION-bin ${HIVE_HOME} \
    && curl -fSL https://jdbc.postgresql.org/download/postgresql-9.4.1212.jar -o $HIVE_HOME/lib/postgresql-9.4.1212.jar \
    && chown -R virgo:hadoop $HIVE_HOME \
    && rm /tmp/apache-hive-$HIVE_VERSION-bin.tar.gz*

COPY core-site.xml $HADOOP_CONF_DIR/core-site.xml
COPY hive-site.xml $HADOOP_CONF_DIR/hive-site.xml

RUN mkdir -p /usr/share/man/man1 \
&& mkdir -p /usr/share/man/man7 \
&& apt-get update \
&& apt-get install --no-install-recommends --no-install-suggests -y apt-utils postgresql-client-11 \
&& rm -rf /var/lib/apt/lists/*

EXPOSE 9083

HEALTHCHECK --interval=1m --timeout=15s --start-period=30s \ 
    CMD nc -vz hive-metastore 9083 && [[ -f $VIRGO_HOME/initialized ]] || exit 1

COPY --chown=virgo:hadoop run.sh $VIRGO_HOME/run.sh

USER virgo

ENTRYPOINT $VIRGO_HOME/run.sh