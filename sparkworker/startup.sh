#!/bin/bash
/spark/sbin/start-slave.sh spark://sparkmaster:7077
tail -f /dev/null
