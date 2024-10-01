---
description: This page describes possible congestion issues in the WEKA system.
---

# System congestion

## Overview

The WEKA system is built to be efficient, provide maximum performance and saturate the network links.

In some situations, the system may slow down IOs when reaching some limits (or even block new IOs at higher limits) until the congested resource is relieved. Such situations may be transient, and the issue will be resolved on its own after a short time. However, some cases suggest an issue that needs to be addressed, such as a workload maxing out the cluster's resources. In such cases, the cluster resources must be expanded, as described in [Expanding & Shrinking Cluster Resources](expanding-and-shrinking-cluster-resources/). Contact the Customer Success Team for more information on this.

## System congestion events/alerts

The WEKA system can issue several types of congestion events/alerts:

<table><thead><tr><th width="167">Type</th><th width="193">Description</th><th>Actions</th></tr></thead><tbody><tr><td>FIBERS</td><td>Extreme load of concurrent system operations on a process</td><td>This is usually a transient situation due to the system's load. If the load is consistent and the problem persists, add more servers or cores.</td></tr><tr><td>DESTAGER</td><td>Too many pending IOs are waiting to be written for a specific process</td><td>This is usually a transient situation due to the load on the system. If the load is consistent and the problem persists, add more servers to the cluster as described in Adding a backend server, or expand the server resources.</td></tr><tr><td>SSD</td><td>Too many pending IOs to the SSD</td><td>If there is a single SSD, it is probably faulty and needs to be replaced. If there are multiple SSDs, the load on the system is too high. To handle such a load, more SSDs should be added to the system.</td></tr><tr><td>RAID_NOT_OK</td><td>More IO failures than can be handled have occurred, and IOs cannot be served</td><td>Make sure to bring up any server that might be down. If all servers are up, contact the Customer Success Team.</td></tr><tr><td>XDESTAGE</td><td>Auxiliary cluster resources are low</td><td>This is usually a transient situation due to the system's load. If the load is consistent and the problem persists, add more servers to the cluster or contact the Customer Success Team.</td></tr></tbody></table>

**Related topic**

[expanding-and-shrinking-cluster-resources](expanding-and-shrinking-cluster-resources/ "mention")
