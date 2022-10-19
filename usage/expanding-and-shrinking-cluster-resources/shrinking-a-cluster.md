---
description: >-
  This page describes the procedures involved in the shrinking of a cluster,
  which may be required when it is necessary to reallocate cluster hardware.
---

# Shrink a Cluster

## Shrink cluster options

Cluster shrinking can involve either the removal of some of the assigned SSDs or the removal of containers from the system. The following operations are available:

1. List all the drives and their states, to receive a view of currently-allocated resources and their status.
2. Deactivate drives as the first step before removing a container.
3. Remove a subset of SSD drives allocated for the cluster.
4. Deactivate containers, which can be used after deactivating drives in preparation for the removal of the container.
5. Remove containers to complete the cluster shrinking.

## List drives and their sees

**Command:** `weka cluster drive`

Use this command to display a list of all the drives in the cluster and their status.

## Deactivate a drive

**Command:** `weka cluster drive deactivate`

Running this deactivation command will redistribute the stored data on the remaining drives and can be performed on multiple drives.

{% hint style="info" %}
**Note:** After running this command, the deactivated drives will still appear in the list.

It is not possible to deactivate a drive if it will lead to an unstable state, i.e., if the [system capacity](../../overview/ssd-capacity-management.md) after drive deactivation is insufficient for the SSD capacity of currently-provisioned filesystems.
{% endhint %}

Drive deactivation starts an asynchronous process known as phasing out, which is a gradual redistribution of the data between the remaining drives in the system. On completion, the phased-out drive is in an inactive state, i.e., not in use by the Weka system, but still appearing in the list of drives.

{% hint style="info" %}
**Note:** Running the `weka cluster drive` command will display whether the redistribution is still being performed.
{% endhint %}

To deactivate a drive, run the following command:

`weka cluster drive deactivate <uuids>`

**Parameters**

| **Name** | **Type**                | **Value**                         | **Limitations** | **Mandatory** | **Default** |
| -------- | ----------------------- | --------------------------------- | --------------- | ------------- | ----------- |
| `uuids`  | Comma-separated strings | Comma-separated drive identifiers |                 | Yes           |             |

## Remove a drive

**Command:** `weka cluster drive remove`

This command is used to completely remove a drive from the cluster. After removal, the drive will not be recoverable.

To remove a drive, run the following command:

`weka cluster drive remove <uuids>`

**Parameters**

| **Name** | **Type**                | **Value**                         | **Limitations** | **Mandatory** | **Default** |
| -------- | ----------------------- | --------------------------------- | --------------- | ------------- | ----------- |
| `uuids`  | Comma-separated strings | Comma-separated drive identifiers |                 | Yes           |             |

## Deactivate an entire container

**Command:** `weka cluster container deactivate`

This command is used as the first step when shrinking a cluster. Running this command automatically deactivates all the drives in the container.

To deactivate an entire container, run the following command:

`weka cluster container deactivate <container-ids> [--allow-unavailable]`

**Parameters**

| **Name**            | **Type**                 | **Value**                                      | **Limitations**                                                       | **Mandatory** | **Default** |
| ------------------- | ------------------------ | ---------------------------------------------- | --------------------------------------------------------------------- | ------------- | ----------- |
| `container-ids`     | Space-separated integers | Space-separated container identifiers          |                                                                       | Yes           |             |
| `allow-unavailable` | Boolean                  | Allow deactivation of an unavailable container | If the container returns, it will join the cluster in an active state | No            | No          |

## Remove a container

**Command:** `weka cluster` c`ontainer remove`

Running this command removes the container from the cluster. The container switches to the [stem mode](../../overview/glossary.md#stem-mode) so that it can be reallocated to another cluster or purpose.

To remove the container from the cluster, run the following command:

`weka cluster container remove <container-id>`

**Parameters**

| **Name**       | **Type**                | **Value**                             | **Limitations** | **Mandatory** | **Default** |
| -------------- | ----------------------- | ------------------------------------- | --------------- | ------------- | ----------- |
| `container-id` | Comma-separated strings | Comma-separated container identifiers |                 | Yes           |             |
