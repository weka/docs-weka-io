---
description: >-
  To use a filesystem via the Weka filesystem driver, it has to be mounted on
  one of the cluster hosts. This page describes how this is performed.
---

# Mount filesystems

## Overview

There are two methods available for mounting a filesystem in one of the cluster hosts:

1. Using the traditional method: See below and also refer to [Adding Clients](../install/bare-metal/adding-clients-bare-metal.md) (Bare Metal Installation) or [Adding Clients](../install/aws/adding-clients.md) (AWS Installation), where first a client is configured and joins a cluster, after which a mount command is executed.
2. Using the Stateless Clients feature: See [Mounting Filesystems Using the Stateless Clients Feature](mounting-filesystems.md#mounting-filesystems-using-stateless-clients) below, which simplifies and improves the management of clients in the cluster and eliminates the Adding Clients process.

## Mount a filesystem using the traditional method&#x20;

{% hint style="info" %}
**Note:** Using the mount command as explained below first requires the installation of the Weka client, configuring the client, and joining it to a Weka cluster.
{% endhint %}

To mount a filesystem on one of the cluster hosts, let’s assume the cluster has a filesystem called `demo`. To add this filesystem to a host, SSH into one of the hosts and run the `mount` command as the `root` user, as follows:

```
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general structure of the `mount` command for a Weka filesystem is:

```
mount -t wekafs [-o option[,option]...]] <fs-name> <mount-point>
```

There are two options for mounting a filesystem on a cluster client: read cache and write cache. Refer to the descriptions in the links below to understand the differences between these modes:

* [Read cache mount mode](../overview/weka-client-and-mount-modes.md#read-cache-mount-mode-default)
* [Write cache mount mode](../overview/weka-client-and-mount-modes.md#write-cache-mount-mode)

## Mount a filesystem using the stateless clients feature <a href="#mounting-filesystems-using-stateless-clients" id="mounting-filesystems-using-stateless-clients"></a>

The Stateless Clients feature defers the process of joining the cluster until the mount is performed. Simplifying and improving the management of clients in the cluster. It removes tedious client management procedures, which is particularly beneficial in AWS installations where clients may join and leave at high frequency.

Furthermore, it unifies all security aspects in the mount command, eliminating the search for separate credentials at cluster join and mount.

To use the Stateless Clients feature, a Weka agent must be installed. Once this is complete, mounts can be created and configured using the mount command and can be easily removed from the cluster using the unmount command.

{% hint style="info" %}
**Note:** To allow only Weka authenticated users to mount a filesystem, set the filesystem `--auth-required` flag to `yes`.  For more information refer the [Mount authentication for organization filesystems](../usage/organizations/organizations-2.md) topic.
{% endhint %}

Assuming the Weka cluster is using the backend IP of `1.2.3.4`, running the following command as `root` on a client will install the agent:

`curl http://1.2.3.4:14000/dist/v1/install | sh`

On completion, the agent is installed on the client machine.

#### Run the mount command

**Command:** `mount -t wekafs`

Use one of the following command lines to invoke the mount command (note, the delimiter between the server and filesystem can be either `:/` or `/`):

`mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-point>`

**Parameters**

| **Name**      | **Type** | **Value**                          | **Limitations**           | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------- | ------------------------- | ------------- | ----------- |
| `options`     | ​        | See Additional Mount Options below | ​                         | ​             | ​           |
| `backend`     | String   | IP/hostname of a backend host      | Must be a valid name      | Yes           | ​           |
| `fs`          | String   | Filesystem name                    | Must be a valid name      | Yes           | ​           |
| `mount-point` | String   | Path to mount on the local machine | Must be a valid path-name | Yes           | ​           |

## Mount command options

Each mount option can be passed by an individual `-o` flag to `mount.`

### For all clients types

