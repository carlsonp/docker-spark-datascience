#!/bin/bash
service nginx restart
# https://spark.apache.org/docs/latest/spark-standalone.html
# ./bin/spark-class org.apache.spark.deploy.master.Master --help
./bin/spark-class org.apache.spark.deploy.master.Master -h sparkmaster --webui-port 8090
