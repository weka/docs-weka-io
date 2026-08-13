---
description: >-
  Use async delete to remove large files, directories, and symlinks without
  keeping client processes blocked on recursive delete work.
---

# Async delete

## Overview

Large filesystems often contain directories with millions of files. Removing them using standard tools like `rm -rf` walks the entire tree serially over the network, which can take hours and keeps client processes blocked until the operation completes.

Async delete solves this by offloading the work to the cluster. Renaming any directory, file, or symlink to the reserved name `.weka-delete` unlinks the entry from its parent immediately and hands the contents to the cluster for background destruction. The rename returns in milliseconds. The cluster then shreds the subtree in parallel, freeing the client to continue other work.

The original name is no longer accessible after the rename returns. For large directory trees, reclaimed capacity becomes available gradually as the background shredder progresses, not at the moment the rename returns.

The filesystem root itself cannot be renamed to `.weka-delete`.

To use async delete, first enable it on the filesystem, then rename the target entry to trigger deletion.

## Enable async delete

Enable async delete per filesystem using `weka fs add` or `weka fs update`. Two compatible settings are available; enabling either one activates the trigger.

While async delete is enabled, creating a file, directory, or symlink literally named `.weka-delete` is rejected with `EPERM`. The name is reserved as a deletion trigger. Renaming away from `.weka-delete` is unaffected.

**Before you begin**

Ensure you have permission to update or create the target filesystem.

**Choose the mode**

Decide whether to allow async delete from any directory in the filesystem, or from the filesystem root only. Root-only mode is recommended for filesystems shared between mutually untrusted users.

**Enable from any directory**

Use one of the following commands:

*   Existing filesystem:

    ```bash
    weka fs update <fsname> --enable-weka-delete true <name>
    ```
*   New filesystem:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs add &#x3C;fsname> --enable-weka-delete true &#x3C;name> &#x3C;group-name> &#x3C;total-capacity> [parameters]
    </code></pre>

**Restrict the trigger to the filesystem root**

Use one of the following commands:

*   Existing filesystem:

    ```bash
    weka fs update <fsname> --enable-weka-delete-root-only true <name>
    ```
*   New filesystem:

    <pre class="language-bash" data-overflow="wrap"><code class="lang-bash">weka fs add &#x3C;fsname> --enable-weka-delete-root-only true &#x3C;name> &#x3C;group-name> &#x3C;total-capacity> [parameters]
    </code></pre>

In root-only mode, rename the entry to `.weka-delete` in the filesystem root only. This restricts access to the feature to users who can create new files in the filesystem root directory.

{% hint style="info" %}
For the full `weka fs add` syntax, see the command help or the CLI reference.
{% endhint %}

## Delete a directory, file, or symlink

Rename the target to `.weka-delete` in the same parent directory to trigger background deletion.

**Before you begin**

Confirm that async delete is enabled on the target filesystem.

**Procedure**

1.  Rename the entry to `.weka-delete` in its current parent directory:

    ```bash
    mv /mnt/myfs/big-dataset /mnt/myfs/.weka-delete
    ```

    For a single file or symlink:

    ```bash
    mv /mnt/myfs/some.file /mnt/myfs/.weka-delete
    ```

    The entry is removed from the parent immediately. The cluster shreds the contents in the background.

{% hint style="info" %}
The destination is always the literal name `.weka-delete` in the same parent directory. This is a rename to a reserved name, not a move into a directory named `.weka-delete`.
{% endhint %}

## Security considerations

The system checks rename permissions only on the parent directory. It does not recheck permissions on each child entry.

Consider these implications before enabling async delete:

* **Parent directory writers:** Anyone with write and execute permission on the parent directory can rename a child to `.weka-delete` and destroy that child and everything beneath it, including files and subdirectories owned by other users with otherwise restrictive permissions.
* **Cluster credentials:** The recursive shredder runs with internal cluster credentials, not the requester's credentials. Mode bits, ownership, ACLs, and immutability of contents are not rechecked.
* **Sticky bit scope:** The sticky bit on the parent directory (`+t`, as on `/tmp`) applies to the rename itself and limits who can trigger deletion of a given top-level entry. It does not protect that entry's descendants once the rename succeeds.
* **Root-only mode:** In root-only mode, only users with write access to the filesystem root can trigger async delete. This is the recommended setting for shared filesystems.
* **Snapshots:** Snapshots are not affected. Data captured in a snapshot before the rename remains in that snapshot.

Treat `--enable-weka-delete` (non-root-only mode) as equivalent to granting every directory writer the ability to recursively delete that directory's contents, regardless of inner ownership.

