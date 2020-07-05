---
description: This page describes how to upgrade to the latest Weka software version.
---

# Upgrading Weka Versions

## Prerequisites for Upgrade

Before upgrading your cluster, ensure the following:

1. All backend hosts are online.
2. Any rebuild has been completed.

## Supported Upgrade Paths

The Weka upgrade process supports upgrading to both higher minor versions and major versions of the Weka software.

When upgrading to a major version, always upgrade to the latest minor version in the new major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to Weka software version 3.7.x, go through version 3.6.2 or above
* To upgrade to Weka software version 3.6.x, go through version 3.5.3 or above
* To upgrade to Weka software version 3.5.x, go through version 3.4.6 or above.
* To upgrade to Weka software version 3.4.x, go through version 3.3.1 or above.

For further information, contact the Weka Support Team.

## Preparing the Cluster for Upgrade

Download and prepare the new release on one of the backend hosts, using one of the following methods:

1. From the backend host, run `weka version get <new-version>` where `<new-version>` is the name of the new version \(as in get.weka.io, e.g.,`3.6.1`\), followed by `weka version prepare <new-version>`
2. From the backend host, run the `curl` command as described in the install tab on the [get.weka.io](https://get.weka.io/ui/releases/) new version release page.
3. Download the new version tar file to the backend host and run `install.sh` \(useful on environments where there is no connectivity to [get.weka.io](https://get.weka.io), such as dark sites or private VPCs\).

## Preparing the Hosts for Upgrade \(Optional\)

Once the Weka cluster upgrade is called, it will first prepare all the connected hosts \(clients and backends\) to the upgrade, which includes downloading the new version and get it ready to be applied. Only then, it will start the upgrade process of the cluster. This reduces to a minimum any downtime that the client host can experience from the Weka cluster.

Although not needed, and distribution of the new version to the hosts should be fast as part of the upgrade, when working with a large number of hosts it is possible to prepare for this in advance, separated from the cluster upgrade \(e.g., to shorten the total upgrade window\).

First, obtain the new version on one of the backend host, as described above, then, use the following CLI command:

```text
weka local run --in <new-version> upgrade --mode one-shot --prepare-only
```

## Running the Upgrade Command

Once a new software version is installed on one of the backend hosts, the cluster has to be upgraded to the new release. This is performed by running the following command on the backend host:

```text
weka local run --in <new-version> upgrade --mode one-shot
```

where `<new-version>` is the name of the new version \(as in get.weka.io, e.g.,`3.6.1`\).

The limited upgrade window can be controlled by setting the following parameters in the `upgrade` command:

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `--stop-io-timeout` | Integer | Maximum time in seconds to wait for IO to successfully stop |  | No | 90 |
| `--host-version-change-timeout` | Integer | Maximum time in seconds to wait for a host version update |  | No | 180 |
| `--start-io-timeout` | Integer | Maximum time in seconds to wait for IO to successfully start |  | No | 300 |
| `--prepare-only` | Boolean | Download and prepare a new software version across all hosts in the cluster, without performing the actual upgrade |  | No | False |

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
Weka v3.6.1 (CLI build 3.6.106)    
...`
{% endhint %}

## Upgrading to Version 3.5 and Above

From Weka software version 3.5 onwards, the disruptiveness of the upgrade procedure is limited to a defined window of 10 minutes. Weka system guarantees that either the upgrade process to the new version finishes successfully or the version is automatically reverted to the old one within this window.

In case of a failure, the version is automatically reverted on the hosts, yet, `weka cluster start-io` command should be run manually after verifying all hosts have indeed been reverted to the old version by running `weka cluster host` command.

## Performance Improvements with V3.5 and Above

Weka version 3.5 provides performance improvements when working with object stores. To reap the benefits of improved object store performance and ensure the conversion of the internal Weka data structure, the following is recommended for each tiered filesystem when upgrading from version 3.4 to version 3.5:

* Attach a new object store bucket.
* Delete any unnecessary snapshots \(so unnecessary data is not copied to the new bucket\).
* Detach the old object store bucket.
* Perform all necessary checks to ensure that data is copied to the new object store bucket.
* Re-upload relevant snapshots to the new object store bucket in order to re-create the snapshot locator on that bucket.

{% hint style="info" %}
**Note:** If there are any capacity constraints with the object store, it is recommended to perform this process one filesystem at a time.
{% endhint %}

## Upgrading to Version 3.7

Version 3.7 introduces space reclamation on object-storage. It might have implications if you have downloaded filesystems from snapshots that have already been logically deleted or dependent on such. For that, the space reclamation will not be enabled by default on such filesystems after the upgrade. If `weka fs` shows filesystems with disabled space reclamation, a manual procedure is required. Please contact the Weka customer support team to assist you with the procedure.

#### Before upgrading to version 3.7:

If the original snapshot that a filesystem was created from has been logically deleted from the cluster that uploaded it, and the filesystem needs to be preserved, it can be migrated to a different object-store bucket.

1. search for every downloaded filesystem in any of the clusters \(e.g., `weka fs snapshot | grep downloaded`\)
2. in case it was downloaded from the upgrading cluster
   * check if that original snapshot exists in the upgrading cluster
   * if not, and the filesystem needs to be preserved, migrate it to a different object-store bucket
     * note, it could be that the snapshot does not exist since its filesystem has been migrated; if you are certain this is the case, nothing needs to be done

#### After upgrading to version 3.7:

1. check if there are filesystems where space reclamation has not been automatically enabled on them \(as shown by calling `weka fs` CLI command\)
2. for those filesystems
   * re-upload \(by calling `weka fs snapshot upload` CLI command\) every snapshot that is marked as needed to be re-uploaded \(as shown by calling `weka fs snapshot` CLI command\)
     * note, if the snapshot is not needed and has not been downloaded by any filesystem, it is possible to delete it
     * note, it is also possible to migrate the filesystem containing the uploaded snapshot to a different object-store bucket and keep the old object-store bucket intact
   * if the snapshot has been re-uploaded in the previous step, wait an additional 10 minutes **after the upload completes** for the data to propagate in the object store
   * for filesystems, in any of the clusters, which were originally created by downloading any of the re-uploaded snapshots
     * in case the filesystem modifications need to be preserved - migrate the downloaded filesystem to a different object-store bucket
     * otherwise, re-create the downloaded filesystem using the re-uploaded snapshot's locator
   * enable space reclamation for each filesystem \(by calling `weka fs tier reclamation enable` CLI command\)
     * if the command fails, it means you have not re-uploaded all of the required snapshots

