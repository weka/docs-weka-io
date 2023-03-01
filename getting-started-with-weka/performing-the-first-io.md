---
description: >-
  This page describes a quick guide using the CLI towards performing the first
  IO in a WekaFS filesystem.
---

# Serving IOs with WekaFS

## Overview

Now that the system is installed and you've become familiar with the CLI/GUI, you can connect to one of the hosts and try it out.

This page will guide you through:

1. The steps needed for performing IOs using a WekaFS filesystem (this is a sanity test for the configuration):
   * [Creating a filesystem](performing-the-first-io.md#creating-the-first-filesystem)
   * [Mounting a filesystem](performing-the-first-io.md#mounting-the-first-filesystem)
   * [Writing to a filesystem](performing-the-first-io.md#writing-to-the-filesystem)
2. [Conducting performance testing](performing-the-first-io.md#validating-the-configuration-achieving-the-expected-performance) to make sure both the Weka cluster and the IT environment are best configured to reap the benefits of WekaFS.

## Creating the First Filesystem

A filesystem should reside in a filesystem group, so first, you will need to create a filesystem group:

```
# to create a new filesystem group
$ weka fs group create my_fs_group
FSGroupId: 0

# to view existing filesystem groups details in the Weka system
$weka fs group
FileSystem Group ID | Name        | target-ssd-retention | start-demote
--------------------+-------------+----------------------+-------------
FSGroupId: 0        | my_fs_group | 1d 0:00:00h          | 0:15:00h
```

Now, you can create a filesystem within that group:

```
# to create a new filesystem
$ weka fs create new_fs my_fs_group 1TiB
FSId: 0

# to view existing filesystems details in the Weka system
$ weka fs
Filesystem ID | Filesystem Name | Group       | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+-------------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | new_fs          | my_fs_group | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
```

{% hint style="info" %}
**Note:** In AWS installation via the [self-service portal](https://start.weka.io/), default filesystem group and filesystem are created. The `default` filesystem is created with the entire SSD capacity.

For creating an additional filesystem, it is first needed to decrease the `default` filesystem SSD size:

```
# to reduce the size of the default filesystem
$ weka fs update default --total-capacity 1GiB

# to create a new filesystem in the default group
$ weka fs create new_fs default 1GiB

# to view existing filesystems details in the Weka system
$ weka fs
Filesystem ID | Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | default         | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.43 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21589     | READY  | False     |                 | False
1             | new_fs          | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
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
```

{% hint style="info" %}
**Note:** In AWS installation via the [self-service portal](https://start.weka.io/), the `default` filesystem is already mounted under `/mnt/weka`
{% endhint %}

For more information about mounting filesystems and mount options, refer to [Mounting Filesystems](../fs/mounting-filesystems.md#overview).

## Writing to the Filesystem

Now everything is set up, and you can write some data to the filesystem:

```
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
Filesystem ID | Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | default         | default | 40.95 MB        | 180.22 KB       | 41.14 MB | 1.03 GB  | 268.43 MB            | 1.07 GB       | 40.95 MB          | 41.14 MB   | 1.03 GB    | 1.07 GB         | 21589     | READY  | False     |                 | False
```

This has completed the sanity check that the Weka cluster is configured and IOs can be performed to it.

## Validating the Configuration - Achieving the Expected Performance

To make sure that the Weka cluster and the IT environment are well configured, more complex IO patterns and benchmark tests should be conducted using the FIO utility.

Although results can vary using different hosts and networking, it is not expected to be very different than what we and many other customers achieved. Properly configured Weka cluster and IT environment should yield similar results as described in [Testing Weka Performance](../testing-and-troubleshooting/testing-weka-system-performance/).

{% hint style="info" %}
**Note:** The numbers achieved in the benchmark tests, as described in [Testing Weka Performance](../testing-and-troubleshooting/testing-weka-system-performance/) are not just achieved in a closed/controlled environment. Similar numbers should be achieved when using similar configuration, if the Weka cluster and IT environment are properly configured. If the numbers achieved in your environment significantly vary from those, please contact the Weka Sales or Support Team before running any other workload on the Weka cluster.

The example results shown in [Testing Weka Performance](../testing-and-troubleshooting/testing-weka-system-performance/), are tested on AWS. In general, for any of Weka reference architecture, you should expect lower than 300 microseconds latency and 5.5 GB/s throughput per host (for a single 100gbps link).
{% endhint %}

{% content-ref url="../testing-and-troubleshooting/testing-weka-system-performance/" %}
[testing-weka-system-performance](../testing-and-troubleshooting/testing-weka-system-performance/)
{% endcontent-ref %}
