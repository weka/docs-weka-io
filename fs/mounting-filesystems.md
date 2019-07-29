---
description: >-
  To use a filesystem via the WekaIO filesystem driver, it has to be mounted on
  one of the cluster hosts. This page describes how this is performed.
---

# Mounting Filesystems

## Overview

There are two methods available for mounting a filesystem in one of the cluster hosts:

1. Using the traditional method: See below and also refer to [Adding Clients](https://docs.weka.io/~/edit/drafts/-LTq8BSEMpeayMPh2Klz/v/3.1.9/install/bare-metal/adding-clients-bare-metal) \(Bare Metal Installation\) or [Adding Clients](../install/aws/adding-clients.md) \(AWS Installation\), where first a client is configured and joins a cluster, after which a mount command is executed.
2. Using the Stateless Clients feature: See [Mounting Filesystems Using the Stateless Clients Feature](https://docs.weka.io/~/edit/drafts/-LTq8BSEMpeayMPh2Klz/v/3.1.9/fs/mounting-filesystems#mounting-filesystems-using-stateless-clients) below, which simplifies and improves the management of clients in the cluster and eliminates the Adding Clients process.

This page describes both these options.

## Traditional Method for Mounting a Filesystem

{% hint style="info" %}
**Note:** Using the mount command as explained below first requires the installation of the WekaIO client, configuring of the client and joining it to a WekaIO cluster.
{% endhint %}

To mount a filesystem on one of the cluster hosts, let’s assume the cluster has a filesystem called `demo`. To add this filesystem to a host, SSH into one of the hosts and run the `mount`command as the `root` user, as follows:

```text
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general structure of a`mount` command for a WekaIO filesystem is:

```text
mount -t wekafs [-o option[,option]...]] <fs-name> <mount-point>
```

There are three options for mounting a filesystem on a cluster client: coherent, read cache and write cache. Refer to the descriptions in the links below to understand the differences between these modes:

* [Coherent mount mode](../overview/weka-client-and-mount-modes.md#coherent-mount-mode)
* [Read cache mount mode](../overview/weka-client-and-mount-modes.md#read-cache-mount-mode-default)
* [Write cache mount mode](../overview/weka-client-and-mount-modes.md#write-cache-mount-mode)

## Mounting Filesystems Using the Stateless Clients Feature <a id="mounting-filesystems-using-stateless-clients"></a>

The Stateless Clients feature defers the process of joining the cluster until a mount is performed. Simplifying and improving the management of clients in the cluster, it removes tedious client management procedures, which is particularly beneficial in AWS installations where clients may join and leave in high frequency. Furthermore, it unifies all security aspects in the mount command, eliminating the search of separate credentials at cluster join and mount.

To use the Stateless Clients feature, a WekaIO agent must be installed. Once this is complete, mounts can be created and configured using the mount command, and can be easily removed from the cluster using the unmount command.

Assuming the WekaIO cluster is using the backend IP of `1.2.3.4`, running the following command as `root` on a client will install the agent:

`curl http://1.2.3.4:14000/dist/v1/install | sh`

On completion, the agent is installed on the client machine.



#### Invoking the Mount Command

**Command:** `mount -t wekafs`

Use the following command line to invoke the mount command:

`mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-path>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `options` | ​ | See Additional Mount Options below | ​ | ​ | ​ |
| `backend` | String | IP/host name of a backend host | Must be a valid name | Yes | ​ |
| `fs` | String | Filesystem name | Must be a valid name | Yes | ​ |
| `mount-path` | String | Path to mount on the local machine | Must be a valid path name | Yes | ​ |

## Mount Mode Command Options

Each mount option can be passed with an individual `-o` flag to `mount`

### For All Clients types

| Option | Value | Description | Default |
| :--- | :--- | :--- | :--- |
| `coherent` | None | Set mode to coherent | No |
| `readcache` | None | Set mode to read cache | No |
| `writecache` | None | Set mode to write cache | Yes |
| `dentry_max_age_positive` | Positive number, time in milliseconds | After the defined time period, every metadata cached entry is refreshed from the system, allowing the host to take into account metadata changes performed by other hosts. | 1000 |
| `dentry_max_age_negative` | Positive number, time in milliseconds | Each time a file or directory lookup fails, an entry specifying that the file or directory does not exist is created in the local dentry cache. This entry is refreshed after the defined time, allowing the host to use files or directories created by other hosts. | 0 |
| `ro` | None | Mount filesystem as read-only | No |
| `rw` | None | Mount filesystem as read-write | Yes |
| `inode_bits` | 32, 64 or auto | Size of the inode in bits, which may be required for 32 bit applications. | Auto |
| `verbose` | None | Write debug logs to the console | No |
| `quiet` | None | Don't show any logs to console | No |
| `acl` | None | Per mount; can degrade access if defined | No |

### **Additional Mount Options Available using the Stateless Clients Feature**

<table>
  <thead>
    <tr>
      <th style="text-align:left">Option</th>
      <th style="text-align:left">Value</th>
      <th style="text-align:left">Description</th>
      <th style="text-align:left">Default</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>memory_mb</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">The amount of memory to be used by the client (for huge pages)</td>
      <td
      style="text-align:left">1400 MiB</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>num_cores=&lt;frontend-cores&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">
        <p>Number of frontend cores to allocate for the client.</p>
        <p>Either<code>&lt;num_cores&gt;</code> or<code>&lt;core&gt;</code> can be
          specified, but not both.</p>
        <p>If none are specified, the client will be configured with 1 core.</p>
        <p>If 0 is specified then you must use <code>net=udp</code>.</p>
      </td>
      <td style="text-align:left">1</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>net=&lt;netdev&gt;[/&lt;ip&gt;/&lt;bits&gt;[/&lt;gateway&gt;]]</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">
        <p>This option must be specified for on-premises installation, and must not
          be specified for AWS installations.</p>
        <p><code>&lt;netdev&gt;</code> is the name, MAC address or PCI address of
          the network device to allocate for the client. A mixture of Ethernet and
          IB is not allowed.</p>
        <p>The<code>&lt;ip&gt;</code>,<code>&lt;bits&gt;</code> and<code>&lt;gateway&gt;</code> options
          allow for configuration of the IP address, netmask bits and gateway for
          the device.</p>
        <p>The gateway itself is optional and does not have to be specified when
          no routing is required in the data network.</p>
        <p>In the cluster, device names are generated by the order in which they
          appear in the command line. For example, if there are two <code>--net</code> options,
          there will be two devices named <code>net0</code> and <code>net1</code>as
          far as the host is concerned. The cluster names them by prefixing the host
          ID, e.g.,<code>host3net0</code>, <code>host3net1</code>.</p>
      </td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>bandwidth_mbps=&lt;bandwidth_mbps&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">
        <p>The network bandwidth limitation for the entire container, in Mb/s.</p>
        <p>This limitation is for all nodes running within the container, and an
          attempt is made to detect it automatically based on the environment e.g.,
          when in AWS. Setting a per-node limitation can be performed in the container
          definition file.</p>
      </td>
      <td style="text-align:left">Auto-select</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>remove_after_secs=&lt;secs&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">The number of seconds without connectivity after which the client will
        be removed from the cluster.
        <br />Minimum value: 60 seconds.</td>
      <td style="text-align:left">86,720 seconds (24 hours)</td>
    </tr>
  </tbody>
</table>{% hint style="info" %}
**Note:** These parameters are only effective on the first mount command for each client.
{% endhint %}

{% hint style="success" %}
**For Example: On Premises Installations**

`mount -t wekafs -o num_cores=1 -o net=ib0 backend-host-0/my_fs /mnt/weka`

Running this command on a host installed with the WekaIO agent will download the appropriate WekaIO version from the host`backend-host-0`and create a WekaIO container which allocates a single core and a named network interface \(`ib0`\). Then it will join the cluster that `backend-host-0` is part of and mount the filesystem `my_fs` on `/mnt/weka.`
{% endhint %}

{% hint style="success" %}
**For Example: AWS Installations**

`mount -t wekafs -o num_cores=2 backend1,backend2,backend3/my_fs /mnt/weka`

Running this command on an AWS host will allocate two cores \(multiple-frontends\) and attach and configure 2 ENIs on the new client. The client will attempt to rejoin the cluster via all three backends used in the command line.
{% endhint %}

Any subsequent mount commands after the first `mount` command \(where the client software is installed and the host joins the cluster\) can use the same command, or use just the traditional mount parameters as defined in [Mounting Filesystems](mounting-filesystems.md#mount-mode-command-options), since it is not necessary to join a cluster. 

{% hint style="info" %}
**Note:** The configuration is distribution-dependent and it is necessary to ensure that the service is configured to start automatically after the host is rebooted. To verify that the  autofs service automatically starts after restarting the server, run the following command: `systemctl is-enabled autofs.` If output is `enabled`, the service is configured to start automatically.
{% endhint %}

It is now possible to access WekaIO filesystems using the`cd /mnt/weka/<fs-name>` command. 

After the execution of an`unmount` command which unmounts the last WekaIO filesystem, the client is disconnected from the cluster and will be uninstalled by the agent. Consequently, executing a new `mount` command requires the specification of the cluster, cores and networking parameters again.

{% hint style="info" %}
**Note:** By default, the command selects the optimal core allocation for WekaIO. If necessary, contact the WekaIO Support Team to learn how to allocate specific cores to the WekaIO client.
{% endhint %}

{% hint style="info" %}
**Note:** When running in AWS, the instance IAM role must allow the following permissions:`ec2:AttachNetworkInterface`, `ec2:CreateNetworkInterface` and `ec2:ModifyNetworkInterfaceAttribute.`.
{% endhint %}

{% hint style="info" %}
**Note:** Memory allocation for a client is predefined. Contact the WekaIO Support Team when it is necessary to change the amount of memory allocated to a client.
{% endhint %}

## Page Cache <a id="page-cache"></a>

WekaIO utilizes the Linux page cache for the mounted filesystem. This allows for better performance when accessing the same files multiple times at around the same time.

## Setting Up Automount \(autofs\)

It is possible to mount a WekaIO filesystem using the `autofs` command. This is useful because mounting a WekaIO filesystem can only be performed after the WekaIO system has started running on a host, i.e., it is not possible to mount WekaIO filesystems at boot time by adding them to `/etc/fstab`.

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

Or run the following commands for stateless clients \(which require the backend names as parameters\):

```text
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs,num_cores=1,net=<netdevice>" > /etc/auto.master.d/wekafs.autofs
echo "*   <backend-1>,<backend-2>/&" > /etc/auto.wekafs
```

Finally, restart the `autofs` service:

```text
service autofs restart
```

{% hint style="info" %}
**Note:** The configuration is distribution-dependent and it is necessary to ensure that the service is configured to start automatically after the host is rebooted. To verify that the  autofs service automatically starts after restarting the server, run the following command: `systemctl is-enabled autofs.` If output is `enabled`, the service is configured to start automatically.
{% endhint %}

It is now possible to access WekaIO filesystems using the`cd /mnt/weka/<fs-name>` command. 

{% hint style="success" %}
**For Example:** The`default`filesystem is automatically mounted under`/mnt/weka/default`.
{% endhint %}

