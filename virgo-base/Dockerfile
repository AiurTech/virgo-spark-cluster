FROM openjdk:8-jdk-slim-stretch

MAINTAINER Aiur Tech <cto+docker@aiurtech.co.uk>

RUN apt-get update \
&& apt-get install --no-install-recommends --no-install-suggests -y vim netcat curl \
&& rm -rf /var/lib/apt/lists/*