# https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html
FROM jupyter/tensorflow-notebook:latest


# conda install?


# disable a required password to login
RUN printf 'c.NotebookApp.token = "" ' >> ~/.jupyter/jupyter_notebook_config.py
