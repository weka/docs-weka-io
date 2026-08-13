---
description: >-
  Share access to physical NVMe devices among multiple Drive IO processes
  through a centralized SSD Proxy process by dividing a single physical drive
  into multiple virtual drives.
---

# Drives sharing

## Overview

Drives sharing enables multiple Drive IO processes on a single host to access the same physical NVMe devices using a centralized SSD Proxy container. This improves resource efficiency by dividing a single physical drive into multiple virtual drives.

### Benefits

* **Improved data reduction performance:** Multiple Drive I/O processes can access the same device, increasing CPU parallelism for compression and decompression and improving effective IOPS utilization.
* **Better Gen5 bandwidth utilization:** Gen5 NVMe drives can exceed 13 GB/s, while per-node network bandwidth is typically lower. Drives sharing enables multiple cores to drive a single device, helping saturate available bandwidth.
* **Multi-tenancy and small-cluster scalability:** Sharing drives across containers or clusters enables smaller, granular capacity allocations, supporting layouts such as 16+2 even in smaller environments.
* **Flexible capacity management:** Virtual drives can be created at arbitrary sizes, with support for over-provisioning. The total allocated virtual capacity can exceed the physical device capacity, enabling future growth planning.

### Key concepts

* **Physical drive:** A physical NVMe device.
* **Virtual drive:** A logical drive carved from a physical drive and presented to the cluster as an independent disk. Each physical drive supports up to 64 virtual drives.
* **Physical UUID:** The unique identifier written to the physical drive.
* **Virtual UUID (VID/vUUID):** The unique identifier assigned to a virtual drive.
* **SSD Proxy:** A dedicated container that owns physical NVMe devices and manages I/O routing and hardware queue allocation for virtual drives.
* **Hardware queues:** NVMe I/O queue pairs allocated per virtual drive. By default, each VID uses four queues, with automatic fallback to one queue when hardware limits are reached.
* **weka-sign-drive**: The command-line utility used to sign physical drives and create or manage virtual drives.

## Configure drives sharing

Configure the SSD Proxy and virtual drives for shared NVMe access.

**Before you begin**

* Identify the device paths (for example, `/dev/nvme0n1`) for the NVMe drives.
* Obtain the cluster GUID.

To get the cluster GUID, run:

```bash
weka status
```

**Procedure**

1. **Sign the physical drive:** For each physical NVMe drive, write the WEKA header and register the device to the SSD Proxy (after this step, the drive is proxy-managed only). Replace `/dev/nvmeXnY` with the actual device path.

```bash
weka-sign-drive sign proxy /dev/nvmeXnY
```

{% hint style="info" %}
This is the only step that uses the device path (`/dev/nvmeXnY`). All subsequent operations reference drives using the UUIDs obtained from the `weka-sign-drive list` command.
{% endhint %}

2. **Identify the physical UUID:** List drives and copy the physical UUID.

```bash
weka-sign-drive list
```

Example output:

```bash
PHYSICAL UUID                         DEVICE       CAPACITY   NUM VIDS   STATUS
a1b2c3d4-e5f6-7890-abcd-ef1234567890  nvme0n1      3.84 TB    0          Ready
```

3. **Create virtual drives (VIDs):** Create one or more virtual drives on the signed physical device. This operation writes VID metadata to the drive header and does not require the SSD Proxy to be running.

```bash
weka-sign-drive virtual add <physical-uuid> \
  --size <size-in-gb> \
  [--owner-cluster-guid <cluster-guid>] \
  [--virtual-uuid <vid>]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `&#x3C;physical-uuid>` | Physical UUID identified in the previous step. |
| `--size` | Virtual drive size, in GB. Over-provisioning is supported. |
| `--owner-cluster-guid` | Cluster GUID used when signing the physical drive.Default: all clusters if not specified. |
| `--virtual-uuid` | Optional. Explicitly assigns a virtual UUID. If omitted, WEKA generates one automatically. |

**Example:** Create three 1 TB virtual drives on the same physical drive.

```bash
weka-sign-drive virtual add a1b2c3d4-e5f6-7890-abcd-ef1234567890 \
    --owner-cluster-guid 12345678-1234-1234-1234-123456789abc \
    --size 1000

weka-sign-drive virtual add a1b2c3d4-e5f6-7890-abcd-ef1234567890 \
    --owner-cluster-guid 12345678-1234-1234-1234-123456789abc \
    --size 1000

weka-sign-drive virtual add a1b2c3d4-e5f6-7890-abcd-ef1234567890 \
    --owner-cluster-guid 12345678-1234-1234-1234-123456789abc \
    --size 1000
```

