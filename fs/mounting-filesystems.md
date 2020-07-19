---
description: >-
  To use a filesystem via the Weka filesystem driver, it has to be mounted on
  one of the cluster hosts. This page describes how this is performed.
---

# Mounting Filesystems

## Overview

There are two methods available for mounting a filesystem in one of the cluster hosts:

1. Using the traditional method: See below and also refer to [Adding Clients](../install/bare-metal/adding-clients-bare-metal.md) \(Bare Metal Installation\) or [Adding Clients](../install/aws/adding-clients.md) \(AWS Installation\), where first a client is configured and joins a cluster, after which a mount command is executed.
2. Using the Stateless Clients feature: See [Mounting Filesystems Using the Stateless Clients Feature](mounting-filesystems.md#mounting-filesystems-using-stateless-clients) below, which simplifies and improves the management of clients in the cluster and eliminates the Adding Clients process.

This page describes both these options.

## Traditional Method for Mounting a Filesystem

{% hint style="info" %}
**Note:** Using the mount command as explained below first requires the installation of the Weka client, configuring of the client and joining it to a Weka cluster.
{% endhint %}

To mount a filesystem on one of the cluster hosts, let’s assume the cluster has a filesystem called `demo`. To add this filesystem to a host, SSH into one of the hosts and run the `mount`command as the `root` user, as follows:

```text
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general structure of a`mount` command for a Weka filesystem is:

```text
mount -t wekafs [-o option[,option]...]] <fs-name> <mount-point>
```

There are two options for mounting a filesystem on a cluster client: read cache and write cache. Refer to the descriptions in the links below to understand the differences between these modes:

* [Read cache mount mode](../overview/weka-client-and-mount-modes.md#read-cache-mount-mode-default)
* [Write cache mount mode](../overview/weka-client-and-mount-modes.md#write-cache-mount-mode)

## Mounting Filesystems Using the Stateless Clients Feature <a id="mounting-filesystems-using-stateless-clients"></a>

The Stateless Clients feature defers the process of joining the cluster until a mount is performed. Simplifying and improving the management of clients in the cluster, it removes tedious client management procedures, which is particularly beneficial in AWS installations where clients may join and leave in high frequency. Furthermore, it unifies all security aspects in the mount command, eliminating the search of separate credentials at cluster join and mount.

To use the Stateless Clients feature, a Weka agent must be installed. Once this is complete, mounts can be created and configured using the mount command and can be easily removed from the cluster using the unmount command.

{% hint style="info" %}
**Note:** To allow only Weka authenticate users to mount a filesystem, set the filesystem `--auth-required` to `yes`. 
{% endhint %}

Assuming the Weka cluster is using the backend IP of `1.2.3.4`, running the following command as `root` on a client will install the agent:

`curl http://1.2.3.4:14000/dist/v1/install | sh`

On completion, the agent is installed on the client machine.

#### Invoking the Mount Command

**Command:** `mount -t wekafs`

Use the following command line to invoke the mount command:

`mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-point>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `options` | ​ | See Additional Mount Options below | ​ | ​ | ​ |
| `backend` | String | IP/hostname of a backend host | Must be a valid name | Yes | ​ |
| `fs` | String | Filesystem name | Must be a valid name | Yes | ​ |
| `mount-path` | String | Path to mount on the local machine | Must be a valid path-name | Yes | ​ |

## Mount Command Options

Each mount option can be passed with an individual `-o` flag to `mount.`

### For All Clients Types

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
      <td style="text-align:left"><code>readcache</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Set mode to read cache</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>writecache</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Set mode to write cache</td>
      <td style="text-align:left">Yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>dentry_max_age_positive</code>
      </td>
      <td style="text-align:left">Number in milliseconds</td>
      <td style="text-align:left">After the defined time period, every metadata cached entry is refreshed
        from the system, allowing the host to take into account metadata changes
        performed by other hosts.</td>
      <td style="text-align:left">1000</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>dentry_max_age_negative</code>
      </td>
      <td style="text-align:left">Number in milliseconds</td>
      <td style="text-align:left">Each time a file or directory lookup fails, an entry specifying that the
        file or directory does not exist is created in the local dentry cache.
        This entry is refreshed after the defined time, allowing the host to use
        files or directories created by other hosts.</td>
      <td style="text-align:left">0</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>ro</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Mount filesystem as read-only</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>rw</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Mount filesystem as read-write</td>
      <td style="text-align:left">Yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>inode_bits</code>
      </td>
      <td style="text-align:left">32, 64 or auto</td>
      <td style="text-align:left">Size of the inode in bits, which may be required for 32 bit applications.</td>
      <td
      style="text-align:left">Auto</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>verbose</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Write debug logs to the console</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>quiet</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Don&apos;t show any logs to console</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>acl</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">
        <p>Can be defined per mount.</p>
        <p>Setting POSIX ACLs can change the effective group permissions (via the <code>mask</code> permissions).
          When ACLs defined but the mount has no ACL, the effective group permissions
          is granted.)</p>
      </td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>obs_direct</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">See <a href="tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store Direct Mount</a> section</td>
      <td
      style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>noatime</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Do not update inode access times</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>strictatime</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Always update inode access times</td>
      <td style="text-align:left">No</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>relatime</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Update inode access times only on modification or change, or if inode
        has been accessed and <code>relatime_treshold</code> has passed.</td>
      <td
      style="text-align:left">Yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>relatime_threshold</code>
      </td>
      <td style="text-align:left">Number in seconds</td>
      <td style="text-align:left">
        <p>How much time (in seconds) to wait since an inode has been accessed (not
          modified) before updating the access time.</p>
        <p>0 means to never update the access time on access only.</p>
        <p>This option is relevant only if <code>relatime</code> is on.</p>
      </td>
      <td style="text-align:left">0 (infinite)</td>
    </tr>
  </tbody>
</table>

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
      <td style="text-align:left"><code>memory_mb=&lt;memory_mb&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Amount of memory to be used by the client (for huge pages)</td>
      <td style="text-align:left">1400 MiB</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>num_cores=&lt;frontend-cores&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">
        <p>The number of frontend cores to allocate for the client.</p>
        <p>Either<code>&lt;num_cores&gt;</code> or<code>&lt;core&gt;</code> can be
          specified, but not both.</p>
        <p>If none are specified, the client will be configured with 1 core.</p>
        <p>If 0 is specified then you must use <code>net=udp</code>.</p>
      </td>
      <td style="text-align:left">1</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>core=&lt;core&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Specify explicit cores to be used by the WekaFS client. Multiple cores
        can be specified.</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>net=&lt;netdev&gt;[/&lt;ip&gt;/&lt;bits&gt;[/&lt;gateway&gt;]]</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">
        <p>This option must be specified for on-premises installation, and <b>must not be specified for AWS</b> installations.</p>
        <p>For more info refer to <a href="mounting-filesystems.md#advanced-network-configuration-via-mount-options">Advanced Network Configuration via Mount Options</a> section.</p>
      </td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>bandwidth_mbps=&lt;bandwidth_mbps&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">
        <p>Network bandwidth limitation for the entire container, in Mb/s.</p>
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
      <td style="text-align:left">86,400 seconds (24 hours)</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>traces_capacity_mb=&lt;size-in-mb&gt;</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">
        <p>Traces capacity limit in MB.</p>
        <p>Minimum value: 512 MB.</p>
      </td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>reserve_1g_hugepages</code>
      </td>
      <td style="text-align:left">None</td>
      <td style="text-align:left">Controls the page allocation algorithm if to reserve only 2MB huge pages
        or also 1GB ones</td>
      <td style="text-align:left">Yes</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>readahead_kb=&lt;readahead&gt;</code>
      </td>
      <td style="text-align:left">Number in KB</td>
      <td style="text-align:left">Controls the readahead per mount (higher readahead better for sequential
        reads of large files)</td>
      <td style="text-align:left">32768</td>
    </tr>
  </tbody>
</table>

{% hint style="info" %}
**Note:** These parameters are only effective on the first mount command for each client.
{% endhint %}

{% hint style="info" %}
**Note:** By default, the command selects the optimal core allocation for Weka. If necessary, multiple `core` parameters can be used to allocate specific cores to the WekaFS client. E.g., `mount -t wekafs -o core=2 -o core=4 -o net=ib0 backend-host-0/my_fs /mnt/weka`
{% endhint %}

{% hint style="success" %}
**For Example: On-Premise Installations**

`mount -t wekafs -o num_cores=1 -o net=ib0 backend-host-0/my_fs /mnt/weka`

Running this command on a host installed with the Weka agent will download the appropriate Weka version from the host`backend-host-0`and create a Weka container which allocates a single core and a named network interface \(`ib0`\). Then it will join the cluster that `backend-host-0` is part of and mount the filesystem `my_fs` on `/mnt/weka.`

`mount -t wekafs -o num_cores=0 -o net=udp backend-host-0/my_fs /mnt/weka`

Running this command will use [UDP mode ](../overview/networking-in-wekaio.md#udp-mode)\(usually selected when the use of DPDK is not available\).
{% endhint %}

{% hint style="success" %}
**For Example: AWS Installations**

`mount -t wekafs -o num_cores=2 backend1,backend2,backend3/my_fs /mnt/weka`

Running this command on an AWS host will allocate two cores \(multiple-frontends\) and attach and configure two ENIs on the new client. The client will attempt to rejoin the cluster via all three backends used in the command line.
{% endhint %}

Any subsequent mount commands after the first `mount` command \(where the client software is installed and the host joins the cluster\) can use the same command, or use just the traditional mount parameters as defined in [Mounting Filesystems](mounting-filesystems.md#mount-mode-command-options), since it is not necessary to join a cluster.

It is now possible to access Weka filesystems via the mount-point, e.g., by `cd /mnt/weka/` command.

After the execution of an`umount` command which unmounts the last Weka filesystem, the client is disconnected from the cluster and will be uninstalled by the agent. Consequently, executing a new `mount` command requires the specification of the cluster, cores and networking parameters again.

{% hint style="info" %}
**Note:** When running in AWS, the instance IAM role is required to provide permissions to several AWS APIs, as described in [IAM Role Created in Template](../install/aws/cloudformation.md#iam-role-created-in-the-template).
{% endhint %}

{% hint style="info" %}
**Note:** Memory allocation for a client is predefined. Contact the Weka Support Team when it is necessary to change the amount of memory allocated to a client.
{% endhint %}

## Advanced Network Configuration via Mount Options

When using a stateless client, it is possible to alter and control many different networking options, such as:

* Virtual functions
* IPs 
* Gateway \(in case the client is on a different subnet\)
* Physical network devices \(for performance and HA\)
* UDP mode

Use `-o net=<netdev>` mount option with the various modifiers as described below.

`<netdev>` is either the name, MAC address, or PCI address of the physical network device to allocate for the client.

{% hint style="warning" %}
**Note:** When using `wekafs` mounts, both clients and backends should use the same type of networking technology \(either IB or Ethernet\).
{% endhint %}

### IP, Subnet, Gateway and Virtual Functions

For higher performance, the usage of multiple Frontends may be required. When using a NIC other than Mellanox, or when mounting a DPDK client on a VM, it is required to use [SR-IOV](../install/bare-metal/setting-up-the-hosts/#sr-iov-enablement) to expose a VF of the physical device to the client. Once exposed, it can be configured via the mount command.

When you want to determine the VFs IP addresses, or when the client resides in a different subnet and routing is needed in the data network, use`net=<netdev>/[ip]/[bits]/[gateway]`.

`ip, bits, gateway` are optional. In case they are not provided, the Weka system tries to deduce them when in AWS or IB environments, or allocate from the default data network otherwise. If both approaches fail, the mount command will fail.

**For example**, the following command will allocate two cores and a single physical network device \(intel0\). It will configure two VFs for the device and assign each one of them to one of the frontend nodes. The first node will receive 192.168.1.100 IP address, and the second will use 192.168.1.101 IP address. Both of the IPs have a 24 network mask bits and default gateway of 192.168.1.254.

```text
mount -t wekafs -o num_cores=2 -o net=intel0/192.168.1.100+192.168.1.101/24/192.168.1.254 backend1/my_fs /mnt/weka
```

### Multiple Physical Network Devices for Performance and HA

For performance or high availability, it is possible to use more than one physical network device.

#### Using multiple physical network devices for better performance

It's easy to saturate the bandwidth of a single network interface when using WekaFS. For higher throughput, it is possible to leverage multiple network interface cards \(NICs\). The `-o net` notation shown in the examples above can be used to pass the names of specific NICs to WekaFS host driver.

**For example**, the following command will allocate two cores and two physical network devices for increased throughput:

```text
mount -t wekafs -o num_cores=2 -o net=mlnx0,net=mlnx1 backend1/my_fs /mnt/weka
```

#### Using multiple physical network devices for HA configuration

Multiple NICs can also be configured to achieve redundancy \(refer to [Weka Networking HA](../overview/networking-in-wekaio.md#ha) section for more information\) in addition to higher throughput, for a complete, highly available solution. For that, use more than one physical device as previously described and, also, specify the the client management IPs using `-o mgmt_ip=<ip>+<ip2>` command line option.

**For example**, the following command will use two network devices for HA networking and allocate both devices to four Frontend processes on the client. Note the modifier `ha` is used here, which stands for using the device on all processes.

```text
mount -t wekafs -o num_cores=4 -o net:ha=mlnx0,net:ha=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```

**Advanced mounting options for multiple physical network devices**

With multiple Frontend processes \(as expressed by `-o num_cores`\), it is possible to control what processes use what NICs. This can be accomplished through the use of special command line modifiers called _slots_. In WekaFS, _slot_ is synonymous with a process number. Typically, the first WekaFS Frontend process will occupy slot 1, then the second - slot 2 and so on.

Examples of slot notation include `s1`, `s2`, `s2+1`, `s1-2`, `slots1+3`, `slot1`, `slots1-4` , where `-` specifies a range of devices, while `+` specifies a list. For example, `s1-4` implies slots 1, 2, 3 and 4, while `s1+4` specifies slots 1 and 4 only.

**For example**, in the following command, `mlnx0` is bound to the second Frontend process while`mlnx1` to the first one for improved performance.

```text
mount -t wekafs -o num_cores=2 -o net:s2=mlnx0,net:s1=mlnx1 backend1/my_fs /mnt/weka
```

**For example,** in the following HA mounting command, two cores \(two Frontend processes\) and two physical network devices \(`mlnx0`, `mlnx1`\) are allocated. By explicitly specifying `s2+1`, `s1-2` modifiers for network devices, both devices will be used by both Frontend processes. Notation `s2+1` stands for the first and second processes, while `s1-2` stands for the range of 1 to 2, and are effectively the same.

```text
mount -t wekafs -o num_cores=2 -o net:s2+1=mlnx0,net:s1-2=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```

### UDP Mode

In cases were DPDK cannot be used, it is possible to use WekaFS in [UDP mode](../overview/networking-in-wekaio.md#udp-mode) through the kernel. Use `net=udp` in the mount command to set the UDP networking mode, for example:

```text
mount -t wekafs -o num_cores=0 -o net=udp backend-host-0/my_fs /mnt/weka
```

{% hint style="info" %}
**Note:** A client in UDP mode cannot be configured in HA mode. However, the client can still work with a highly available cluster.
{% endhint %}

## Mounting Filesystems Using fstab

{% hint style="info" %}
**Note:** This option works when using **stateless clients** and with OS that supports `systemd` \(e.g.: RHEL/CentOS 7.2 and up, Ubuntu 16.04 and up, Amazon Linux 2 LTS\).
{% endhint %}

Edit `/etc/fstab` file to include the filesystem mount entry:

* A comma-separated list of backend hosts, with the filesystem name
* The mount point
* Filesystem type - `wekafs`
* Mount options:
  * Configure `systemd` to wait for the `weka-agent` service to come up, and set the filesystem as a network filesystem, e.g.:
    * `x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev`
  * Any additional `wekafs` supported mount option

```text
# create a mount point 
mkdir -p /mnt/weka/my_fs

