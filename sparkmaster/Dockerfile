# https://hub.docker.com/_/ubuntu
FROM ubuntu:bionic

ARG SPARK_FILE=spark-3.0.0-preview2-bin-hadoop2.7

# for the apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk nginx  \
    && apt-get -y upgrade \
    && rm -rf /var/lib/apt/lists/*

COPY ${SPARK_FILE}.tgz /

# use nginx to port forward to the Spark web-ui, use nginx -t to check syntax
COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

COPY startup.sh /spark/startup.sh

# https://spark.apache.org/docs/latest/spark-standalone.html
RUN printf 'SPARK_MASTER_URL=spark://sparkmaster:7077 \n SPARK_MASTER_WEBUI_PORT=8090' >> /spark/conf/spark-env.sh && \
    chmod +x /spark/conf/spark-env.sh

WORKDIR /spark