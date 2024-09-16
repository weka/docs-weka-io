---
description: >-
  Explore the methods for mounting a filesystem on a client host using the WEKA
  filesystem driver, including the stateful client and stateless client methods.
---

# Mount filesystems

## Overview

There are two methods available for mounting a filesystem on a client host:

* **Stateful client**: This method involves the following steps:
  * Install the WEKA client on the host.
  * Configure the client according to your requirements.
  * Join the client in a WEKA cluster.
  * Once the above steps are completed, you can mount the filesystem. For detailed instructions, see [#mount-a-filesystem-using-the-stateful-client-method](./#mount-a-filesystem-using-the-stateful-client-method "mention").
* **Stateless client**: This method simplifies client management in the cluster by eliminating the need for the adding clients' process. For detailed instructions on how to use this feature to mount filesystems, see [#mounting-filesystems-using-stateless-clients](./#mounting-filesystems-using-stateless-clients "mention").

If you need to mount a single client to multiple clusters, see [mount-filesystems-from-multiple-clusters-on-a-single-client.md](mount-filesystems-from-multiple-clusters-on-a-single-client.md "mention").

## Mount a filesystem using the stateful client method

Before using the mount command, you must install the WEKA client, configure it, and join it to a WEKA cluster. This process involves adding clients, which can be done either for bare metal installation or as part of the WEKA deployment on one of the supported clouds.

Assuming the cluster has a filesystem named `demo`, you can add this filesystem to a server by SSHing into one of the servers and running the `mount` command as the `root` user:

```bash
mkdir -p /mnt/weka/demo
mount -t wekafs demo /mnt/weka/demo
```

The general syntax of the mount command for a WEKA filesystem is:

```bash
mount -t wekafs [-o option[,option]...] <fs-name> <mount-point>
```

When mounting a filesystem on a cluster client, you have two options: **read cache** and **write cach**e. See the respective sections to understand the differences between these modes.

**Related topics**

[weka-client-and-mount-modes.md](../../overview/weka-client-and-mount-modes.md "mention")

[adding-clients-bare-metal.md](../../install/bare-metal/adding-clients-bare-metal.md "mention") (on bare-metal servers)

[adding-clients.md](../../install/aws/weka-installation-on-aws-using-the-cloud-formation/adding-clients.md "mention") (on AWS deployment)

[add-clients.md](../../install/weka-installation-on-azure/add-clients.md "mention") (on Azure deployment)

[add-clients.md](../../install/weka-installation-on-azure/add-clients.md "mention") (on GCP deployment)

## Mount a filesystem using the stateless client method <a href="#mounting-filesystems-using-stateless-clients" id="mounting-filesystems-using-stateless-clients"></a>

The stateless client feature enhances cluster management by deferring the client’s joining process until the filesystem mount is performed. This simplification is especially advantageous in cloud deployments, where client turnover can be high.

This feature also consolidates all security aspects into the mount command, eliminating the need to search for separate credentials during cluster join and mount operations.

To use the stateless client feature, a WEKA agent must be installed. Once this is done, the `mount` command can be used to create and configure mounts. If needed, existing mounts can be removed from the cluster using the `unmount` command.

{% hint style="info" %}
For added security, the filesystem can be configured to only allow mounts by WEKA authenticated users by setting the `--auth-required` flag to `yes`. For more details, see [organizations-2.md](../../usage/organizations/organizations-2.md "mention").
{% endhint %}

Assuming the WEKA cluster is using the backend IP of `1.2.3.4`, running the following command as `root` on a client will install the agent:

```sh
curl http://1.2.3.4:14000/dist/v1/install | sh
```

On completion, the agent is installed on the client.

#### Run the mount command

**Command:** `mount -t wekafs`

Use one of the following command lines to invoke the mount command. The delimiter between the server and filesystem can be either `:/` or `/`:

{% code overflow="wrap" %}
```bash
mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-point>

mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]:/<fs> <mount-point>
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="250">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>options</code></td><td>See Additional Mount Options below.</td></tr><tr><td><code>backend</code></td><td>IP/hostname of a backend container.<br>Mandatory.</td></tr><tr><td><code>fs</code></td><td>Filesystem name.<br>Mandatory.</td></tr><tr><td><code>mount-point</code></td><td>Path to mount on the local server.<br>Mandatory.</td></tr></tbody></table>

## Mount command options

Each mount option can be passed by an individual `-o` flag to `mount.`

### For all clients types

<table><thead><tr><th width="235">Option</th><th width="321">Description</th><th width="94">Default</th><th>Remount supported</th></tr></thead><tbody><tr><td><code>readcache</code></td><td>Set the mount mode to read from the cache. This action automatically turns off the <code>writecache</code>.<br><strong>Note:</strong> The SMB share mount mode is always <code>readcache</code>. Set this option to <code>Yes</code>. </td><td>No</td><td>Yes</td></tr><tr><td><code>writecache</code></td><td>Set the mount mode to write to the cache.</td><td>Yes</td><td>Yes</td></tr><tr><td><code>forcedirect</code></td><td><p>Set the mount mode to directly read from and write to storage, avoiding the cache. This action automatically turns off both the <code>writecache</code> and <code>readcache</code>.</p><p><strong>Note:</strong> Enabling this option could impact performance. Use it carefully. If you’re unsure, contact the <a href="../../support/getting-support-for-your-weka-system.md#contact-customer-success-team">Customer Success Team</a>.<br>Do not use this option for SMB shares.</p></td><td>No</td><td>Yes</td></tr><tr><td><code>dentry_max_age_positive</code></td><td>The time in milliseconds after which the system refreshes the metadata cached entry. This refresh informs the WEKA client about metadata changes performed by other clients.</td><td>1000</td><td>Yes</td></tr><tr><td><code>dentry_max_age_negative</code></td><td>Each time a file or directory lookup fails, the local entry cache creates an entry specifying that the file or directory does not exist.<br>This entry is refreshed after the specified time (number in milliseconds), allowing the WEKA client to use files or directories created by other clients.</td><td>0</td><td>Yes</td></tr><tr><td><code>ro</code></td><td>Mount filesystem as read-only.</td><td>No</td><td>Yes</td></tr><tr><td><code>rw</code></td><td>Mount filesystem as read-write.</td><td>Yes</td><td>Yes</td></tr><tr><td><code>inode_bits</code></td><td>The inode size in bits may be required for 32-bit applications.<br>Possible values: <code>32</code>, <code>64</code>, or <code>auto</code></td><td>Auto</td><td>No</td></tr><tr><td><code>verbose</code></td><td>Write debug logs to the console.</td><td>No</td><td>Yes</td></tr><tr><td><code>quiet</code></td><td>Don't show any logs to console.</td><td>No</td><td>Yes</td></tr><tr><td><code>acl</code></td><td><p>Can be defined per mount. </p><p>Setting POSIX ACLs can change the effective group permissions (via the <code>mask</code> permissions). When ACLs are defined but the mount has no ACL, the effective group permissions are granted.</p></td><td>No</td><td>No</td></tr><tr><td><code>obs_direct</code></td><td>See <a href="../tiering/advanced-time-based-policies-for-data-storage-location.md#object-store-direct-mount-option">Object-store direct mount</a>.</td><td>No</td><td>Yes</td></tr><tr><td><code>noatime</code></td><td>Do not update inode access times.</td><td>No</td><td>Yes</td></tr><tr><td><code>strictatime</code></td><td>Always update inode access times.</td><td>No</td><td>Yes</td></tr><tr><td><code>relatime</code></td><td>Update inode access times only on modification or change, or if inode has been accessed and <code>relatime_threshold</code> has passed.</td><td>Yes</td><td>Yes</td></tr><tr><td><code>relatime_threshold</code></td><td><p>The time (number in seconds) to wait since an inode has been accessed (not modified) before updating the access time. </p><p>0 means never update the access time on access only.</p><p>This option is relevant only if the <code>relatime</code> is on.</p></td><td>0 (infinite)</td><td>Yes</td></tr><tr><td><code>nosuid</code></td><td>Do not take <code>suid</code>/<code>sgid</code> bits into effect.</td><td>No</td><td>Yes</td></tr><tr><td><code>nodev</code></td><td>Do not interpret character or block special devices.</td><td>No</td><td>Yes</td></tr><tr><td><code>noexec</code></td><td>Do not allow direct execution of any binaries.</td><td>No</td><td>Yes</td></tr><tr><td><code>file_create_mask</code></td><td><p>File creation mask. A numeric (octal) notation of POSIX permissions.<br>Newly created file permissions are masked with the creation mask. For example, if a user creates a file with permissions=777 but the <code>file_create_mask</code> is 770, the file is created with 770 permissions. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>file_create_mask</code> and then the <code>force_file_mode</code>.</p></td><td>0777</td><td>Yes</td></tr><tr><td><code>directory_create_mask</code></td><td><p>Directory creation mask. A numeric (octal) notation of POSIX permissions.<br>Newly created directory permissions are masked with the creation mask. For example, if a user creates a directory with permissions=777 but the <code>directory_create_mask</code> is 770, the directory will be created with 770 permissions. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>directory_create_mask</code> and then the <code>force_directory_mode</code>.</p></td><td>0777</td><td>Yes</td></tr><tr><td><code>force_file_mode</code></td><td><p>Force file mode. A numeric (octal) notation of POSIX permissions.<br>Newly created file permissions are logically OR'ed with the mode. <br>For example, if a user creates a file with permissions 770 but the <code>force_file_mode</code> is 775, the resulting file is created with mode 775. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>file_create_mask</code> and then the <code>force_file_mode</code>.</p></td><td>0</td><td>Yes</td></tr><tr><td><code>force_directory_mode</code></td><td><p>Force directory mode. A numeric (octal) notation of POSIX permissions.<br>Newly created directory permissions are logically OR'ed with the mode. For example, if a user creates a directory with permissions 770 but the <code>force_directory_mode</code> is 775, the resulting directory will be created with mode 775. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>directory_create_mask</code> and then the <code>force_directory_mode</code>.</p></td><td>0</td><td>Yes</td></tr><tr><td><code>sync_on_close</code></td><td>This option ensures that all data for a file is written to the server when the file is closed. This means that changes made to the file by the client are immediately written to the server's disk upon close, which can provide greater data consistency and reliability.<br>It simulates the open-to-close semantics of NFS when working with <code>writecache</code> mount mode and directory quotas. <br>Enabling this option is essential when applications expect returned write errors at syscall close if the quota is exceeded.</td><td>No</td><td>Yes</td></tr><tr><td><code>nosync_on_close</code></td><td>This option disables the <code>sync_on_close</code> behavior of file writes. When <code>nosync_on_close</code> is enabled, the client does not wait for the server to confirm that all file data has been written to disk before closing the file.<br>This means that any changes made to the file by the client may not be immediately written to the server's disk when the file is closed. Instead, the changes are buffered in memory and written to disk asynchronously later.</td><td>No</td><td>Yes</td></tr></tbody></table>

### Remount of general options

You can remount using the mount options marked as `Remount Supported` in the above table (`mount -o remount)`.

When a mount option has been explicitly changed, you must set it again in the remount operation to ensure it retains its value. For example, if you mount with `ro`, a remount without it changes the mount option to the default `rw`. If you mount with `rw`, it is not required to re-specify the mount option because this is the default.&#x20;

### **Additional mount options using the stateless clients feature**

<table><thead><tr><th width="237">Option</th><th width="314">Description</th><th width="117">Default</th><th>Remount Supported</th></tr></thead><tbody><tr><td><code>memory_mb=&#x3C;memory_mb></code></td><td>The memory size in MiB the client can use for hugepages.</td><td><code>1400</code></td><td>Yes</td></tr><tr><td><code>num_cores=&#x3C;frontend-cores></code></td><td><p>The number of frontend cores to allocate for the client.</p><p>You can specify <code>&#x3C;num_cores></code> or<code>&#x3C;core></code> but not both.</p><p>If none are specified, the client is configured with 1 core. </p><p>If you specify 0 then you must use <code>net=udp</code>.</p></td><td><code>1</code></td><td>No</td></tr><tr><td><code>core=&#x3C;core-id></code></td><td>Specify explicit cores to be used by the WekaFS client. Multiple cores can be specified.<br>Core 0 is not allowed.</td><td></td><td>No</td></tr><tr><td><code>net=&#x3C;netdev>[/&#x3C;ip>/&#x3C;bits>[/&#x3C;gateway>]]</code></td><td><p>This option must be specified for on-premises installation and <strong>must not be specified for AWS</strong> installations.</p><p>For more details, see <a href="./#advanced-network-configuration-by-mount-options">Advanced network configuration by mount option</a>.</p></td><td></td><td>No</td></tr><tr><td><code>remove_after_secs=&#x3C;secs></code></td><td>The time in seconds without connectivity, after which the client is removed from the cluster. <br>Minimum value: <code>60</code> seconds.<br><code>3600</code> seconds = 1 hour.</td><td><code>3600</code></td><td>Yes</td></tr><tr><td><code>traces_capacity_mb=&#x3C;size-in-mb></code></td><td><p>Traces capacity limit in MB.</p><p>Minimum value: 512 MB.</p></td><td></td><td>No</td></tr><tr><td><code>reserve_1g_hugepages=&#x3C;true or false></code></td><td>Controls the page allocation algorithm to reserve hugepages.<br>Possible values:<br><code>true</code>: reserves 1 GB<br><code>false</code>: reserves 2 MB</td><td><code>true</code></td><td>Yes</td></tr><tr><td><code>readahead_kb=&#x3C;readahead></code></td><td>The readahead size in KB per mount. A higher readahead is better for sequential reads of large files.</td><td><code>32768</code></td><td>Yes</td></tr><tr><td><code>auth_token_path</code></td><td>The path to the mount authentication token (per mount).</td><td><code>~/.weka/auth-token.json</code></td><td>No</td></tr><tr><td><code>dedicated_mode</code></td><td>Determine whether DPDK networking dedicates a core (<code>full</code>) or not (<code>none</code>). none can only be set when the NIC driver supports it. See <a href="../../overview/networking-in-wekaio.md#dpdk-without-the-core-dedication">DPDK without the core dedication</a>. <br>This option is relevant when using DPDK networking (<code>net=udp</code> is not set).<br>Possible values: <code>full</code> or <code>none</code></td><td><code>full</code></td><td>No</td></tr><tr><td><code>qos_preferred_throughput_mbps</code></td><td>Preferred requests rate for QoS in megabytes per second.</td><td><code>0</code> (unlimited)<br></td><td>Yes</td></tr><tr><td><code>qos_max_throughput_mbps</code></td><td>Maximum requests rate for QoS in megabytes per second.<br>This option allows bursting above the specified limit but aims to keep this limit on average.<br>The cluster admin can set the default value. See <a href="./#set-mount-option-default-values">Set mount option default values</a>.</td><td><code>0</code> (unlimited)</td><td>Yes</td></tr><tr><td><code>qos_max_ops</code></td><td>Maximum number of IO operations a client can perform per second.<br>Set a limit to a client or clients to prevent starvation from the rest of the clients. (Do not set this option for mounting from a backend.)</td><td><code>0</code> (unlimited)</td><td>Yes</td></tr><tr><td><code>connect_timeout_secs</code></td><td>The timeout, in seconds, for establishing a connection to a single server. </td><td><code>10</code></td><td>Yes</td></tr><tr><td><code>response_timeout_secs</code></td><td>The timeout, in seconds, waiting for the response from a single server.</td><td><code>60</code></td><td>Yes</td></tr><tr><td><code>join_timeout_secs</code></td><td>The timeout, in seconds, for the client container to join the Weka cluster.</td><td><code>360</code></td><td>Yes</td></tr><tr><td><code>dpdk_base_memory_mb</code></td><td>The base memory in MB to allocate for DPDK. Set this option when mounting to a WEKA cluster on GCP.<br>Example: <code>-o dpdk_base_memory_mb=16</code></td><td><code>0</code></td><td>Yes</td></tr><tr><td><code>weka_version</code></td><td>The WEKA client version to run.</td><td>The cluster version</td><td>No</td></tr></tbody></table>

{% hint style="info" %}
These parameters, if not stated otherwise, are only effective on the first mount command for each client.
{% endhint %}

{% hint style="info" %}
By default, the command selects the optimal core allocation for WEKA. If necessary, multiple `core` parameters can be used to allocate specific cores to the WekaFS client. For example, `mount -t wekafs -o core=2 -o core=4 -o net=ib0 backend-server-0/my_fs /mnt/weka`
{% endhint %}

{% hint style="success" %}
**Example: On-Premise Installations**

`mount -t wekafs -o num_cores=1 -o net=ib0 backend-server-0/my_fs /mnt/weka`

Running this command on a server installed with the Weka agent downloads the appropriate WEKA version from the `backend-server-0`and creates a WEKA container that allocates a single core and a named network interface (`ib0`). Then it joins the cluster that `backend-server-0` is part of and mounts the filesystem `my_fs` on `/mnt/weka.`

`mount -t wekafs -o num_cores=0 -o net=udp backend-server-0/my_fs /mnt/weka`

Running this command uses [UDP mode ](../../overview/networking-in-wekaio.md#udp-mode)(usually selected when the use of DPDK is not available).
{% endhint %}

{% hint style="success" %}
**Example: AWS Installations**

`mount -t wekafs -o num_cores=2 backend1,backend2,backend3/my_fs /mnt/weka`

Running this command on an AWS EC2 instance allocates two cores (multiple-frontends), attaches and configures two ENIs on the new client. The client attempts to rejoin the cluster through all three backends specified in the command line.
{% endhint %}

For stateless clients, the first `mount` command installs the weka client software and joins the cluster). Any subsequent `mount` command, can either use the same syntax or just the traditional/per-mount parameters as defined in [Mounting Filesystems](./#mount-mode-command-options) since it is not necessary to join a cluster.

It is now possible to access Weka filesystems via the mount-point, e.g., by `cd /mnt/weka/` command.

After the execution of an`umount` command, which unmounts the last Weka filesystem, the client is disconnected from the cluster and will be uninstalled by the agent. Consequently, executing a new `mount` command requires the specification of the cluster, cores, and networking parameters again.

{% hint style="info" %}
When running in AWS, the instance IAM role must provide permissions to several AWS APIs (see the [IAM role created in template](../../install/aws/weka-installation-on-aws-using-the-cloud-formation/cloudformation.md#iam-role-created-in-the-template) section).
{% endhint %}

{% hint style="info" %}
Memory allocation for a client is predefined. To change the memory allocation, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### Remount of stateless clients options

Mount options marked as `Remount Supported` in the above table can be remounted (using `mount -o remount`). When a mount option is not set in the remount operation, it will retain its current value. To set a mount option back to its default value, use the `default` modifier (e.g., `memory_mb=default)`.

### Set mount option default values <a href="#set-mount-option-default-values" id="set-mount-option-default-values"></a>

The defaults of the mount options `qos_max_throughput_mbps` and `qos_preferred_throughput_mbps` have no limit.

The cluster admin can set these default values to meet the organization's requirements, reset them to the initial default values (no limit), or show the existing values.

The mount option defaults are only relevant for new mounts performed and do not influence the existing ones.

**Commands:**

`weka cluster mount-defaults set`

`weka cluster mount-defaults reset`

`weka cluster mount-defaults show`

To set the mount option default values, run the following command:

{% code overflow="wrap" %}
```bash
weka cluster mount-defaults set [--qos-max-throughput qos-max-throughput] [--qos-preferred-throughput qos-preferred-throughput]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="309">Option</th><th>Description</th></tr></thead><tbody><tr><td><code>qos_max_throughput</code></td><td>Sets the default value for the <code>qos_max_throughput_mbps</code> option, which is the max requests rate for QoS in megabytes per second.</td></tr><tr><td><code>qos_preferred_throughput</code></td><td>Sets the default value for the <code>qos_preferred_throughput_mbps</code> option, which is the preferred requests rate for QoS in megabytes per second.</td></tr></tbody></table>

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
When using `wekafs` mounts, both clients and backends should use the same type of networking technology (either IB or Ethernet).
{% endhint %}

