---
description: >-
  Confirm a new NeuralMesh cluster is operational by creating, mounting, and
  writing to a filesystem.
---

# Perform a basic IO sanity check

Validate a newly installed NeuralMesh cluster with a basic input/output (I/O) check. Create and mount a filesystem, then write a small amount of data to confirm the system operates.

After this check, validate the NeuralMesh cluster and IT environment for optimal performance.

## Create a filesystem

Create a filesystem group before creating a filesystem in that group.

**Procedure**

1.  Create a filesystem group. A filesystem must reside in a group.

    ```bash
    $ weka fs group add my_fs_group
    Created filesystem group my_fs_group with ID 2.
    ```
2.  View the existing filesystem groups to confirm the creation.

    ```bash
    $ weka fs group
    ID  Name         SSD Retention  Start Demote
     0  .meta          1d 0:00:00h      0:15:00h
     1  default        1d 0:00:00h      0:15:00h
     2  my_fs_group
    ```

    A group created without `--ssd-retention` or `--start-demote` shows no value for those columns: the group has no tiering policy yet, rather than a policy set to zero. Set both with `weka fs group update` before you attach an object store to a filesystem in the group. The `.meta` and `default` groups created with the cluster already have values.
3.  Create a filesystem within the new group.

    ```bash
    $ weka fs add new_fs 100GiB --fs-group my_fs_group
    Created filesystem with ID 3.
    ```
4.  View the existing filesystems to confirm the creation

    ```bash
    $ weka fs
    ID  Name        Group ID  Used SSD  Available SSD  Used Total  Available Total  Thin Provisioned
     0  .config_fs         0  12.29 KB        5.37 GB    12.29 KB          5.37 GB        False
     1  default            1  12.29 KB      214.75 GB    12.29 KB        214.75 GB        False
     3  new_fs             2  12.29 KB      107.37 GB    12.29 KB        107.37 GB        False
    ```

{% hint style="info" %}
On NeuralMesh clusters installed in AWS through the [self-service portal,](https://start.weka.io/) a `default` filesystem group and a `default` filesystem are created automatically. The `default` filesystem uses the entire available SSD capacity.

To create an additional filesystem, first reduce the size of the `default` filesystem.

```
# Reduce the size of the default filesystem
$ weka fs update default --total-capacity 1GiB
Updated filesystem default.

# Create a new filesystem in the default group
$ weka fs add new_fs 1GiB --fs-group default
Created filesystem with ID 2.

# View the existing filesystems
$ weka fs
ID  Name        Group ID  Used SSD  Available SSD  Used Total  Available Total  Thin Provisioned  Thin Provisioned Minimum SSD  Thin Provisioned Maximum SSD
 0  .config_fs         0  12.29 KB        5.37 GB    12.29 KB          5.37 GB        False
 1  default            1  12.29 KB        1.07 GB    12.29 KB          1.07 GB        False
 2  new_fs             1  12.29 KB        1.07 GB    12.29 KB          1.07 GB        False
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
On NeuralMesh clusters installed in AWS through the [self-service portal](https://start.weka.io/), the `default` filesystem is already mounted under `/mnt/weka`.
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
    ID  Name        Group ID   Used SSD  Available SSD  Used Total  Available Total  Thin Provisioned  Thin Provisioned Minimum SSD  Thin Provisioned Maximum SSD
     0  .config_fs         0  442.37 KB       21.47 GB   442.37 KB         21.47 GB        False
     1  default            1   12.29 KB      200.00 GB    12.29 KB        200.00 GB        False
     3  new_fs             1   41.19 MB        1.07 GB    41.19 MB          1.07 GB        False
    ```

    This completes the basic sanity check.

## Validate the cluster configuration

To ensure the NeuralMesh cluster and your IT environment are optimally configured, run benchmark tests using a tool such as FIO. A properly configured environment should produce performance results similar to those documented in the official NeuralMesh performance tests.

If your benchmark results differ significantly from the expected values, contact the Customer Success Team for assistance before running production workloads on the cluster.

**Related topics**

[Filesystems & Object Stores](https://app.gitbook.com/s/qDcZwR9zamxPsY03oTOq/weka-filesystems-and-object-stores "mention")

[mounting-filesystems](../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")

[testing-weka-system-performance](../performance/testing-weka-system-performance/ "mention")

[#open-a-support-case](../support/getting-support-for-your-weka-system.md#open-a-support-case "mention")