{% hint style="warning" %}
* If the device is accessible through the kernel, the command writes directly to the device. If the device is managed by the SSD Proxy, the operation is transparently routed through the proxy using JRPC.
* Capacity is not enforced. The total size of virtual drives can exceed the physical drive capacity. Capacity planning and enforcement are the operator’s responsibility.
{% endhint %}

4. **Verify the virtual drive configuration:** List all signed drives and VID counts.

```bash
weka-sign-drive list
```

**Example output**

```bash
Status      Device   Physical UUID                         Model        Size     Format Status              Cluster GUID  Checksum
🔗 Proxy    nvme0n1  a1b2c3d4-e5f6-7890-abcd-ef1234567890  Model123    3.84 TB  Proxy (3 virtual drives)  Proxy GUID    Valid
```

To see detailed information about each VID, use the `show` command:

```bash
weka-sign-drive show  a1b2c3d4-e5f6-7890-abcd-ef1234567890
```

5. **Configure the SSD Proxy container:** Configure the SSD Proxy container with resources that match the expected storage footprint.

```bash
weka local setup ssdproxy \
  --max-drives <max-drives> \
  --expected-max-drive-size-gb <max-size> \
  -- memory <memory>
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `--max-drives` | Maximum number of physical drives managed by the proxy (up to 40). |
| `--expected-max-drive-size-gb` | Largest expected drive size in GB. Used to calculate memory allocation for ChunkDB metadata. |
| `--memory` | If not using the `max-drives` and `expected-max-drive-size-gb`, specify the exact container memory. |

**Memory sizing guidance**

The SSD Proxy allocates memory for ChunkDB metadata approximately based on the specified `max-drives` and `expected-max-drive-size-gb` parameters:

```
Memory ≈ 100 MB + 4 MB × total TB of expected storage
```

**Example**

For 10 drives × 30 TB each (300 TB total):

```
Memory ≈ 100 MB + (10 × 30 TB × 4 MB/TB)
       ≈ 1.27 GB
```

This ensures sufficient memory is reserved for managing virtual drives efficiently.

6. **Start the SSD Proxy container:** Start the container and confirm that the `ssdproxy` container reports `Running` (otherwise, the following step will fail).

```bash
weka local start ssdproxy
weka local ps
```

7. **Add virtual drives to the cluster:** Add each VID by using the standard drive add command.

```bash
weka cluster drive add <container-id> <virtual-uuid> [--pool <pool-name>]
```

**Parameters**

|  |  |
| --- | --- |
| `&#x3C;container-id>` | ID of the container to attach the virtual drive. |
| `&#x3C;virtual-uuid>` | Virtual UUID created in the previous step. |
| `--pool` | Optional. Target storage pool (for example, `iubig` for large indirection unit pools). |

**Examples**

```bash
# Add a virtual drive to container 0 in the iubig pool
weka cluster drive add 0 11111111-2222-3333-4444-555555555555 --pool iubig

# Add a virtual drive to container 1 in the default pool
weka cluster drive add 1 22222222-3333-4444-5555-666666666666
```

All standard `weka cluster drive add` flags, including protection scheme options, apply to virtual drives.

## System limits and planning guidelines

The following provides guidelines for planning SSD Proxy resources and ensures virtual drive performance remains optimal.

* **Physical drives per proxy**
  * Maximum: 40 drives
* **Virtual drives per physical drive**
  * Maximum: 64 VIDs per physical drive
* **Capacity**
  * VID sizes can exceed physical drive capacity (over-provisioning allowed. Capacity management is the operator’s responsibility)
  * Minimum VID size is 1 GB. However, the capacity ratio of SSD in the cluster must be 8:1 or less between the smallest and largest SSDs.

#### Capacity planning

Example configuration:

* 10 physical drives × 30 TB each → 300 TB raw capacity
* 5 VIDs per drive × 5 TB each → 250 TB allocated
* Remaining: 50 TB reserved for future growth

Memory requirements:

1. ChunkDB memory: \~4 MB per TB
   * 300 TB → 1.2 GB
