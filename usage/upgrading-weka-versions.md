---
description: This page describes how to upgrade to the latest Weka software version.
---

# Upgrade Weka versions

## Upgrade prerequisites&#x20;

Before upgrading your cluster, ensure the following:

1. All the backend servers are online.
2. Any rebuild has been completed.
3. There are no outstanding alerts that haven't been addressed.
4. There is at least 4 GB of free space in the `/opt/weka` directory.

{% hint style="info" %}
**Note:** If you plan a multi-hop version upgrade, once an upgrade is done, a background process of converting metadata to a new format may occur (in some versions). This upgrade takes several minutes to complete and must finish before another upgrade can start. You can monitor the progress using the `weka status` CLI command and check if there is a `data upgrade` task in a`RUNNING` state.
{% endhint %}

## Supported upgrade paths

The Weka upgrade process supports upgrading to higher minor versions and major versions of the Weka software.

When upgrading to a major version, always upgrade to the latest minor version in the new major version. This may require first upgrading to a specific minor version in the current software version, as follows:

* To upgrade to Weka software version 4.0.x, go through version 3.14.1 or above
* To upgrade to Weka software version 3.14.x, go through version 3.13.1 or above
* To upgrade to Weka software version 3.13.x, go through version 3.12.1 or above
* To upgrade to Weka software version 3.12.x, go through version 3.11.0 or above
* To upgrade to Weka software version 3.11.x, go through version 3.10.0 or above

For more information, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

## Prepare the cluster for upgrade

Download the new release on one of the backends using one of the following methods:

*   From the backend server, run `weka version get <new-version>` where `<new-version>` is the name of the new version (for example,`4.0.1`), followed by `weka version prepare <new-version>`.&#x20;

    * If you don't have a distribution server set, you can add it explicitly to the command. For example, to get the `4.0.1` version from [get.weka.io](https://get.weka.io/ui/releases/) using a token as follows:&#x20;

    ```bash
    weka version get 4.0.1 --from https://[GET.WEKA.IO-TOKEN]@get.weka.io
    ```
* From the backend server, run the `curl` command described in the install tab on the [get.weka.io](https://get.weka.io/ui/releases/) new release page.
* Download the new version tar file to the backend server and run the `install.sh` command. This method is helpful in environments without connectivity to [get.weka.io](https://get.weka.io), such as dark sites or private VPCs.

## Prepare the backend servers for upgrade (optional)

When working with many backend servers, it is possible to prepare the backend servers separately from the upgrade process in advance to minimize the total upgrade time. For a small number of backend servers, this step is not required.&#x20;

The preparation phase prepares all the connected backend servers for the upgrade, which includes downloading the new version and getting it ready to be applied.

Once the new version is downloaded to one of the backend servers (as described above), run the following CLI command:

`weka local run --in <new-version> upgrade --prepare-only`

## Upgrade the backend servers

Once a new software version is installed on one of the backend servers, upgrade the cluster to the new version by running the following command on the backend server:

`weka local run --in <new-version> upgrade`

where `<new-version>` is the name of the new version (for example,`4.0.1`).

The upgrade command skips the download and preparation operations if you already ran the preparation step.

You can control the upgrade window time by setting the following parameters in the `upgrade` command:

**Parameters**

| **Name**                                 | **Type** | **Value**                                                                                                           | **Limitations** | **Mandatory** | **Default** |
| ---------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------- | --------------- | ------------- | ----------- |
| `--stop-io-timeout`                      | Integer  | Maximum time in seconds to wait for IO to stop successfully                                                         |                 | No            | 90          |
| `--host-version-change-timeout`          | Integer  | Maximum time in seconds to wait for a host version update                                                           |                 | No            | 180         |
| `--disconnect-stateless-clients-timeout` | Integer  | Maximum time in seconds to wait for stateless clients to be marked as DOWN and continue the upgrade without them    |                 | No            | 60          |
| `--prepare-only`                         | Boolean  | Download and prepare a new software version across all servers in the cluster without performing the actual upgrade |                 | No            | False       |



{% hint style="info" %}
**Note:** To run the upgrade command, ensure you are logged in as a Cluster Admin (using a `weka user login`).
{% endhint %}

Before switching the cluster to the new release, the upgrade command distributes the new release to all cluster servers. It makes the necessary preparations, such as compiling the new `wekafs` driver.

If a failure occurs during the preparation, such as the disconnection of a server or failure to build a driver, the upgrade process stops, and a summary message indicates the problematic server.

In a successful process, the upgrade stops the cluster IO service, switches all servers to the new release, and then turns the IO service back on. This process takes about 1 minute, depending on the size of the cluster.

{% hint style="info" %}
**Note:** In large deployments of Weka with many backend servers and hundreds or thousands of clients, it is recommended to adjust the following timeout parameters: &#x20;

* Set `host-version-change-timeout` to `600`
* Set `disconnect-stateless-clients-timeout` to `200`

If further assistance and adjustments are required, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

## Upgrade the clients

Once all backends are upgraded, the clients remain with the existing version and continue working with the upgraded backends. Once a client is rebooted, or a complete `umount` and `mount` is performed, the client is automatically upgraded to the backend version.

If you need to upgrade the clients manually, for example, in a maintenance window, run the `weka local upgrade` CLI command from the client.

An alert is raised if there is a mismatch between the clients' and the cluster versions.

{% hint style="info" %}
**Note:** Clients with two or more versions behind the version of the backends are not supported. Therefore, you must upgrade the clients before the next software version upgrade.
{% endhint %}

## Check the status after the upgrade

Once the upgrade is complete, verify that the cluster is in the new version by running the `weka status` command.

{% hint style="success" %}
**Example:** The following is returned when the system is upgraded to version 4.0.1:

`# weka status`  \
`Weka v4.0.1`   \
`...`
{% endhint %}

## Upgrade revert on failure

The disruptiveness of the upgrade procedure is limited to a defined window of 10 minutes. Weka system ensures that either the upgrade process to the new version finishes successfully or the version is automatically reverted to the old one within this window.

If a failure occurs, the version is automatically reverted on the backends. In this case, verify that all the backends are reverted to the old version by running the `weka cluster host` command.
