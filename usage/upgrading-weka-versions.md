---
description: This page describes how to upgrade to the latest WekaIO software version.
---

# Upgrading WekaIO Versions

## Preparing for the Upgrade

Before upgrading your cluster, ensure the following:

1. All backend hosts are online.
2. Any rebuild has been completed.

## Supported Upgrade Paths

The WekaIO upgrade process supports upgrading to both higher minor versions and major versions of the WekaIO software. 

When upgrading to a major version, always upgrade to the latest minor version in the new major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to WekaIO software version 3.6.x, go through version 3.5.3 or above
* To upgrade to WekaIO software version 3.5.x, go through version 3.4.6 or above.
* To upgrade to WekaIO software version 3.4.x, go through version 3.3.1 or above.
* To upgrade to WekaIO software version 3.3.x, go through version 3.2.1 or above.

For further information, contact the WekaIO Support Team.

## Downloading the New Release

Download the new release on one of the backend hosts, as follows:

1. SSH into one of the backend hosts of the cluster.
2. Go to [https://get.weka.io](https://get.weka.io) and navigate to the release to be downloaded.
3. Run the `curl`/`wget` command line on the backend host.
4. Untar the downloaded package.
5. Run the`install.sh` script of the new release.

## Preparing the Client Hosts for Upgrade \(Optional\)

Once the WekaIO cluster upgrade is called, it will first prepare all the connected clients to the upgrade, which includes downloading the new version and get it ready to be applied. Only then, it will start the upgrade process of the cluster. This would reduce to a minimum any downtime that the client can experience.

It is possible to prepare ahead for this, separated from the cluster upgrade \(e.g., to reduce the total upgrade window\), by using the following CLI commands for each client host:

```text
# downloading the new version
weka version get <new-version>

#preparing the new software version 
weka version prepare <new-version>
```

where `<new-version>` is the name of the new version downloaded from get.weka.io, e.g.,`3.6.1`.

## Upgrading to Version 3.5 and Above

From WekaIO software version 3.5 onwards, the disruptiveness of the upgrade procedure is limited to a defined window of 10 minutes. WekaIO system guarantees that either the upgrade process to the new version finishes successfully or the version is automatically reverted to the old one within this window.

In case of a failure, the version is automatically reverted on the hosts, yet, `weka cluster start-io` command should be run manually after verifying all hosts have indeed been reverted to the old version by running `weka cluster host` command. 

## Running the Upgrade Command

Once a new software version is installed on one of the backend hosts, the cluster has to be upgraded to the new release. This is performed by running the following command on the backend host:

```text
weka local run --in <new-version> upgrade --mode one-shot
```

where `<new-version>` is the name of the new version downloaded from get.weka.io, e.g.,`3.6.1`.

The limited upgrade window can be controlled by setting the following parameters in the `upgrade` command:

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `--stop-io-timeout` | Integer | Maximum time in seconds to wait for IO to successfully stop |  | No | 90 |
| `--host-version-change-timeout` | Integer | Maximum time in seconds to wait for a host version update |  | No | 180 |
| `--start-io-timeout` | Integer | Maximum time in seconds to wait for IO to successfully start |  | No | 300 |
| `--prepare-only` | Boolean | Download and prepare a new software version across all hosts in the cluster, without performing the actual upgrade  |  | No | False |

{% hint style="info" %}
**Note:** When using non-default passwords, run this command with the environment variables. For example:

`weka local run --in <new-version> -e WEKA_USERNAME=<user> -e WEKA_PASSWORD=<passwd> upgrade --mode=one-shot`
{% endhint %}

Before switching the cluster to the new release, the upgrade command will distribute the new release to all cluster hosts and make any necessary preparations, such as compiling the new `wekafs` driver. If any failure occurs during the preparations, such as disconnection of a host or failure to build a driver, the upgrade process will stop and a summary message will be received indicating the problematic host.

If everything goes to plan, the upgrade will stop the cluster IO service, switch all hosts to the new release and then turn the IO service back on. This takes about 1 minute, depending on the size of the cluster.

## After the Upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="success" %}
**For Example:** The following will be received when the system has been upgraded to version 3.6.1: 

`# weka status   
WekaIO v3.6.1 (CLI build 3.6.106)  
...`
{% endhint %}

## Performance Improvements with V3.5 and Above

WekaIO version 3.5 provides performance improvements when working with object stores. To reap the benefits of improved object store performance and ensure the conversion of the internal WekaIO data structure, the following is recommended for each tiered filesystem when upgrading from version 3.4 to version 3.5:

* Attach a new object store bucket.
* Delete any unnecessary snapshots \(so unnecessary data is not copied to the new bucket\).
* Detach the old object store bucket.
* Perform all necessary checks to ensure that data is copied to the new object store bucket.
* Re-upload relevant snapshots to the new object store bucket in order to re-create the snapshot locator on that bucket.

{% hint style="info" %}
**Note:** If there are any capacity constraints with the object store, it is recommended to perform this process one filesystem at a time.
{% endhint %}

