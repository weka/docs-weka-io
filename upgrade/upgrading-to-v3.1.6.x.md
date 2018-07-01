---
description: >-
  This guide describes how to upgrade from all 3.1.2, 3.1.3 and 3.1.4 versions
  to the latest 3.1.6.x version.
---

# Upgrading Guide: 3.1.6 and Before

## Preparing For The Upgrade

Before upgrading your cluster, you'll have to prepare a few things:

1. All cluster backend hosts need to be in UP status
2. If a rebuild is in progress, wait for the rebuild to finish before proceeding with the upgrade
3. Un-mount all clients connected to the cluster
4. Select one host from which you'll perform the upgrade and make sure it has SSH access to all other hosts

## Upgrading The Cluster

Log-in to one of your cluster hosts from which you'll perform the upgrade. Then run the following commands to download the upgrade script:

```text
curl -O 
chmod a+x wekaio-upgrade.sh
```

To run the upgrade script, you'll have to export several environment variables:

```text
export WEKA_SSH_USER=<ssh-user>
export WEKA_SSH_PARAMS=<ssh-params>
export OLD_VERSION=<old-version>
export NEW_VERSION=<new-version>
export NEW_VERSION_URL=<new-version-url>
```

| Environment Variable | Description |
| --- | --- | --- | --- | --- | --- |
| `WEKA_SSH_USER` | The username to will be used to login to all cluster hosts. If you don't pass this variable, a default value of `root` is assumed. |
| `WEKA_SSH_PARAMS` | Optional SSH parameters to pass when connecting to cluster hosts, such as `-i` to provide a key file. |
| `OLD_VERSION` | The current cluster version. |
| `NEW_VERSION` | The version you'll be upgrading to. |
| `NEW_VERSION_URL` | The download link for the new WekaIO package obtained from [https://get.weka.io](https://get.weka.io). |

Then, run the upgrade script and pass the cluster hostnames or IP-addresses as arguments to the script:

```text
./wekaio-upgrade.sh <host1> <host2> <host3>...
```

## The Upgrade Process

The upgrade process takes a few minutes, depending on the size of your cluster.

During the upgrade process, your cluster will be stopped and its software will be replaced with the new version provided by the new version URL.

If anything goes wrong during upgrade, the upgrade script stops and prints any error that might have occurred \(e.g. one of the hosts could not download the software package\). Note that some errors might include the host in which the error has occurred and what needs to be fixed before trying to upgrade again.

## After The Upgrade

When the upgrade is done your cluster will be brought back online and your clients can re-mount their filesystems and resume operation.

If any clients were down during the upgrade, they would not be able to connect to the new cluster and would have to be reinstalled manually with the new software version.

