#!/usr/bin/env bash

## Example Job below:

NAMENODE=hdfs://hadoop-namenode:8020

JOB_MAIN="uk.co.aiur.spark.utils.JdbcToHive"
JOB_MAIN_JAR="$NAMENODE/apps/spark-utils-assembly-0.4.5.jar"

declare -a JOB_EXTRA_JARS=("$NAMENODE/apps/postgresql-9.3-1100-jdbc4.jar")
declare -a JOB_ARGS=("films")
