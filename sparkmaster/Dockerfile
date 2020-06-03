# https://hub.docker.com/_/debian
FROM debian:latest

ARG SPARK_FILE=spark-3.0.0-preview2-bin-hadoop2.7

RUN export SPARK_BASEDIR="/spark" && \
    export SPARK_CONFDIR="${SPARK_BASEDIR}/conf" && \
    export SPARK_WORKDIR="${SPARK_BASEDIR}/work" && \
    export SPARK_CONF_FILE="${SPARK_CONFDIR}/spark-defaults.conf" && \
    export SPARK_LOGDIR="${SPARK_BASEDIR}/logs"

RUN apt-get update && apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk nginx  \
    #&& apt-get -y upgrade \
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