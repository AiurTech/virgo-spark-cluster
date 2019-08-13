# Virgo Spark Cluster

Simplifies building and testing applications using Spark 2.3+.
This cluster setup focuses primarily on Spark with Hive integration.

## Components  

* Spark with external Hive Metastore (Postgres)
* YARN
* HDFS
* Hive (same version as required by Spark)
* Spark History Server

The cluster is integrated in such a way that it correctly handles all dependencies and it's expected to work correctly out of the box.

The main benefits of this small cluster is that it's easy to configure to run integration tests with YARN cluster support on your own machine.

## Versions

| Virgo cluster | Hadoop   | Spark  | Hive  | Postgres | Livy     |
| ------------- |:--------:| ------:|-------|----------|----------|
| 0.7.5         | 2.7.7    | *2.3.0*  | 1.2.2 | 9.5    | Moved    |
| 0.7.0         | 2.7.7    | *2.3.0*  | 1.2.2 | 9.5    | 0.4      |
| 0.6.2         | 2.7.7    | 2.2.3  | 1.2.2 | 9.5      | *0.4*    |
| 0.5.7         | 2.7.7    | 2.2.3  | 1.2.2 | 9.5      |          |  

## Use :sparkles: :eight_spoked_asterisk: :dizzy:

To use, clone this repo, and use any of two forms:


```bash
docker-compose up -d
```

or just Docker:

```bash
./run-cluster.sh
```

To stop the cluster:

```bash
docker-compose down
```
or Just docker

```bash
./stop-cluster.sh
```

The folder virgo-client contains several useful clients to test the cluster:

* Spark Submit with YARN cluster mode
* Spark Submit with YARN client mode
* Remote Spark Shell via YARN master
* Remote Hive Beeline Shell

## Comparison with other commercial distributions:

Advantages:

* The docker images are just over 1 GB vs 21 GB for HDP. They reuse base images extensively.
* Simple to use docker images. No special docker privileges required
* Focus on ease of use versus a large set of components
* Full micro-services stack: It offers 10 components in independent images, which makes debugging easier.
* Requires a minimum of 2GB of RAM to run all containers. This is significantly less than the 10 GB required by HDP.
* Limits itself to a maximum of 8 GB of RAM (total size of all containers)
* "Fast" startup time, it can boot up fully in under 2 minutes, which is several times faster than full distros.
* Biased towards Spark, instead of Hadoop
* Aims to support Kubernetes deployment soon.

Disadvantages

* It aims to provide a realistic cluster setup for development phase, not to substitute a full production cluster distribution.
* Whilst security can be added, is not the main focus at this point.
* No admin console

### Full Distros

Whilst there are several commercial full distributions which offer a fully managed hadoop cluster, including Spark, they bundle at least another 30 components, several of which are out of date or not relevant in many workflows:

* [Hortownworks Data Platform](https://docs.hortonworks.com/HDPDocuments/HDP2/HDP-2.6.5/bk_release-notes/content/comp_versions.html) 
* [Cloudera 5](https://www.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_516.html#cm_vd_cdh_package_tarball_515)

This project started as an attempt to use the images kindly provided by the [Big Data Europe 2020 Project](https://hub.docker.com/u/bde2020).
However, we've found the images not suitable since they did not integrate Spark with Hive correctly.
Furthermore, those images are no longer supported.

## Commercial support available

Please contact Aiur Tech [cto @ aiur.co.uk]

## FAQ

### Why the name Virgo?

The [Virgo Cluster](https://en.wikipedia.org/wiki/Virgo_Cluster) is a "neighbouring" star cluster. 
It has some beatiful members:

* [Messier 87](https://www.messier-objects.com/messier-87-virgo-a/)
* [M91 Barred Spiral Galaxy](http://www.messier-objects.com/wp-content/uploads/2015/08/Messier-91.jpg) -
*  [M91](https://www.messier-objects.com/messier-91/)

Interestingly enough, soon after this project was created, [the first ever picture of a black hole emerged](https://www.bbc.co.uk/news/science-environment-47873592), which was no other than M87 :smiley:
