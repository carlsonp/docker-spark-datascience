#!/bin/bash
service nginx restart
/spark/sbin/start-master.sh
tail -f /dev/null
