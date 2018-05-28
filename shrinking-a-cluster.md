---
description: This page describes the procedures involved in the shrinking of a cluster.
---

# Shrinking a Cluster

## About Shrinking a Cluster

The shrinking of a cluster may be required when it is necessary to reallocate cluster hardware to other needs.

## Options for Shrinking a Cluster

Cluster shrinking can involve the either the removal of some of the SSDs assigned to the system, or the removal of hosts from the system.

To perform these operations, the following commands are available:

1. Listing all the drives and their states, in order to obtain a view of currently allocated resources and their status
2. Deactivating drives, which can be used  for either removing a subset of the SSDs allocated, or as the first step before removing a host.
3. Deactivating hosts, which can be used after its drives has been deactivated, in preparation for the removal of the host
4. Removing hosts in order to complete the cluster shrinking.

### Listing Drives and Their States

**Command:** `weka cluster drive`

Using this command displays a list of all the drives in the cluster and their status.

### Deactivating a Drive

**Command:** `weka cluster drive deactivate`

Running the deactivation command will redistribute the stored data on the remaining drives and can be performed on multiple drives. 

{% hint style="info" %}
**Note:** When running the `weka cluster drive` command, the deactivated drives will still appear in the list.

**Note:** It is not possible to deactivate a drive if it will lead to an unstable state, i.e. if the [system capacity](overview/ssd-capacity-management.md) after drive deactivation is insufficient for the currently provisioned filesystems SSD capacity.
{% endhint %}

Drive deactivation starts an asynchronous process known as phasing out, which is a gradual redistribution of the data between the remaining drives in the system. On completion, the phased-out drive is in an inactive state i.e., not in use by the Weka system, but still appearing in the list of drives.

{% hint style="info" %}
**Note:** Running the `weka cluster drive` command will display whether the redistribution is still being performed.
{% endhint %}

To remove a drive, run the following command line:`weka cluster drive deactivate <drive-uuids>…`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `uuids` | Comma-separated strings | Comma-separated drive identifiers | . | Yes |  |

### Deactivating an Entire Host

The following command is used as the first step when seeking to shrink a cluster.

**Command:** `weka cluster host deactivate`

Running this command is mandatory to deactivate the relevant host drives prior to removal of the host, thereby terminating the IO participation of the host in the cluster. All the host drives must have been previously deactivated.

`weka cluster host deactivate <host-ids>…`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `host-ids` | Comma-separated strings | Comma-separated host identifiers | . | Yes |  |

### Removing a Host

**Command:** `weka cluster host remove <host-id>`

Running this command will eliminate the host from the cluster, i.e., the host will switch to the stem mode after the removal, at which point it can be reallocated either to another cluster or another purpose.

To remove the host from the cluster, run the following command:

`weka cluster host remove <host-id>…`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
| `host-id` | Comma-separated strings | Comma-separated host identifiers | . | Yes |  |

