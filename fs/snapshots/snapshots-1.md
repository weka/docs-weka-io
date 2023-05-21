---
description: This page describes how to manage snapshots using the CLI.
---

# Manage snapshots using the CLI



Using the CLI, you can:

* [Create a snapshot](snapshots-1.md#create-a-snapshot)
* [Delete a snapshot](snapshots-1.md#delete-a-snapshot)
* [Restore a snapshot to a filesystem or another snapshot](snapshots-1.md#restore-a-snapshot-to-a-filesystem-or-another-snapshot)
* [Update a snapshot](snapshots-1.md#update-a-snapshot)

Consider the following when working with snapshots:

* When moving a file in or out of a snapshot directory, or between snapshots, the kernel implements the move operation as a copy operation, similar to moving a file between two different filesystems. Such operations for directories fail.
* If symbolic links are accessed via the `.snapshots` directory, the symlinks with absolute paths can lead to the current filesystem. Consequently, depending on the usage, it may be preferable not to follow symlinks or to use relative paths.

{% hint style="info" %}
The `.snapshots` directory is not listed. Running `ls` on the root of the filesystem does not show the `.snapshots` directory. However, it can be explicitly accessed, e.g. using the `cd .snapshots` command.&#x20;
{% endhint %}

## Create a snapshot

**Command:** `weka fs snapshot create`

Use the following command line to add a snapshot:

`weka fs snapshot create <file-system> <name> [--access-point access-point] [--source-snap=<source-snap>] [--is-writable]`

**Parameters**

| **Name**       | **Type** | **Value**                                                                                                              | **Limitations**      | **Mandatory** | **Default**                                                                                                                                                                                                                                                                                             |
| -------------- | -------- | ---------------------------------------------------------------------------------------------------------------------- | -------------------- | ------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`  | String   | A valid filesystem identifier                                                                                          | Must be a valid name | Yes           | ​                                                                                                                                                                                                                                                                                                       |
| `name`         | String   | Unique name for filesystem snapshot                                                                                    | Must be a valid name | Yes           |                                                                                                                                                                                                                                                                                                         |
| `access-point` | String   | Name of the newly-created directory for filesystem-level snapshots, which serves as the access point for the snapshots | Must be a valid name | No            | Controlled by `weka fs snapshot access-point-naming-convention update <date/name>.` By default it is `<date>` format: `@GMT_%Y.%m.%d-%H.%M.%S` which is compatible with [windows previous versions format for SMB](../../additional-protocols/smb-support/#integration-with-windows-previous-versions). |
| `source-snap`  | String   | Must be an existing snapshot                                                                                           | Must be a valid name | No            | The snapshot name of the specified filesystem.                                                                                                                                                                                                                                                          |
| `is-writable`  | Boolean  | Sets the created snapshot to be writable                                                                               |                      | No            | False                                                                                                                                                                                                                                                                                                   |

## Delete a snapshot

**Command:** `weka fs snapshot delete`

Use the following command line to delete a snapshot:

`weka fs snapshot delete <file-system> <name>`

**Parameters**

| **Name**      | **Type** | **Value**                           | **Limitations**      | **Mandatory** | **Default** |
| ------------- | -------- | ----------------------------------- | -------------------- | ------------- | ----------- |
| `file-system` | String   | A valid filesystem identifier       | Must be a valid name | Yes           | ​           |
| `name`        | String   | Unique name for filesystem snapshot | Must be a valid name | Yes           |             |

{% hint style="warning" %}
**Note:** A snapshot deletion cannot happen in parallel to a snapshot upload to the same filesystem. Since uploading a snapshot to a remote object store might take a while, it is advisable to delete the desired snapshots before uploading to the remote object store.&#x20;

Also, note that this becomes more important when uploading snapshots to both local and remote object stores. While local and remote uploads can progress in parallel, consider the case of a remote upload in progress, then a snapshot is deleted, and later a snapshot is uploaded to the local object store. In this scenario, the local snapshot upload waits for the pending deletion of the snapshot (which happens only once the remote snapshot upload is done).
{% endhint %}

## Restore a snapshot to a filesystem or another snapshot

**Commands:** `weka fs restore` or `weka fs snapshot copy`

Use the following command line to restore a filesystem from a snapshot:

`weka fs restore <file-system> <source-name> [--preserved-overwritten-snapshot-name=preserved-overwritten-snapshot-name] [--preserved-overwritten-snapshot-access-point=preserved-overwritten-snapshot-access-point]`

Use the following command line to restore a snapshot to another snapshot:

`weka fs snapshot copy <file-system> <source-name> <destination-name> [--preserved-overwritten-snapshot-name=preserved-overwritten-snapshot-name] [--preserved-overwritten-snapshot-access-point=preserved-overwritten-snapshot-access-point]`

**Parameters**

| Name                                          | Value                                                                                                                                                                                                                                                             | Default                                                                                                                                                                                             |
| --------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `file-system`\*                               | A valid filesystem identifier                                                                                                                                                                                                                                     | ​                                                                                                                                                                                                   |
| `source-name`\*                               | Unique name for the source of the snapshot                                                                                                                                                                                                                        |                                                                                                                                                                                                     |
| `destination-`\*`name`                        | Destination name to which the existing snapshot should be copied to.                                                                                                                                                                                              |                                                                                                                                                                                                     |
| `preserved-overwritten-snapshot-name`         | <p>A new name for the overwritten snapshot to preserve, thus allowing the IO operations continuity to the filesystem.<br>If not specified, the original snapshot or active filesystem is overwritten, and IO operations to an existing filesystem might fail.</p> |                                                                                                                                                                                                     |
| `preserved-overwritten-snapshot-access-point` | A directory that serves as the access point for the preserved overwritten snapshot.                                                                                                                                                                               | If the `preserved-overwritten-snapshot-name` parameter is specified, but the `preserved-overwritten-snapshot-access-point`parameter is not, it is created automatically based on the snapshot name. |

{% hint style="warning" %}
**Note:** When restoring a filesystem from a snapshot (or copying over an existing snapshot), the filesystem data and metadata are changed. If you do not specify the `preserved-overwritten-snapshot-name` parameter, ensure IOs to the filesystem are stopped during this time.
{% endhint %}

## Update a snapshot

**Command:** `weka fs snapshot update`

This command changes the snapshot attributes. Use the following command line to update an existing snapshot:

`weka fs snapshot update <file-system> <name> [--new-name=<new-name>] [--access-point=<access-point>]`

**Parameters**

| Name            | Value                                                                                 |
| --------------- | ------------------------------------------------------------------------------------- |
| `file-system`\* | A valid filesystem identifier                                                         |
| `name`\*        | Unique name for the updated snapshot                                                  |
| `new-name`      | New name for the updated snapshot                                                     |
| `access-point`  | Name of a directory for the snapshot that serves as the access point for the snapshot |
