---
description: >-
  Use this procedure to perform a basic input/output (IO) sanity check on a
  newly installed WEKA cluster to confirm it is operational.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/getting-started-with-weka/performing-the-first-io
---

# Perform a basic IO sanity check

Use this procedure to perform a basic input/output (IO) sanity check on a newly installed WEKA cluster. This check involves creating a filesystem, mounting it, and writing a small amount of data to confirm the system is operational.

After completing this sanity check, you can proceed to validate that the WEKA cluster and your IT environment are configured for optimal performance.

## Create a filesystem

To create a filesystem, you first create a filesystem group and then create the filesystem within that group.

**Procedure**

1.  Create a filesystem group. A filesystem must reside in a group.

    ```bash
    $ weka fs group create my_fs_group
    FSGroupId: 0
    ```
2.  View the existing filesystem groups to confirm the creation.

    ```bash
    $ weka fs group
    FileSystem Group ID | Name        | target-ssd-retention | start-demote
    FSGroupId: 0          | my_fs_group | 1d 0:00:00h          | 0:15:00h
    ```
3.  Create a filesystem within the new group.

    ```bash
    $ weka fs create new_fs my_fs_group 1TiB
    FSId: 0
    ```
4.  View the existing filesystems to confirm the creation

    ```bash
    $ weka fs
    Filesystem ID | Filesystem Name | Group       | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
    +-------------+-----------------+-------------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+---------------+
    0             | new_fs          | my_fs_group | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
    ```

{% hint style="info" %}
On WEKA systems installed in AWS through the [self-service portal,](https://start.weka.io/) a `default` filesystem group and a `default` filesystem are created automatically. The `default` filesystem uses the entire available SSD capacity.

To create an additional filesystem, first reduce the size of the `default` filesystem.

```
# Reduce the size of the default filesystem
$ weka fs update default --total-capacity 1GiB

# Create a new filesystem in the default group
$ weka fs create new_fs default 1GiB

# View the existing filesystems
$ weka fs
Filesystem ID | Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
--------------+-----------------+---------+-----------------+-----------------+----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+--------------
0             | default         | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.07 GB  | 268.43 MB            | 1.07 GB       | 0 B               | 4.09 KB    | 1.07 GB    | 1.07 GB         | 21589     | READY  | False     |                 | False
1             | new_fs          | default | 0 B             | 4.09 KB         | 4.09 KB  | 1.09 TB  | 274.87 GB            | 1.09 TB       | 0 B               | 4.09 KB    | 1.09 TB    | 1.09 TB         | 22107463  | READY  | False     |                 | False
```
{% endhint %}

## Mount the filesystem

To mount the filesystem, create a mount point directory on your server and use the `mount` command.

**Procedure**

1.  Create a directory to serve as the mount point and mount the filesystem.

    ```bash
    $ sudo mkdir -p /mnt/weka
    $ sudo mount -t wekafs new_fs /mnt/weka
    ```
2.  Verify that the filesystem is mounted.

    ```bash
    $ mount | grep new_fs
    new_fs on /mnt/weka type wekafs (rw,relatime,writecache,inode_bits=64,dentry_max_age_positive=1000,dentry_max_age_negative=0)
    ```

{% hint style="info" %}
On WEKA systems installed in AWS through the [self-service portal](https://start.weka.io/), the `default` filesystem is already mounted under `/mnt/weka`.
{% endhint %}

## Write data to the filesystem

Write a test file to the mounted filesystem to confirm that IO operations are working correctly.

**Procedure**

1.  Use the `dd` command to write a small file to the mount point.

    ```bash
    $ sudo dd if=/dev/urandom of=/mnt/weka/my_first_data bs=4096 count=10000
    10000+0 records in
    10000+0 records out
    40960000 bytes (41 MB) copied, 4.02885 s, 10.2 MB/s
    ```
2.  List the contents of the directory to see the new file.

    ```bash
    $ ls -l /mnt/weka
    total 40000
    -rw-r--r-- 1 root root 40960000 Oct 30 11:58 my_first_data
    ```
3.  View the filesystem details to see the change in used SSD capacity.

    ```bash
    $ weka fs
    Filesystem ID | Filesystem Name | Group   | Used SSD (Data) | Used SSD (Meta) | Used SSD  | Free SSD | Available SSD (Meta) | Available SSD | Used Total (Data) | Used Total | Free Total | Available Total | Max Files | Status | Encrypted | Object Storages | Auth Required
    +-------------+-----------------+---------+-----------------+-----------------+-----------+----------+----------------------+---------------+-------------------+------------+------------+-----------------+-----------+--------+-----------+-----------------+---------------+
    0             | default         | default | 40.95 MB        | 180.22 KB       | 41.14 MB  | 1.03 GB  | 268.43 MB            | 1.07 GB       | 40.95 MB          | 41.14 MB   | 1.03 GB    | 1.07 GB         | 21589     | READY  | False     |                 | False
    ```

    This completes the basic sanity check.

## Validate the cluster configuration

To ensure the WEKA cluster and your IT environment are optimally configured, run benchmark tests using a tool such as FIO. A properly configured environment should produce performance results similar to those documented in the official WEKA performance tests.

If your benchmark results differ significantly from the expected values, contact the Customer Success Team for assistance before running production workloads on the cluster.

**Related topics**

[Filesystems & Object Stores](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/weka-filesystems-and-object-stores "mention")

[mounting-filesystems](../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")

[testing-weka-system-performance](../performance/testing-weka-system-performance/ "mention")

[#contact-customer-success-team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team "mention")
