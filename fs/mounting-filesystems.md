---
description: >-
  To use a filesystem, it has to be mounted on one of the cluster hosts. This
  page describes how this is performed.
---

# Mounting Filesystems

## Mounting a Filesystem on a Cluster Host

To mount a filesystem on one of the cluster hosts, let’s assume the cluster has a filesystem called `demo`. To add this filesystem to a host, SSH into one of the hosts and run the `mount`command as the `root` user, as follows:

```text
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general structure of a`mount` command for a WekaIO filesystem is:

```text
mount -t wekafs [option[,option]...]] <fs-name> <mount-point>
```

There are three options for mounting a filesystem on a cluster client: coherent, read cache and write cache. Refer to the descriptions below to understand the differences between these modes.

* [Coherent mount mode](../overview/weka-client-and-mount-modes.md#coherent-mount-mode)
* [Read cache mount mode](../overview/weka-client-and-mount-modes.md#read-cache-mount-mode-default)
* [Write cache mount mode](../overview/weka-client-and-mount-modes.md#write-cache-mount-mode)

## Mount Mode Command Options

| Option | Values | Description |
| :--- | :--- | :--- |
| `coherent` | None | Set mode to coherent |
| `readcache` | None | Set mode to read cache |
| `writecache` | None | Set mode to write cache |

## Control of Metadata Caching

The following two parameters exist for the fine-tuning of read or write caches of metadata in the Dentry cache:

| Option | Value | Description | Default |
| :--- | :--- | :--- | :--- |
| `dentry_max_age_positive` | Positive number, time in milliseconds | After the defined time period, every metadata cached entry is refreshed from the system, allowing the host to take into account metadata changes performed by other hosts. | 1000 |
| `dentry_max_age_negative` | Positive number, time in milliseconds | Each time a file or directory lookup fails, an entry specifying the file or directory does not exist is created in the local dentry cache. This entry is refreshed after the defined time, allowing the host to use files or directories created by other hosts. | 1000 |

In addition, the `inode_bits` option is available:

| Option | Value | Description | Default |
| :--- | :--- | :--- | :--- |
| `inode_bits` | 32, 64 or auto | Size of the inode in bits, which may be required for 32 bit applications. | Auto |

## Page Cache {#page-cache}

WekaIO utilizes the Linux page cache for the mounted filesystem. This allows for better performance when accessing the same files multiple times at about the same time.

## Setting Up Automount \(autofs\)

It is possible to mount a WekaIO filesystem using the `autofs` command. This is useful because mounting a WekaIO filesystem can only be performed after the Weka system has started running on a host, i.e., it is not possible to mount WekaIO filesystems at boot time by adding them to `/etc/fstab`.

To get started, install `autofs` on the host:

```text
# On RedHat/Centos
yum install -y autofs
```

```text
# On Debian/Ubuntu
apt-get install -y autofs
```

Then run the following commands to create the `autofs` configuration files for WekaIO filesystems:

```text
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs" > /etc/auto.master.d/wekafs.autofs
echo "*   &" > /etc/auto.wekafs
```

Finally, restart the `autofs` service:

```text
service autofs restart
```

It is now possible to access WekaIO filesystems using the`/mnt/weka/<fs-name>` command. 

{% hint style="warning" %}
**For Example:** The`default` filesystem is automatically mounted under`/mnt/weka/default`.
{% endhint %}

