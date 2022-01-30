---
description: >-
  This page describes how to attach/detach object stores to filesystems using
  the GUI and the CLI.
---

# Attaching/Detaching Object Stores to/from Filesystems

## Overview

### Attaching a Local Object-Store Bucket to a Filesystem

Two local object-store buckets can be attached to a filesystem, but only one of the buckets will be writable. A `local` object-store bucket is used for both tiering and snapshots. When attaching a new object-store bucket to an already tiered filesystem, the existing object-store bucket becomes read-only, and the new object-store bucket is read/write. Multiple object stores allow a range of use cases, including migration to different object stores, scaling of object store capacity, and increasing the total tiering capacity of filesystems.

When attaching an object store to a non-tiered filesystem, the filesystem becomes tiered.

### Detaching a Local Object-Store Bucket from a Filesystem

Detaching a local object-store bucket from a filesystem migrates the filesystem data residing in the object-store bucket either to the writable object-store bucket (if one exists) or to the SSD, as described below. When detaching, the background task of detaching the object-store bucket begins. Detaching can be a long process, depending on the amount of data and the load on the object stores. For more information, refer to [Background Tasks](../../usage/background-tasks.md).

{% hint style="warning" %}
**Note:** Detaching an object-store bucket is irreversible. Re-attaching the bucket is considered as re-attaching a new bucket regardless of the data that may still be there.
{% endhint %}

#### Migrating to a Different Object Store

When detaching from a filesystem tiered to two object-store buckets, only the read-only object-store bucket can be detached. In such cases, the background task will copy the relevant data to the writable object-store.

#### Un-tiering a Filesystem

Detaching from a filesystem tiered to one object-store bucket will un-tier the filesystem and copy the data back to the SSD.

{% hint style="info" %}
**Note:** The SSD must have sufficient capacity, i.e., the allocated SSD capacity should be at least the total capacity used by the filesystem.
{% endhint %}

On completion of detaching, the object-store bucket does not appear under the filesystem when using the `weka fs` command. However, it still appears under the object store and can be removed if it is not being used by any other filesystem. The data in the read-only object-store bucket remains in the object-store bucket for backup purposes. If this is unnecessary or the reclamation of object store space is required, it is possible to delete the object-store bucket.

{% hint style="info" %}
**Note:** Before deleting an object-store bucket, remember to take into account data from another filesystem or data not relevant to the Weka system on the object-store bucket.
{% endhint %}

{% hint style="warning" %}
**Note:** After the migration process is done, while relevant data is migrated, old snapshots (and old locators) reside on the old object-store bucket. To recreate snapshots locators on the new object-store bucket, snapshots should be re-uploaded to the (new) object-store bucket.
{% endhint %}

### Migration Considerations

When migrating data (using the detach operation) you would like to copy only the necessary data (to reduce migration time and capacity), however, you may want to keep snapshots in the old object-store bucket. For that follow these steps:

1. Attach a new object-store bucket (old object-store bucket becomes read-only).
2. Delete any snapshot which doesn't need to be migrated - this will keep the snapshot on the old bucket, but will not migrate its data to the new bucket.
3. Detach the old object-store bucket

{% hint style="info" %}
**Note:** performing these steps in a different order might result in either the snapshots are completely deleted from any of the object-store buckets or are already in the migration process (and cannot be deleted until the migration is done).
{% endhint %}

### Attaching a Remote Object-Store Bucket

One remote object-store bucket can be attached to a filesystem. A `remote` object-store bucket is used for backup only, and only snapshots are uploaded to it using [Snap-2-Object](../snap-to-obj.md). The snapshot uploads are incremental to the previous one.&#x20;

{% hint style="info" %}
**Note:** Please contact the Weka Customer Support Team before you attach a remote object-store bucket.
{% endhint %}

### Detaching a Remote Object-Store Bucket

