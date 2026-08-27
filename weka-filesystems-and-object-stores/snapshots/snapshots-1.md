---
description: >-
  Create, restore, update, remove, and inspect filesystem snapshots from the
  CLI.
---

# Manage snapshots using the CLI

## Add a snapshot

Creates a point-in-time snapshot of a filesystem. A snapshot is read-only unless you pass `--writable`, and `--source-snapshot` bases it on an existing snapshot rather than the live filesystem.

**Command:** `weka fs snapshot add`

```sh
weka fs snapshot add <filesystem> <name> [--access-point <string>] [--source-snapshot <string>] [--writable]
```

**Parameters**

<table><thead><tr><th width="271.85546875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>filesystem</code>*</td><td>Filesystem name.</td></tr><tr><td><code>name</code>*</td><td>Target snapshot name.</td></tr><tr><td><code>--access-point</code> &#x3C;string></td><td><p>Snapshot access point name.</p><p>Default: Controlled by <code>weka fs snapshot access-point-naming-convention update &#x3C;date/name>.</code> By default, it is &#x3C;date> format: <code>@GMT_%Y.%m.%d-%H.%M.%S</code>, which is compatible with <a href="https://docs.weka.io/additional-protocols/smb-support#windows-previous-versions">Windows' previous versions' format for SMB</a>.</p></td></tr><tr><td><code>--source-snapshot</code> &#x3C;string></td><td><p>Use this snapshot as the source.</p><p>Default: The latest snapshot of the specified filesystem</p></td></tr><tr><td><code>--writable</code></td><td><p>Create the snapshot as writable.</p><p>Default: false</p></td></tr></tbody></table>

{% hint style="info" %}
The newly created snapshot is saved in the `.snapshots` directory.\
See [#access-the-.snapshots-directory](snapshots-1.md#access-the-.snapshots-directory "mention").
{% endhint %}

## Remove a snapshot

Deletes a snapshot. The filesystem and any other snapshots are unaffected.

**Command:** `weka fs snapshot remove`

```sh
weka fs snapshot remove <filesystem> <name> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `filesystem`\*  | Filesystem name.                                                |
| `name`\*        | Snapshot name.                                                  |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

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

Renames a snapshot or changes its access point.

**Command:** `weka fs snapshot update`

```sh
weka fs snapshot update <filesystem> <name> [--access-point <string>] [--new-name <string>]
```

**Parameters**

| Parameter                  | Description                        |
| -------------------------- | ---------------------------------- |
| `filesystem`\*             | Filesystem name.                   |
| `name`\*                   | Snapshot name.                     |
| `--access-point` \<string> | New access point for the snapshot. |
| `--new-name` \<string>     | Rename the snapshot.               |

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

Lists the snapshots on the cluster. Use `--output` to add columns such as the snapshot UID, its local and remote object locators, and the estimated reclaimable space.

**Command:** `weka fs snapshot`

```sh
weka fs snapshot [--filesystem <filesystem>] [--name <string>]
```

**Parameters**

| Parameter                    | Description                                 |
| ---------------------------- | ------------------------------------------- |
| `--filesystem` \<filesystem> | Filter results to a specific filesystem.    |
| `--name` \<string>           | Filter results to a specific snapshot name. |

<table><thead><tr><th width="212.421875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--file-system</code></td><td>Filter the output by filesystem name.</td></tr><tr><td><code>--name</code></td><td>Filter the output by snapshot name.</td></tr><tr><td><code>-o</code>, <code>--output</code>...</td><td>Select the columns to display. Supported values are <code>uid</code>, <code>id</code>, <code>filesystem</code>, <code>name</code>, <code>access</code>, <code>writeable</code>, <code>created</code>, <code>local_upload_size</code>, <code>remote_upload_size</code>, <code>local_object_status</code>, <code>local_object_progress</code>, <code>local_object_locator</code>, <code>remote_object_status</code>, <code>remote_object_progress</code>, <code>remote_object_locator</code>, <code>removing</code>, <code>prefetched</code>, <code>est_reclaimable_size</code>, and <code>metadata_size</code>.Repeat the option or use a comma-separated list.</td></tr></tbody></table>
