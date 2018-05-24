# Mounting Filesystems

To use a filesystem you’d have to mount it on one of the cluster hosts.

Let’s assume our cluster has a filesystem named `demo`. SSH into one of your hosts and run the following `mount`command as the `root` user:

```text
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general structure of a `mount` command for a WekaIO filesystem is:

```text
mount -t wekafs [options] <fs-name> <mount-point>
```

## Page Cache {#page-cache}

WekaIO utilizes Linux’s page-cache for the mounted filesystem, which allows for better performance when accessing the same files multiple times around the same times.

## Setting Up Automount \(autofs\)

A WekaIO filesystem can be mounted using `autofs`.

This is useful because mounting a WekaIO filesystem can only be done after WekaIO has started running on a host. As a result, you can't mount WekaIO filesystems at boot time by adding them to `/etc/fstab`.

To get started, install `autofs` on your host:

```text
# On RedHat/Centos
yum install -y autofs
```

```text
# On Debian/Ubuntu
apt-get install -y autofs
```

Then, simply run the following commands to create the `autofs` configuration files for WekaIO filesystems:

```text
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs" > /etc/auto.master.d/wekafs.autofs
echo "*   &" > /etc/auto.wekafs
```

Finally, restart the `autofs` service:

```text
service autofs restart
```

You can now access WekaIO filesystems by accessing `/mnt/weka/<fs-name>`. For example, the `default` filesystem would be automatically mounted under `/mnt/weka/default`.

