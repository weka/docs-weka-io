---
description: >-
  Snapshots enable the saving of a filesystem state to a directory and can be
  used for backup, archiving and testing purposes.
---

# Snapshots

Snapshots allow the saving of a filesystem state to a `.snapshots`directory located under the root filesystem. They can be used for:

* **Physical backup:** The snapshot directory can be copied into a different storage system, possibly on another site, using either the Weka system Snap-To-Object feature or third-party software.
* **Logical backup:** Periodic snapshots enable filesystem restoration to a previous state if logical data corruption occurs.
* **Archive:** Periodic snapshots enable accessing a previous filesystem state for compliance or other needs.
* **DevOps environments:** Writable snapshots enable the execution of software tests on copies of the data.

Snapshots have no impact on system performance and can be taken for each filesystem while applications are running. They consume minimal space, according to the differences between the filesystem and the snapshots, or between the snapshots, in 4K granularity.

By default, snapshots are read-only, and any attempt to change the content of a read-only snapshot returns an error message.

It is possible to create a writable snapshot or update an existing snapshot to be writable. However, a writable snapshot cannot be changed to a read-only snapshot.

The Weka system supports the following snapshot operations:

* View snapshots.
* Create a snapshot of an existing filesystem.
* Delete a snapshot.
* Access a snapshot under a dedicated directory name.
* Restore a filesystem from a snapshot.
* Make snapshots writable.
* Create a snapshot of a snapshot (relevant for writable snapshots or read-only snapshots before being made writable).
* List the snapshots and obtain their metadata.
* Schedule automatic **** snapshots (see [Snapshot management](../../appendix/snapshot-management.md) **** in the Appendix).

## Maximum supported snapshots

The maximum number of snapshots in a system depends on whether they are read-only or writeable.

* If all snapshots are read-only, the maximum is 24K (24,576).
* If all snapshots are writable, the maximum is 14K (14,336).

A system can have a mix of read-only and writable snapshots, given that a writable snapshot consumes about twice the internal resources of a read-only snapshot.

Some examples of mixing maximum read-only and writable snapshots that a system can have:

* 20K read-only and 4K writable snapshots.
* 12K read-only and 8K writable snapshots.

{% hint style="info" %}
**Note:** A live filesystem is counted as part of the maximum writable snapshots.
{% endhint %}

**Related topics**

****[snapshots.md](snapshots.md "mention")****

****[snapshots-1.md](snapshots-1.md "mention")****
