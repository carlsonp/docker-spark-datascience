#!/bin/bash
service nginx restart
/livy/bin/livy-server start &
# https://spark.apache.org/docs/latest/spark-standalone.html
# ./bin/spark-class org.apache.spark.deploy.master.Master --help
./bin/spark-class org.apache.spark.deploy.master.Master -h sparkmaster --webui-port 8090
