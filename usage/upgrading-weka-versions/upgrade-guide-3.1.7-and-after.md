---
description: >-
  This page describes how to upgrade from version 3.1.7 to the latest WekaIO
  software version.
---

# Upgrading from Version 3.1.7 and After

## Preparing for the Upgrade

Before upgrading your cluster, ensure the following:

1. All backend hosts are online.
2. Any rebuild has been completed.

{% hint style="info" %}
**Note:** During the upgrade process, client IOs will hang for about 1 minute.
{% endhint %}

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

where `<new-version>` is the name of the new version downloaded from get.weka.io, e.g.,`3.2.2.`

Before switching the cluster to the new release, the upgrade command will distribute the new release to all cluster hosts and make any necessary preparations, such as compiling the new `wekafs` driver. If any failure occurs during the preparations, such as disconnection of a host or failure to build a driver, the upgrade process will stop and an error will be received indicating the problematic host.

If everything goes to plan, the upgrade will stop the cluster IO service, switch all hosts to the new release and then turn the IO service back on. This takes about 1 minute, depending on the size of the cluster.

## After the Upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="warning" %}
**For Example:** The following will be received when the system has been upgraded to version 3.2.2: 

`# weka status   
WekaIO v3.2.2 (CLI build 3.2.29)  
...`
{% endhint %}

{% hint style="info" %}
**Note: Disconnected Clients During Upgrade**  
In some cases, there may be clients disconnected from the cluster during the upgrade process.  From version 3.1.7, such clients are automatically upgraded when an out-of-date software version is detected.
{% endhint %}

## 

