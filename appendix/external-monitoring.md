---
description: >-
  This page describes how to set up external monitoring using Prometheus and
  Grafana
---

# External Monitoring

## Overview

The Weka GUI allows monitoring basic information of the CPUs, Network, Drives, IOPS/Throughput, and more advanced information via the statistics as well as Weka Alerts and the Weka Events log.

![Screenshot of Weka Grafana Dashboard](../.gitbook/assets/image%20%2823%29.png)

It is sometimes useful to use external tools like Prometheus and Grafana for monitoring. It could be that you already have them in the environment and would like to correlate with other products and see all information on the same dashboard.

In this guide, we will learn how to easily set-up a nice Grafana dashboard to monitor Weka. We will use a custom Prometheus client that presents weka statistics. 

It is advisable to set-up a machine \(or a VM\) to run the external services used if you do not already have those running in the environment. 

The easiest way to set up a Grafana environment is with Docker. For that, make sure `docker-ce` and `docker-compose` are installed on that machine. Installation instructions for installing Docker are on the [Docker website](https://www.docker.com/get-started).

## Setting up the Weka-mon package

### Step 1: Install the Weka-mon package

The package resides on GitHub. There are two ways you can pull it from GitHub - either download a Release or clone the repository.

To download a Release, go to [https://github.com/weka/weka-mon/releases](https://github.com/weka/weka-mon/releases) in your web browser, and select the latest release. Click on the "Source Code" link to download. Copy this to your intended management server or VM and unpack it.

![Weka-mon GitHub Releases Page](../.gitbook/assets/image%20%2822%29.png)

Alternatively, to clone the repository, run the following commands to pull the weka-mon package from GitHub:

```text
# Clone the package from github:
git clone https://github.com/weka/weka-mon
cd weka-mon

```

### Step 2: Run the install.sh script:

The `install.sh` script creates some directories and sets the permissions on them:

```text
# Set up the package
./install.sh

```

### Step 3: Edit the export.yml file

The `export.yml` configuration file is used to configure weka-mon and the exporter.  The `export.yml` file can be found in the base of the `weka-mon` directory hierarchy.

Edit the list of hosts under the `cluster:` heading to reflect your hostnames or ip addresses; you need to specify one or more hostnames/ips - there's not need to list all the cluster hostnames; two or three will do.

Also under `cluster:` is `auth_token_file:` which is used to provide the security token required to authenticate with the cluster.   This file can be generated with the `weka user login` command on any cluster host \(including clients\) and copied to the server/VM running weka-mon.   It is highly suggested that you create a ReadOnly User just for this package and use it for cluster communications.  See the Security section in the Operations Guide for details on creating users and using tokens.

```text
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

All other settings are pre-defined defaults and should work with weka-mon without modification.  If you want to add custom panels to Grafana containing other metrics from the cluster, you can uncomment any metrics you would like to gather.

To edit the file, do not add or delete any lines; all the configurable items are already in there but commented out with a \#.  To enable collecting data for these additional metrics, just uncomment them.

To edit the file, do not add or delete any lines; all the configurable items are already in there but commented out with a \#.  To enable collecting data for these additional metrics, just uncomment them.

For example, below is a snippet of the `export.yml`. To enable collecting the FILEATOMICOPEN\_OPS statistic, remove the `#` character at the beginning of the line. Note that if the statistic you wish to gather is in a Category that is commented out, you will need to uncomment the Category line as well if it is not already uncommented \(the first line in the example below\). Conversely, to stop collecting a statistic, comment out the statistic by inserting a `#` at the beginning of the line.

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

### Step 3: Edit the export.yml \(optional\)

Follow the instructions appearing in the above [Edit the export.yml file](external-monitoring.md#step-4-edit-the-export-yml-file-optional) section.

### Step 4: Run the exporter

You can run the exporter in a number of ways - as a Docker container, as a compiled binary, or as a Python script. The Docker container is easy, but if you don't want or don't have Docker, you can run the binary directly. Running the Python scripts directly is also an option, but will require installing some Python Modules from PyPi.

In order to run the exporter, you will need a `CLUSTER_SPEC` \(as defined above\).

Perform one of the next 3 steps - 4a, 4b, or 4c:

#### Step 4a: Getting and running the container

Get and run the container. The only required command-line argument is at least one ClusterSpec \(see [Set your CLUSTER\_SPEC](external-monitoring.md#step-3-set-your-cluster_spec) section for details\), so it knows where your cluster is. You may specify more than one ClusterSpec - it takes a comma-separated list of ClusterSpecs on the command line.

The below example maps in several volumes: the `~/.weka directory` \(so the container can read the auth file\), `/dev/log` so it can put entries in the Syslog, `/etc/hosts` so it has some name resolution \(you can also use DNS if your Docker environment is set up to do so\), and finally mapping the config file \(`export.yml`\) into the container.

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
  wekasolutions/export -vv weka01,weka02,weka09:~/.weka/myauthfile
  
```

#### Step 4b: Getting the binary version

Go to [https://github.com/weka/export/releases](https://github.com/weka/export/releases) and download the tarball from the latest release. As of time of this last doc update, the current version is 1.0.2, so download the `export-1.0.2.tar` file from the Version-1.0.2 release. Copy this file to your management server or VM. 

Then, run the exporter \(see above for an explanation of the command-line arguments\):

```
tar xvf export-1.0.2.tar
cd export
./export -vv weka01,weka02,weka09:~/.weka/myauthfile

```

#### Step 4c: Getting the sources

You can either `git clone https://github.com/weka/export` or go to [https://github.com/weka/export/releases](https://github.com/weka/export/releases) and download the source tarball.

After cloning or unpacking the tarball, you will need to run `pip3 install -r requirements.txt` command to install all the required python modules.

Then, run the exporter \(see above for an explanation of the command-line arguments\):

```
./export -vv weka01,weka02,weka09:~/.weka/myauthfile

```

