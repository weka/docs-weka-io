---
description: This page describes possible congestion issues in the WEKA system.
---

# System congestion

## Overview

The WEKA system is built to be efficient, provide maximum performance and saturate the network links.

In some situations, the system may slow down IOs when reaching some limits (or even block new IOs at higher limits) until the congested resource is relieved. Such situations may be transient, and the issue will be resolved on its own after a short time. However, there are also cases that suggest an issue that needs to be addressed, such as a workload maxing out the cluster's resources. In such cases, the cluster resources must be expanded, as described in [Expanding & Shrinking Cluster Resources](expanding-and-shrinking-cluster-resources/). Contact the Customer Success Team for more information on this.

## System congestion events/alerts

The WEKA system can issue several types of congestion events/alerts:

| **Type**      | **Description**                                                              | **Actions**                                                                                                                                                                                                                                                                                                                                                                           |
| ------------- | ---------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| FIBERS        | Extreme load of concurrent system operations on a process                    | This is usually a transient situation due to the load on the system. If the load is consistent and the problem persists, add more resources (servers/cores), as described in [Adding a backend server](broken-reference) or [Addition of CPU cores](expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md#addition-of-only-cpu-cores).                         |
| DESTAGER      | Too many pending IOs are waiting to be written for a specific process        | This is usually a transient situation due to the load on the system. If the load is consistent and the problem persists, add more servers to the cluster as described in [Adding a backend server](broken-reference), or expand the server resources as described in [Expansion of specific resources](expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md). |
| SSD           | Too many pending IOs to the SSD                                              | If there is a single SSD, it is probably faulty and needs to be replaced. If there are multiple SSDs, the load on the system is too high. To handle such a load, more SSDs should be added to the system, as described in  [Expansion of specific resources](expanding-and-shrinking-cluster-resources/expansion-of-specific-resources.md).                                           |
| RAID\_NOT\_OK | More IO failures than can be handled have occurred, and IOs cannot be served | Make sure to bring up any server that might be down. If all servers are up, contact the Customer Success Team.                                                                                                                                                                                                                                                                        |
| XDESTAGE      | Auxiliary cluster resources are low                                          | This is usually a transient situation due to the load on the system. If the load is consistent and the problem persists, add more servers to the cluster as described in [Adding a backend server](broken-reference), or consult the Customer Success Team.                                                                                                                           |

