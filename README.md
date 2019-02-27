# Virgo Spark Cluster :sparkles: :eight_spoked_asterisk: :dizzy:

Simplifies testing of Spark 2.2 application, this cluster setup focuses primarily on Spark with Hive integration.

Main features: Spark with Hive Metastore, Hive, YARN and Spark History server.

The cluster is integrated in such a way that it correctly handles all dependencies and it's expected to work correctly out of the box. 

The main benefits of this small cluster is that it's easy to configure to run integration tests with YARN cluster support on your own machine.


| Virgo cluster | Hadoop   | Spark  | Hive  | Postgres |
| ------------- |:--------:| ------:|-------|----------|
| 0.5.6         | 2.7.7    | 2.2.3  | 1.2.2 | 9.5      | 

To use, clone this repo, and use any of two forms:

```bash
./run-cluster.sh
```

or

```bash
docker-compose up -d
```

The folder virgo-client contains several useful clients to test the cluster:

  * Spark Submit with YARN cluster mode
  * Spark Submit with YARN client mode
  * Remote Spark Shell via YARN master

## Comparison with other commercial distributions:

Advantages:
  * The docker images are just over 1 GB vs 21 GB for HDP. They reuse base images extensively.
  * Simple to use docker images. No special docker privileges required
  * Focus on ease of use versus a large set of components
  * It offers 10 components in independent images, which makes debugging easier.
  * Requires a minimum of 2GB of RAM to run all containers. This is significantly less than the 10 GB required by HDP.
  * "Fast" startup time, it can boot up fully in under 2 minutes, which is several times faster than full distros.
  * Completely based on Spark, not on Hadoop

Disadvantages:
  * It aims to provide a realistic cluster setup for development phase, not to substitute a full production cluster distribution.
  * Whilst security can be added, is not the main focus.
  * No admin console 

### Full Distros

Whilst there are several commercial full distributions which offer a fully managed hadoop cluster, including Spark, they bundle at least another 30 components, several of which are out of date or not relevant in many workflows:

  * [Hortownworks Data Platform](https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.5/bk_release-notes/content/comp_versions.html) 
  * [Cloudera 5](https://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_516.html#cm_vd_cdh_package_tarball_515)

This project started as an attempt to use the images kindly provided by the [Big Data Europe 2020 Project](https://hub.docker.com/u/bde2020).
However, we've found the images not suitable since they did not integrate Spark with Hive correctly. 
Furthermore, the images are no longer supported.

## Commercial support available

Please contact Aiur Tech [cto@aiur.co.uk]
