---
description: This page describes possible congestion issues in the WEKA system.
---

# System congestion

## Overview

The WEKA system is designed for efficiency, delivering maximum performance and fully utilizing network links. However, in certain situations, the system may slow down I/O operations or even block new I/Os if specific limits are reached, until the congested resource is alleviated.

While these situations are often temporary and may resolve themselves quickly, persistent congestion can indicate an underlying issue, such as a workload overwhelming the cluster's resources. In such cases, expanding the cluster's resources, as detailed in [expanding-and-shrinking-cluster-resources](expanding-and-shrinking-cluster-resources/ "mention"). For further assistance, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md).

## System congestion events and alerts

The WEKA system can issue several types of congestion events and alerts:

<table><thead><tr><th width="163">Type</th><th width="215">Description</th><th>Actions</th></tr></thead><tbody><tr><td>FIBERS</td><td>Extreme load of concurrent system operations on a process.</td><td>This is typically a transient condition caused by system load. If the load is persistent, consider adding more resources, such as servers or cores. See <a data-mention href="expanding-and-shrinking-cluster-resources/add-a-backend-server.md">add-a-backend-server.md</a> or <a data-mention href="expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md#add-cpu-cores-to-a-container">#add-cpu-cores-to-a-container</a> for guidance.</td></tr><tr><td>DESTAGER</td><td>Excessive pending I/O operations waiting to be written for a specific process.</td><td><p>This situation is often temporary due to system load. If the condition persists, increase the number of servers in the cluster. </p><p>See <a data-mention href="expanding-and-shrinking-cluster-resources/add-a-backend-server.md">add-a-backend-server.md</a> or <a data-mention href="expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md">expansion-of-specific-resources.md</a> for guidance.</p></td></tr><tr><td>SSD</td><td>An excessive number of pending I/O operations to the SSD.</td><td><p>If there is only one SSD, it may be faulty and require replacement. If multiple SSDs are involved, the system load is too high. </p><p>To manage the load, add more SSDs to the system. See <a data-mention href="expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md">expansion-of-specific-resources.md</a> for guidance.</p></td></tr><tr><td>RAID_NOT_OK</td><td>I/O failures exceed the system's handling capacity, and I/Os cannot be processed.</td><td>Ensure all servers are operational. If any server is down, bring it up. If all servers are active and the issue persists, contact the <a href="../support/getting-support-for-your-weka-system.md">Customer Success Team</a>.</td></tr><tr><td>XDESTAGE</td><td>Auxiliary cluster resources are low</td><td><p>This is usually a temporary condition due to system load. If the problem persists, add more servers to the cluster.</p><p>See <a data-mention href="expanding-and-shrinking-cluster-resources/add-a-backend-server.md">add-a-backend-server.md</a> for guidance or contact the <a href="../support/getting-support-for-your-weka-system.md">Customer Success Team</a>.</p></td></tr></tbody></table>