## Monitor async delete progress

Use related signals to infer async delete progress. The entry is removed at rename time, and the queued work lives in a per-bucket on-disk trash bin that is not surfaced as a cluster-wide task. The following signals are available.

### Events

Async delete does not emit entries in `weka events`. There are no started, progress, or finished events in the events stream.

### Audit log

If filesystem auditing is enabled, the audit log records the following entries:

| Audit entry | When it is recorded |
| --- | --- |
| `AuditTraceAsyncDeleteInit` | The rename to `.weka-delete` occurs. One entry per request. |
| `AuditTraceAsyncDeleteSubdir` | A subdirectory is unlinked during shredding. |
| `AuditTraceAsyncDeleteFile` | A file or symlink is unlinked during shredding. |

These entries appear in the audit destination configured for the filesystem, for example an S3 audit bucket. They do not appear in `weka events`. Without auditing enabled, there is no per-entry trail.

To enable auditing on a filesystem:

```bash
weka fs update <fsname> --enable-audit <audit-target>
```

### Stats

Query async delete counters using `weka stats` under the `async_delete` category:

| Stat | Meaning |
| --- | --- |
| `ASYNC_DELETE_DIRS_QUEUED` | Directories added to the trash bin, broken out by `DeletionSource`. The `WEKA_DEL` label corresponds to the rename-to-`.weka-delete` path. `XATTR_OVERFLOW` and `FSCK` are unrelated internal sources. |
| `ASYNC_DELETE_DIRS_QUEUED_SUBDIRS` | Subdirectories the shredder discovers and enqueues while walking a queued tree. |
| `ASYNC_DELETE_FILES_QUEUED` | Files the shredder discovers and enqueues for unlinking. |
| `ASYNC_DELETE_SLICES_SHREDDED` | Directory slices the shredder has processed. Indicates forward progress through queued work. |

Useful monitoring patterns:

* **Trigger rate:** Watch `ASYNC_DELETE_DIRS_QUEUED[WEKA_DEL]` as a rate to see how often async delete is triggered.
* **Backlog proxy:** Compare `ASYNC_DELETE_FILES_QUEUED` against the rate of file unlinks in normal filesystem metadata-op stats as a rough proxy for remaining shred work. A persistently growing gap indicates the shredder is throttled or load-limited.
* **Forward progress:** `ASYNC_DELETE_SLICES_SHREDDED` advancing while `ASYNC_DELETE_FILES_QUEUED` is flat indicates the shredder is making forward progress.

The shredder is a bucket-local worker. It does not appear in `weka cluster task`.

## Snapshot interaction

Pending async deletions can block the following snapshot-related cluster-wide tasks on the snap layers they affect:

* `SnapshotDeleteTask`: deletes a snapshot, including merging it into its parent.
* `StowUploadTask`: tiers a snapshot's data out.
* `StowReplicateSnapshotTask`: replicates a snapshot.

Each task passes through a `WAIT_FOR_ASYNC_DELETIONS` phase before doing its main work. In this phase, the leader polls every bucket for a drained state on the affected snap layers and only advances after two consecutive idle reports from every relevant bucket.

Behavior during this phase:

* **Task state:** The task does not error or retry. It remains in the `WAIT_FOR_ASYNC_DELETIONS` phase, visible in `weka cluster task`, until the relevant snap layers are quiescent.
* **Abort behavior:** The task is abortable while in `WAIT_FOR_ASYNC_DELETIONS`. It is not abortable in later phases.
* **Task impact:** A large outstanding shred on a snap layer delays snapshot deletion, tier upload, and replication for that snap layer. Snapshots on unrelated filesystems or different snap layers are not affected.

## Overrides

Set cluster-wide overrides using `weka debug override add --key <key> --value <value>`. These affect every filesystem that has async delete enabled.

| Key | Default | Purpose |
| --- | --- | --- |
| `fs.dir.async_delete.delete_name` | `.weka-delete` | Changes the reserved trigger name cluster-wide. If changed, the literal string `.weka-delete` becomes an ordinary filename on every filesystem in the cluster. |
| `fs.dir.async_delete.node_shred_parallelism` | Internal default | Sets per-process parallelism for the shredder worker. Increase for faster reclaim on idle clusters; decrease to reduce impact on foreground I/O. |
| `fs.dir.async_delete.throttle_load_threshold` | Load-level metric default | Sets the metadata load level at which the shredder begins backing off to protect foreground I/O. |
| `fs.dir.async_delete.choking_stop_level` | Load-level metric default | Sets the metadata load level at which the shredder stops issuing new work entirely until load subsides. |