2. DPDK memory: Based on the number of VIDs
   * 50 VIDs × 4 qpairs = 200 qpairs
   * Memory ≈ (200 × 540 KB) / 1,024 ≈ 105 MB
   * Default allocation of 1.32 GB is sufficient in this scenario
3. Base overhead: \~100 MB

Total estimated memory:

```
1.2 GB (ChunkDB) + 1.32 GB (DPDK) + 100 MB (base) ≈ 2.6 GB
```

## Manage drives sharing

#### Identify drive information

Display detailed or filtered information about physical and virtual drives.

**Before you begin**

Ensure the `weka-sign-drive` tool is available on the server.

**Procedure**

1. **View detailed drive properties:** Display details for a device.

```bash
weka-sign-drive show /dev/nvme0n1
```

**Example output**

```bash
Physical UUID: a1b2c3d4-e5f6-7890-abcd-ef1234567890
Cluster GUID:  12345678-1234-1234-1234-123456789abc
Total Size:    3.84 TB
Virtual Drives:
  - VID: v1111111-2222-3333-4444-555555555555, Size: 1.00 TB, Status: Active
  - VID: v2222222-3333-4444-5555-666666666666, Size: 1.00 TB, Status: Active
  - VID: v3333333-4444-5555-6666-777777777777, Size: 1.00 TB, Status: Ready
```

2. **List all drives:** Display a summary of all proxy-managed drives.

```bash
weka-sign-drive list
```

3. **Filter by proxy-managed drives:** Display only drives accessible through SSD Proxy.

```bash
weka-sign-drive list --view proxy
```

4. **Filter by local drives:** Display only drives visible to the local kernel.

```bash
weka-sign-drive list --view local
```

#### Delete a virtual drive

Delete a virtual drive (VID) from a physical NVMe device.

**Before you begin**

Verify that the virtual drive is no longer in use by the cluster. If the VID is currently attached, deactivate and remove it at the cluster level before deleting the VID from the hardware.

**Procedure**

1. **Deactivate the drive:** Prevent new I/O operations.

```bash
weka cluster drive deactivate <drive-id>
```

2. **Verify removal readiness:** Wait for a removable state.

```bash
weka cluster drive
```

3. **Remove the drive from the cluster:** Detach the drive from the cluster configuration.

```bash
weka cluster drive remove <drive-id>
```

4. **Delete the virtual drive:** Remove the VID from the physical drive header.

```bash
weka-sign-drive virtual remove <physical-uuid> --virtual-uuid <vid>
```

**Example**

```bash
weka-sign-drive virtual remove a1b2c3d4-e5f6-7890-abcd-ef1234567890 \
    --virtual-uuid v1111111-2222-3333-4444-555555555555
```

## Advanced operations

<details>

<summary>Using JRPC for advanced operations</summary>

Advanced users can interact programmatically with the SSD Proxy using JRPC over the Unix domain socket. The `wapi` CLI tool provides direct access to these proxy functions.

```bash
weka local run -- /weka/hostside/wapi \
  -U /opt/weka/data/agent/sockets/ssdproxy/container.sock:/api/v1 \
  <function-name> [--flag value ...]
```

* `<function-name>` corresponds to a JRPC function in the SSD Proxy API.
* Flags and parameters depend on the selected function.

**Example 1: List all drives**

```bash
weka local run -- /weka/hostside/wapi \
  -U /opt/weka/data/agent/sockets/ssdproxy/container.sock:/api/v1 \
  list_disks
```

**Example 2: Add a virtual drive via the SSD Proxy**

```bash
weka local run -- /weka/hostside/wapi \
  -U /opt/weka/data/agent/sockets/ssdproxy/container.sock:/api/v1 \
  ssd-proxy-add-virtual-drive \
  --physicalUuid fb9236ec-6a85-47d5-a030-d5e254f6c753 \
  --clusterGuid 3d3bfbd8-b0f2-47a5-b634-6b8eacf8bdc6 \
  --virtualUuid <vid-uuid>
```

{% hint style="info" %}
* Commands return structured JSON, which can be parsed using tools like jq.
* This interface is intended for programmatic management, automation, or troubleshooting beyond standard CLI workflows.
{% endhint %}

</details>

<details>

<summary>Troubleshooting commands</summary>

Use the following commands to verify SSD Proxy and virtual drive health, resource allocation, and connectivity.

**Check SSD Proxy resource allocation**

```bash
weka local resources ssdproxy
```

**View detailed drive and hardware queue information**

```bash
weka-sign-drive list -v
```

