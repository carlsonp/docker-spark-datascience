# https://hub.docker.com/_/ubuntu
FROM ubuntu:focal

ARG SPARK_FILE=spark-3.0.2-bin-hadoop2.7
ARG LIVY_FILE=apache-livy-0.7.1-incubating-bin

# for the apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
    apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk nginx python3 unzip && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10

COPY ${SPARK_FILE}.tgz /

# use nginx to port forward to the Spark web-ui, use nginx -t to check syntax
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

COPY ${LIVY_FILE}.zip /

RUN unzip ${LIVY_FILE}.zip && \
    mv ${LIVY_FILE} livy && \
    rm ${LIVY_FILE}.zip

COPY startup.sh /spark/startup.sh

ENV SPARK_HOME="/spark/"

WORKDIR /spark