#edit fstab file
vi /etc/fstab

#fstab
backend-0,backend-1,backend-3/my_fs /mnt/weka/my_fs  wekafs  x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev   0       0
```

Reboot the machine for the `systemd` unit to be created and marked correctly.

The filesystem should now be mounted at boot time.

{% hint style="danger" %}
**Note:** Do not configure this entry for a mounted filesystem before un-mounting it \(`umount`\), as the `systemd` needs to mark the filesystem as a network filesystem \(occurs as part of the `reboot`\). Trying to reboot a host when there is a mounted WekaFS filesystem when setting its `fstab` configuration might yield a failure to unmount the filesystem and leave the system hanged.
{% endhint %}

## Mounting Filesystems Using autofs

It is possible to mount a Weka filesystem using the `autofs` command.

To get started, install `autofs` on the host:

```text
# On RedHat/Centos
yum install -y autofs
```

```text
# On Debian/Ubuntu
apt-get install -y autofs
```

Then run the following commands to create the `autofs` configuration files for Weka filesystems:

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

The configuration is distribution-dependent, and it is necessary to ensure that the service is configured to start automatically after the host is rebooted. To verify that the autofs service automatically starts after restarting the server, run the following command: `systemctl is-enabled autofs.` If the output is `enabled` the service is configured to start automatically.

In Amazon Linux, for example, autofs service can be verified with `chkconfig` command. If the output is `on` for the current _runlevel_ \(can be checked with `runlevel` command\), autofs will be enabled upon reboot.

```text
# chkconfig | grep autofs
autofs         0:off 1:off 2:off 3:on 4:on 5:on 6:off
```

It is now possible to access Weka filesystems using the`cd /mnt/weka/<fs-name>` command.

