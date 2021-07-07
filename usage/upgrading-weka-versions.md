---
description: This page describes how to upgrade to the latest Weka software version.
---

# Upgrading Weka Versions

## Prerequisites for Upgrade

Before upgrading your cluster, ensure the following:

1. All the backend hosts are online.
2. Any rebuild has been completed.
3. There are no outstanding alerts that haven't been addressed.
4. There is at least 4GB of free space in the `/opt/weka` directory.

{% hint style="info" %}
**Note:** If you are planning a multi-hop version upgrade, once an upgrade is done, a background process of converting metadata to a new format may occur \(in some versions\). This will take several minutes to complete and must finish before another upgrade can start \(the progress can be monitored via `weka status` CLI command if there is  a `data upgrade` task in a`RUNNING` state.
{% endhint %}

## Supported Upgrade Paths

The Weka upgrade process supports upgrading to both higher minor versions and major versions of the Weka software.

When upgrading to a major version, always upgrade to the latest minor version in the new major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to Weka software version 3.12.x, go through version 3.11.0 or above
* To upgrade to Weka software version 3.11.x, go through version 3.10.0 or above
* To upgrade to Weka software version 3.10.x, go through version 3.9.0 or above
* To upgrade to Weka software version 3.9.x, go through version 3.8.0 or above

For further information, contact the Weka Support Team.

## Preparing the Cluster for Upgrade

Download and prepare the new release on one of the backend hosts, using one of the following methods:

* From the backend host, run `weka version get <new-version>` where `<new-version>` is the name of the new version \(e.g.,`3.12.0`\), followed by `weka version prepare <new-version>`. 

  * If you don't have a distribution server set, you can add it explicitly to the command. For example, to get the `3.12.0` version from [get.weka.io](https://get.weka.io/ui/releases/), where a token need to be supplied as, use: 

  ```bash
  weka version get 3.12.0 --from https://[GET.WEKA.IO-TOKEN]@get.weka.io
  ```

* From the backend host, run the `curl` command as described in the install tab on the [get.weka.io](https://get.weka.io/ui/releases/) new version release page.
* Download the new version tar file to the backend host and run `install.sh` \(useful on environments where there is no connectivity to [get.weka.io](https://get.weka.io), such as dark sites or private VPCs\).

## Preparing the Hosts for Upgrade \(Optional\)

Once the Weka cluster upgrade is called, it will first prepare all the connected hosts \(clients and backends\) for the upgrade, which includes downloading the new version and get it ready to be applied. Only then, it will start the upgrade process of the cluster. This reduces to a minimum any downtime that the client host can experience from the Weka cluster.

Although not needed, and distribution of the new version to the hosts should be fast as part of the upgrade, when working with a large number of hosts it is possible to prepare for this in advance, separated from the cluster upgrade \(e.g., to shorten the total upgrade window\).

First, obtain the new version on one of the backend host, as described above, then, use the following CLI command:

`weka local run --in <new-version> upgrade --prepare-only`

## Running the Upgrade Command

Once a new software version is installed on one of the backend hosts, the cluster has to be upgraded to the new release. This is performed by running the following command on the backend host:

`weka local run --in <new-version> upgrade`

where `<new-version>` is the name of the new version \(e.g.,`3.12.0`\).

The limited upgrade window can be controlled by setting the following parameters in the `upgrade` command:

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `--stop-io-timeout` | Integer | Maximum time in seconds to wait for IO to successfully stop |  | No | 90 |
| `--host-version-change-timeout` | Integer | Maximum time in seconds to wait for a host version update |  | No | 180 |
| `--disconnect-stateless-clients-timeout` | Integer | Maximum time in seconds to wait for stateless clients to be marked as DOWN and continue the upgrade without them |  | No | 60 |
| `--prepare-only` | Boolean | Download and prepare a new software version across all hosts in the cluster, without performing the actual upgrade |  | No | False |
| `--dont-upgrade-clients` | Boolean | Run the upgrade command only on backend servers \(leaving the clients  one version  behind\) |  | No | False |

{% hint style="info" %}
**Note:** Make sure you are logged-in as a Cluster Admin \(using `weka user login`\) to run the upgrade command.
{% endhint %}

Before switching the cluster to the new release, the upgrade command will distribute the new release to all cluster hosts and make any necessary preparations, such as compiling the new `wekafs` driver. If any failure occurs during the preparations, such as the disconnection of a host or failure to build a driver, the upgrade process will stop and a summary message will be received indicating the problematic host.

If everything goes to plan, the upgrade will stop the cluster IO service, switch all hosts to the new release and then turn the IO service back on. This takes about 1 minute, depending on the size of the cluster.

{% hint style="info" %}
**Note:** In large deployments of Weka with many backend hosts and hundreds/thousands of clients it might be required to adjust the above timeouts.  

It is recommended then to set `host-version-change-timeout` to `600` and `disconnect-stateless-clients-timeout` to `200 .`

If further assistance and adjustments are required please contact the Weka Support Team.

Alternatively, to reduce the number of hosts undergoing an upgrade by separating the upgrade of the backend hosts and client hosts, you can use the [Backends-Only Upgrade](upgrading-weka-versions.md#backends-only-upgrade) approach.
{% endhint %}

## Backends-Only Upgrade

Using  the `--dont-upgrade-clients` flag in the upgrade command will only upgrade the backend servers, leaving the clients in the old version. Since version 3.12.0, the Weka system supports connecting clients from the one version prior and serving IOs in a mixed-version cluster \(backends in version `N` and clients in version `N/N-1`\). 

Performing a backends-only upgrade may ease the upgrade in large clusters, as there is no need to coordinate and wait for the upgrade of all the clients \(which can be thousands of hosts\). Once the backend servers have been successfully upgraded to the new version, the clients can be upgraded one by one, coordinated separately for each client.

To upgrade a client host, run the `weka local upgrade` CLI command from the client host.

An alert is raised once there is a mismatching of versions in the cluster, and Weka requires upgrading all clients before the next software version upgrade \(clients with two or more versions behind the version of the backends are not supported\). In addition, if a client is rebooted or a umount/mount performed, the client will be automatically upgraded to the version of the backends.  

## After the Upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="success" %}
**For Example:** The following will be received when the system has been upgraded to version 3.12.0:

`# weka status    
Weka v3.12.0     
...`
{% endhint %}

## Upgrade Revert on Failure

The disruptiveness of the upgrade procedure is limited to a defined window of 10 minutes. Weka system ensures that either the upgrade process to the new version finishes successfully or the version is automatically reverted to the old one within this window.

In case of a failure, the version is automatically reverted on the hosts, yet, `weka cluster start-io` command should be run manually after verifying all hosts have indeed been reverted to the old version by running `weka cluster host` command.

