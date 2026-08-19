---
description: >-
  Create, restore, update, remove, and inspect filesystem snapshots from the
  CLI.
---

# Manage snapshots using the CLI

## Add a snapshot

**Command:** `weka fs snapshot add`

Use the following command line to create a snapshot:

`weka fs snapshot add <file-system> <name> [--access-point access-point] [--source-snap=<source-snap>] [--is-writable]`

{% hint style="info" %}
The newly created snapshot is saved in the `.snapshots` directory.\
See [#access-the-.snapshots-directory](snapshots-1.md#access-the-.snapshots-directory "mention").
{% endhint %}

**Parameters**

<table><thead><tr><th width="204.7890625">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>Filesystem on which to create the snapshot.</td></tr><tr><td><code>name</code>*</td><td>Name to assign to the new snapshot.</td></tr><tr><td><code>access-point</code></td><td>Directory name to use as the snapshot access point.Default: Controlled by <code>weka fs snapshot access-point-naming-convention update &#x26;#x3C;date/name></code>. By default, the system uses the date format <code>@GMT_%Y.%m.%d-%H.%M.%S</code>, which is compatible with <a href="../../additional-protocols/smb-support/#windows-previous-versions">Windows previous versions for SMB</a>.</td></tr><tr><td><code>source-snap</code></td><td>Existing snapshot to use as the source for the new snapshot.Default: The latest snapshot of the specified filesystem.</td></tr><tr><td><code>is-writable</code></td><td>Create the snapshot as writable.Default: <code>false</code></td></tr></tbody></table>

## Remove a snapshot

**Command:** `weka fs snapshot remove`

Use the following command line to remove a snapshot:

`weka fs snapshot remove <file-system> <name>`

**Parameters**

| Name            | Value                               |
| --------------- | ----------------------------------- |
| `file-system`\* | A valid filesystem identifier       |
| `name`\*        | Unique name for filesystem snapshot |

{% hint style="warning" %}
A snapshot deletion cannot happen parallel to a snapshot upload to the same filesystem. Since uploading a snapshot to a remote object store might take a while, it is advisable to delete the desired snapshots before uploading to the remote object store.

This becomes more important when uploading snapshots to local and remote object stores. While local and remote uploads can progress in parallel, consider the case of a remote upload in progress, then a snapshot is deleted, and later a snapshot is uploaded to the local object store. In this scenario, the local snapshot upload waits for the pending deletion of the snapshot (which happens only once the remote snapshot upload is done).
{% endhint %}

## Restore a snapshot to a filesystem or another snapshot

**Commands:** `weka fs restore` or `weka fs snapshot copy`

Use the following command line to restore a filesystem from a snapshot:

`weka fs restore <file-system> <source-name> [--preserved-overwritten-snapshot-name=preserved-overwritten-snapshot-name] [--preserved-overwritten-snapshot-access-point=preserved-overwritten-snapshot-access-point]`

Use the following command line to restore a snapshot to another snapshot:

`weka fs snapshot copy <file-system> <source-name> <destination-name> [--preserved-overwritten-snapshot-name=preserved-overwritten-snapshot-name] [--preserved-overwritten-snapshot-access-point=preserved-overwritten-snapshot-access-point]`

**Parameters**

| Name                                          | Value                                                                                                                                                                                                                                                                          |
| --------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `file-system`\*                               | Filesystem that contains the source snapshot, or the filesystem to restore.                                                                                                                                                                                                    |
| `source-name`\*                               | Name of the snapshot to restore from or copy from.                                                                                                                                                                                                                             |
| `destination-name`\*                          | Name of the destination snapshot when using `weka fs snapshot copy`.                                                                                                                                                                                                           |
| `preserved-overwritten-snapshot-name`         | Name to assign to the overwritten snapshot or live filesystem so it is preserved during the restore.If not specified, the system overwrites the target directly, and active IO to an existing filesystem can fail.                                                             |
| `preserved-overwritten-snapshot-access-point` | Directory name that serves as the access point for the preserved overwritten snapshot.Default: If `preserved-overwritten-snapshot-name` is specified and `preserved-overwritten-snapshot-access-point` is not, the system creates it automatically based on the snapshot name. |

{% hint style="warning" %}
When restoring a filesystem from a snapshot (or copying over an existing snapshot), the filesystem data and metadata are changed. If you do not specify the `preserved-overwritten-snapshot-name` parameter, ensure IOs to the filesystem are stopped during this time.
{% endhint %}

## Update a snapshot

**Command:** `weka fs snapshot update`

This command changes the snapshot attributes. Use the following command line to update an existing snapshot:

`weka fs snapshot update <file-system> <name> [--new-name=<new-name>] [--access-point=<access-point>]`

**Parameters**

<table><thead><tr><th width="211.1171875">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>file-system</code>*</td><td>Filesystem that contains the snapshot to update.</td></tr><tr><td><code>name</code>*</td><td>Current name of the snapshot to update.</td></tr><tr><td><code>new-name</code></td><td>New name to assign to the snapshot.</td></tr><tr><td><code>access-point</code></td><td>Directory name to use as the snapshot access point.</td></tr></tbody></table>

## Access the `.snapshots` directory

The `.snapshots` directory is located in the root directory of each mounted filesystem. It is not displayed with the `ls -la` command. You can access this directory using the `cd .snapshots` command from the root directory.

#### Example

The following example shows a filesystem named `default` mounted to `/mnt/weka`.

To confirm you are in the root directory of the mounted filesystem, change into the `.snapshots` directory, and then display any snapshots in that directory:

```bash
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

<table><thead><tr><th width="212.421875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--file-system</code></td><td>Filter the output by filesystem name.</td></tr><tr><td><code>--name</code></td><td>Filter the output by snapshot name.</td></tr><tr><td><code>-o</code>, <code>--output</code>...</td><td>Select the columns to display. Supported values are <code>uid</code>, <code>id</code>, <code>filesystem</code>, <code>name</code>, <code>access</code>, <code>writeable</code>, <code>created</code>, <code>local_upload_size</code>, <code>remote_upload_size</code>, <code>local_object_status</code>, <code>local_object_progress</code>, <code>local_object_locator</code>, <code>remote_object_status</code>, <code>remote_object_progress</code>, <code>remote_object_locator</code>, <code>removing</code>, <code>prefetched</code>, <code>est_reclaimable_size</code>, and <code>metadata_size</code>.Repeat the option or use a comma-separated list.</td></tr></tbody></table>

## Set up snapshot replication between clusters

Simplify snapshot replication cluster setup using a single command on each cluster.

Use the `weka cluster remote-cluster setup` command to pair two clusters for snapshot replication. This command replaces several manual setup steps with a single workflow. It automates the setup of the staging filesystem, S3 service, replication bucket, object-store tier, and remote-cluster registration.

If the setup fails, the system rolls back the changes automatically.

**Before you begin**

* Ensure CLI access to both clusters.
* Choose the remote cluster `NAME` to use for the pairing.
* Prepare to copy the connection payload from the first cluster to the second cluster.

**Procedure**

1. On the first cluster, initialize the remote cluster setup and copy the returned payload.

```bash
weka cluster remote-cluster setup NAME --init
```

2. On the second cluster, complete the pairing using the payload from the first cluster.

```bash
weka cluster remote-cluster setup NAME --remote=<payload>
```

Use the same `NAME` value on both clusters.
