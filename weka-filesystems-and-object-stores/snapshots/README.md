---
description: >-
  Snapshots enable the saving of a filesystem state to a directory and can be
  used for backup, archiving and testing purposes.
---

# Snapshots

Snapshots allow the saving of a filesystem state to a hidden `.snapshots` directory under the root filesystem. They can be used for:

* **Physical backup:** The snapshots directory can be copied into a different storage system, possibly on another site, using either the WEKA system Snap-To-Object feature or third-party software.
* **Logical backup:** Periodic snapshots enable filesystem restoration to a previous state if logical data corruption occurs.
* **Archive:** Periodic snapshots enable accessing a previous filesystem state for compliance or other needs.
* **DevOps environments:** Writable snapshots enable the execution of software tests on copies of the data.

Snapshots do not impact system performance and can be taken for each filesystem while applications run. They consume minimal space, according to the differences between the filesystem and the snapshots, or between the snapshots, in 4K granularity.

By default, snapshots are read-only, and any attempt to change the content of a read-only snapshot returns an error message.

It is possible to create a writable snapshot. A writable snapshot cannot be changed to a read-only snapshot.

The WEKA system supports the following snapshot operations:

* View snapshots.
* Create a snapshot of an existing filesystem.
* Delete a snapshot.
* Access a snapshot under a dedicated directory name.
* Restore a filesystem from a snapshot.
* Create a snapshot of a snapshot (relevant for writable snapshots or read-only snapshots before being made writable).
* List the snapshots and obtain their metadata.
* Schedule automatic snapshots. For details, see [snapshot-policies](../snapshot-policies/ "mention").

To access the hidden `.snapshot` directory, see [#access-the-.snapshots-directory](snapshots-1.md#access-the-.snapshots-directory "mention").

## Working with snapshots considerations

* **Do not move a file within a snapshot directory or between snapshots:** \
  Moving a file within a snapshot directory or between snapshots is implemented as a copy operation by the kernel, similar to moving between different filesystems. However, such operations for directories will fail.
* **Working with symlinks (symbolic links):**\
  When accessing symlinks through the `.snapshots` directory, symlinks with absolute paths can lead to the current filesystem. Depending on your needs, consider either not following symlinks or using relative paths.
* **Snapshot estimated reclaimable space:**\
  The estimate is an upper limit of capacity that can be freed by deleting the snapshot. It is the size of all data accessible from a snapshot but not accessible from newer snapshots or the active file system. In snapshot chains without writable snapshots, deleting multiple consecutive snapshots (only the oldest N snapshots) release the sum of Estimated Reclaimable Space amounts. Snapshots created before an upgrade to 4.4 or downloaded from OBS may not have an Estimated Reclaimable Space available.

## Maximum supported snapshots

The maximum number of snapshots in a system depends on whether they are read-only or writeable.

* If all snapshots are read-only, the maximum is 24K (24,576).
* If all snapshots are writable, the maximum is 14K (14,336).

A system can have a mix of read-only and writable snapshots, given that a writable snapshot consumes about twice the internal resources of a read-only snapshot.

Some examples of mixing maximum read-only and writable snapshots that a system can have:

* 20K read-only and 4K writable snapshots.
* 12K read-only and 8K writable snapshots.

{% hint style="info" %}
A live filesystem is counted as part of the maximum writable snapshots.
{% endhint %}

## Track filesystem changes with the DiffList REST API

Use the DiffList REST API to identify and list changes between two filesystem states, such as two snapshots or a snapshot and the live state. This function supports backup, auditing, and data movement workflows by detecting changes without performing a full filesystem scan.

The DiffList API service runs on a configured and active Data Service container (`dataserv`). You can compare any two filesystem states, regardless of their creation order. For example, you can compare an early snapshot with a more recent one. The API returns paginated results to effectively manage large datasets.

Each change entry provides an operation type (`opType`) that combines the object type and the change action. The entry also includes attributes that describe the event, such as its path, size, and whether it was renamed.

Using the API is a two-step process that supports parallel processing, enabling fast, large-scale change analysis for automated workflows

**Before you begin**

* Ensure at least one `dataserv` container is configured and running.
* Enable the DiffList feature by running the `weka debug override add --key snapshot_difflist.enabled` command.

**Procedure**

1. Prepare the change query using the `POST /snapshots/diff/prepare` endpoint to obtain processing tokens.
2. Retrieve the paginated change lists using the `POST /snapshots/diff/getResults` endpoint.



**Related topics**

[snapshots.md](snapshots.md "mention")

[snapshots-1.md](snapshots-1.md "mention")

[weka-rest-api-and-equivalent-cli-commands.md](../../getting-started-with-weka/weka-rest-api-and-equivalent-cli-commands.md "mention") (Snapshots)

[set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/set-up-a-data-services-container-for-background-tasks.md "mention")
