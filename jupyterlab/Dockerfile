# https://hub.docker.com/_/ubuntu
FROM ubuntu:focal

ARG SPARK_FILE=spark-3.0.1-bin-hadoop2.7

USER root

# for the apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata && \
    apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk software-properties-common dirmngr gpg-agent python3 python3-pip build-essential python3-dev libkrb5-dev nodejs npm python3-pymongo && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.8 10

RUN pip3 install --no-cache-dir jupyterlab numpy

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
    cd /usr/local/lib/python3.8/dist-packages && \
    jupyter-kernelspec install sparkmagic/kernels/sparkkernel && \
    jupyter-kernelspec install sparkmagic/kernels/pysparkkernel && \
    jupyter serverextension enable --py sparkmagic && \
    mkdir -p /root/.sparkmagic/

COPY sparkmagic_config.json /root/.sparkmagic/config.json

COPY startup.sh /startup.sh

# install our specific version of pyspark
# https://sigdelta.com/blog/how-to-install-pyspark-locally/
ENV SPARK_HOME="/spark/"
ENV PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH"
ENV PYSPARK_SUBMIT_ARGS="--master sparkmaster[*] pyspark-shell"
ENV PATH="$SPARK_HOME:$SPARK_HOME/python:$PATH"

WORKDIR /work
