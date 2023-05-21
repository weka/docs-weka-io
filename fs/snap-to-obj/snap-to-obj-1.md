---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object store.
---

# Manage Snap-To-Object using the CLI

Using the CLI, you can:

* [Upload a  snapshot](snap-to-obj-1.md#upload-a-snapshot)
* [Create a filesystem from an uploaded snapshot](snap-to-obj-1.md#create-a-filesystem-from-an-uploaded-snapshot)
* [Manage incremental snapshots](snap-to-obj-1.md#manage-incremental-snapshots)
* [Recover from a remote snapshot](snap-to-obj-1.md#recover-from-a-remote-snapshot)

## Upload a  snapshot

**Command:** `weka fs snapshot upload`

Use the following command line to upload an existing snapshot:

`weka fs snapshot upload <file-system> <snapshot> [--site site]`

**Parameters**

| Name            | Value                                                                                                                                                                                              | Default                                                  |
| --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `file-system`\* | Name of the filesystem                                                                                                                                                                             |                                                          |
| `snapshot`\*    | <p>Name of the snapshot of the <code>&#x3C;file-system></code> filesystem to upload.<br></p>                                                                                                       |                                                          |
| `site`\*        | <p>Location for the snapshot  upload.<br>Mandatory only if both <code>local</code> and <code>remote</code> buckets are attached.<br>Possible values: <code>local</code> or <code>remote</code></p> | Auto-selected if only one bucket for upload is attached. |

## Create a filesystem from an uploaded snapshot

**Command:** `weka fs download`

Use the following command line to create (or recreate) a filesystem from an existing snapshot:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--additional-obs additional-obs] [--snapshot-name snapshot-name] [--access-point access-point]`

When creating a filesystem from a snapshot, a background cluster task automatically prefetches its metadata, providing better latency for metadata queries.

**Parameters**

| Name               | Value                                                                                                                                                                                                                                                                                                                                                                           | Default                     |
| ------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------- |
| `name`\*           | Name of the filesystem to create.                                                                                                                                                                                                                                                                                                                                               |                             |
| `group-name`\*     | Name of the filesystem group in which the new filesystem is placed.                                                                                                                                                                                                                                                                                                             |                             |
| `total-capacity`\* | The total capacity of the downloaded filesystem.                                                                                                                                                                                                                                                                                                                                |                             |
| `ssd-capacity`\*   | SSD capacity of the downloaded filesystem.                                                                                                                                                                                                                                                                                                                                      |                             |
| `obs-bucket`\*     | Object store name for tiering.                                                                                                                                                                                                                                                                                                                                                  |                             |
| `locator`\*        | Object store locator obtained from a previously successful snapshot upload.                                                                                                                                                                                                                                                                                                     |                             |
| `additional-obs`   | <p>An additional object-store name.<br>If the data to recover reside in two object stores (a second object store attached to the filesystem, and the filesystem has not undergone full migration), this object store is attached in a <code>read-only</code> mode.<br>The snapshot locator must be in the primary object store specified in the <code>obs</code> parameter.</p> |                             |
| `snapshot-name`    | The downloaded snapshot name.                                                                                                                                                                                                                                                                                                                                                   | The uploaded snapshot name. |
| `access-point`     | The downloaded snapshot access point.                                                                                                                                                                                                                                                                                                                                           | The uploaded access point.  |

The `locator` can be a previously saved locator for disaster scenarios, or you can obtain the `locator` using the `weka fs snapshot` command on a system with a live filesystem with snapshots.

If you need to pause and resume the download process, use the command: `weka cluster task pause / resume`. To abort the download process, delete the downloaded filesystem directly. For details, see [Manage background tasks](../../usage/background-tasks/#managing-background-tasks).

{% hint style="info" %}
**Note:** Due to the bandwidth characteristics and potential costs when interacting with remote object stores it is not allowed to download a filesystem from a remote object-store bucket. If a snapshot on a local object-store bucket exists, it is advisable to use that one. Otherwise, follow the procedure in [Recover from a remote snapshot](./#recover-from-a-remote-snapshot).&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** For encrypted filesystem, when downloading, you must use the same KMS master key to decrypt the snapshot data. For more information, see the [KMS Management](../../usage/security/kms-management/#overview) section.
{% endhint %}

## Manage incremental snapshots

The workflow to manage the incremental snapshots includes:

1. Upload snapshots using, for example, the snapshots scheduler. See [Snapshot management](../../appendix/snapshot-management.md).
2. Download the incremental snapshot (described below).
3. Restore a specific snapshot to a filesystem. See [Restore a snapshot to a filesystem or another snapshot](../snapshots/snapshots-1.md#restore-a-snapshot-to-a-filesystem-or-another-snapshot).

### Download an incremental snapshot

**Command:** `weka fs snapshot download`

Use the following command line to download an incremental snapshot. This command is only relevant for snapshots uploaded from a system of version 4.0 and higher:

&#x20;`weka fs snapshot download <file-system> <locator>`

{% hint style="warning" %}
Make sure to download incremental snapshots in chronological order. Non-chronological snapshots are inefficient and are not incremental.&#x20;

If you need to download a snapshot earlier than the latest downloaded one, for example, when you need one of the daily incremental snapshots after the weekly incremental snapshot was downloaded, add the `--allow-non-chronological` flag to download it anyway.
{% endhint %}

**Parameters**

| Name            | Value                                                                       |
| --------------- | --------------------------------------------------------------------------- |
| `file-system`\* | Name of the filesystem.                                                     |
| `locator`\*     | Object store locator obtained from a previously successful snapshot upload. |

If you need to pause and resume the download process, use the command: `weka cluster task pause / resume`. To abort the download process, delete the downloaded snapshot directly. For details, see [Manage background tasks](../../usage/background-tasks/#managing-background-tasks).

**Related topics**

[#incremental-snapshots](./#incremental-snapshots "mention")

## Recover from a remote snapshot

When recovering a snapshot residing on a remote object store, it is required to define the object store bucket containing the snapshot as a local bucket.

A remote object store has restrictions over the download, and we want to use a different local object store due to the QoS reasons explained in [Manage object stores](../managing-object-stores/#overview).

To recover a snapshot residing on a remote object store, create a new filesystem from this snapshot as follows:

1. Add a new local object-store, using `weka fs tier obs add` CLI command.
2. Add a local object-store bucket, referring to the bucket containing the snapshot to recover, using `weka fs tier s3 add.`
3. Download the filesystem, using `weka fs download.`
4. If the recovered filesystem should also be tiered, add a local object store bucket for tiering using `weka fs tier s3 add.`
5. Detach the initial object store bucket from the filesystem.
6. Assuming you want a remote backup to this filesystem, attach a remote bucket to the filesystem.
7. Remove the local object store bucket and local object store created for this procedure.