Detaching a remote object-store bucket from a filesystem keeps the backup data within the bucket intact. It is still possible to use these [snapshots for recovery](../snap-to-obj.md#creating-a-filesystem-from-an-uploaded-snapshot).

## Attaching/Detaching Object-Store Buckets

### Attaching/Detaching Object-Store Buckets Using the GUI

To attach a new object store to a filesystem, select the filesystem in the main filesystem/filesystem group view screen and click the Attach Object Store button.

![Attach Object Store to Filesystem Screen](<../../.gitbook/assets/Attach obs select 3.5.png>)

The Attach Object Store to Filesystem dialog box will be displayed.

![Attach Object Store to Filesystem Dialog Box](<../../.gitbook/assets/Attach obs dialog 3.5.png>)

Select the object store to attach and click Attach.

To detach an object store from a filesystem, select the filesystem in the main filesystem/filesystem group view screen. A list of all attached object stores will be displayed in the Attached Object Stores dialog box.

![Attached Object Stores Dialog Box](<../../.gitbook/assets/FS obs view 3.5.png>)

Click the Detach button next to the relevant object store to be detached. If more than one object store is attached, the Detach Object Store dialog box will be displayed as follows:

![Detach Object Store Dialog Box](<../../.gitbook/assets/Detach obs dialog 3.5.png>)

Click Yes to detach the object store from the filesystem.

If there is only one object store attached, detaching will un-tier the filesystem, and the following Detach Object Store and Untier Filesystem dialog box will be displayed:

![Detach Object Store and Untier Filesystem Dialog Box](<../../.gitbook/assets/Detach Untier 3.5.png>)

Since object stores usually expand the filesystem capacity, the un-tiering of a filesystem requires adjustment of its total capacity. It is possible to increase the SSD capacity to match the current total capacity; reduce the total filesystem capacity to match the SSD capacity or used capacity (the decrease option depends on the used capacity); or configure a different value.

{% hint style="info" %}
**Note:** Used capacity should be taken into account. Since un-tiering takes time to propagate the data from the object store to the SSD, when un-tiering an active filesystem it is recommended to adjust to a higher value than the used capacity, in order to accommodate the additional writes during the detaching process.
{% endhint %}

The following options are available in the Solution drop-down list:

![Un-tier Adjusting Capacity Options](<../../.gitbook/assets/Detach Untier Used options 3.5.png>)

Select the desired option and click Continue in the Detach Object Store and Untier Filesystem dialog box. A summary dialog box of the system operations will be displayed.

![Detach Object Store and Un-tier Summary Dialog Box](<../../.gitbook/assets/Detach Untier progress 3.5.png>)

To confirm the operation, click Detach.

### Attaching/Detaching Object-Store Buckets Using the CLI

#### **Attaching an Object-Store Bucket Using the CLI**

**Command:** `weka fs tier s3 attach`

To attach an object store to a filesystem, use the following command:

`weka fs tier s3 attach <fs-name> <obs-name> [--mode mode]`

**Parameters in Command Line**

| **Name**   | **Type** | **Value**                                                 | **Limitations**                                                                                         | **Mandatory** | **Default** |
| ---------- | -------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `fs-name`  | String   | Name of the filesystem to be attached to the object store | Must be a valid name                                                                                    | Yes           | ​           |
| `obs-name` | String   | Name of the object store to be  attached                  | Must be a valid name                                                                                    | Yes           |             |
| `mode`     | String   | `local` or `remote`                                       | A `local` bucket can only be attached as `local` and a `remote` bucket can only be attached as `remote` | No            | `local`     |

#### **Detaching an Object-Store Bucket Using the CLI**

**Command:** `weka fs tier s3 detach`

To detach an object store from a filesystem, use the following command:

`weka fs tier s3 detach <fs-name> <obs-name>`

**Parameters in Command Line**

| **Name**   | **Type** | **Value**                                                   | **Limitations**      | **Mandatory** | **Default** |
| ---------- | -------- | ----------------------------------------------------------- | -------------------- | ------------- | ----------- |
| `fs-name`  | String   | Name of the filesystem to be detached from the object store | Must be a valid name | Yes           | ​           |
| `obs-name` | String   | Name of the object store to be  detached                    | Must be a valid name | Yes           |             |

{% hint style="info" %}
**Note:** To [recover from a snapshot](../snap-to-obj.md#creating-a-filesystem-from-a-snapshot-using-the-cli) that has been uploaded when two `local` object stores have been attached, use the `--additional-obs` parameter in `weka fs download` command. The primary object-store should be the one where the locator has been uploaded to
{% endhint %}