**Check SSD Proxy logs**

```bash
weka local run -- viewer -c ssdproxy -u ssd_proxy -s0
```

**Verify DPDK hugepage allocation**

```bash
weka local run -- cat /proc/meminfo | grep Huge
```

**Test JRPC connectivity to the proxy**

```bash
weka local run -- /weka/hostside/wapi \
  -U /opt/weka/data/agent/sockets/ssdproxy/container.sock:/api/v1
```

**Check hardware queue limits for NVMe devices**

```bash
# Using nvme-cli
nvme get-feature /dev/nvme0 -f 0x07 -H

# Or via verbose weka-sign-drive output
weka-sign-drive list -v
```

This set of commands helps identify configuration, performance, and connectivity issues related to SSD Proxy and virtual drives.

</details>

## Troubleshoot drives sharing common issues

<details>

<summary>SSD Proxy reports insufficient ChunkDB memory</summary>

**Cause**

The SSD Proxy allocates approximately 4 MB of RAM per TB of total managed storage. Configuring more or larger drives than planned can exhaust ChunkDB memory.

**Resolution**

Reconfigure the SSD Proxy with the correct drive count and expected sizes. The following command automatically calculates and allocates sufficient memory based on the total expected storage.

```bash
weka local setup ssdproxy \
  --max-drives <num-drives> \
  --expected-max-drive-size-gb <size>
```

</details>

<details>

<summary>Cannot allocate additional virtual drives due to queue limits</summary>

**Cause**

NVMe hardware queue limits have been reached.

Each virtual drive (VID) is allocated 4 hardware queues by default. NVMe devices have a limited number of hardware queues (typically 128–256). If the total required queues exceed the device limit, new VIDs cannot be fully allocated.

**Resolution**

1. Check current queue allocation. The following command displays the Num Queues for each VID.

```bash
weka-sign-drive list -v
```

2. Verify queue availability. Ensure that:

```
(existing VIDs + 1) × 4 ≤ hardware queue limit
```

3. Understand device capacity. Example:\
   A device with 128 hardware queues can fully support up to 32 VIDs (32 × 4 = 128).
4. Manage additional VIDs. If you create more VIDs than the device can fully support, the proxy allocates fewer queues per VID (down to 1 queue minimum). Do one of the following:
   * Reduce the number of VIDs per physical drive.
   * Allow fallback allocation with fewer queues per VID.

</details>

<details>

<summary>VID allocation fails due to insufficient DPDK memory</summary>

The SSD Proxy relies on DPDK/SPDK for high-performance I/O. Each queue pair (qpair) requires approximately 540 KB of memory.

**Default allocation**

* \~1.32 GB of DPDK memory supports up to 640 VIDs (2,560 qpairs at 4 queues per VID).
* Allocating more VIDs requires increasing DPDK memory.

**Symptoms**

* VID creation fails with memory errors.
* Proxy logs show `"DPDK allocation failed"` or hugepage exhaustion.
* `weka local ps` indicates the proxy is in a degraded state.
* New qpairs cannot be allocated, even if hardware queues are available.

**Resolution**

Increase the DPDK memory allocation for the SSD Proxy:

```bash
weka local resources ssdproxy --dpdk-base-memory-mb <value-in-mb>
weka local resources apply
```

**Estimating required memory**

* Memory per VID = 4 queues × 540 KB ≈ 2.1 MB
* Total memory (MB) ≈ (Number of VIDs × 4 × 540) / 1024

**Examples**

* \~640 VIDs: Default 1.32 GB sufficient
* \~1,000 VIDs: Required memory ≈ 2,109 MB

```bash
weka local resources ssdproxy --dpdk-base-memory-mb 2560
```

* Maximum VIDs (40 drives × 64 VIDs = 2,560 VIDs): Required memory ≈ 5,400 MB

```bash
weka local resources ssdproxy --dpdk-base-memory-mb 6144
```

This ensures sufficient memory for queue pair allocation and prevents DPDK-related errors during virtual drive operations.

</details>

<details>

<summary>Cannot add a VID to the cluster (“proxy not running”)</summary>

**Cause**

The SSD Proxy container is not running or not reachable.

**Resolution**

```bash
# Verify proxy status
weka local ps | grep ssdproxy

# Start the proxy if required
weka local start ssdproxy

# Confirm proxy visibility
weka-sign-drive list --view proxy
```

</details>
