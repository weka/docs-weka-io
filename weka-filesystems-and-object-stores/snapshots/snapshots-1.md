---
description: This page describes how to manage snapshots using the CLI.
---

# Manage snapshots using the CLI

Using the CLI, you can:

* [#add-a-snapshot](snapshots-1.md#add-a-snapshot "mention")
* [#remove-a-snapshot](snapshots-1.md#remove-a-snapshot "mention")
* [#restore-a-snapshot-to-a-filesystem-or-another-snapshot](snapshots-1.md#restore-a-snapshot-to-a-filesystem-or-another-snapshot "mention")
* [#update-a-snapshot](snapshots-1.md#update-a-snapshot "mention")
* [#access-the-.snapshots-directory](snapshots-1.md#access-the-.snapshots-directory "mention")
* [#retrieve-snapshot-details](snapshots-1.md#retrieve-snapshot-details "mention")

## Add a snapshot

**Command:** `weka fs snapshot add`

Use the following command line to create a snapshot:

`weka fs snapshot add <file-system> <name> [--access-point access-point] [--source-snap=<source-snap>] [--is-writable]`

{% hint style="info" %}
The newly created snapshot is saved in the `.snapshots` directory. \
See [#access-the-.snapshots-directory](snapshots-1.md#access-the-.snapshots-directory "mention").
{% endhint %}

**Parameters**

<table><thead><tr><th width="154.90625">Name</th><th width="254.96875">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>A valid filesystem identifier.</td><td>​</td></tr><tr><td><code>name</code>*</td><td>Unique name for filesystem snapshot.</td><td></td></tr><tr><td><code>access-point</code></td><td>Name of the newly-created directory for filesystem-level snapshots, which serves as the access point for the snapshots.</td><td>Controlled by <code>weka fs snapshot access-point-naming-convention update &#x3C;date/name>.</code> By default, it is &#x3C;date> format: @GMT_%Y.%m.%d-%H.%M.%S, which is compatible with <a href="../../additional-protocols/smb-support/#windows-previous-versions">Windows' previous versions' format for SMB</a>.</td></tr><tr><td><code>source-snap</code></td><td>Must be an existing snapshot.</td><td>The snapshot name of the specified filesystem.</td></tr><tr><td><code>is-writable</code></td><td>Sets the created snapshot to be writable.</td><td>False</td></tr></tbody></table>

## Remove a snapshot

**Command:** `weka fs snapshot remove`

Use the following command line to remove a snapshot:

`weka fs snapshot remove <file-system> <name>`

**Parameters**

<table><thead><tr><th width="227.9375">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>A valid filesystem identifier</td></tr><tr><td><code>name</code>*</td><td>Unique name for filesystem snapshot</td></tr></tbody></table>

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
| `destination-``name`\*                        | The destination name to which the existing snapshot should be copied.                                                                                                                                                                                             |                                                                                                                                                                                                     |
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

<table><thead><tr><th width="231.953125">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>A valid filesystem identifier</td></tr><tr><td><code>name</code>*</td><td>Unique name for the updated snapshot</td></tr><tr><td><code>new-name</code></td><td>New name for the updated snapshot</td></tr><tr><td><code>access-point</code></td><td>Name of a directory for the snapshot that serves as the access point for the snapshot</td></tr></tbody></table>

## Access the `.snapshots` directory

The `.snapshots` directory is located in the root directory of each mounted filesystem. It is not displayed with the `ls -la` command. You can access this directory using the `cd .snapshots` command from the root directory.

#### Example

The following example shows a filesystem named `default` mounted to `/mnt/weka`.&#x20;

To confirm you are in the root directory of the mounted filesystem, change into the `.snapshots` directory, and then display any snapshots in that directory:

```
[root@ip-172-31-23-177 weka]# pwd 
/mnt/weka 
[root@ip-172-31-23-177 weka]# ls -la 
total 0 
drwxrwxr-x 1 root root   0 Sep 19 04:56 . 
drwxr-xr-x 4 root root  33 Sep 20 06:48 .. 
drwx------ 1 user1 user1 0 Sep 20 09:26 user1 
[root@ip-172-31-23-177 weka]# cd .snapshots 
[root@ip-172-31-23-177 .snapshots]# ls -l 
total 0 
drwxrwxr-x 1 root root 0 Sep 21 02:44 @GMT-2023.09.21-02.44.38 
[root@ip-172-31-23-177 .snapshots]#
```



## Retrieve snapshot details

**Command:** `weka fs snapshot`

Use the following command to retrieve snapshot details, such as its UID, local object locator, estimated reclaimable space, and metadata size:

{% code overflow="wrap" %}
```sh
weka fs snapshot [--file-system file-system] [--name name] [--output output]...
```
{% endcode %}

<table><thead><tr><th width="199">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--file-system</code></td><td>Filesystem name</td></tr><tr><td><code>--name</code></td><td>Snapshot name</td></tr><tr><td><code>-o</code>, <code>--output</code>...</td><td>Specify which columns to output. May include any of the following: uid, id, filesystem, name, access, writeable, created, local_upload_size, remote_upload_size, local_object_status, local_object_progress, local_object_locator, remote_object_status, remote_object_progress, remote_object_locator, removing, prefetched, est_reclaimable_size, metadata_size (may be repeated or comma-separated)</td></tr></tbody></table>

