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

| Parameter                     | Description                      |
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `name`\* | Target snapshot name. |
| `--access-point` \<string> | Snapshot access point name. Default: Controlled by weka fs snapshot access-point-naming-convention update &#x26;#x3C;date/name>. By default, the system uses the date format @GMT_%Y.%m.%d-%H.%M.%S, which is compatible with Windows previous versions for SMB |
| `--source-snapshot` \<string> | Use this snapshot as the source. Default: The latest snapshot of the specified filesystem |
| `--writable` | Create the snapshot as writable. Default: false |

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
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `name`\* | Snapshot name. |
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
| --- | --- |
| `filesystem`\* | Filesystem name. |
| `name`\* | Snapshot name. |
| `--access-point` \<string> | New access point for the snapshot. |
| `--new-name` \<string> | Rename the snapshot. |

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
| --- | --- |
| `--filesystem` \<filesystem> | Filter results to a specific filesystem. |
| `--name` \<string> | Filter results to a specific snapshot name. |

{% endcode %}

<table><thead><tr><th width="212.421875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--file-system</code></td><td>Filter the output by filesystem name.</td></tr><tr><td><code>--name</code></td><td>Filter the output by snapshot name.</td></tr><tr><td><code>-o</code>, <code>--output</code>...</td><td>Select the columns to display. Supported values are <code>uid</code>, <code>id</code>, <code>filesystem</code>, <code>name</code>, <code>access</code>, <code>writeable</code>, <code>created</code>, <code>local_upload_size</code>, <code>remote_upload_size</code>, <code>local_object_status</code>, <code>local_object_progress</code>, <code>local_object_locator</code>, <code>remote_object_status</code>, <code>remote_object_progress</code>, <code>remote_object_locator</code>, <code>removing</code>, <code>prefetched</code>, <code>est_reclaimable_size</code>, and <code>metadata_size</code>.Repeat the option or use a comma-separated list.</td></tr></tbody></table>

## Set up snapshot replication between clusters

Pair two clusters for snapshot replication using the `weka cluster peer` commands.

A cluster exposes itself for replication by running `weka cluster peer init`, which provisions the resources replication needs on that cluster — the replication filesystem, an S3 cluster, the `weka-repl-bucket` bucket, and the `weka-repl-user` user with a read-write policy — and then prints the connection details and a pairing token. The administrator of the other cluster registers that token with `weka cluster peer add`.

Running `weka cluster peer init` again on an already-initialized cluster is safe: it re-emits the same credentials rather than provisioning a second time.

{% hint style="warning" %}
The pairing token contains the cluster's S3 secret. Treat it as sensitive — anyone holding it can pair a cluster against yours. To rotate the credentials, run `weka cluster peer init --reinit`. This invalidates every existing peer relationship that references the cluster, and each one must be paired again.
{% endhint %}

**Before you begin**

* Ensure CLI access to both clusters.
* Decide which containers serve S3 for replication on the initializing cluster. Use `--container` to name them, or `--all-servers` to use every backend server. The two options are mutually exclusive, and one of them is required.
* Choose the name to register the peer cluster under.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** The commands, flags, and provisioned resources above are verified against the 6.0 CLI. What is still unconfirmed is whether bidirectional replication requires `peer init` and `peer add` to be run on *both* clusters, or whether initializing one side and adding from the other is sufficient. The procedure below documents the one-direction pairing only. Resolve with the wider replication review (Gokul, Anand).
{% endhint %}

**Procedure**

1. On the cluster that will be the replication target, provision the replication endpoint and copy the pairing token from the output.

```bash
weka cluster peer init --all-servers
```

To serve S3 from specific containers instead, use `--container`:

```bash
weka cluster peer init --container <container-ids>
```

The command asks for confirmation before provisioning. Add `-f` to skip the prompt.

2. On the other cluster, register the peer using the token from step 1.

```bash
weka cluster peer add <name> <token>
```

3. Verify the pairing.

```bash
weka cluster peer
```