### IP, subnet, gateway, and virtual functions

For higher performance, the usage of multiple Frontends may be required. When using a NIC other than Mellanox or Intel E810 or mounting a DPDK client on a VM, it is required to use [SR-IOV](../../install/bare-metal/setting-up-the-hosts/#sr-iov-enablement) to expose a VF of the physical device to the client. Once exposed, it can be configured via the mount command.

To assign the VF IP addresses or when the client resides in a different subnet and routing is needed in the data network, use`net=<netdev>/[ip]/[bits]/[gateway]`.

`ip, bits, gateway` are optional. If these options are not provided, the WEKA system performs one of the following depending on the environment:

* **Cloud environment:** The WEKA system deduces the values of the `ip, bits, gateway` options.
*   **On-premises environment:** The WEKA system allocates values to the `ip, bits, gateway` options based on the cluster default network. Failure to set the default network may result in the WEKA cluster failing to allocate an IP address for the client.

    Ensure that the WEKA cluster default data networking is configured prior to running the mount command. For details, see [Configure default data networking (optional)](../../install/bare-metal/perform-post-configuration-procedures.md#id-6.-configure-default-data-networking-optional).

#### Example: allocate two cores and a single physical network device (intel0)

The following command configures two VFs for the device and assign each one of them to one of the frontend processes. The first container receives a 192.168.1.100 IP address, and the second uses a 192.168.1.101 IP address. Both IPs have 24 network mask bits and a default gateway of 192.168.1.254.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o num_cores=2 -o net=intel0/192.168.1.100+192.168.1.101/24/192.168.1.254 backend1/my_fs /mnt/weka
```
{% endcode %}

### Multiple physical network devices for performance and HA

For performance or high availability, it is possible to use more than one physical network device.

#### Using multiple physical network devices for better performance

It's easy to saturate the bandwidth of a single network interface when using WekaFS. For higher throughput, it is possible to leverage multiple network interface cards (NICs). The `-o net` notation shown in the examples above can be used to pass the names of specific NICs to the WekaFS server driver.

For example, the following command will allocate two cores and two physical network devices for increased throughput:

```bash
mount -t wekafs -o num_cores=2 -o net=mlnx0 -o net=mlnx1 backend1/my_fs /mnt/weka
```

#### Using multiple physical network devices for HA configuration

Multiple NICs can also be configured to achieve redundancy (for details, see the [WEKA networking HA](../../overview/networking-in-wekaio.md#ha) section) and higher throughput for a complete, highly available solution. For that, use more than one physical device as previously described, and also, specify the client management IPs using `-o mgmt_ip=<ip>+<ip2>` command-line option.

For example, the following command will use two network devices for HA networking and allocate both devices to four Frontend processes on the client. The modifier `ha` is used here, which stands for using the device on all processes.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o num_cores=4 -o net:ha=mlnx0,net:ha=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```
{% endcode %}

**Advanced mounting options for multiple physical network devices**

With multiple Frontend processes (as expressed by `-o num_cores`), it is possible to control what processes use what NICs. This can be accomplished through the use of special command line modifiers called _slots_. In WekaFS, _slot_ is synonymous with a process number. Typically, the first WekaFS Frontend process will occupy slot 1, then the second - slot 2 and so on.

Examples of slot notation include `s1`, `s2`, `s2+1`, `s1-2`, `slots1+3`, `slot1`, `slots1-4` , where `-` specifies a range of devices, while `+` specifies a list. For example, `s1-4` implies slots 1, 2, 3, and 4, while `s1+4` specifies slots 1 and 4.

For example, in the following command, `mlnx0` is bound to the second Frontend process while`mlnx1` to the first one for improved performance.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o num_cores=2 -o net:s2=mlnx0,net:s1=mlnx1 backend1/my_fs /mnt/weka
```
{% endcode %}

For example**,** in the following HA mounting command, two cores (two Frontend processes) and two physical network devices (`mlnx0`, `mlnx1`) are allocated. By explicitly specifying `s2+1`, `s1-2` modifiers for network devices, both devices will be used by both Frontend processes. Notation `s2+1` stands for the first and second processes, while `s1-2` stands for the range of 1 to 2, and are effectively the same.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o num_cores=2 -o net:s2+1=mlnx0,net:s1-2=mlnx1 backend1/my_fs -o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```
{% endcode %}

### UDP mode

If DPDK cannot be used, you can use the WEKA filesystem UDP networking mode through the kernel (for details about UDP mode. see the [WEKA networking](../../overview/networking-in-wekaio.md) section). Use `net=udp` in the mount command to set the UDP networking mode, for example:

```bash
mount -t wekafs -o net=udp backend-server-0/my_fs /mnt/weka
```

{% hint style="info" %}
A client in UDP mode cannot be configured in HA mode. However, the client can still work with a highly available cluster.&#x20;
{% endhint %}

{% hint style="info" %}
Providing multiple IPs in the \<mgmt-ip> in UDP mode uses their network interfaces for more bandwidth, which can be useful in RDMA environments rather than using only one NIC.
{% endhint %}

## Mount a filesystem using fstab

Using the _fstab_ (filesystem table) enables automatic remount after reboot. It applies to **stateless clients** running on an OS that supports `systemd`, such as RHEL/CentOS 7.2 and up, Ubuntu 16.04 and up, and Amazon Linux 2 LTS.

**Before you begin**

If the mount point you want to set in the fstab is already mounted,  unmount it before setting the fstab file.

**Procedure**

1. Remove the `/etc/init.d/weka-agent` file.
2. Create a file named `weka-agent.service` with the following content and save it in `/etc/systemd/system`.

{% code title="weka-agent.service" %}
```
[Unit]
Description=WEKA Agent Service
Wants=network.target network-online.target
After=network.target network-online.target rpcbind.service
Documentation=http://docs.weka.io
Before=remote-fs-pre.target remote-fs.target

[Service]
Type=simple
ExecStart=/usr/bin/weka --agent
Restart=always
WorkingDirectory=/
EnvironmentFile=/etc/environment
# Increase the default a bit in order to allow many simultaneous
# files to be monitored, we might need a lot of fds.
LimitNOFILE=65535

[Install]
RequiredBy=remote-fs-pre.target remote-fs.target
```
{% endcode %}

3. Run the following command:

```bash
systemctl daemon-reload; systemctl enable --now weka-agent.service
```

4. Create a mount point.\
   Example: `mkdir -p /mnt/weka/my_fs`
5. Edit `/etc/fstab` file.

**fstab structure**

{% code overflow="wrap" %}
```bash
<backend servers/my_fs> <mount point> <filesystem type> <mount options> <systemd mount options>  0     0

```
{% endcode %}

**fstab example**

{% code overflow="wrap" %}
```bash
backend-0,backend-1,backend-3/my_fs /mnt/weka/my_fs  wekafs  num_cores=1,net=eth1,x-systemd.requires=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev   0       0

```
{% endcode %}

**fstab structure descriptions**

* **Backend servers/my\_fs:** A comma-separated list of backend servers with the filesystem name
* **Mount point:** If the client mounts multiple clusters, specify a unique name for each client container. Example: For two client containers, set `container_name=client1` and  `container_name=client2`.
* **Filesystem type:** `wekafs`
* **Mount options:**
  * See [Additional mount options using the stateless clients feature](./#additional-mount-options-using-the-stateless-clients-feature).
  * **Systemd mount options:**\
    `x-systemd.after=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev`\
    You can set the `mount-timeout` based on your preferences, such as `180` seconds. This flexibility allows you to customize the timeout according to your specific system needs.

7. Mount the the filesystem to test the fstab setting by running the command, for example:\
   `mount /mnt/weka/my_fs`
8. To test the fstab implementation, reboot the server.\
   WEKA creates the mounts for the next boot.

The filesystem is mounted automatically after server reboot.

## Mount a filesystem using autofs

**Procedure:**

1. Install `autofs` on the server using one of the following commands according to your deployment:

* On Red Hat or CentOS:&#x20;

```bash
yum install -y autofs
```

* On Debian or Ubuntu:

```bash
apt-get install -y autofs
```

2\. To create the `autofs` configuration files for Weka filesystems, do one of the following\
&#x20;   depending on the client type:

* For a stateless client, run the following commands (specify the backend names as parameters):

{% code overflow="wrap" %}
```bash
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs,num_cores=1,net=<netdevice>" > /etc/auto.master.d/wekafs.autofs
echo "*   <backend-1>,<backend-2>/&" > /etc/auto.wekafs
```
{% endcode %}

* For a stateful client (traditional), run the following commands:

{% code overflow="wrap" %}
```bash
echo "/mnt/weka   /etc/auto.wekafs -fstype=wekafs" > /etc/auto.master.d/wekafs.autofs
echo "*   &" > /etc/auto.wekafs
```
{% endcode %}

3\. Restart the `autofs` service:

```
service autofs restart
```

4\. The configuration is distribution-dependent. Verify that the service is configured to start\
&#x20;    automatically after restarting the server. Run the following command:\
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
