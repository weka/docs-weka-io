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
mount -t wekafs [options] <fs-name> <mount-point>
```

## Page Cache {#page-cache}

WekaIO utilizes the Linux page cache for the mounted filesystem. This allows for better performance when accessing the same files multiple times at around the same time.

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

