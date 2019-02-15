FROM openjdk:8-jdk-slim-stretch

LABEL maintainer "Aiur Tech <cto+docker@aiurtech.co.uk>"

ENV HADOOP_VERSION 2.7.7
ENV HIVE_VERSION 1.2.2
ENV SPARK_VERSION=2.2.3
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV VIRGO_HOME=/opt/virgo

RUN apt-get update \
&& apt-get install --no-install-recommends --no-install-suggests -y vim netcat curl \
&& rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${HADOOP_CONF_DIR}

COPY virgo-utils.sh $VIRGO_HOME/virgo-utils.sh

WORKDIR ${VIRGO_HOME}