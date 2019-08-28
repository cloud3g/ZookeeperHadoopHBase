#!/usr/bin/env bash
export SCALA_HOME=/usr/local/scala2.11.8
export JAVA_HOME=/usr/local/jdk1.8
export HADOOP_HOME=/usr/local/hadoop
export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
SPARK_MASTER_IP=master
SPARK_LOCAL_DIRS=/usr/local/spark2.0.1
SPARK_DRIVER_MEMORY=1G