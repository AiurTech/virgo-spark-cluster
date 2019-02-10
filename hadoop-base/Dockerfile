FROM aiurtech/virgo-base:0.4.6

RUN adduser --system virgo
RUN groupadd hadoop
RUN usermod -a -G hadoop virgo

RUN mkdir -p $VIRGO_HOME && chown virgo:hadoop ${VIRGO_HOME}

ENV HADOOP_HOME=$VIRGO_HOME/hadoop-$HADOOP_VERSION

ARG HADOOP_URL=https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \    
    && tar -xf /tmp/hadoop.tar.gz -C ${VIRGO_HOME} \
    && rm -rf $HADOOP_HOME/share/doc \
    && mkdir -p ${HADOOP_HOME}/logs \
    && chown -R virgo:hadoop $HADOOP_HOME \
    && cp $HADOOP_HOME/etc/hadoop/log4j.properties $HADOOP_CONF_DIR \
    && cp $HADOOP_HOME/etc/hadoop/yarn-env.sh $HADOOP_CONF_DIR \
    && chown -R virgo:hadoop $HADOOP_CONF_DIR \
    && rm /tmp/hadoop.tar.gz*

ENV PATH $HADOOP_HOME/bin/:$PATH

#COPY coordinator.sh /opt/coordinator.sh
#RUN chmod +x /opt/coordinator.sh