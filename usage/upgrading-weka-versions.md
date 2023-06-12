---
description: This page describes how to upgrade to the latest Weka software version.
---

# Upgrade WEKA versions

## Overview&#x20;

The WEKA upgrade process supports upgrading to higher minor and major versions of a WEKA system deployed in a multi-container backend architecture (MCB). MCB is supported from version 4.0.2. MCB enables non-disruptive upgrades (NDU).

Always upgrade to the latest minor version in the new major version when upgrading to a major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to WEKA software version 4.1.x, the minimum source version must be 4.0.2 in MCB architecture. If the source system is not in MCB architecture, it is required to convert the cluster architecture to MCB. Contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for assistance.
* To upgrade to WEKA software version 4.0.x, go through version 3.14.1 or above&#x20;
* To upgrade to WEKA software version 3.14.x, go through version 3.13.1 or above
* To upgrade to WEKA software version 3.13.x, go through version 3.12.1 or above

{% hint style="warning" %}
**Warning:** Customers running WEKA clusters on AWS with **auto-scaling groups** must contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) before converting the cluster to MCB.
{% endhint %}

{% hint style="info" %}
**Note:** Backend servers with Intel E810 NIC are not supported on MCB architecture, so the cluster remains in the legacy architecture (single container architecture).
{% endhint %}

## What is a non-disruptive upgrade (NDU)?

In MCB architecture, each container serves a single type of process, drive, frontend, or compute function. Therefore it is possible to upgrade one container at a time (rolling upgrade) while the remaining containers continue serving the clients with one exception that the compute containers are upgraded at once in a very short time with a minimal impact on serving IOs.&#x20;

