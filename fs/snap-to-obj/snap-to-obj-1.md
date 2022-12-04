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

| **Name**      | **Type** | **Value**                         | **Limitations**                                      | **Mandatory**                                          | **Default**                                             |
| ------------- | -------- | --------------------------------- | ---------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------- |
| `file-system` | String   | Name of the filesystem            |                                                      | Yes                                                    |                                                         |
| `snapshot`    | String   | Name of the snapshot to upload    | Must be a snapshot of the `<file-system>` filesystem | Yes                                                    |                                                         |
| `site`        | String   | Location for the snapshot  upload | `local` or `remote`                                  | Only if both `local` and `remote` buckets are attached | Auto selected if only one bucket for upload is attached |

## Create a filesystem from an uploaded snapshot

**Command:** `weka fs download`

Use the following command line to create (or recreate) a filesystem from an existing snapshot:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--additional-obs additional-obs] [--snapshot-name snapshot-name] [--access-point access-point]`

**Parameters**

| **Name**         | **Type** | **Value**                                                                                                                                                                                                                                                    | **Limitations**                                                                              | **Mandatory** | **Default**                |
| ---------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- | ------------- | -------------------------- |
| `name`           | String   | Name of the filesystem to be created                                                                                                                                                                                                                         |                                                                                              | Yes           |                            |
| `group-name`     | String   | Name of the filesystem group in which the new filesystem will be placed                                                                                                                                                                                      |                                                                                              | Yes           |                            |
| `total-capacity` | Capacity | The total capacity of the downloaded filesystem                                                                                                                                                                                                              |                                                                                              | Yes           |                            |
| `ssd-capacity`   | Capacity | SSD capacity of the downloaded filesystem                                                                                                                                                                                                                    |                                                                                              | Yes           |                            |
| `obs-bucket`     | String   | Object store name for tiering                                                                                                                                                                                                                                |                                                                                              | Yes           |                            |
| `locator`        | String   | Object store locator obtained from a previously successful snapshot upload                                                                                                                                                                                   |                                                                                              | Yes           |                            |
| `additional-obs` | String   | An additional object-store name. In case the data to recover resides in two object stores (a second object-store attached to the filesystem, and the filesystem has not undergone full migration). This object-store will be attached in a `read-only` mode. | The snapshot locator must reside in the primary object-store supplied in the `obs` parameter | No            |                            |
| `snapshot-name`  | String   | The downloaded snapshot name.                                                                                                                                                                                                                                |                                                                                              | No            | The uploaded snapshot name |
| `access-point`   | String   | The downloaded snapshot access point.                                                                                                                                                                                                                        |                                                                                              | No            | The uploaded access point. |

The `locator` can be a locator saved previously for disaster scenarios, or you can obtain the `locator` using the `weka fs snapshot` command on a system with a live filesystem with snapshots.

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

If you need to download a snapshot that is earlier than the latest downloaded one, for example, when you need one of the daily incremental snapshots after the weekly incremental snapshot was downloaded, add the `--allow-non-chronological` flag to download it anyway.
{% endhint %}

**Parameters**

| **Name**      | **Type** | **Value**                                                                  | **Limitations** | **Mandatory** | **Default** |
| ------------- | -------- | -------------------------------------------------------------------------- | --------------- | ------------- | ----------- |
| `file-system` | String   | Name of the filesystem                                                     |                 | Yes           |             |
| `locator`     | String   | Object store locator obtained from a previously successful snapshot upload |                 | Yes           |             |



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
