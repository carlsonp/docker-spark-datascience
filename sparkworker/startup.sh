#!/bin/bash
# https://spark.apache.org/docs/latest/spark-standalone.html
# ./bin/spark-class org.apache.spark.deploy.worker.Worker --help
./bin/spark-class org.apache.spark.deploy.worker.Worker spark://sparkmaster:7077
