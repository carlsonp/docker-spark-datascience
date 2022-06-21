# https://hub.docker.com/_/ubuntu
FROM ubuntu:22.04

ARG SPARK_FILE=spark-3.3.0-bin-hadoop3
ARG SPARK_NLP_FILE=spark-nlp-assembly-4.0.0.jar

USER root

# for the local apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "${APT_CACHE_PROXY}";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
    apt-get install -y --no-install-recommends \
    nano curl procps openjdk-11-jdk software-properties-common dirmngr gpg-agent python3 python3-pip build-essential python3-dev libkrb5-dev python3-pymongo && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

# https://github.com/nodesource/distributions/blob/master/README.md
RUN curl -sL https://deb.nodesource.com/setup_18.x  | bash -
RUN apt-get update && apt-get -y install nodejs

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.10 10

RUN pip3 install --no-cache-dir jupyterlab numpy matplotlib plotly scikit-learn spark-nlp

# download "fat" JAR from Github releases page
# https://github.com/JohnSnowLabs/spark-nlp/releases
COPY ${SPARK_NLP_FILE} /

# disable a required password to login
RUN mkdir -p ~/.jupyter/ && printf 'c.NotebookApp.token = "" ' >> ~/.jupyter/jupyter_notebook_config.py

COPY ${SPARK_FILE}.tgz /

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

# https://github.com/jupyter-incubator/sparkmagic
RUN pip3 install --no-cache-dir sparkmagic

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter labextension install "@jupyter-widgets/jupyterlab-manager" && \
    cd /usr/local/lib/python3.10/dist-packages && \
    jupyter-kernelspec install sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install sparkmagic/kernels/pysparkkernel && \
    jupyter serverextension enable --py sparkmagic && \
    mkdir -p /root/.sparkmagic/

COPY sparkmagic_config.json /root/.sparkmagic/config.json

COPY startup.sh /startup.sh

RUN chmod +x /startup.sh

# install our specific version of pyspark
# https://sigdelta.com/blog/how-to-install-pyspark-locally/
ENV SPARK_HOME="/spark/"
ENV PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.3-src.zip:$PYTHONPATH"
ENV PYSPARK_SUBMIT_ARGS="--master sparkmaster[*] pyspark-shell"
ENV PATH="$SPARK_HOME:$SPARK_HOME/python:$PATH"

WORKDIR /work
