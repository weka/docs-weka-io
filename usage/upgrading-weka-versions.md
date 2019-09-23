---
description: >-
  This page describes how to upgrade from version 3.1.9 to the latest WekaIO
  software version.
---

# Upgrading WekaIO Versions

## Preparing for the Upgrade

Before upgrading your cluster, ensure the following:

1. All backend hosts are online.
2. Any rebuild has been completed.

{% hint style="info" %}
**Note:** During the upgrade process, client IOs will hang for about 1 minute.
{% endhint %}

## Supported Upgrade Paths

The WekaIO upgrade process supports upgrading to both higher minor versions and major versions of the WekaIO software. 

When upgrading to a major version, always upgrade to the latest minor version in the new major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to WekaIO software version 3.4.x, go through version 3.3.1 or above.
* To upgrade to WekaIO software version 3.3.x, go through version 3.2.1 or above.
* To upgrade to WekaIO software version 3.2.x, go through version 3.1.9.4 or above.

For further information, contact the WekaIO Support Team.

## Downloading the New Release

Download the new release on one of the backend hosts, as follows:

1. SSH into one of the backend hosts of the cluster.
2. Go to [https://get.weka.io](https://get.weka.io) and navigate to the release to be downloaded.
3. Run the `curl`/`wget` command line on the backend host.
4. Untar the downloaded package.
5. Run the`install.sh` script of the new release.

## Running the Upgrade Command

Once the new release is installed on one of the backend hosts, the cluster has to be upgraded to the new release. This is performed by running the following command on the backend host:

```text
weka local run --in <new-version> upgrade --mode one-shot
```

where `<new-version>` is the name of the new version downloaded from get.weka.io, e.g.,`3.4.2`.

{% hint style="info" %}
**Note:** When using non-default passwords, run this command with the environment variables. For example:

`weka local run --in <new-version> -e WEKA_USERNAME=<user> -e WEKA_PASSWORD=<passwd> upgrade --mode=one-shot`
{% endhint %}

Before switching the cluster to the new release, the upgrade command will distribute the new release to all cluster hosts and make any necessary preparations, such as compiling the new `wekafs` driver. If any failure occurs during the preparations, such as disconnection of a host or failure to build a driver, the upgrade process will stop and an error will be received indicating the problematic host.

If everything goes to plan, the upgrade will stop the cluster IO service, switch all hosts to the new release and then turn the IO service back on. This takes about 1 minute, depending on the size of the cluster.

## After the Upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="success" %}
**For Example:** The following will be received when the system has been upgraded to version 3.4.2: 

`# weka status   
WekaIO v3.4.2 (CLI build 3.4.42)  
...`
{% endhint %}

## Performance Improvements with V3.5

WekaIO version 3.5 provides performance improvements when working with object stores. To reap the benefits of improved object store performance and ensure the conversion of the internal WekaIO data structure, the following is recommended for each tiered filesystem when upgrading from version 3.4 to version 3.5:

* Attach a new object store bucket.
* Delete any unnecessary snapshots \(so unnecessary data is not copied to the new bucket\).
* Detach the old object store bucket.
* Perform all necessary checks to ensure that data is copied to the new object store bucket.

{% hint style="info" %}
**Note:** If there are any capacity constraints with the object store, it is recommended to perform this process one filesystem at a time.
{% endhint %}

