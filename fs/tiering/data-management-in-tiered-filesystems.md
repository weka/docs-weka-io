---
description: >-
  This page describes the system behavior when tiering, accessing or deleting
  data in tiered filesystems.
---

# Data Management in Tiered Filesystems

## Overview

In tiered filesystems, the hot data resides in SSDs and warm data resides in object stores. When tiering, the Weka system is highly efficient in terms of:

* Tiering only the subset of a file that is not accessed frequently, and not keeping infrequently-accessed portions of a file on SSDs.
* Gathering several subsets of different files and tiering them together to the object store (usually 64 MB objects), thereby providing a huge performance boost when working with object stores.
* When accessing data that resides just on the object store, only the required portion is retrieved from the object-store, regardless of the entire object it was tiered as part of it.

When data is logically freed, it can be reclaimed. Data is logically freed when it has been modified or deleted and is not being used by any snapshot.

{% hint style="info" %}
**Note:** Only data that is not logically freed is taken into account for licensing purposes.
{% endhint %}

## Space Reclamation in Tiered Filesystems

### SSD Space Reclamation

For logically freed data that resides on SSD, the Weka system immediately deletes the data from the SSD (leaving the physical space reclamation for the SSD erasure technique).

### Object Store Space Reclamation

For object store, merely deleting the data from the object store is insufficient, since it might involve downloading up to 64 MB object and re-uploading most of the data just for a very small portion (even 4 KB) of the object.

To overcome this inefficiency, the Weka system reclaims object-store space in the background and will allow for 7%-13% more object store usage than required. In this way, for each filesystem that exceeds this 13% threshold, the Weka system will only re-upload objects for which logically more than 5% of them are freed (and will gather those objects in a full 64 MB object again). Moreover, the Weka system will stop the reclamation process if the filesystem consumes less than 7% of its object store space, to avoid high writes amplifications and allow some time for higher portions of the 64 BM objects to become logically free. This ensures that the object storage will not be overloaded when just reclaiming small portions of space.

While the steady-state of a filesystem requires up to 13% more raw capacity in the object store, this percentage may increase when there is a load on the object store (which takes precedence) and when there is a frequent deletion of data/snapshots. Over time, it will return to the normal threshold after the load/burst is reduced.

{% hint style="info" %}
**Note:** If tuning of the system interaction with the object store is required (such as object size, reclamation threshold numbers, or the object store space reclamation is not fast enough for the workload), contact the Weka Support Team.
{% endhint %}

{% hint style="info" %}
**Note:** Object store space reclamation is only relevant for object-store buckets used for tiering (defined as `local`) and not for buckets used for backup-only (defined as `remote`).
{% endhint %}

## Object Tagging

{% hint style="info" %}
**Note:** To enable the object-tagging capability the Weka object-store entity should be configured as such using `enable-upload-tags` parameter in either of the `weka fs tier s3 add/update` CLI commands.
{% endhint %}

Whenever Weka uploads objects to the object-store, it classifies them using tags. It is useful to carry further lifecycle management rules via the object-store based on these tags (e.g., transfer objects of a specific filesystem to/from Glacier).

| **Tag**        | **Description**                                                                                                                                                                                 |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `wekaBlobType` | <p>The Weka-internal type representation of the object. One of:  </p><p><code>DATA</code>, <code>METADATA</code>, <code>METAMETADATA</code>, <code>LOCATOR</code>, <code>RELOCATIONS</code></p> |
| `wekaFsId`     | The filesystem ID (a combination of the filesystem ID and the cluster GUID uniquely identifies a filesystem).                                                                                   |
| `wekaGuid`     | The cluster GUID                                                                                                                                                                                |
| `wekaFsName`   | The name of the filesystem that uploaded this object.                                                                                                                                           |

The object-store must support S3 object-tagging and might require additional permissions to use object tagging.

The following extra permissions are required when using AWS S3:

* `s3:PutObjectTagging`&#x20;
* `s3:DeleteObjectTagging`

{% hint style="info" %}
**Note:** Additional charges may apply when using AWS S3.
{% endhint %}
