---
description: >-
  This is a quick reference guide using the CLI to perform the first IO in the
  WEKA filesystem.
---

# Run first IOs with WEKA filesystem

Once the system is installed and you are familiar with the CLI and GUI, you can connect to one of the servers and try it out.

To perform a sanity check that the WEKA cluster is configured and IOs can be performed on it, do the following procedures:

1. [Create the first filesystem](performing-the-first-io.md#create-the-first-filesystem).
2. [Mount the filesystem](performing-the-first-io.md#mount-the-filesystem).
3. [Writing to the filesystem](performing-the-first-io.md#write-to-the-filesystem).

To validate that the WEKA cluster and IT environment are best configured to benefit from the WEKA filesystem, do the following procedure:

* [Validate the configuration](performing-the-first-io.md#validate-the-configuration).

## Create the first filesystem

1. A filesystem must reside in a filesystem group. Create a filesystem group:

```
# to create a new filesystem group
$ weka fs group create my_fs_group
FSGroupId: 0

# to view existing filesystem groups details in the WEKA system
$weka fs group
FileSystem Group ID | Name        | target-ssd-retention | start-demote
--------------------+-------------+----------------------+-------------
FSGroupId: 0        | my_fs_group | 1d 0:00:00h          | 0:15:00h
```

2\. Create a filesystem within that group:

```
# to create a new filesystem
$ weka fs create new_fs my_fs_group 1TiB
FSId: 0

# to view existing filesystems details in the WEKA system
$ weka fs
Filesystem ID | Filesystem Name | Group       | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+-------------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | new_fs          | my_fs_group | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
```

{% hint style="info" %}
In AWS installation via the [self-service portal](https://start.weka.io/), the default filesystem group and filesystem are created. The `default` filesystem is created with the entire SSD capacity.

For creating an additional filesystem, it is first needed to decrease the `default` filesystem SSD size:

```
# to reduce the size of the default filesystem
$ weka fs update default --total-capacity 1GiB

# to create a new filesystem in the default group
$ weka fs create new_fs default 1GiB

# to view existing filesystems details in the WEKA system
$ weka fs
Filesystem ID | Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | default         | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.43 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21589     | READY  | False     |                 | False
1             | new_fs          | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
```
{% endhint %}

For more information about filesystems and filesystem groups, see [Managing Filesystems, Object Stores & Filesystem Groups](broken-reference).

## Mount the filesystem

1. To mount a filesystem, create a mount point and call the mount command:

```
$ sudo mkdir -p /mnt/weka
$ sudo mount -t wekafs new_fs /mnt/weka

```

2\. Check that the filesystem is mounted:

```
# using the mount command
$ mount | grep new_fs
new_fs on /mnt/weka type wekafs (rw,relatime,writecache,inode_bits=64,dentry_max_age_positive=1000,dentry_max_age_negative=0)
```

{% hint style="info" %}
In AWS installation via the [self-service portal](https://start.weka.io/), the `default` filesystem is already mounted under `/mnt/weka.`
{% endhint %}

For more information about mounting filesystems and mount options, refer to [Mounting Filesystems](../weka-filesystems-and-object-stores/mounting-filesystems/#overview).

## Write to the filesystem

Write data to the filesystem:

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

This has completed the sanity check that the WEKA cluster is configured and IOs can be performed on it.

## Validate the configuration

To ensure that the WEKA cluster and the IT environment are well configured, more complex IO patterns and benchmark tests should be conducted using the FIO utility.

Although results can vary using different servers and networking, it is not expected to be very different than what many other customers and we achieved. A properly configured WEKA cluster and IT environment should yield similar results described in the WEKA performance tests section.

{% hint style="info" %}
The numbers achieved in the benchmark tests, as described in the WEKA performance tests section, are not just achieved in a controlled environment. Similar numbers should be achieved using a similar configuration if the WEKA cluster and IT environment are properly configured.

If the numbers achieved in your environment significantly vary from those, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) before running any other workload on the WEKA cluster.
{% endhint %}

**Related topic**

[testing-weka-system-performance](../performance/testing-weka-system-performance/ "mention")
