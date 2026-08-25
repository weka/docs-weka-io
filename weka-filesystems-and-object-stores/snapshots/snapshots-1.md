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
| ----------------------------- | -------------------------------- |
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
| --------------- | --------------------------------------------------------------- |
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
| -------------------------- | ---------------------------------- |
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
| ---------------------------- | ------------------------------------------- |
| `--filesystem` \<filesystem> | Filter results to a specific filesystem. |
| `--name` \<string> | Filter results to a specific snapshot name. |

## Set up snapshot replication between clusters

Simplify snapshot replication cluster setup using a single command on each cluster.

Use the `weka cluster remote-cluster setup` command to pair two clusters for snapshot replication. This command replaces several manual setup steps with a single workflow. It automates the setup of the staging filesystem, S3 service, replication bucket, object-store tier, and remote-cluster registration.

If the setup fails, the system rolls back the changes automatically.

**Before you begin**

* Ensure CLI access to both clusters.
* Choose the remote cluster `NAME` to use for the pairing.
* Prepare to copy the connection payload from the first cluster to the second cluster.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Engineering):** `weka cluster remote-cluster setup` does not exist in 6.0. The group survives with `add`, `update`, and `remove`, but `setup` and its `--init` / `--remote` flags are gone. The replacement is the two-command pairing flow: `weka cluster peer init` on the first cluster emits a pairing token, and `weka cluster peer add <name> <token>` registers it on the second. The surrounding text also needs rewriting — it promises a single command per cluster and automatic rollback, neither of which describes the peer flow. Held pending the wider replication review.
{% endhint %}

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
