---
description: >-
  Discover the two modes for mounting a filesystem on a cluster server:
  persistent mount mode (stateful) and stateless mount mode. You can also use
  fstab or autofs for mounting.
---

# Mount filesystems

## Overview

There are two modes available for mounting a filesystem in a cluster server:

* **Persistent mount mode (stateful):** This mode involves configuring a client to join the cluster before running the mount command.
* **Stateless mount mode:** This mode simplifies and improves client management by eliminating the need for the Adding Clients process.

If you need to mount filesystems from multiple clusters on a single client, refer to the relevant topic for detailed instructions.

In addition, you can mount a filesystem using **fstab** or **autofs**.

**Related topics**

[#mount-a-filesystem-using-the-persistent-mount-mode](./#mount-a-filesystem-using-the-persistent-mount-mode "mention")

[#mounting-filesystems-using-stateless-clients](./#mounting-filesystems-using-stateless-clients "mention")

[#mount-a-filesystem-using-fstab](./#mount-a-filesystem-using-fstab "mention")

[#mount-a-filesystem-using-autofs](./#mount-a-filesystem-using-autofs "mention")

[mount-fs-from-scmc.md](mount-fs-from-scmc.md "mention")

***



## Mount a filesystem using the persistent mount mode

To mount a WEKA filesystem persistently, follow these steps:

1. **Install the WEKA client**: Ensure the WEKA client is installed, configured, and connected to your WEKA cluster. See [adding-clients-bare-metal.md](../../planning-and-installation/bare-metal/adding-clients-bare-metal.md "mention").
2. **Identify the filesystem**: Determine the name of the filesystem you want to mount. For this example, we use a filesystem named `demo`.
3.  **Create a mount point**: SSH into one of your cluster servers and create a directory to serve as the mount point for the filesystem:

    ```bash
    mkdir -p /mnt/weka/demo
    ```
4.  **Mount the filesystem**: As the root user, run the following command to mount the filesystem:

    ```bash
    mount -t wekafs demo /mnt/weka/demo
    ```

**General command structure**: The general syntax for mounting a WEKA filesystem is:

```bash
mount -t wekafs [-o option[,option]...] <fs-name> <mount-point>
```

Replace `<fs-name>` with the name of your filesystem and `<mount-point>` with the directory you created for mounting.

**Read and write cache modes:** When mounting a filesystem, you can choose between two cache modes: read cache and write cache. Each mode offers distinct advantages depending on your use case. For detailed descriptions of these modes, refer to the following links:

* [Read cache mount mode](../../weka-system-overview/weka-client-and-mount-modes.md#read-cache-mount-mode-default)
* [Write cache mount mode](../../weka-system-overview/weka-client-and-mount-modes.md#write-cache-mount-mode)

***



## Mount a filesystem using the stateless mount mode <a href="#mounting-filesystems-using-stateless-clients" id="mounting-filesystems-using-stateless-clients"></a>

The stateless mount mode simplifies client management by deferring the joining of the cluster until the mount operation is performed. This approach is particularly beneficial in environments like AWS, where clients frequently join and leave the cluster.

**Key benefits**

* **Simplified client management**: Eliminates the need for tedious client management procedures.
* **Unified security**: Consolidates all security aspects within the mount command, removing the need to manage separate credentials for cluster join and mount.

**Prerequisites**

* The stateless clients must have a connection to all the backends, dedicated protocol servers  (gateways), and persistent clients.
* Ensure the WEKA agent is installed on your client to utilize the stateless mount mode. See [adding-clients-bare-metal.md](../../planning-and-installation/bare-metal/adding-clients-bare-metal.md "mention").

**Mount a filesystem**

Once the WEKA agent is installed, you can create and configure mounts using the mount command. To mount a filesystem:

* **Create and configure mounts**: Use the `mount` command to create and configure the mounts. See [#mount-command-options](./#mount-command-options "mention").
* **Unmounting**: Remove existing mounts from the cluster using the `unmount` command.

**Authentication**

To restrict mounting to only WEKA authenticated users, set the `--auth-required` flag to `yes` for the filesystem. For more information, refer to [organizations-2.md](../../operation-guide/organizations/organizations-2.md "mention").

### **Set a stateless client with restricted operations on an Isolated port**

To restrict a stateless client's operations to only the essential APIs for mounting and unmounting, connect to WEKA clusters through TCP base port + 3 (for example, 14003). This configuration enables operational segregation between client and backend control plane requests.

### **Mount with restricted options**

When mounting with the restricted option, the logged-in user's privileges are set to regular user privileges, regardless of the user's role.

### Install the WEKA agent

To install a WEKA agent on a client, run one of the following commands as `root` on the client:

* For a non-restricted client:

```sh
curl -k https://hostname:14000/dist/v1/install | sh
```

* For a restricted client:

```bash
curl -k https://hostname:14003/dist/v1/install | sh
```

{% hint style="info" %}
The `-k` flag instructs the `curl` command to bypass SSL certificate verification.
{% endhint %}

After running the appropriate command, the agent is installed on the client.

### Run the mount command

**Command:** `mount -t wekafs`

#### Command syntax

Use one of the following command lines to invoke the mount command. The delimiter between the server and filesystem can be either `:/` or `/`:

{% code overflow="wrap" %}
```bash
mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-point>

mount -t wekafs -o <options> <backend0>[,<backend1>,...,<backendN>]:/<fs> <mount-point>
```
{% endcode %}

### **Example: Mount for a restricted stateless client on an isolated port**

{% code overflow="wrap" %}
```bash
mount -t wekafs -o restricted -o <options> <backend0>[,<backend1>,...,<backendN>]/<fs> <mount-point>
```
{% endcode %}

This setup ensures that the stateless client operates with restricted privileges, maintaining a secure and controlled environment for mounting and unmounting operations on an isolated port.

**Parameters**

<table><thead><tr><th width="250">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>options</code></td><td>See Additional Mount Options below.</td></tr><tr><td><code>backend</code></td><td>IP/hostname of a backend container.<br>Mandatory.</td></tr><tr><td><code>fs</code></td><td>Filesystem name.<br>Mandatory.</td></tr><tr><td><code>mount-point</code></td><td>Path to mount on the local server.<br>Mandatory.</td></tr></tbody></table>

***



## Mount command options

Each mount option can be passed by an individual `-o` flag to `mount.`

### For all client types

<table data-full-width="false"><thead><tr><th width="221.87109375">Option</th><th width="343.1953125">Description</th><th width="97.6484375">Default</th><th>Remount supported</th></tr></thead><tbody><tr><td><code>readcache</code></td><td><p>Enables read-only cache mode for mounts. When enabled, data is read from cache, and <code>writecache</code> is automatically disabled.</p><p></p><p><strong>Note:</strong> SMB share mounts always use <code>readcache</code> mode; use this flag for SMB shares.</p></td><td>Disabled</td><td>Yes</td></tr><tr><td><code>writecache</code></td><td>Enables write-to-cache mode for mounts, allowing data to be written to the cache.</td><td>Enabled</td><td>Yes</td></tr><tr><td><code>forcedirect</code></td><td><p>Enables direct I/O mode, bypassing cache for both read and write operations. Automatically disables <code>writecache</code> and <code>readcache</code> when enabled.</p><p></p><p><strong>Notes:</strong> </p><ul><li>This may impact performance. Use with caution. If unsure, contact the <a href="../../support/getting-support-for-your-weka-system.md#contact-customer-success-team">Customer Success Team</a>.</li></ul><ul><li>It is not supported for SMB shares.</li></ul></td><td>Disabled</td><td>Yes</td></tr><tr><td><code>dentry_max_age_positive</code></td><td><p>Maximum time in milliseconds to cache positive directory entries before refreshing metadata. This ensures the WEKA client detects metadata changes made by other clients.</p><p><strong>Values:</strong> Time in milliseconds</p></td><td><code>1000</code></td><td>Yes</td></tr><tr><td><code>dentry_max_age_negative</code></td><td><p>Time in milliseconds to cache "file not found" results. When a file lookup fails, the system remembers this failure for the specified duration. After this time expires, the system will check again, allowing detection of files created by other clients.</p><p><strong>Values:</strong> Time in milliseconds</p></td><td><code>0</code></td><td>Yes</td></tr><tr><td><code>ro</code></td><td>Mounts the filesystem in read-only mode, preventing write operations.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>rw</code></td><td>Mounts the filesystem in read-write mode, allowing both read and write operations.</td><td>Enabled</td><td>Yes</td></tr><tr><td><code>inode_bits</code></td><td>Sets the inode size in bits. May be required for compatibility with 32-bit applications.<br>Values: <code>32</code>, <code>64</code>, <code>auto</code></td><td><code>Auto</code></td><td>No</td></tr><tr><td><code>verbose</code></td><td>Enables debug logging output to the console.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>quiet</code></td><td>Disables all log output to the console.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>acl</code></td><td><p>Enables POSIX ACL support for the mount. When ACLs are defined, they can modify effective group permissions through mask permissions.</p><p>If ACLs are configured but not present on the mount, effective group permissions are granted.</p></td><td>Disabled</td><td>No</td></tr><tr><td><code>obs_direct</code></td><td><p>Enables bypassing time-based file retention policies, prioritizing the immediate release of files to the object store regardless of other policies. Data is still written to the SSD first, but released with precedence.</p><p>For more details, see <a data-mention href="../tiering/advanced-time-based-policies-for-data-storage-location.md#direct-object-store-mount-option">#direct-object-store-mount-option</a></p></td><td>Disabled</td><td>Yes</td></tr><tr><td><code>noatime</code></td><td>Disables updating of inode access times on file reads, improving performance by reducing metadata writes.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>strictatime</code></td><td>Enables always updating inode access times on file access, ensuring accurate access time tracking.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>relatime</code></td><td>Updates inode access times only when files are modified, changed, or when accessed after <code>relatime_threshold</code> has elapsed.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>relatime_threshold</code></td><td><p>Time in seconds to wait since the last inode access before updating the access time again. Set to 0 to never update access time on read-only access.</p><p>Only applies when <code>relatime</code> is enabled.</p><p><strong>Values:</strong> Time in seconds</p></td><td><code>0</code> (infinite)</td><td>Yes</td></tr><tr><td><code>nosuid</code></td><td>Ignores <code>setuid</code> and <code>setgid</code> bits on files, preventing privilege escalation through these mechanisms.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>nodev</code></td><td>Prevents interpretation of character and block device files, disabling device access through the mount.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>noexec</code></td><td>Prevents direct execution of binaries on the mounted filesystem.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>file_create_mask</code></td><td><p>File creation mask. A numeric (octal) notation of POSIX permissions.<br>Newly created file permissions are masked with the creation mask. For example, if a user creates a file with permissions=777 but the <code>file_create_mask</code> is 770, the file is created with 770 permissions. </p><p>First, the <code>umask</code> is taken into account, followed by the <code>file_create_mask</code> and then the <code>force_file_mode</code>.</p></td><td><code>0777</code></td><td>Yes</td></tr><tr><td><code>directory_create_mask</code></td><td><p>Directory creation mask in octal notation. Newly created directories have their permissions masked with this value. For example, creating a directory with 777 permissions and a mask of 770 results in 770 permissions.</p><p>Permission precedence: <code>umask</code> → <code>directory_create_mask</code> → <code>force_directory_mode</code></p><p><strong>Values:</strong> Octal permissions (for example, <code>755</code>, <code>770</code>)</p></td><td><code>0777</code></td><td>Yes</td></tr><tr><td><code>force_file_mode</code></td><td><p>Forces file permissions using octal notation. Newly created files have their permissions logically OR'ed with this value. For example, creating a file with 770 permissions and force mode 775 results in 775 permissions.</p><p>Permission precedence: <code>umask</code> → <code>file_create_mask</code> → <code>force_file_mode</code></p><p><strong>Values:</strong> Octal permissions (for example, <code>644</code>, <code>755</code>)</p></td><td><code>0</code></td><td>Yes</td></tr><tr><td><code>force_directory_mode</code></td><td><p>Forces directory permissions using octal notation. Newly created directories have their permissions logically OR'ed with this value. For example, creating a directory with 770 permissions and force mode 775 results in 775 permissions.</p><p>Permission precedence: <code>umask</code> → <code>directory_create_mask</code> → <code>force_directory_mode</code></p><p><strong>Values:</strong> Octal permissions (for example, <code>755</code>, <code>775</code>)</p></td><td><code>0</code></td><td>Yes</td></tr><tr><td><code>sync_on_close</code></td><td>Ensures all file data is written to the server when files are closed, providing immediate data consistency. Simulates NFS open-to-close semantics with <code>writecache</code> mode and directory quotas. Required for applications that expect write errors at <code>close()</code> when quotas are exceeded.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>nosync_on_close</code></td><td>Cancels <code>sync_on_close</code> behavior, allowing files to close without waiting for server confirmation that data is written to disk. Changes are buffered in memory and written asynchronously, improving performance but reducing immediate data consistency.</td><td>Disabled</td><td>Yes</td></tr><tr><td><code>df_remote</code></td><td>Ensures the mount source includes a colon (<code>:</code>), identifying the filesystem as remote. This prevents tools that list only local filesystems, such as df -l, from incorrectly including the WEKA filesystem in their output.</td><td>Disabled</td><td>No</td></tr></tbody></table>

### Remount of general options

You can remount using the mount options marked as `Remount Supported` in the above table (`mount -o remount)`.

When a mount option has been explicitly changed, you must set it again in the remount operation to ensure it retains its value. For example, if you mount with `ro`, a remount without it changes the mount option to the default `rw`. If you mount with `rw`, it is not required to re-specify the mount option because this is the default.&#x20;

### **Additional mount options using the stateless clients feature**

<table data-full-width="false"><thead><tr><th width="256.51171875">Option</th><th width="278.88671875">Description</th><th width="104.8984375">Default</th><th>Remount supported</th></tr></thead><tbody><tr><td><code>memory_mb=&#x3C;memory_mb></code></td><td>The memory size in MiB the client can use for hugepages.</td><td><code>1400</code></td><td>Yes</td></tr><tr><td><code>num_cores=&#x3C;frontend-cores></code></td><td><p>Specifies the number of processing cores allocated to handle client network operations.</p><p><strong>Values:</strong></p><ul><li>1 to N (where N is the maximum available cores)</li><li>0 (only valid with UDP networking mode)</li></ul><p><strong>Notes</strong>:</p><ul><li>Cannot be used with  <code>core</code> parameter</li><li>When using NICs with Virtual Functions, <code>num_cores</code> must match the number of configured network devices (<code>net=</code>)</li><li>Higher core counts may improve performance for multi-connection workloads</li></ul><p>Example: <code>core_num=4</code> # Allocates 4 cores for client processing</p></td><td><code>1</code></td><td>Yes</td></tr><tr><td><code>core=&#x3C;core-id></code></td><td><p>Specifies which CPU cores to assign to the WEKA client.</p><p>Multiple cores can be specified as a comma-separated list.</p><p>Core 0 is reserved for system use and cannot be specified.</p><p>Examples:</p><pre data-overflow="wrap"><code>-o core=1   # Single core

-o core=1 -o core=3 -o core=5    # Multiple cores
</code></pre><p><strong>Restrictions</strong>:</p><ul><li>Core IDs must be unique and available on system</li><li>Cannot be used with <code>num_cores</code> parameter</li><li>Core 0 not allowed</li></ul></td><td></td><td>Yes</td></tr><tr><td><code>net=&#x3C;netdev>[/&#x3C;ip>/&#x3C;bits>[/&#x3C;gateway>]]</code></td><td><p>Specifies network devices for WEKA client connections. Required for on-premises installations.</p><p>Format:</p><ul><li>Single device: <code>-o net=eth1</code></li><li>Multiple devices: <code>-o net=eth1 -o net=eth2 -o net=eth3</code></li></ul><p><strong>Important</strong>:</p><ul><li>For NICs with Virtual Functions (VFs), the number of network devices must equal <code>num_cores</code></li><li>Supports both physical NICs and virtual functions</li><li>Must specify at least one network device</li></ul><p>For additional options, see <a data-mention href="./#advanced-network-configuration-for-stateless-clients">#advanced-network-configuration-for-stateless-clients</a> </p></td><td></td><td>Yes</td></tr><tr><td><code>remove_after_secs=&#x3C;secs></code></td><td>The time in seconds without connectivity, after which the client is removed from the cluster. <br>Minimum value: <code>60</code> seconds.<br><code>3600</code> seconds = 1 hour.</td><td><code>3600</code></td><td>Yes</td></tr><tr><td><code>traces_capacity_mb=&#x3C;size-in-mb></code></td><td><p>Traces capacity limit in MB.</p><p>Minimum value: 512 MB.</p></td><td></td><td>No</td></tr><tr><td><code>reserve_1g_hugepages=&#x3C;true or false></code></td><td>Controls the page allocation algorithm to reserve hugepages.<br><strong>Values:</strong><br><code>true</code>: reserves 1 GB<br><code>false</code>: reserves 2 MB</td><td><code>true</code></td><td>Yes</td></tr><tr><td><code>readahead_kb=&#x3C;readahead></code></td><td>The readahead size in KB per mount. A higher readahead is better for sequential reads of large files.</td><td><code>32768</code></td><td>Yes</td></tr><tr><td><code>auth_token_path</code></td><td>The path to the mount authentication token (per mount).</td><td><code>~/.weka/auth-token.json</code></td><td>No</td></tr><tr><td><code>dedicated_mode</code></td><td><p>Controls CPU core allocation for DPDK networking.</p><p>Set to <code>full</code> to dedicate an entire core to network processing, or <code>none</code> to operate without core dedication (requires NIC driver support).</p><p>Only applies when DPDK networking is enabled (<code>net=udp</code> not set). See <a href="../../weka-system-overview/networking-in-wekaio.md#dpdk-without-the-core-dedication">DPDK without the core dedication</a>.</p><p><strong>Values:</strong> <code>full</code>, <code>none</code></p></td><td><code>full</code></td><td>No</td></tr><tr><td><code>qos_preferred_throughput_mbps</code></td><td>Specifies the preferred request rate for Quality of Service (QoS), in megabytes per second. This is a soft target used to guide bandwidth allocation. The system aims to maintain this rate under normal conditions but allows the frontend to exceed it, up to the maximum, when additional resources are available.<br>The cluster admin can set the default value. See <a href="./#set-mount-option-default-values">Set mount option default values</a>.</td><td><code>0</code> (unlimited)<br></td><td>Yes</td></tr><tr><td><code>qos_max_throughput_mbps</code></td><td>Specifies the maximum request rate for Quality of Service (QoS), in megabytes per second. This is an average-based limit applied at the front end. The system allows short bursts above this value but aims to maintain the specified limit over time.<br>The cluster admin can set the default value. See <a href="./#set-mount-option-default-values">Set mount option default value</a>.</td><td><code>0</code> (unlimited)</td><td>Yes</td></tr><tr><td><code>qos_max_ops</code></td><td>Maximum number of IO operations a client can perform per second.<br>Set a limit to a client or clients to prevent starvation from the rest of the clients. (Do not set this option for mounting from a backend.)</td><td><code>0</code> (unlimited)</td><td>Yes</td></tr><tr><td><code>connect_timeout_secs</code></td><td>The timeout, in seconds, for establishing a connection to a single server. </td><td><code>10</code></td><td>Yes</td></tr><tr><td><code>response_timeout_secs</code></td><td>The timeout, in seconds, waiting for the response from a single server.</td><td><code>60</code></td><td>Yes</td></tr><tr><td><code>join_timeout_secs</code></td><td>The timeout, in seconds, for the client container to join the Weka cluster.</td><td><code>360</code></td><td>Yes</td></tr><tr><td><code>dpdk_base_memory_mb</code></td><td>The base memory in MB to allocate for DPDK. Set this option when mounting to a WEKA cluster on GCP.<br>Example: <code>-o dpdk_base_memory_mb=16</code></td><td><code>0</code></td><td>Yes</td></tr><tr><td><code>weka_version</code></td><td>The WEKA client version to run.</td><td>Cluster version</td><td>No</td></tr><tr><td><code>restricted</code></td><td>Restricts a stateless client’s operations to only the essential APIs for mounting and unmounting operations.</td><td></td><td>No</td></tr></tbody></table>

{% hint style="info" %}
The additional mount options parameters above are only effective on the first mount command for each client, unless stated otherwise.
{% endhint %}

{% hint style="info" %}
By default, the command selects the optimal core allocation for WEKA. If necessary, multiple `core` parameters can be used to allocate specific cores to the WEKA client. For example, `mount -t wekafs -o core=2 -o core=4 -o net=ib0 backend-server-0/my_fs /mnt/weka`
{% endhint %}

{% hint style="success" %}
**Example: On-Premise Installations**

`mount -t wekafs -o num_cores=1 -o net=ib0 backend-server-0/my_fs /mnt/weka`

Running this command on a server installed with the Weka agent downloads the appropriate WEKA version from the `backend-server-0`and creates a WEKA container that allocates a single core and a named network interface (`ib0`). Then it joins the cluster that `backend-server-0` is part of and mounts the filesystem `my_fs` on `/mnt/weka.`

`mount -t wekafs -o num_cores=0 -o net=udp backend-server-0/my_fs /mnt/weka`

Running this command uses [UDP mode ](../../weka-system-overview/networking-in-wekaio.md#udp-mode)(usually selected when the use of DPDK is not available).
{% endhint %}

{% hint style="success" %}
**Example: AWS Installations**

`mount -t wekafs -o num_cores=2 backend1,backend2,backend3/my_fs /mnt/weka`

Running this command on an AWS EC2 instance allocates two cores (multiple-frontends), attaches and configures two ENIs on the new client. The client attempts to rejoin the cluster through all three backends specified in the command line.
{% endhint %}

For stateless clients, the first `mount` command serves a dual purpose:

1. It installs the WEKA client software.
2. It joins the WEKA cluster.

Subsequent `mount` commands can be simplified, requiring only the persistent or per-mount parameters as defined in the [#mount-command-options](./#mount-command-options "mention"). The full cluster configuration is not needed for these additional mounts.

WEKA filesystems can be accessed directly through the mount point. You can navigate to the filesystem using standard directory commands, such as `cd /mnt/weka/`.

When the final WEKA filesystem is unmounted using the `umount` command, two key actions occur:

* The client is automatically disconnected from the cluster.
* The WEKA client software is uninstalled by the agent.

As a result, initiating a new `mount` operation requires re-specifying the complete cluster configuration, including cluster details, cores, and networking parameters.

{% hint style="info" %}
When running in AWS, the instance IAM role must provide permissions to several AWS APIs (see the [IAM role created in template](../../planning-and-installation/aws/weka-installation-on-aws-using-the-cloud-formation/cloudformation.md#iam-role-created-in-the-template) section).
{% endhint %}

{% hint style="info" %}
Memory allocation for a client is predefined. To change the memory allocation, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

### Remount options for stateless clients

Mount options explicitly marked as `Remount Supported` can be modified using the `mount -o remount` command. During a remount operation:

* Unspecified mount options retain their current configuration.
* To reset a specific option to its default value, use the `default` modifier.

Example of resetting an option to its default:

* `memory_mb=default` restores the default memory configuration.

This approach allows for flexible, granular adjustments to mount parameters without requiring a complete filesystem unmount and remount.

{% hint style="info" %}
Remounting a stateless client restarts the client container. Once the restart process is complete, all active I/O operations of that client resume automatically.
{% endhint %}

### Set mount option default values <a href="#set-mount-option-default-values" id="set-mount-option-default-values"></a>

#### Default throughput settings

* By default, `qos_max_throughput_mbps` and `qos_preferred_throughput_mbps` are unset, meaning no throughput limit is enforced.

#### Cluster administrator capabilities

* Set custom default values aligned with organizational requirements.
* Reset to initial unlimited configuration.
* View current default settings.

#### Key characteristics

* QoS settings apply to the frontend process, not individual mounts. All mounts on the same frontend share the same QoS limits.
* If a client connects to multiple WEKA clusters, each frontend enforces its QoS settings independently.
* Default value changes only affect new mounts. Existing mounts retain the QoS values they were created with.

#### Available commands

* Set defaults: `weka cluster mount-defaults set`
* Reset to initial values: `weka cluster mount-defaults reset`
* Display current defaults: `weka cluster mount-defaults show`

#### Command syntax

{% code overflow="wrap" %}
```
weka cluster mount-defaults set [--qos-max-throughput qos-max-throughput] [--qos-preferred-throughput qos-preferred-throughput]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="249.9453125">Option</th><th>Description</th></tr></thead><tbody><tr><td><code>qos_max_throughput</code></td><td>Specifies the default maximum request rate for Quality of Service (QoS), in megabytes per second. This is an average-based limit applied at the frontend. The system allows short bursts above this value but aims to maintain the specified limit over time.</td></tr><tr><td><code>qos_preferred_throughput</code></td><td>Specifies the default preferred request rate for Quality of Service (QoS), in megabytes per second. This is a soft target used to guide bandwidth allocation. The system aims to maintain this rate under normal conditions but allows the frontend to exceed it, up to the maximum, when additional resources are available.</td></tr></tbody></table>

### Monitor active mounts per container

Tracking the number of active mounts per container is important for troubleshooting, validating mount configurations, and identifying potential issues in the WEKA cluster. It provides visibility into mount activity, helping users and automation tools detect anomalies and ensure expected behavior.

To view the active mount count for a specific container, read the following `/proc` interface:

```
/proc/wekafs/<container-name>/interface
```

***



## Advanced network configuration for stateless clients

Stateless clients allow for customizable network configurations to enhance performance and connectivity. The following parameters can be adjusted:

* Virtual Functions (VFs)
* IP addresses
* Gateway configuration (required if the client is on a different subnet)
* Physical network devices (for improved performance and high availability)
* UDP mode

To configure networking, use the `-o net=<netdev>` mount option with the appropriate modifiers.

#### **Identify `<netdev>`**

`<netdev>` can be specified using:

* Network interface name
* MAC address
* PCI address of the physical network device
* Bonded device for redundancy and load balancing

#### **Networking technology compatibility**

When using WEKA mounts (`wekafs`), ensure that clients and backends use the same network type. Supported options include InfiniBand (IB) or Ethernet.

#### **Key considerations**

* The `-o net=<netdev>` option provides detailed control over network interfaces.
* Selecting the appropriate configuration helps optimize performance and connectivity.
* Consistent networking technology is essential for system reliability.

### **Configure IP, subnet, gateway, and Virtual Functions (VFs)**

For improved performance, multiple frontend processes may be required. When using a Network Interface Card (NIC) other than Mellanox, or when deploying a DPDK client on a virtual machine (VM), **Single Root I/O Virtualization (SR-IOV)** must be used to expose a **Virtual Function (VF)** of the physical device to the client. Once exposed, the VF can be configured using the `mount` command.

#### **Assign VF IP addresses and routing**

To assign an IP address to a VF or to enable routing when the client is in a different subnet, use the following format:

```bash
net=<netdev>/[ip]/[bits]/[gateway]
```

* `ip`, `bits`, and `gateway` are optional parameters.
* If these parameters are not provided, the WEKA system assigns values based on the environment:
  * **Cloud environment**: The system automatically deduces the IP address, subnet mask, and gateway.
  * **On-premises environment**: The system assigns values based on the cluster’s default network configuration.
    * If the default network is not set, the WEKA cluster may fail to allocate an IP address for the client.

{% hint style="warning" %}
**Important:** Ensure that the **WEKA cluster default data networking** is configured before executing the `mount` command. For configuration details, see [#id-6.-configure-default-data-networking-optional](../../planning-and-installation/bare-metal/perform-post-configuration-procedures.md#id-6.-configure-default-data-networking-optional "mention").
{% endhint %}

#### **Example: Configuring VFs on a single physical network device**

The following command configures VFs for a specified network device and assigns each VF to a frontend process.

* The first frontend process is assigned **192.168.1.100**.
* The second frontend process is assigned **192.168.1.101**.
* Both IPs are configured with a **24-bit subnet mask** and a **default gateway of 192.168.1.254**.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o num_cores=2 -o net=intel0/192.168.1.100+192.168.1.101/24/192.168.1.254 backend1/my_fs /mnt/weka
```
{% endcode %}

### Multiple physical network devices for performance and high availability

Utilizing multiple physical network interface cards (NICs) on a WEKA client can unlock significant gains in data throughput and enhance system resilience. By strategically distributing network traffic across several interfaces, you can overcome single-NIC bottlenecks for demanding applications and ensure continuous data access even if one network path fails.

This section delves into the various methods for configuring and managing multiple NICs with WEKA. It covers how to:

* Aggregate NICs for increased overall performance.
* Set up redundant configurations to achieve high availability.
* Implement advanced NUMA-aware setups for optimal efficiency on multi-socket servers.
* Use specific mount options, including detailed slot notation, to precisely control how client processes uses the available network interfaces.

The following subsections provide detailed explanations and practical examples for each of these configurations, enabling you to tailor your WEKA client's network setup to your specific performance and availability requirements.

<details>

<summary>Multiple physical network devices for better performance</summary>

Demanding workloads on WEKA can readily saturate the bandwidth of a single network interface. For higher throughput, you can leverage multiple network interface cards (NICs). By using the `-o net=<interface>` mount option for each desired NIC, you instruct the WEKA client driver to utilize these specific interfaces, potentially distributing the load and increasing overall bandwidth.

For example, the following command allocates two cores and two physical network devices for increased throughput:

```bash
mount -t wekafs \
-o num_cores=2 \
-o net=mlnx0 -o net=mlnx1 \
backend1/my_fs /mnt/weka
```

</details>

<details>

<summary>Multiple physical network devices for high availability configuration</summary>

Multiple NICs can also be configured to achieve redundancy and higher throughput for a complete, highly available solution. For that, use more than one physical device as previously described, and also, specify the client management IPs using `-o mgmt_ip=<ip1>+<ip2>` command-line option.

For example, the following command uses two network devices (`mlnx0` and `mlnx1`) for high availability and allocates both devices to four Frontend processes on the client(because `num_cores=4`). The modifier `ha` is used here, which stands for using the device on all processes.  Note that in this example, `10.0.0.1` is the IP address of `mlnx0` while `10.0.0.2` is the IP address of `mlnx1`.&#x20;

{% code overflow="wrap" %}
```bash
mount -t wekafs \
-o num_cores=4 \
-o net:ha=mlnx0,net:ha=mlnx1 \
-o mgmt_ip=10.0.0.1+10.0.0.2 \
backend1/my_fs /mnt/weka
```
{% endcode %}

</details>

<details>

<summary>Advanced configuration: NUMA affinity with multiple physical network devices and sockets</summary>

For more complex systems, especially those with multiple CPU sockets and NUMA (Non-Uniform Memory Access) nodes, you can achieve higher performance and efficiency by pinning client processes and their network traffic to specific NUMA nodes. This involves assigning cores from a specific NUMA node to WekaFS client processes and then mapping these processes to a network interface card (NIC) physically located on the same NUMA node.

Consider a server with four NUMA nodes and four InfiniBand (IB) network interfaces, where each IB interface is assumed to reside on a different NUMA node. The NUMA configuration of the CPUs is as follows:

* NUMA node0 CPU(s): 0-63
* NUMA node1 CPU(s): 64-127
* NUMA node2 CPU(s): 128-191
* NUMA node3 CPU(s): 192-255

Let's assume you have four IB interfaces: `ib0` (on NUMA node0), `ib1` (on NUMA node1), `ib2` (on NUMA node2), and `ib3` (on NUMA node3). To configure WekaFS for optimal NUMA affinity, you would pin specific cores from each NUMA node to WekaFS frontend processes and then map these groups of processes to their corresponding NUMA-local IB interface. Management IPs must also be specified for high availability.

**Example:**

The following command configures 16 WekaFS client processes. Four processes are pinned to cores on each of the four NUMA nodes. Each group of four processes is then mapped to its local IB interface.

```
mount -t wekafs \
-o core=63 -o core=62 -o core=61 -o core=60 \
-o core=127 -o core=126 -o core=125 -o core=124 \
-o core=191 -o core=190 -o core=189 -o core=188 \
-o core=255 -o core=254 -o core=253 -o core=252 \
-o net:s1-4=ib0 \
-o net:s5-8=ib1 \
-o net:s9-12=ib2 \
-o net:s13-16=ib3 \
backend_servers/my_fs /mnt/weka
```

**Explanation of the options in this example:**

* **`-o core=...`**: Sixteen specific CPU cores are assigned to WekaFS client processes:
  * Cores 63, 62, 61, 60 are on NUMA node0.
  * Cores 127, 126, 125, 124 are on NUMA node1.
  * Cores 191, 190, 189, 188 are on NUMA node2.
  * Cores 255, 254, 253, 252 are on NUMA node3. This creates 16 frontend processes, with each group of four processes affinitized to a specific NUMA node.
* **`-o net:s1-4=ib0, net:s5-8=ib1, net:s9-12=ib2, net:s13-16=ib3`**: These options use the "multiple NIC slot notation" to map the WekaFS client processes (referred to by "slots") to the specified network interfaces (`ib0`, `ib1`, `ib2`, `ib3`). In this configuration with 16 frontend processes, the intended mapping is:
  * The first group of four processes (running on cores 63,62,61,60 on NUMA0) uses `ib0` (assumed to be on NUMA0).
  * The second group of four processes (running on cores 127,126,125,124 on NUMA1) uses `ib1` (assumed to be on NUMA1).
  * The third group of four processes (running on cores 191,190,189,188 on NUMA2) uses `ib2` (assumed to be on NUMA2).
  * The fourth group of four processes (running on cores 255,254,253,252 on NUMA3) uses `ib3` (assumed to be on NUMA3). This setup ensures that network traffic for processes on a given NUMA node utilizes the NIC local to that NUMA node, minimizing cross-NUMA data transfers and potentially improving performance.

- **`backend_servers/my_fs`**: Replace with your WekaFS backend server address(es) and filesystem name.
- **`/mnt/weka`**: Replace with your desired mount point.

This type of granular configuration is beneficial for maximizing throughput and minimizing latency in high-performance computing (HPC) and AI workloads that are sensitive to NUMA effects.

</details>

<details>

<summary>Advanced mounting options for multiple physical network devices</summary>

With multiple Frontend processes (as expressed by `-o num_cores=X`), it is possible to control what processes use what NICs. This can be accomplished through the use of special command line modifiers called _slots_. In WEKA, _slot_ is synonymous with a process number. Typically, the first WEKA Frontend process will occupy slot 1, then the second - slot 2 and so on.

Examples of slot notation include `s1`, `s2`, `s2+1`, `s1-2`, `slots1+3`, `slot1`, `slots1-4` , where `-` specifies a range of devices, while `+` specifies a list. For example, `s1-4` implies slots 1, 2, 3, and 4, while `s1+4` specifies slots 1 and 4.

For example, in the following command, `mlnx0` is bound to the second Frontend process while `mlnx1` to the first one for improved performance.

{% code overflow="wrap" %}
```bash
mount -t wekafs \
-o num_cores=2 -o net:s2=mlnx0,net:s1=mlnx1 \
backend1/my_fs /mnt/weka
```
{% endcode %}

For exampl&#x65;**,** in the following mounting command, two cores (two Frontend processes) and two physical network devices (`mlnx0`, `mlnx1`) are allocated. By explicitly specifying `s2+1`, `s1-2` modifiers for network devices, both devices will be used by both Frontend processes. Notation `s2+1` stands for the first and second processes, while `s1-2` stands for the range of 1 to 2, and are effectively the same.

{% code overflow="wrap" %}
```bash
mount -t wekafs \
-o num_cores=2 \
-o net:s2+1=mlnx0,net:s1-2=mlnx1 \
backend1/my_fs \
-o mgmt_ip=10.0.0.1+10.0.0.2 /mnt/weka
```
{% endcode %}

</details>

### Network label configuration for stateless clients

In environments with stateless clients and high-availability backend networks, configuring network labels is essential for optimizing data path locality and minimizing inter-switch traffic.

Stateless clients, which typically lack persistent state or configuration storage, often connect to a single top-of-rack switch. In contrast, backend servers are usually dual-connected across multiple switches to ensure high availability. In topologies where these switches are interconnected via inter-switch links (ISLs), traffic between nodes may traverse these ISLs unnecessarily if peer selection is left to default behavior. This can introduce additional latency and consume limited east-west bandwidth.

To influence peer selection and ensure efficient traffic routing, stateless clients can use **network labels**. These labels bind the client’s traffic to a specific network segment or switch, helping ensure that peering remains within the local switch when possible.

**Use case**

This configuration is especially beneficial in:

* Two-switch topologies with ISL connections.
* Deployments where backend nodes are dual-attached and clients are single-attached.
* Scenarios requiring controlled peering to reduce east-west traffic.

**Configuration**

To assign a network label, use the `-o net` mount option in the following format:

```
mount -t wekafs -o net=<device>/label@<label> <filesystem> <mountpoint>
```

**Parameters:**

* `<device>`: The name of the client’s network interface (for example, `eth0`).
* `<label>`: The label that corresponds to the client’s network attachment point.
* `<filesystem>`: The WEKA filesystem to mount.
* `<mountpoint`>: The local directory where the filesystem will be mounted.

**Example:**

```
mount -t wekafs -o net=eth0/label@datacenter-a  project-fs1/data
```

In this example:

* The client uses the `eth0` interface.
* The label `datacenter-a` indicates the switch or network zone the interface is connected to.
* The `project-fs1` WEKA filesystem is mounted at `/data`.

By using a label that reflects the client’s physical or logical network location, the system can make more informed decisions about peering and data path selection, reducing cross-switch communication and improving overall performance.

**Remount support**

The network label configuration using the `-o net` option is also supported during remount operations. This allows administrators to change the network label dynamically without needing to fully unmount and remount the filesystem. For example:

```
mount -o remount,net=eth0/label@datacenter-b /data
```

In this scenario, the client updates the network label to datacenter-b for the existing mount at `/data`. This flexibility is useful when network topology or client attachment changes, allowing adjustments to peering behavior with minimal disruption.

**Related topic**

[#high-availability](../../weka-system-overview/networking-in-wekaio.md#high-availability "mention")

### UDP mode

If DPDK cannot be used, you can use the WEKA filesystem UDP networking mode through the kernel. Use `net=udp` in the mount command to set the UDP networking mode, for example:

```bash
mount -t wekafs -o net=udp backend-server-0/my_fs /mnt/weka
```

{% hint style="info" %}
A client in UDP mode cannot be configured in high availability mode (`ha`). However, the client can still work with a highly available cluster.&#x20;
{% endhint %}

{% hint style="info" %}
Providing multiple IPs in the \<mgmt-ip> in UDP mode uses their network interfaces for more bandwidth, which can be useful in RDMA environments rather than using only one NIC.
{% endhint %}

**Related topic**

[#udp-mode](../../weka-system-overview/networking-in-wekaio.md#udp-mode "mention") (in the WEKA Networking topic)

***



## Mount a filesystem using fstab

Using the fstab (filesystem table) enables automatic remount after a reboot. This applies to stateless clients running on an OS that supports systemd, such as RHEL/CentOS 7.2 and up, Ubuntu 16.04 and up, and Amazon Linux 2 LTS.

#### Before you begin

* If the mount point you want to set in the fstab is already mounted, unmount it before setting the fstab file.

#### Procedure

1. **Create a mount point:** Run the following command to create a mount point:

```
mkdir -p /mnt/weka/my_fs  
```

2. **Edit the `/etc/fstab` file:** Add the entry for the WEKA filesystem.

**fstab structure**

{% code overflow="wrap" %}
```php-template
<backend servers/my_fs> <mount point> <filesystem type> <mount options> <systemd mount options> 0 0  
```
{% endcode %}

**Example**

{% code overflow="wrap" %}
```
backend-0,backend-1,backend-3/my_fs /mnt/weka/my_fs wekafs num_cores=1,net=eth1,x-systemd.after=weka-agent.service,x-systemd.mount-timeout=infinity,_netdev 0 0  
```
{% endcode %}

**fstab configuration parameters**

<table><thead><tr><th width="298">Parameter</th><th>Description</th></tr></thead><tbody><tr><td>Backend servers/my_fs</td><td>Comma-separated list of backend servers with the filesystem name.</td></tr><tr><td>Mount point</td><td><p>If mounting multiple clusters, specify a unique name.</p><p>For two client containers, set <code>container_name=client1</code> and <code>container_name=client2</code>.</p></td></tr><tr><td>Filesystem type</td><td>Must be <code>wekafs</code>.</td></tr><tr><td>Systemd mount options</td><td><ul><li><code>x-systemd.after=weka-agent.service</code></li><li><code>x-systemd.mount-timeout=infinity</code></li><li><code>_netdev</code></li></ul><p>Adjust the mount-timeout to your preference, for example, 180 seconds.</p></td></tr><tr><td>Mount options</td><td>See <a data-mention href="./#additional-mount-options-using-the-stateless-clients-feature">#additional-mount-options-using-the-stateless-clients-feature</a></td></tr></tbody></table>

3. **Mount the filesystem:** Test the fstab setting by running:

```
mount /mnt/weka/my_fs  
```

4. **Reboot the server:** Reboot the server to apply the fstab settings. The filesystem is automatically mounted after the reboot.

***



## Mount a filesystem using autofs

Autofs allows filesystems to be mounted dynamically when accessed and unmounted after a period of inactivity. This approach reduces system overhead and ensures efficient resource utilization. Follow these steps to configure autofs for mounting Weka filesystems.

#### Procedure

1. **Install autofs on the server:** Install the autofs package based on your operating system:
   *   **For Red Hat or CentOS**:

       ```
       yum install -y autofs
       ```
   *   **For Debian or Ubuntu**:

       ```
       apt-get install -y autofs
       ```
2. **Configure autofs for WEKA filesystems:** Set up the autofs configuration files according to the client type:
   *   **Stateless client**: Run the following commands, replacing `<backend-1>`, `<backend-2>`, and `<netdevice>` with appropriate values:

       <pre data-overflow="wrap"><code>echo "/mnt/weka /etc/auto.wekafs -fstype=wekafs,num_cores=1,net=&#x3C;netdevice>" > /etc/auto.master.d/wekafs.autofs
       echo "* &#x3C;backend-1>,&#x3C;backend-2>/&#x26;" > /etc/auto.wekafs
       </code></pre>
   *   **Persistent client**: Run the following commands:

       <pre data-overflow="wrap"><code>echo "/mnt/weka /etc/auto.wekafs -fstype=wekafs" > /etc/auto.master.d/wekafs.autofs
       echo "* &#x26;" > /etc/auto.wekafs
       </code></pre>
3.  **Restart the autofs service:** Apply the changes by restarting the autofs service:

    ```
    service autofs restart
    ```
4.  **Ensure autofs starts automatically on reboot:** Verify that autofs is configured to start on reboot:

    ```bash
    systemctl is-enabled autofs
    ```

    * If the output is `enabled`, no further action is required.

    **For Amazon Linux**: Use `chkconfig` to confirm autofs is enabled for the current runlevel:

    ```
    chkconfig | grep autofs
    ```

    Ensure the output indicates `on` for the active runlevel.\
    Example output:

    ```
    autofs 0:off 1:off 2:off 3:on 4:on 5:on 6:off
    ```
5.  **Access the WEKA filesystem:** Navigate to the mount point to access the WEKA filesystem. Replace `<fs-name>` with the desired filesystem name:

    ```
    cd /mnt/weka/<fs-name>
    ```

{% hint style="info" %}
* Adjust backend and network device configurations as needed for your deployment.
* Review distribution-specific documentation for additional configuration options.
{% endhint %}