{% hint style="info" %}
**Note:** Some background tasks, such as snapshot uploads or downloads, must be postponed or aborted. See the [prerequisites](upgrading-weka-versions.md#1.-verify-prerequisites-for-the-upgrade) in the upgrade workflow for details.
{% endhint %}

#### **Internal upgrade process**

Once you run the upgrade command in `ndu` mode, the following occurs:

1. Downloading the version and preparing all backend servers.
2. Rolling upgrade of the **drive** containers.
3. Upgrading all **compute** containers at once.
4. Rolling upgrade of the **frontend** and **protocol** containers and the protocol gateways.

<figure><img src="../.gitbook/assets/NDU_process_4.1.png" alt=""><figcaption><p>NDU process at a glance</p></figcaption></figure>

**Related topics**

[weka-containers-architecture-overview.md](../overview/weka-containers-architecture-overview.md "mention")

## Upgrade workflow

1. [Verify prerequisites for the upgrade](upgrading-weka-versions.md#1.-verify-prerequisites-for-the-upgrade)
2. [Prepare the cluster for upgrade](upgrading-weka-versions.md#2.-prepare-the-cluster-for-upgrade)
3. [Prepare the backend servers for upgrade (optional)](upgrading-weka-versions.md#3.-optional.-prepare-the-backend-servers-for-upgrade)
4. [Upgrade the backend servers](upgrading-weka-versions.md#4.-upgrade-the-backend-servers)
5. [Upgrade the clients](upgrading-weka-versions.md#5.-upgrade-the-clients)
6. [Check the status after the upgrade](upgrading-weka-versions.md#6.-check-the-status-after-the-upgrade)

{% hint style="warning" %}
**Note:** Upgrading a Weka cluster with a server used for more than one of the following protocols, NFS, SMB, or S3, is not allowed. In such a case, the upgrade does not start.\
Contact the Customer Success Team to ensure only one additional protocol is installed on each server.
{% endhint %}

### 1. Verify prerequisites for the upgrade

Before upgrading the cluster, ensure the following prerequisites. Otherwise, the NDU is not possible:

1. The backend servers meet the [prerequisites and compatibility](../support/prerequisites-and-compatibility.md) of the target version.
2. If you perform a non-disruptive upgrade (NDU), ensure the source version is configured in a multiple containers architecture. If not, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to convert the source version from a single container architecture to a multiple containers architecture. This prerequisite only applies to an upgrade from source version 4.0.2 and above to 4.1.x.
3. All the backend servers are online.
4. Ensure you are logged in as a Cluster Admin (using a `weka user login`).
5. Any rebuild has been completed.
6. There are no outstanding alerts that still need to be addressed.
7. There is at least 4 GB of free space in the `/opt/weka` directory.
8. The NDU process requires the following tasks to be stopped. If these tasks are planned, postpone them. If the tasks are running, perform the required action.

<table><thead><tr><th width="208">Task</th><th width="242">Required action</th><th>Backgrounk task name</th></tr></thead><tbody><tr><td>Upload a snapshot  </td><td>Wait for the snapshot upload to complete,  or abort it.</td><td>STOW_UPLOAD</td></tr><tr><td>Create a filesystem from an uploaded snapshot</td><td>Wait for the download to complete or abort it by deleting the downloaded filesystem or snapshot.<br><br>If the task is in the snapshot prefetch metadata stage, wait for the prefetch to complete or abort it. It is not possible to resume the snapshot prefetch metadata after the upgrade.</td><td>STOW_DOWNLOAD_SNAPSHOT<br>STOW_DOWNLOAD_FILESYSTEM<br>FILESYSTEM_SQUASH<br>SNAPSHOT_PREFETCH</td></tr><tr><td>Sync a filesystem from a snapshot</td><td>Wait for the download to complete or abort it by deleting the downloaded filesystem or snapshot.</td><td>STOW_DOWNLOAD_SNAPSHOT</td></tr><tr><td>Detach object store bucket from a filesystem</td><td>Detaching an object store is blocked during the upgrade. If it is running, ignore it. </td><td>OBS_DETACH</td></tr></tbody></table>

For details on managing the background tasks, see the [Background tasks](background-tasks.md) topic.

{% hint style="info" %}
**Note:** If you plan a multi-hop version upgrade, once an upgrade is done, a background process of converting metadata to a new format may occur (in some versions). This upgrade takes several minutes to complete before another upgrade can start. You can monitor the progress using the `weka status` CLI command and check if there is a `data upgrade` task in a `RUNNING` state.
{% endhint %}

### 2. Prepare the cluster for upgrade&#x20;

Download the new software release on one of the backends using one of the following methods:

* From the backend server, run `weka version get <new-version>` \
  (`<new-version>` is for example, `4.1.0`). Then, run `weka version prepare <new-version>`.&#x20;
* If you don't have a distribution server set, you can add it explicitly to the command. For example, to get the `4.1.0` version from [get.weka.io](https://get.weka.io/ui/releases/), use a token as follows: \
  \
  `weka version get 4.1.0 --from https://[GET.WEKA.IO-TOKEN]@get.weka.io`\
  \
  Then, run `weka version prepare <new-version>`. &#x20;
* From the backend server, run the `curl` command described in the install tab on the [get.weka.io](https://get.weka.io/ui/releases/) new release page.
* Download the new version tar file to the backend server and run the `install.sh` command. This method is helpful in environments without connectivity to [get.weka.io](https://get.weka.io), such as dark sites or private VPCs.

### 3. Prepare the backend servers for upgrade (optional)

When working with many backend servers, preparing them separately from the upgrade process in advance is possible to minimize the total upgrade time. For a small number of backend servers, this step is not required.&#x20;

The preparation phase prepares all the connected backend servers for the upgrade, which includes downloading the new version and getting it ready to be applied.

Once the new version is downloaded to one of the backend servers, run the following CLI command:\
`weka local run --container <container-name> --in <new-version> upgrade --mode ndu --prepare-only`

Where:

`<new-version>`: Specify the new version. For example,`4.1.0`.

`<container-name>`: Specify only one container name. For example: `drives0`.

`<upgrade mode>`: For a cluster in MCB architecture, specify `ndu`.  For a cluster in legacy architecture, the default is `oneshot`, so it is not required to specify it.

### 4. Upgrade the backend servers

Once a new software version is installed on one of the backend servers, upgrade the cluster to the new version by running the following command on the backend server.&#x20;

If you already ran the preparation step, the upgrade command skips the download and preparation operations.

`weka local run --container <container-name> --in <new-version> upgrade --mode <upgrade mode>`

Example:

`weka local run --container drives0 --in 4.1.1 upgrade --mode ndu`

**Adhere to the following:**

* Before switching the cluster to the new software release, the upgrade command distributes the new release to all cluster servers. It makes the necessary preparations, such as compiling the new `wekafs` driver.
* If a failure occurs during the preparation, such as a disconnection of a server or failure to build a driver, the upgrade process stops and a summary message indicates the problematic server.
* In a successful process, the upgrade stops the cluster IO service, switches all servers to the new release, and then turns the IO service back on. This process takes about 1 minute, depending on the cluster size.

### 5. Upgrade the clients

Once all backends are upgraded, the clients remain with the existing version and continue working with the upgraded backends.

Once a stateless client is rebooted, or a complete `umount` and `mount` is performed, the stateless client is automatically upgraded to the backend version.

For stateful clients, a manual upgrade is required, usually during a maintenance window.

For a manual upgrade of both stateless or stateful clients, run the following command line on the client:

`weka local upgrade`

An alert is raised if there is a mismatch between the clients' and the cluster versions.

{% hint style="warning" %}
Add the `--prepare-driver` flag to the command for client source versions 4.0.1 and above.
{% endhint %}

{% hint style="info" %}
**Note:** Clients with two or more versions behind the version of the backends are not supported. Therefore, clients must be automatically or manually upgraded before the next cluster software version upgrade.
{% endhint %}

### 6. Check the status after the upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="success" %}
**Example:** The following is returned when the system is upgraded to version 4.1.0:

`# weka status`  \
`Weka v4.1.0`   \
`...`
{% endhint %}