| **Option**                | **Value**                                     | **Description**                                                                                                                                                                                                                                                                                                                                                                                                       | **Default**  | **Remount Supported** |
| ------------------------- | --------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------ | --------------------- |
| `readcache`               | None                                          | Set mode to read cache                                                                                                                                                                                                                                                                                                                                                                                                | No           | Yes                   |
| `writecache`              | None                                          | Set mode to write cache                                                                                                                                                                                                                                                                                                                                                                                               | Yes          | Yes                   |
| `dentry_max_age_positive` | Number in milliseconds                        | After the defined time period, every metadata cached entry is refreshed from the system, allowing the host to take into account metadata changes performed by other hosts.                                                                                                                                                                                                                                            | 1000         | Yes                   |
| `dentry_max_age_negative` | Number in milliseconds                        | Each time a file or directory lookup fails, an entry specifying that the file or directory does not exist is created in the local dentry cache. This entry is refreshed after the defined time, allowing the host to use files or directories created by other hosts.                                                                                                                                                 | 0            | Yes                   |
| `ro`                      | None                                          | Mount filesystem as read-only                                                                                                                                                                                                                                                                                                                                                                                         | No           | Yes                   |
| `rw`                      | None                                          | Mount filesystem as read-write                                                                                                                                                                                                                                                                                                                                                                                        | Yes          | Yes                   |
| `inode_bits`              | 32, 64 or auto                                | Size of the inode in bits, which may be required for 32-bit applications.                                                                                                                                                                                                                                                                                                                                             | Auto         | No                    |
| `verbose`                 | None                                          | Write debug logs to the console                                                                                                                                                                                                                                                                                                                                                                                       | No           | Yes                   |
| `quiet`                   | None                                          | Don't show any logs to console                                                                                                                                                                                                                                                                                                                                                                                        | No           | Yes                   |
| `acl`                     | None                                          | <p>Can be defined per mount. </p><p>Setting POSIX ACLs can change the effective group permissions (via the <code>mask</code> permissions). When ACLs defined but the mount has no ACL, the effective group permissions are granted.)</p>                                                                                                                                                                              | No           | No                    |
| `obs_direct`              | None                                          | See [Object-store Direct Mount](tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option) section                                                                                                                                                                                                                                                                           | No           | Yes                   |
| `noatime`                 | None                                          | Do not update inode access times                                                                                                                                                                                                                                                                                                                                                                                      | No           | Yes                   |
| `strictatime`             | None                                          | Always update inode access times                                                                                                                                                                                                                                                                                                                                                                                      | No           | Yes                   |
| `relatime`                | None                                          | Update inode access times only on modification or change, or if inode has been accessed and `relatime_threshold` has passed.                                                                                                                                                                                                                                                                                          | Yes          | Yes                   |
| `relatime_threshold`      | Number in seconds                             | <p>How much time (in seconds) to wait since an inode has been accessed (not modified) before updating the access time. </p><p>0 means to never update the access time on access only.</p><p>This option is relevant only if <code>relatime</code> is on.</p>                                                                                                                                                          | 0 (infinite) | Yes                   |
| `nosuid`                  | None                                          | Do not take `suid`/`sgid` bits into effect.                                                                                                                                                                                                                                                                                                                                                                           | No           | Yes                   |
| `nodev`                   | None                                          | Do not interpret character or block special devices.                                                                                                                                                                                                                                                                                                                                                                  | No           | Yes                   |
| `noexec`                  | None                                          | Do not allow direct execution of any binaries.                                                                                                                                                                                                                                                                                                                                                                        | No           | Yes                   |
| `file_create_mask`        | Numeric (octal) notation of POSIX permissions | <p>Newly created file permissions are masked with the creation mask. For example, if a user creates a file with permissions=777 but the <code>file_create_mask</code> is 770, the file will be created with 770 permissions. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>file_create_mask</code> and then the <code>force_file_mode</code>.</p>                                 | 0777         | Yes                   |
| `directory_create_mask`   | Numeric (octal) notation of POSIX permissions | <p>Newly created directory permissions are masked with the creation mask. For example, if a user creates a directory with permissions=777 but the <code>directory_create_mask</code> is 770, the directory will be created with 770 permissions. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>directory_create_mask</code> and then the <code>force_directory_mode</code>.</p>   | 0777         | Yes                   |
| `force_file_mode`         | Numeric (octal) notation of POSIX permissions | <p>Newly created file permissions are logically OR'ed with the mode. For example, if a user creates a file with permissions 770 but the <code>force_file_mode</code> is 775, the resulting file will be created with mode 775. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>file_create_mask</code> and then the <code>force_file_mode</code>.</p>                               | 0            | Yes                   |
| `force_directory_mode`    | Numeric (octal) notation of POSIX permissions | <p>Newly created directory permissions are logically OR'ed with the mode. For example, if a user creates a directory with permissions 770 but the <code>force_directory_mode</code> is 775, the resulting directory will be created with mode 775. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>directory_create_mask</code> and then the <code>force_directory_mode</code>.</p> | 0            | Yes                   |

### Remount of general options

