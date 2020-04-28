---
description: >-
  This page describes the procedures involved in the shrinking of a cluster,
  which may be required when it is necessary to reallocate cluster hardware.
---

# Shrinking a Cluster

## Options for Shrinking a Cluster

Cluster shrinking can involve either the removal of some of the assigned SSDs or the removal of hosts from the system. The following operations are available:

1. Listing all the drives and their states, in order to receive a view of currently-allocated resources and their status.
2. Deactivating drives as the first step before removing a host.
3. Removing \(a subset of\) SSD drives allocated for the cluster.
4. Deactivating hosts, which can be used after deactivating drives in preparation for the removal of the host.
5. Removing hosts in order to complete the cluster shrinking.

## Listing Drives and Their States

**Command:** `weka cluster drive`

Use this command to display a list of all the drives in the cluster and their status.

## Deactivating a Drive

**Command:** `weka cluster drive deactivate`

Running this deactivation command will redistribute the stored data on the remaining drives and can be performed on multiple drives.

{% hint style="info" %}
**Note:** After running this command, the deactivated drives will still appear in the list.

**Note:** It is not possible to deactivate a drive if it will lead to an unstable state, i.e., if the [system capacity](../../overview/ssd-capacity-management.md) after drive deactivation is insufficient for the SSD capacity of currently-provisioned filesystems.
{% endhint %}

Drive deactivation starts an asynchronous process known as phasing out, which is a gradual redistribution of the data between the remaining drives in the system. On completion, the phased-out drive is in an inactive state, i.e., not in use by the Weka system, but still appearing in the list of drives.

{% hint style="info" %}
**Note:** Running the `weka cluster drive` command will display whether the redistribution is still being performed.
{% endhint %}

To deactivate a drive, run the following command:

`weka cluster drive deactivate <uuids>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `uuids` | Comma-separated strings | Comma-separated drive identifiers |  | Yes |  |

## Removing a Drive

**Command:** `weka cluster drive remove`

This command is used to completely remove a drive from the cluster. After removal, the drive will not be recoverable and the drive entries can be reused during `weka drive scan` for new drives.

To remove a drive, run the following command:

`weka cluster drive remove <uuids>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `uuids` | Comma-separated strings | Comma-separated drive identifiers |  | Yes |  |

## Deactivating an Entire Host

**Command:** `weka cluster host deactivate`

This command is used as the first step when seeking to shrink a cluster. Running it is mandatory to deactivate the relevant host drives prior to removal of the host, thereby terminating the IO participation of the host in the cluster. All the host drives must first be deactivated.

To deactivate an entire host, run the following command:

`weka cluster host deactivate <host-ids>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-ids` | Comma-separated strings | Comma-separated host identifiers |  | Yes |  |
| `--allow-unavailable-host` | Boolean | Allow deactivation of an unavailable host | If host is returned, it will join the cluster in active state | No | No |

## Removing a Host

**Command:** `weka cluster host remove`

Running this command will eliminate the host from the cluster, i.e., the host will switch to the [stem mode](../../overview/glossary.md#stem-mode) after the removal, at which point it can be reallocated either to another cluster or purpose.

To remove the host from the cluster, run the following command:

`weka cluster host remove <host-id>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `host-id` | Comma-separated strings | Comma-separated host identifiers |  | Yes |  |

