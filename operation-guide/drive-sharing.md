---
description: >-
  Learn how to configure drive sharing across multiple Drive IO processes to
  improve performance and enable multi-tenancy in your storage cluster.
---

# Drive sharing

## Overview

The drive sharing feature enables a physical NVMe device to be partitioned into multiple virtual drives, each with a unique virtual UUID (vUUID).

This capability is essential for:

* **Performance Optimization:** Allows multiple cores to simultaneously access the same physical device, boosting throughput.
* **Resource Utilization:** Efficiently manages high core counts, such as WEKAPod Prime setups utilizing 128 Intel E-series Efficiency cores.
* **Scalability:** Simplifies distributing drive resources across numerous containers.

## Configure drive sharing

Create virtual UUIDs and integrate them into the cluster using a streamlined, single-command process.

**Before you begin**

* Ensure the physical NVMe devices are installed and recognized by the server.
* Identify the target container ID and the storage pool name.

**Procedure**

1.  Run the drive add command with the `--virtual` parameter to specify the number of virtual drives.

    ```bash
    weka cluster drive add <containerid> <device-path> --virtual <number> --pool <pool-name>
    ```

    **Example:** To create 2 virtual drives from `/dev/nvme0n1` and add them to the `legacy` pool for container 0:

    ```bash
    weka cluster drive add 0 /dev/nvme0n1 --virtual 2 --pool legacy
    ```

    The system automatically starts the SSD proxy, allocates required memory, signs the drive, and divides capacity evenly to prevent over-provisioning.
2.  Verify the configuration of the virtual drives.

    ```bash
    weka cluster drive show --verbose
    ```

## Manage virtual drives manually

Manually configure vUUIDs for better control over memory allocation and drive identification.

**Before you begin**

* Identify the cluster GUID.
* Verify that the physical NVMe device is not actively utilized by the cluster.

**Procedure**

1.  Initialize the SSD proxy on the local server.

    ```bash
    weka local setup ssdproxy --memory <size>
    ```
2.  Sign the physical drive for proxy usage.

    ```bash
    /usr/bin/weka-sign-drive sign proxy /dev/nvme0n1
    ```
3.  Create the vUUIDs by specifying the size in TiB to ensure the total does not exceed physical capacity.

    ```bash
    /usr/bin/weka-sign-drive virtual add -o <cluster_guid> /dev/nvme0n1 --size <capacity>
    ```
4.  Retrieve the generated vUUID strings.

    ```bash
    /usr/bin/weka-sign-drive show /dev/nvme0n1 -j | jq -r '.partitions[].header.virtual_drives[].virtual_uuid'
    ```
5.  Add each vUUID to the cluster.

    ```bash
    weka cluster drive add <containerid> <vUUID> --pool <pool-name>
    ```

## Drive sharing reference

Use these commands and parameters to monitor and manage virtual drive configurations.

#### Display commands

<table><thead><tr><th width="322">Command</th><th>Description</th></tr></thead><tbody><tr><td><code>weka cluster drive show</code></td><td>Displays physical drives and aggregate capacity.</td></tr><tr><td><code>weka cluster drive show --verbose</code></td><td>Displays individual vUUIDs and their mapping to physical NVMe devices.</td></tr><tr><td><code>weka cluster drive scan</code></td><td>Detects pre-provisioned NVMes for rapid deployment or replacement.</td></tr></tbody></table>

#### Error handling and events

* **Over-provisioning protection:** The system prevents configurations where the total size of vUUIDs surpasses the physical capacity.
* **Failure identification:** Provides specific serial numbers and PCIe IDs for physical NVMe failures, even when vUUIDs are used, through detailed views and system alerts.