You can remount using the mount options marked as `Remount Supported` in the above table (`mount -o remount)`.

When a mount option has been explicitly changed, you must set it again in the remount operation to ensure it retains its value. For example, if you mount with `ro`, a remount without it changes the mount option to the default `rw`. If you mount with `rw`, it is not required to re-specify the mount option because this is the default.&#x20;

### **Additional mount options using the stateless clients feature**

| **Option**                               | **Value**            | **Description**                                                                                                                                                                                                                                                                                                             | **Default**                                                                                                                                                            | **Remount supported** |
| ---------------------------------------- | -------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- |
| `memory_mb=<memory_mb>`                  | Number               | Amount of memory to be used by the client (for huge pages)                                                                                                                                                                                                                                                                  | 1400 MiB                                                                                                                                                               | Yes                   |
| `num_cores=<frontend-cores>`             | Number               | <p>The number of frontend cores to allocate for the client.</p><p>Either<code>&#x3C;num_cores></code> or<code>&#x3C;core></code> can be specified, but not both.</p><p>If none are specified, the client will be configured with 1 core. </p><p>If 0 is specified then you must use <code>net=udp</code>.</p>               | 1                                                                                                                                                                      | No                    |
| `core=<core>`                            | Number               | <p>Specify explicit cores to be used by the WekaFS client. Multiple cores can be specified.<br>Core 0 is not allowed.</p>                                                                                                                                                                                                   |                                                                                                                                                                        | No                    |
| `net=<netdev>[/<ip>/<bits>[/<gateway>]]` | String               | <p>This option must be specified for on-premises installation, and <strong>must not be specified for AWS</strong> installations.</p><p>For more info refer to <a href="mounting-filesystems.md#advanced-network-configuration-via-mount-options">Advanced Network Configuration via Mount Options</a> section.</p>          |                                                                                                                                                                        | No                    |
| `bandwidth_mbps=<bandwidth_mbps>`        | Number               | <p>Maximum network bandwidth in Mb/s, which limits the traffic that the container can send.</p><p>The bandwidth setting is helpful in deployments like AWS, where the bandwidth is limited but allowed to burst.</p>                                                                                                        | Auto-select                                                                                                                                                            | Yes                   |
| `remove_after_secs=<secs>`               | Number               | <p>The number of seconds without connectivity after which the client will be removed from the cluster. <br>Minimum value: 60 seconds. </p>                                                                                                                                                                                  | 86,400 seconds (24 hours)                                                                                                                                              | Yes                   |
| `traces_capacity_mb=<size-in-mb>`        | Number               | <p>Traces capacity limit in MB.</p><p>Minimum value: 512 MB.</p>                                                                                                                                                                                                                                                            |                                                                                                                                                                        | No                    |
| `reserve_1g_hugepages`                   | None                 | Controls the page allocation algorithm if to reserve only 2 MB huge pages or also 1 GB ones.                                                                                                                                                                                                                                | Yes                                                                                                                                                                    | Yes                   |
| `readahead_kb=<readahead>`               | Number in KB         | Controls the readahead per mount (higher readahead better for sequential reads of large files).                                                                                                                                                                                                                             | 32768                                                                                                                                                                  | Yes                   |
| `auth_token_path`                        | String               | Path to the mount authentication token (per mount).                                                                                                                                                                                                                                                                         | `~/.weka/auth-token.json`                                                                                                                                              | No                    |
| `dedicated_mode`                         | `full` or `none`     | Determine whether DPKD networking dedicates a core (`full`) or not (`none`). none can only be set when the NIC driver supports it. See [DPDK Without Core Dedication](../overview/networking-in-wekaio.md#dpdk-without-core-dedication) section. This option is relevant when using DPDK networking (`net=udp` is not set). | `full`                                                                                                                                                                 | No                    |
| `qos_preferred_throughput_mbps`          | Number               | Preferred requests rate for QoS in megabytes per second.                                                                                                                                                                                                                                                                    | <p>No limit.<br>The cluster admin can set this default. See <a href="mounting-filesystems.md#set-mount-option-default-values">Set mount option default values</a>.</p> | Yes                   |
| `qos_max_throughput_mbps`                | <p></p><p>Number</p> | <p>Maximum requests rate for QoS in megabytes per second.<br>This option allows bursting above the specified limit but aims to keep this limit on average.</p>                                                                                                                                                              | <p>No limit.<br>The cluster admin can set this default. See <a href="mounting-filesystems.md#set-mount-option-default-values">Set mount option default values</a>.</p> | Yes                   |
| `connect_timeout_secs`                   | Number               | The timeout, in seconds, for establishing a connection to a single host.                                                                                                                                                                                                                                                    | 10                                                                                                                                                                     | Yes                   |
| `response_timeout_secs`                  | Number               | The timeout, in seconds, waiting for the response from a single host.                                                                                                                                                                                                                                                       | 60                                                                                                                                                                     | Yes                   |
| `join_timeout_secs`                      | Number               | The timeout, in seconds, for the client container to join the Weka cluster.                                                                                                                                                                                                                                                 | 360                                                                                                                                                                    | Yes                   |

{% hint style="info" %}
**Note:** These parameters, if not stated otherwise, are only effective on the first mount command for each client.
{% endhint %}

{% hint style="info" %}
**Note:** By default, the command selects the optimal core allocation for Weka. If necessary, multiple `core` parameters can be used to allocate specific cores to the WekaFS client. E.g., `mount -t wekafs -o core=2 -o core=4 -o net=ib0 backend-host-0/my_fs /mnt/weka`
{% endhint %}

{% hint style="success" %}
**Example: On-Premise Installations**

`mount -t wekafs -o num_cores=1 -o net=ib0 backend-host-0/my_fs /mnt/weka`

Running this command on a host installed with the Weka agent will download the appropriate Weka version from the host`backend-host-0`and create a Weka container that allocates a single core and a named network interface (`ib0`). Then it will join the cluster that `backend-host-0` is part of and mount the filesystem `my_fs` on `/mnt/weka.`

`mount -t wekafs -o num_cores=0 -o net=udp backend-host-0/my_fs /mnt/weka`

Running this command will use [UDP mode ](../overview/networking-in-wekaio.md#udp-mode)(usually selected when the use of DPDK is not available).
{% endhint %}

{% hint style="success" %}
**Example: AWS Installations**

`mount -t wekafs -o num_cores=2 backend1,backend2,backend3/my_fs /mnt/weka`

Running this command on an AWS host will allocate two cores (multiple-frontends) and attach and configure two ENIs on the new client. The client will attempt to rejoin the cluster via all three backends used in the command line.
{% endhint %}

For stateless clients, the first `mount` command installs the weka client software and joins the cluster). Any subsequent `mount` command, can either use the same syntax or just the traditional/per-mount parameters as defined in [Mounting Filesystems](mounting-filesystems.md#mount-mode-command-options) since it is not necessary to join a cluster.

It is now possible to access Weka filesystems via the mount-point, e.g., by `cd /mnt/weka/` command.

After the execution of an`umount` command, which unmounts the last Weka filesystem, the client is disconnected from the cluster and will be uninstalled by the agent. Consequently, executing a new `mount` command requires the specification of the cluster, cores, and networking parameters again.

{% hint style="info" %}
**Note:** When running in AWS, the instance IAM role is required to provide permissions to several AWS APIs, as described in [IAM Role Created in Template](../install/aws/cloudformation.md#iam-role-created-in-the-template).
{% endhint %}

{% hint style="info" %}
**Note:** Memory allocation for a client is predefined. Contact the Weka Support Team when it is necessary to change the amount of memory allocated to a client.
{% endhint %}

### Remount of stateless clients options

Mount options marked as `Remount Supported` in the above table can be remounted (using `mount -o remount`). When a mount option is not set in the remount operation, it will retain its current value. To set a mount option back to its default value, use the `default` modifier (e.g., `memory_mb=default)`.

### Set mount option default values <a href="#set-mount-option-default-values" id="set-mount-option-default-values"></a>

The defaults of the mount options `qos_max_throughput_mbps` and `qos_preferred_throughput_mbps` have no limit.

The cluster admin can set these default values to meet the organization's requirements, reset to the initial default values (no limit), or show the existing values.

The mount option defaults are only relevant for new mounts performed and do not influence the existing ones.

**Commands:**

`weka cluster mount-defaults set`

`weka cluster mount-defaults reset`

`weka cluster mount-defaults show`

To set the mount option default values, run the following command:

`weka cluster mount-defaults set [--qos-max-throughput qos-max-throughput] [--qos-preferred-throughput qos-preferred-throughput]`

**Parameters**

| **Option**                 | **Value** | **Description**                                                                                                                              |
| -------------------------- | --------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `qos_max_throughput`       | Number    | Sets the default value for the `qos_max_throughput_mbps` option, which is the max requests rate for QoS in megabytes per second.             |
| `qos_preferred_throughput` | Number    | Sets the default value for the `qos_preferred_throughput_mbps` option, which is the preferred requests rate for QoS in megabytes per second. |

## Advanced network configuration by mount options

When using a stateless client, it is possible to alter and control many different networking options, such as:

* Virtual functions
* IPs&#x20;
* Gateway (in case the client is on a different subnet)
* Physical network devices (for performance and HA)
* UDP mode

Use `-o net=<netdev>` mount option with the various modifiers as described below.

`<netdev>` is either the name, MAC address, or PCI address of the physical network device (can be a bond device) to allocate for the client.

{% hint style="warning" %}
**Note:** When using `wekafs` mounts, both clients and backends should use the same type of networking technology (either IB or Ethernet).
{% endhint %}

### IP, subnet, gateway, and virtual functions

For higher performance, the usage of multiple Frontends may be required. When using a NIC other than Mellanox or Intel E810, or when mounting a DPDK client on a VM, it is required to use [SR-IOV](../install/bare-metal/setting-up-the-hosts/#sr-iov-enablement) to expose a VF of the physical device to the client. Once exposed, it can be configured via the mount command.

To determine the VFs IP addresses, or when the client resides in a different subnet and routing is needed in the data network, use`net=<netdev>/[ip]/[bits]/[gateway]`.

`ip, bits, gateway` are optional. If these options are not provided, the Weka system performs one of the following depending on the environment:

* **Cloud environment:** the Weka system deduces the values of these options.
* **On-premises environment:** the Weka system allocates values of these options from the cluster default network (the `weka cluster default-net` must be set before running the mount command). Otherwise, the Weka cluster does not allocate the IP for the client. For more details, see [Optional: Configure default data networking](../install/bare-metal/using-cli.md#optional-configure-default-data-networking).

For example, the following command allocates two cores and a single physical network device (intel0). It will configure two VFs for the device and assign each one of them to one of the frontend nodes. The first node will receive a 192.168.1.100 IP address, and the second will use a 192.168.1.101 IP address. Both of the IPs have 24 network mask bits and a default gateway of 192.168.1.254.

```
mount -t wekafs -o num_cores=2 -o net=intel0/192.168.1.100+192.168.1.101/24/192.168.1.254 backend1/my_fs /mnt/weka
```

### Multiple physical network devices for performance and HA

It is possible to use more than one physical network device for performance or high availability.

#### Using multiple physical network devices for better performance

It's easy to saturate the bandwidth of a single network interface when using WekaFS. It is possible to leverage multiple network interface cards (NICs) for higher throughput. The `-o net` notation shown in the examples above can be used to pass the names of specific NICs to the WekaFS host driver.

For example, the following command will allocate two cores and two physical network devices for increased throughput:

```
mount -t wekafs -o num_cores=2 -o net=mlnx0 -o net=mlnx1 backend1/my_fs /mnt/weka
```

#### Using multiple physical network devices for HA configuration

Multiple NICs can also be configured to achieve redundancy (refer to [Weka Networking HA](../overview/networking-in-wekaio.md#ha) section for more information) in addition to higher throughput, for a complete, highly available solution. For that, use more than one physical device as previously described and, also, specify the client management IPs using `-o mgmt_ip=<ip>+<ip2>` command-line option.

For example, the following command will use two network devices for HA networking and allocate both devices to four Frontend processes on the client. The modifier `ha` is used here, which means using the device on all processes.

```
mount -t wekafs -o num_cores=4 -o net:ha=mlnx0,net:ha=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```

**Advanced mounting options for multiple physical network devices**

With multiple Frontend processes (as expressed by `-o num_cores`), it is possible to control what processes use what NICs. This can be accomplished through the use of special command line modifiers called _slots_. In WekaFS, _slot_ is synonymous with a process number. Typically, the first WekaFS Frontend process will occupy slot 1, then the second - slot 2 and so on.

Examples of slot notation include `s1`, `s2`, `s2+1`, `s1-2`, `slots1+3`, `slot1`, `slots1-4` , where `-` specifies a range of devices, while `+` specifies a list. For example, `s1-4` implies slots 1, 2, 3 and 4, while `s1+4` specifies slots 1 and 4 only.

For example, in the following command, `mlnx0` is bound to the second Frontend process while`mlnx1` to the first one for improved performance.

```
mount -t wekafs -o num_cores=2 -o net:s2=mlnx0,net:s1=mlnx1 backend1/my_fs /mnt/weka
```

For example**,** in the following HA mounting command, two cores (two Frontend processes) and two physical network devices (`mlnx0`, `mlnx1`) are allocated. By explicitly specifying `s2+1`, `s1-2` modifiers for network devices, both devices will be used by both Frontend processes. Notation `s2+1` stands for the first and second processes, while `s1-2` stands for the range of 1 to 2, and are effectively the same.

```
mount -t wekafs -o num_cores=2 -o net:s2+1=mlnx0,net:s1-2=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```

### UDP mode

In cases where DPDK cannot be used, it is possible to use WekaFS in [UDP mode](../overview/networking-in-wekaio.md#udp-mode) through the kernel. Use `net=udp` in the mount command to set the UDP networking mode, for example:

```
mount -t wekafs -o num_cores=0 -o net=udp backend-host-0/my_fs /mnt/weka
```

{% hint style="info" %}
**Note:** A client in UDP mode cannot be configured in HA mode. However, the client can still work with a highly available cluster.&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** Providing multiple IPs in the \<mgmt-ip> in UDP mode will utilize their network interfaces for more bandwidth (can be useful in RDMA environments), rather than using only one NIC.
{% endhint %}

## Mount filesystems using fstab

{% hint style="info" %}
**Note:** This option works when using **stateless clients** and with OS that supports `systemd` (e.g.: RHEL/CentOS 7.2 and up, Ubuntu 16.04 and up, Amazon Linux 2 LTS).
{% endhint %}

Edit `/etc/fstab` file to include the filesystem mount entry:

* A comma-separated list of backend hosts, with the filesystem name
* The mount point
* Filesystem type - `wekafs`
* Mount options:
  *   Configure `systemd` to wait for the `weka-agent` service to come up, and set the filesystem as a network filesystem, e.g.:

      `x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev`
  * Any additional `wekafs` supported mount option
* A comma-separated list of backend hosts, with the filesystem name
* The mount point
* Filesystem type - `wekafs`
* Mount options:
  *   Configure `systemd` to wait for the `weka-agent` service to come up, and set the filesystem as a network filesystem, e.g.:

      `x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev`
  * Any additional `wekafs` supported mount option

```
# create a mount point 
mkdir -p /mnt/weka/my_fs

# edit fstab file
vi /etc/fstab

# fstab with weka options (example, change with your desired settings)
backend-0,backend-1,backend-3/my_fs /mnt/weka/my_fs  wekafs  num_cores=1,net=eth1,x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev   0       0

```

Reboot the machine for the `systemd` unit to be created and marked correctly.

The filesystem should now be mounted at boot time.

{% hint style="danger" %}
**Note:** Do not configure this entry for a mounted filesystem before un-mounting it (`umount`), as the `systemd` needs to mark the filesystem as a network filesystem (occurs as part of the `reboot`). Trying to reboot a host when there is a mounted WekaFS filesystem when setting its `fstab` configuration might yield a failure to unmount the filesystem and leave the system hanged.
{% endhint %}

## Mount filesystems using autofs

**Procedure:**

1. Install `autofs` on the host using one of the following commands according to your deployment:

* On RedHat or Centos:&#x20;

```
yum install -y autofs
```

* On Debian or Ubuntu:

```
apt-get install -y autofs
```

2\. To create the `autofs` configuration files for Weka filesystems, do one of the following\
&#x20;   depending on the client type:

* For a stateful client (traditional), run the following commands:

```
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs" > /etc/auto.master.d/wekafs.autofs
echo "*   &" > /etc/auto.wekafs
```

3\. Restart the `autofs` service:

```
service autofs restart
```

4\. The configuration is distribution-dependent. Verify that the service is configured to start\
&#x20;    automatically after restarting the host. Run the following command:\
&#x20;    `systemctl is-enabled autofs.` \
&#x20;   If the output is `enabled` the service is configured to start automatically.

{% hint style="info" %}
**Example:** In Amazon Linux, you can verify that the `autofs` service is configured to start automatically by running the command `chkconfig`. \
If the output is `on` for the current _runlevel_ (you can check with the`runlevel` command), `autofs` is enabled upon restart.

```
# chkconfig | grep autofs
autofs         0:off 1:off 2:off 3:on 4:on 5:on 6:off
```
{% endhint %}

&#x20;Once you complete this procedure, it is possible to access Weka filesystems using the command `cd /mnt/weka/<fs-name>`.
