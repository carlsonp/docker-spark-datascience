# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
FROM jupyter/datascience-notebook:latest

ARG SPARK_FILE=spark-3.0.0-preview2-bin-hadoop2.7

USER root

# for the apt-cacher-ng proxy
RUN echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy && \
    echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nano procps openjdk-11-jdk software-properties-common dirmngr gpg-agent && \
    apt-get -y upgrade && \
    rm -rf /var/lib/apt/lists/*

# disable a required password to login
RUN printf 'c.NotebookApp.token = "" ' >> ~/.jupyter/jupyter_notebook_config.py

COPY ${SPARK_FILE}.tgz /

WORKDIR /

RUN tar -xzf ${SPARK_FILE}.tgz && \
    mv ${SPARK_FILE} spark && \
    rm ${SPARK_FILE}.tgz

RUN chown -R jovyan /spark/ /spark/*

# copy over our cached conda packages
COPY ./cache/conda/ /home/jovyan/.conda/pkgs/

# fix permissions on the entire jovyan home folder
RUN chown -R jovyan /home/jovyan/ /home/jovyan/*

USER jovyan

# https://github.com/jupyter-incubator/sparkmagic
RUN conda install --yes sparkmagic

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
    jupyter labextension install "@jupyter-widgets/jupyterlab-manager" && \
    jupyter serverextension enable --py sparkmagic && \
    mkdir -p /home/jovyan/.sparkmagic/

COPY sparkmagic_config.json /home/jovyan/.sparkmagic/config.json

# install our specific version of pyspark
# https://sigdelta.com/blog/how-to-install-pyspark-locally/
ENV SPARK_HOME="/spark/"
ENV PYTHONPATH="$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.8.1-src.zip:$PYTHONPATH"
ENV PYSPARK_SUBMIT_ARGS="--master sparkmaster[*] pyspark-shell"
ENV PATH="$SPARK_HOME:$SPARK_HOME/python:$PATH"

WORKDIR /home/jovyan/
