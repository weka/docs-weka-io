---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object store.
---

# Manage Snap-To-Object using the CLI

Using the CLI, you can:

* [Upload a  snapshot](snap-to-obj-1.md#upload-a-snapshot)
* [Create a filesystem from an uploaded snapshot](snap-to-obj-1.md#create-a-filesystem-from-an-uploaded-snapshot)

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

Use the following command line to create a filesystem from an existing snapshot:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--additional-obs additional-obs]`

**Parameters**

| **Name**         | **Type** | **Value**                                                                                                                                                                                                                                                    | **Limitations**                                                                              | **Mandatory** | **Default** |
| ---------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `name`           | String   | Name of the filesystem to be created                                                                                                                                                                                                                         |                                                                                              | Yes           |             |
| `group-name`     | String   | Name of the filesystem group in which the new filesystem will be placed                                                                                                                                                                                      |                                                                                              | Yes           |             |
| `total-capacity` | Capacity | The total capacity of the downloaded filesystem                                                                                                                                                                                                              |                                                                                              | Yes           |             |
| `ssd-capacity`   | Capacity | SSD capacity of the downloaded filesystem                                                                                                                                                                                                                    |                                                                                              | Yes           |             |
| `obs-bucket`     | String   | Object store name for tiering                                                                                                                                                                                                                                |                                                                                              | Yes           |             |
| `locator`        | String   | Object store locator obtained from a previously successful snapshot upload                                                                                                                                                                                   |                                                                                              | Yes           |             |
| `additional-obs` | String   | An additional object-store name. In case the data to recover resides in two object stores (a second object-store attached to the filesystem, and the filesystem has not undergone full migration). This object-store will be attached in a `read-only` mode. | The snapshot locator must reside in the primary object-store supplied in the `obs` parameter | No            |             |

The `locator` is either a locator saved previously for disaster scenarios or can be obtained using the `weka fs snapshot` command on a system with a live filesystem with snapshots.

{% hint style="info" %}
**Note:** Due to the bandwidth characteristics and potential costs when interacting with remote object stores it is not allowed to download a filesystem from a remote object-store bucket. If a snapshot on a local object-store bucket exists it is advisable to use that one, otherwise, follow the procedure in [Recover from a remote snapshot](./#recover-from-a-remote-snapshot).&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** For encrypted filesystem, when downloading, the same KMS master key must be used to decrypt the snapshot data. For more information, see the [KMS Management](../kms-management/#overview) section.
{% endhint %}
