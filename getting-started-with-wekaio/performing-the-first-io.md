---
description: >-
  This page describes a quick guide using the CLI towards performing the first
  IO in a WekaFS filesystem.
---

# Performing the First IO

## Overview

Now that the system is installed and you've become familiar with the CLI/GUI, you can connect to one of the hosts and try it out. 

This page will guide you through the steps needed for performing IOs using a WekaFS filesystem:

* Creating a filesystem
* Mounting a filesystem
* Writing to a filesystem

## Creating the First Filesystem

A filesystem should reside in a filesystem group, so first, you will need to create a filesystem group:

```text
# to create a new filesystem group
$ weka fs group create my_fs_group
FSGroupId: 0

# to view existing filesystem groups details in the WekaIO system
$weka fs group
FileSystem Group ID | Name        | target-ssd-retention | start-demote
--------------------+-------------+----------------------+-------------
FSGroupId: 0        | my_fs_group | 1d 0:00:00h          | 0:15:00h
```

Now, you can create a filesystem within that group:

```
# to create a new filesystem
$ weka fs create new_fs my_fs_group 1GiB
FSId: 0

# to view existing filesystems details in the WekaIO system
$ weka fs
Filesystem Name | Group       | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Auth Required | Object Storages
----------------+-------------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+---------------+----------------
new_fs          | my_fs_group | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.02 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21556     | READY  | False     | False         |
```

{% hint style="info" %}
**Note:** In AWS installation via the [self-service portal](https://start.weka.io/), default filesystem group and filesystem are created. The `default` filesystem is created with the entire SSD capacity. 

For creating an additional filesystem, it is first needed to decrease the `default` filesystem SSD size:

```
# to reduce the size of the default filesystem
$ weka fs update default --total-capacity 1GiB
 
# to create a new filesystem in the default group
$ weka fs create new_fs default 1GiB
 
# to view existing filesystems details in the WekaIO system
$ weka fs
Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted
----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+----------
default         | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.43 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21589     | READY  | False
new_fs          | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.43 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21589     | READY  | False

```
{% endhint %}

For more information about filesystems and filesystem groups, refer to [Managing Filesystems, Object Stores & Filesystem Groups](../fs/managing-filesystems/).

## Mounting the First Filesystem

You can mount a filesystem by creating a mount point and calling the mount command:

```
$ sudo mkdir -p /mnt/weka
$ sudo mount -t wekafs new_fs /mnt/weka
```

To check the filesystem is indeed mounted:

```
# using the mount command
$ mount | grep new_fs
new_fs on /mnt/weka type wekafs (rw,relatime,writecache,inode_bits=64,dentry_max_age_positive=1000,dentry_max_age_negative=0)

# using ls to check for the existence of .snapshots directory in the mount point
$ ls -a /mnt/weka/
.  ..  .snapshots
```

{% hint style="info" %}
**Note:**  In AWS installation via the [self-service portal](https://start.weka.io/), the `default` filesystem is already mounted under `/mnt/weka`
{% endhint %}

For more information about mounting filesystems and mount options, refer to [Mounting Filesystems](../fs/mounting-filesystems.md#overview).

## Writing to the Filesystem

Now everything is set up, and you can write some data to the filesystem:

```text
# to perform random writes
$ sudo dd if=/dev/urandom of=/mnt/weka/my_first_data bs=4096 count=10000
10000+0 records in
10000+0 records out
40960000 bytes (41 MB) copied, 4.02885 s, 10.2 MB/s

# to see the new file creted
$ ll /mnt/weka
total 40000
-rw-r--r-- 1 root root 40960000 Oct 30 11:58 my_first_data

# to check the WekaFS filesystems via the CLI shows the used SSD capacity:
$ weka fs
Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted
----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+----------
default         | default | 40.95 MB        | 180.22 KB       | 41.14 MB | 1.03 GB  | 268.43 MB            | 1.07 GB       | 40.95 MB          | 41.14 MB   | 1.03 GB    | 1.07 GB         | 21589     | READY  | False
```

For more complex IO patterns and benchmark tests via the FIO utility, refer to [Testing WekaIO Performance](../testing-and-troubleshooting/testing-weka-system-performance.md).

