---
description: This page describes how to manage snapshots using the CLI.
---

# Manage snapshots using the CLI

Using the CLI, you can:

* [Create a snapshot](snapshots-1.md#create-a-snapshot)
* [Delete a snapshot](snapshots-1.md#delete-a-snapshot)
* [Restore a snapshot to a filesystem or another snapshot](snapshots-1.md#restore-a-snapshot-to-a-filesystem-or-another-snapshot)
* [Update a snapshot](snapshots-1.md#update-a-snapshot)

## Create a snapshot

**Command:** `weka fs snapshot create`

Use the following command line to add a snapshot:

`weka fs snapshot create <file-system> <name> [--access-point access-point] [--source-snap=<source-snap>] [--is-writable]`

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th width="150">Type</th><th>Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>file-system</code></td><td>String</td><td>A valid filesystem identifier</td><td>Must be a valid name</td><td>Yes</td><td>​</td></tr><tr><td><code>name</code></td><td>String</td><td>Unique name for filesystem snapshot</td><td>Must be a valid name</td><td>Yes</td><td></td></tr><tr><td><code>access-point</code></td><td>String</td><td>Name of the newly-created directory for filesystem-level snapshots, which serves as the access point for the snapshots</td><td>Must be a valid name</td><td>No</td><td>Controlled by <code>weka fs snapshot access-point-naming-convention update &#x3C;date/name>.</code> By default it is <code>&#x3C;date></code> format: <code>@GMT_%Y.%m.%d-%H.%M.%S</code> which is compatible with <a href="../../additional-protocols/smb-support/#integration-with-windows-previous-versions">windows previous versions format for SMB</a>.</td></tr><tr><td><code>source-snap</code></td><td>String</td><td>Must be an existing snapshot</td><td>Must be a valid name</td><td>No</td><td>The snapshot name of the specified filesystem.</td></tr><tr><td><code>is-writable</code></td><td>Boolean</td><td>Sets the created snapshot to be writable</td><td></td><td>No</td><td>False</td></tr></tbody></table>

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
A snapshot deletion cannot happen parallel to a snapshot upload to the same filesystem. Since uploading a snapshot to a remote object store might take a while, it is advisable to delete the desired snapshots before uploading to the remote object store.&#x20;

This becomes more important when uploading snapshots to local and remote object stores. While local and remote uploads can progress in parallel, consider the case of a remote upload in progress, then a snapshot is deleted, and later a snapshot is uploaded to the local object store. In this scenario, the local snapshot upload waits for the pending deletion of the snapshot (which happens only once the remote snapshot upload is done).
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
When restoring a filesystem from a snapshot (or copying over an existing snapshot), the filesystem data and metadata are changed. If you do not specify the `preserved-overwritten-snapshot-name` parameter, ensure IOs to the filesystem are stopped during this time.
{% endhint %}

## Update a snapshot

**Command:** `weka fs snapshot update`

This command changes the snapshot attributes. Use the following command line to update an existing snapshot:

`weka fs snapshot update <file-system> <name> [--new-name=<new-name>] [--access-point=<access-point>]`

**Parameters**

<table><thead><tr><th width="278">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>A valid filesystem identifier</td></tr><tr><td><code>name</code>*</td><td>Unique name for the updated snapshot</td></tr><tr><td><code>new-name</code></td><td>New name for the updated snapshot</td></tr><tr><td><code>access-point</code></td><td>Name of a directory for the snapshot that serves as the access point for the snapshot</td></tr></tbody></table>
