# https://hub.docker.com/_/debian
FROM debian:latest

ARG SPARK_FILE=spark-3.0.0-preview2-bin-hadoop2.7

RUN export SPARK_BASEDIR="/spark" && \
    export SPARK_CONFDIR="${SPARK_BASEDIR}/conf" && \
    export SPARK_WORKDIR="${SPARK_BASEDIR}/work" && \
    export SPARK_CONF_FILE="${SPARK_CONFDIR}/spark-defaults.conf" && \
    export SPARK_LOGDIR="${SPARK_BASEDIR}/logs"

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk lsof \
    #&& apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

COPY ${SPARK_FILE}.tgz /

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

COPY startup.sh /spark/startup.sh

WORKDIR /spark