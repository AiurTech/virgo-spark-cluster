FROM aiurtech/virgo-base:0.3.0

ENV HADOOP_URL https://www.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz
RUN set -x \
    && curl -fSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \    
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION

RUN ln -s $HADOOP_HOME/etc/hadoop $HADOOP_CONF_DIR
RUN mkdir $HADOOP_HOME/logs

ENV PATH $HADOOP_HOME/bin/:$PATH

COPY coordinator.sh /opt/coordinator.sh
RUN chmod +x /opt/coordinator.sh