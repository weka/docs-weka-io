---
description: >-
  Learn how the WEKA system runs asynchronous and maintenance operations in the
  background, what limits apply to them, and how to monitor and control them.
---

# Background tasks

Background tasks handle work that must not interfere with serving IO. Examples include checking metadata integrity, uploading and downloading snapshots, detaching an object store, reducing data, and applying a directory quota to existing data.

## Resource consumption

The WEKA system limits background tasks to 5% of the overall CPU. When the CPU is idle, background tasks can use more than the configured resources, and release them immediately when needed to serve IO.

## Concurrency limits

Two separate limits apply to background tasks:

**Queued tasks:** the number of tasks that can exist at the same time. A paused or aborted task still occupies a slot. When the queue is full, a new operation fails rather than waits.

**Running tasks:** the number of queued tasks that perform work at the same time. Additional tasks remain queued until a slot frees.

Both limits apply cluster-wide.

<table><thead><tr><th width="219.8671875">Task group</th><th width="193.953125">Maximum queued</th><th>Maximum running</th></tr></thead><tbody><tr><td>Filesystem tasks</td><td>16</td><td>Set by the task-specific rules below</td></tr><tr><td>Directory quota tasks</td><td>32</td><td>4</td></tr></tbody></table>

If an operation cannot start because the queue is full, it fails with the following message:

```
Operation cannot start because there are already 32 tasks running
```

Wait for a running task to finish, then retry.

### Task-specific rules

**Snapshot upload and download:**

* Only a single local upload can exist concurrently inside a filesystem.
* Only a single remote upload inside a filesystem can be done concurrently. Local and remote uploads can co-exist.
* Only a single upload from any filesystem can exist in the same object store bucket, to prevent uploads from slowing each other down.
* An object store snapshot download operation cannot run at the same time as another snapshot download or upload operation.

**Data reduction:**

* Only one data reduction or data defragmentation task runs in the cluster at a time. If either task exists, no new task of either type starts.
* The cluster starts these tasks automatically. You do not create them.

**Snapshot metadata prefetch:**

* When a snapshot is downloaded from the object store, the system automatically prefetches its metadata as the initial step.

{% hint style="info" %}
Further restrictions exist between different tasks and between multiple tasks of the same type. When a background task does not run because of a restriction, the system provides a relevant message.
{% endhint %}

## Background tasks list

| Task name                  | Description                                                                                                                                   | Possible actions                                                      |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| OBS\_DETACH2               | Detaches an object store from a filesystem.                                                                                                   | Pause, Resume, Abort until the task reaches the CLEAR\_MANIFEST phase |
| STOW\_UPLOAD               | Uploads a snapshot from a filesystem to an object store bucket.                                                                               | Pause, Resume, Abort                                                  |
| STOW\_DOWNLOAD\_FILESYSTEM | Downloads a filesystem from a locator in an object store.                                                                                     | Pause, Resume                                                         |
| STOW\_DOWNLOAD\_SNAPSHOT   | Downloads a snapshot to a filesystem from a locator in an object store. Includes fetching the snapshot metadata and squashing the filesystem. | Pause, Resume                                                         |
| SNAPSHOT\_DELETE           | Deletes a snapshot of a filesystem.                                                                                                           | Pause, Resume                                                         |
| FSCK                       | Checks metadata integrity.                                                                                                                    | Pause, Resume, Abort                                                  |
| DATA\_REDUCTION            | Reduces data.                                                                                                                                 | Pause, Resume, Abort                                                  |
| DATA\_DEFRAG               | Defragments data.                                                                                                                             | Pause, Resume, Abort                                                  |
| FILESYSTEM\_RECOMPRESS     | Rewrites the data of a filesystem to compress or decompress it.                                                                               | Pause, Resume, Abort                                                  |
| QUOTA\_COLORING            | Applies or clears a directory quota on a directory that already contains data. Requires an active Data Services container.                    | Pause, Resume, Abort                                                  |
