# https://hub.docker.com/_/ubuntu
FROM ubuntu:focal

ARG SPARK_FILE=spark-3.0.2-bin-hadoop2.7

# for the apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
    apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk python3 python3-pip python3-pymongo && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10

RUN pip3 install --no-cache-dir numpy

COPY ${SPARK_FILE}.tgz /

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

COPY startup.sh /spark/startup.sh

# install our specific version of pyspark
# https://sigdelta.com/blog/how-to-install-pyspark-locally/
ENV SPARK_HOME="/spark/"
ENV PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH"
ENV PATH="$SPARK_HOME:$SPARK_HOME/python:$PATH"

WORKDIR /spark