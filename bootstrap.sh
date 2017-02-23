#!/bin/bash

hdfs namenode -format
service ssh start
start-dfs.sh
start-yarn.sh
cd /usr/local/hadoop/share/hadoop/mapreduce
hadoop jar hadoop-mapreduce-examples-2.7.3.jar pi 2 5


