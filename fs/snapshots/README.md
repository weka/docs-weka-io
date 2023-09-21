---
description: >-
  Snapshots enable the saving of a filesystem state to a directory and can be
  used for backup, archiving and testing purposes.
---

# Snapshots

Snapshots allow the saving of a filesystem state to a `.snapshots` directory under the root filesystem. They can be used for:

* **Physical backup:** The snapshots directory can be copied into a different storage system, possibly on another site, using either the WEKA system Snap-To-Object feature or third-party software.
* **Logical backup:** Periodic snapshots enable filesystem restoration to a previous state if logical data corruption occurs.
* **Archive:** Periodic snapshots enable accessing a previous filesystem state for compliance or other needs.
* **DevOps environments:** Writable snapshots enable the execution of software tests on copies of the data.

Snapshots do not impact system performance and can be taken for each filesystem while applications run. They consume minimal space, according to the differences between the filesystem and the snapshots, or between the snapshots, in 4K granularity.

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
* Schedule automatic snapshots (see [Set up the SnapTool external snapshots manager](broken-reference) in the Appendix).

## Locate the `.snapshots` directory

The `.snapshots` directory is located in the root directory of each mounted filesystem. It is not displayed with the `ls -la` command. You can access this directory using the `cd .snapshots` command from the root directory.

#### Example

The following example shows a filesystem named  `default` mounted to `/mnt/weka`.&#x20;

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

## Working with snapshots considerations

* **Do not move a file within a snapshot directory or between snapshots:** \
  Moving a file within a snapshot directory or between snapshots is implemented as a copy operation by the kernel, similar to moving between different filesystems. However, such operations for directories will fail.
* **Working with symlinks (symbolic links):**\
  When accessing symlinks through the `.snapshots` directory, symlinks with absolute paths can lead to the current filesystem. Depending on your needs, consider either not following symlinks or using relative paths.

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

**Related topics**

[snapshots.md](snapshots.md "mention")

[snapshots-1.md](snapshots-1.md "mention")
