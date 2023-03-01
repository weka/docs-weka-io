---
description: >-
  This page describes how to set up external monitoring using Prometheus and
  Grafana
---

# External Monitoring

## Overview

The Weka GUI allows monitoring basic information of the CPUs, Network, Drives, IOPS/Throughput, and more advanced information via the statistics as well as Weka Alerts and the Weka Events log.

![Screenshot of Weka Grafana Dashboard](<../.gitbook/assets/image (1).png>)

It is sometimes useful to use external tools like Prometheus and Grafana for monitoring. It could be that you already have them in the environment and would like to correlate with other products and see all information on the same dashboard.

In this guide, we will learn how to easily set-up a nice Grafana dashboard to monitor Weka. We will use a custom Prometheus client that presents weka statistics.&#x20;

It is advisable to set-up a machine (or a VM) to run the external services used if you do not already have those running in the environment.&#x20;

The easiest way to set up a Grafana environment is with Docker. For that, make sure `docker-ce` and `docker-compose` are installed on that machine. Installation instructions for installing Docker are on the [Docker website](https://www.docker.com/get-started).

## Setting up the Weka-mon package

### Step 1: Install the Weka-mon package

The package resides on GitHub. There are two ways you can pull it from GitHub - either download a Release or clone the repository.

To download a Release, go to [https://github.com/weka/weka-mon/releases](https://github.com/weka/weka-mon/releases) in your web browser, and select the **latest** release. Click on the "Source Code" link to download. Copy this to your intended management server or VM and unpack it.

![Weka-mon GitHub Releases Page](<../.gitbook/assets/image (18).png>)

Alternatively, to clone the repository, run the following commands to pull the weka-mon package from GitHub:

```
# Clone the package from github:
git clone https://github.com/weka/weka-mon
cd weka-mon

```

### Step 2: Run the install.sh script:

The `install.sh` script creates some directories and sets the permissions on them:

```
# Set up the package
./install.sh

```

### Step 3: Edit the export.yml file

The `export.yml` configuration file is used to configure weka-mon and the exporter.  The `export.yml` file can be found in the base of the `weka-mon` directory hierarchy.

#### Host Configuration

Edit the list of hosts under the `cluster:` heading to reflect your hostnames or ip addresses; you need to specify one or more hostnames/ips - there's not need to list all the cluster hostnames; two or three will do.

Also under `cluster:` is `auth_token_file:` which is used to provide the security token required to authenticate with the cluster.   This file can be generated with the `weka user login` command on any cluster host (including clients) and copied to the server/VM running weka-mon.   It is highly suggested that you create a ReadOnly User just for this package and use it for cluster communications.  See the Security section in the Operations Guide for details on creating users and using tokens.

```
# cluster section - info about the weka cluster we want to export data from:
cluster:
  # a list of hostnames or ip addresses.  Minimum of 1 requred.  You do not need to list all hosts in the 
  #     cluster, but more than one is suggested

  auth_token_file: auth-token.json
  hosts:
    - vweka01      # EDIT THESE LINES 
    - vweka02
    - vweka03

  force_https: True   # only 3.10+ clusters support https
  verify_cert: False  # default cert cannot be verified
```

#### Exporter configuration

There are a few more options in the export.yml file in the `exporter:` section that defines the program behavior.

```
# exporter section - info about how we're going to run
exporter:
  listen_port: 8001
  loki_host:
  loki_port: 3100
  timeout: 10.0
  max_procs: 8
  max_threads_per_proc: 100
```

The `listen_port:` parameter defines the port that Prometheus should scrape.  This should not be changed unless you change the Prometheus configuration.

The `loki_host:`and `loki_port:` parameters should not be changed if you're using the weka-mon setup. Make `loki_host:` blank to disable sending events to Loki entirely.

The `timeout:` parameter is the max time in seconds to wait for an API call to return. The default should be sufficient for most purposes.

The `max_procs:` and  `max_threads_per_proc:` parameters define the scaling behavior. If the total number of hosts (servers and clients) exceeds `max_threads_per_proc`, the exporter will spawn more processes accordingly.&#x20;

{% hint style="success" %}
**For example,** a cluster with 80 weka servers and 200 compute nodes (aka clients) has 280 total hosts. With the default `max_threads_per_proc` of 100, it would spawn 3 processes (280 / 100 = 2.8, round up to 3).
{% endhint %}

It's recommended to have 1 available core per process. With the above example, you should deploy on a VM or server with at least 4 available cores.

The exporter will always try to allocate one host per thread, but will not exceed `max_procs` processes. If you have 1000's of hosts, it will double/triple up hosts on the threads.

{% hint style="success" %}
**For example,** with 3000 hosts and defaults of `max_procs` of 8 and `max_threads_per_proc`of 100, only 8 proccesses will be spawned, each with 100 threads, but there will be close to 4 hosts serviced per thread instead of the default 1 host per thread.
{% endhint %}

All other settings have pre-defined defaults that should work with weka-mon without modification.&#x20;

If you want to add custom panels to Grafana containing other metrics from the cluster, you can uncomment any metrics you would like to gather.

To edit the file, do not add or delete any lines; all the configurable items are already in there but commented out with a #.  To enable collecting data for these additional metrics, just uncomment them.

To edit the file, do not add or delete any lines; all the configurable items are already in there but commented out with a #.  To enable collecting data for these additional metrics, just uncomment them.

For example, below is a snippet of the `export.yml`. To enable collecting the FILEATOMICOPEN\_OPS statistic, remove the `#` character at the beginning of the line. Note that if the statistic you wish to gather is in a Category that is commented out, you will need to uncomment the Category line as well if it is not already uncommented (the first line in the example below). Conversely, to stop collecting a statistic, comment out the statistic by inserting a `#` at the beginning of the line.

```
 'ops_driver':     # Category
   'DIRECT_READ_SIZES':  'sizes'
   'DIRECT_WRITE_SIZES':  'sizes'
#   'FILEATOMICOPEN_LATENCY':  'microsecs'
#   'FILEATOMICOPEN_OPS':  'ops'

```

### Step 4: Start the containers

To start the containers with docker-compose, run the following command:

```
docker-compose up -d

```

That's it! Grafana should appear on port 3000 on the server running the docker containers.  The default credentials for Grafana are `admin/admin`.

## Integrating with an existing Grafana/Prometheus environment

If you already have Grafana and Prometheus running in your environment, you only need to run the exporter and add it to the Prometheus configuration.

### Step 1: Install the Weka-mon package

Follow the instructions appearing in the above [Install the Weka-mon package](external-monitoring.md#step-1-install-the-weka-mon-package) section.

### Step 2: Import the dashboards

The dashboard `JSON` files are in the subdirectory `weka-mon/var_lib_grafana/dashboards`.  Please follow the [Grafana documentation](https://grafana.com/docs/grafana/latest/dashboards/export-import/#importing-a-dashboard) on how to import the files.

### Step 3: Edit the export.yml (optional)

Follow the instructions appearing in the above [Edit the export.yml file](external-monitoring.md#step-4-edit-the-export-yml-file-optional) section.

### Step 4: Run the exporter

You can run the exporter in a number of ways - as a Docker container, as a compiled binary, or as a Python script. The Docker container is the simplest, but if you don't want or don't have Docker, you can run the binary directly. Running the Python scripts directly is also an option, but will require installing some Python Modules from PyPi.

Perform one of the next 3 steps - 4a, 4b, or 4c:

#### Step 4a: Getting and running the container

Get and run the container. There are no required command-line arguments, but you do need to fill in the `export.yml` configuration file. (see above)

The below example maps in several volumes: the `~/.weka directory` (so the container can read the auth file), `/dev/log` so it can put entries in the Syslog, `/etc/hosts` so it has some name resolution (you can also use DNS if your Docker environment is set up to do so), and finally mapping the config file (`export.yml`) into the container.

There are other options, and you can run the command with `--help` or `-h` for a full description.

```
# get the container from dockerhub:
docker pull wekasolutions/export

# example of how to run the container
docker run -d --network=host \
  --mount type=bind,source=/root/.weka/,target=/weka/.weka/ \
  --mount type=bind,source=/dev/log,target=/dev/log \
  --mount type=bind,source=/etc/hosts,target=/etc/hosts \
  --mount type=bind,source=$PWD/export.yml,target=/weka/export.yml \
  wekasolutions/export -v
  
```

#### Step 4b: Getting the binary version

Go to [https://github.com/weka/export/releases](https://github.com/weka/export/releases) and download the tarball from the latest release. As of the time of this last doc update, the current version is 1.3.0, so download the `export-1.3.0.tar` file from the Version-1.3.0 release. Copy this file to your management server or VM.&#x20;

Then, run the exporter (see above for an explanation of the command-line arguments):

```
tar xvf export-1.3.0.tar
cd export
./export -v

```

#### Step 4c: Getting the sources

You can either `git clone https://github.com/weka/export` or go to [https://github.com/weka/export/releases](https://github.com/weka/export/releases) and download the source tarball.

After cloning or unpacking the tarball, you will need to run `pip3 install -r requirements.txt` command to install all the required python modules.

Then, run the exporter (see above for an explanation of the command-line arguments):

```
./export -v

```
