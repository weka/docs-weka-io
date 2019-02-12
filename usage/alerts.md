---
description: >-
  This page describes the alerts that can be received in this version of the
  WekaIO system.
---

# Alerts

## Overview

WekaIO alerts indicate problematic ongoing states that the cluster is currently suffering from. They can only be dismissed by resolving the root cause of their existence. Usually, an alert is introduced alongside an equivalent event. This can help in identifying the point in time that the problematic state occurred and its root cause.

Alerts are indicated by a yellow triangle. Click the triangle to display a list of active alerts in the system.

{% hint style="info" %}
**Note:** If for any reason it is not possible to solve the root cause of an alert at any given time, the alert can be muted in order to hide it. This action is only possible from the CLI.
{% endhint %}

## List of Alerts

| Name | Description |
| :--- | :--- |
| NodeDisconnected |  A node is disconnected from the cluster. Check network connectivity to make sure the node can communicate with the cluster. |
| AdminDefault Password | The admin password is still set to the factory default. Change it to ensure only authorized users can access the cluster. |
| CloudHealth | A host cannot upload events to the WekaIO cloud. Check Internet connectivity. |
| NoClusterLicense | No license is assigned. |
| LicenseError | A license conflict exists. |
| ClusterIsUpgrading | Cluster is upgrading. |
| HugePagesAlloc | WekaIO could not allocate RAM on a host via huge pages, because of the host allocation status. |
| Negative UnprovisionedCapacity | The cluster unprovisioned capacity is negative from trying to improve the calculation of spare space required for data protection. |
| HighDrivesCapacity | The average hot tier capacity level is high in relation to the total capacity available. Free-up space or add more hot tier drives to the cluster. |
| DriveDown | A drive is not responding. |
| DriveNeedsPhaseout | A drive has too many errors and is marked as requiring phaseout. |
| JumboConnectivity | A host cannot send jumbo frames to any of its cluster peers. Check the host network settings and the switch to which it is connected. |
| DataProtection | Partial data protection. |
| NodeTiering Connectivity | A node cannot connect to an object store. Check the connection. |
| OfedVersions | A host Mellanox OFED version ID does not match the one used by the WekaIO container. |
| DedicatedWatchdog | A host is configured as a dedicated WekaIO host and requires the installation of a hardware watchdog driver. |
| AgentNotRunning | The WekaIO local control agent is not running on a host. |
| NumaBalancingEnabled | A host has automatic NUMA balancing enabled which can negatively impact performance.  |
| BucketHasNoQuorum | A number of compute nodes are down, causing the bucket compute resource to be unavailable. |
| BucketUnresponsive | A compute resource bucket has failed, causing system unavailability. Check the connectivity and status of the drives. |
| HangingIOs | Some IOs are hanging. |
| ClockSkew | The clock of a host is skewed in relation to the cluster leader, with a time difference more than the permitted maximum of 30 seconds. |
| FilesystemHasToo ManyFiles | The filesystem storage configuration is not large enough for the size of files and directory entries being stored.  |
| NotEnoughConfigured MemoryForFilesystems | The total configured memory bytes for filesystems is insufficient to store the file and directory entries of the filesystems in the cluster.  |
| NotEnoughAvailable MemoryForFilesystems | There are not enough working compute nodes in the cluster to store the file and directory entries for all the filesystems in the cluster.  |

