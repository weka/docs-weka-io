# Add clients to an on-premises WEKA cluster

## Cgroups configuration

Clients run applications that access the WEKA filesystem but do not contribute CPUs or drives to the cluster. They connect solely to use the filesystems.

By default, WEKA uses Cgroups to limit or isolate resources for its exclusive use, such as assigning specific CPUs.

Cgroups (Control Groups) is a Linux kernel feature that allows you to limit, prioritize, and isolate the resource usage (CPU, memory, disk I/O, network) of a collection of processes. It helps allocate resources among user-defined groups of tasks and manage their performance effectively.

**Versions of Cgroups:**

* **CgroupsV1**: Uses multiple hierarchies for different resource controllers, offering fine-grained control but with increased complexity.
* **CgroupsV2**: Combines all resource controllers into a single unified hierarchy, simplifying management and providing better resource isolation and a more consistent interface.

{% hint style="info" %}
**Hybrid mode**: If the OS is configured with hybrid mode (CgroupsV1 and CgroupsV2), WEKA defaults to using CgroupsV1.
{% endhint %}

**WEKA requirements:**

* **Backends and clients serving protocols:** Must run on an OS with CgroupsV1 support. CgroupsV2 is supported on backends and clients but is incompatible with protocol cluster deployments.
* **Cgroups mode compatibility:** When setting up Cgroups on clients or backends, ensure that the Cgroups configuration (whether using CgroupsV1 or CgroupsV2) aligns with the operating system's capabilities and configuration.

### Cgroups configuration and compatibility

The configuration of Cgroups depends on the installed operating system, and it is important that the cluster server settings match the OS configuration to ensure proper resource management and compatibility.

Customers using a supported OS with CgroupsV2 or wanting to modify the Cgroups usage can set the cgroups usage during the agent installation or by editing the service configuration file. The specified mode must match the existing Cgroups configuration in the OS.

The Cgroups setting includes the following modes:

* `auto`: WEKA tries using CgroupsV1 (default). If it fails, the Cgroups is set to none automatically.
* `force`: WEKA uses CgroupsV1. If the OS does not support it, WEKA fails.
* `force_v2`: WEKA uses CgroupsV2. If the OS does not support it, WEKA fails. This mode is not supported in protocol cluster deployments.
* `none`: WEKA never uses Cgroups, even if it runs on an OS with CgroupsV1.

### Set the Cgroups mode during the client or backend installation

In the installation command line, specify the required Cgroups mode (`WEKA_CGROUPS_MODE`).

Example:

```bash
curl http://Backend-1:14000/dist/v1/install | WEKA_CGROUPS_MODE=none sh
```

### Set the Cgroups mode in the service configuration file

You can set the Cgroups mode in the service configuration file for clients and backends.

1. Open the service configuration file `/etc/wekaio/service.conf` and add one of the following:
   * `cgroup_mode=auto`
   * `cgroup_mode=force`
   * `cgroup_mode=force_v2`
   * `cgroup_mode=none`
2. Restart the WEKA agent service.
3. Verify the Cgroups setting by running the `weka local status` command.

Example:

```bash
[root@weka-cluster] #weka local status
Weka v4.2.0 (CLI build 4.2.0)
Cgroups: mode=auto, enabled=true

Containers: 1/1 running (1 weka)
Nodes: 2/2 running (2 READY)
Mounts: 1
```

## Add stateless clients

To use the WEKA filesystems from a client, just call the mount command. The mount command automatically installs the software version, and there is no need to join the client to the cluster.

To mount a filesystem in this method, first, install the WEKA agent from one of the backend instances and then mount the filesystem.

Example:

<pre class="language-bash"><code class="lang-bash"># Agent Installation (one time)
curl http://Backend-1:14000/dist/v1/install | sh

# Creating a mount point (one time)
mkdir -p /mnt/weka

# Mounting a filesystem
<strong>mount -t wekafs -o net=eth0 backend-1/my_fs /mnt/weka
</strong></code></pre>

For the first mount, this installs the WEKA software and automatically configures the client. For more information on mount and configuration options, refer to [Mount a filesystem using the stateless clients feature](../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-stateless-clients).

Configuring the client OS to mount the filesystem at boot time automatically is possible. For more information, refer to [Mount a filesystem using the traditional method](../../weka-filesystems-and-object-stores/mounting-filesystems/#mount-a-filesystem-using-the-traditional-method) or [Mount filesystems using autofs](../../weka-filesystems-and-object-stores/mounting-filesystems/#mount-filesystems-using-autofs).

{% hint style="info" %}
Clients can be deployed on [diskless servers](https://en.wikipedia.org/wiki/Diskless\_node). They can use RAM for the WEKA client software and NFS mount for the traces. For more information, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

{% hint style="info" %}
Each client must have a unique IP and FQDN.
{% endhint %}

## Add persistent clients, which are always part of the cluster

{% hint style="info" %}
Adding instances that do not contribute resources to the cluster but are used for mounting filesystems is possible. It is recommended to use the previously described method for adding client instances for mounting purposes. However, in some cases, adding them to the cluster permanently is helpful. For example, use these instances as NFS/SMB servers, which are always expected to be up.
{% endhint %}

### 1. Install the WEKA software

Install the WEKA software.

* Once the WEKA software tarball is downloaded from [get.weka.io](https://get.weka.io), run the untar command.
* Run the `install.sh` command on each server, according to the instructions in the **Install** tab.

{% hint style="info" %}
All clients in a WEKA system cluster must use the same software version as the backends or a maximum of one version back. The backend containers must run the same WEKA software version except during upgrades (as managed by the upgrade process).
{% endhint %}

### 2. Join the cluster

**Command:** `weka cluster container add`

Once the client is in the stem mode (this is the mode defined immediately after running the `install.sh` command), use the following command line on the client to add it to the cluster:

```bash
weka -H <backend-hostname> cluster container add <client-hostname>
```

**Parameters in the command line**

<table><thead><tr><th width="227">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>backend-hostname</code>*</td><td>An existing hostname (IP or FQDN) of one of the existing backend instances in the cluster.</td></tr><tr><td><code>client-hostname</code>*</td><td>A unique hostname (IP or FQDN) of the client to add.</td></tr></tbody></table>

{% hint style="info" %}
On completion of this stage, the container-id of the newly added container will be received. Make a note of it for the next steps.
{% endhint %}

### 3. Configure the container as a client

**Command:** `weka cluster container cores`

To configure the new container as a client, run the following command:

{% code overflow="wrap" %}
```bash
weka cluster container cores <container-id> <cores> --frontend-dedicated-cores=<frontend-dedicated-cores>
```
{% endcode %}

**Parameters in the command line**

<table data-header-hidden><thead><tr><th width="299">Name</th><th>Value</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td></tr><tr><td><code>container-id</code>*</td><td>A valid identifier of the container to add to the cluster.</td></tr><tr><td><code>cores</code>*</td><td>The number of physical cores to allocate to the WEKA client.</td></tr><tr><td><code>frontend-dedicated-cores</code>*</td><td>The number of physical cores to be dedicated to frontend processes.<br>Mandatory to configure a container as a client.<br>Maximum 19 cores.<br>For clients, the number of total cores and <code>frontend-dedicated-cores</code> must be equal.</td></tr></tbody></table>

### 4. Configure client networking

**Command:** `weka cluster container net add`

{% hint style="info" %}
If the new client is to communicate with the WEKA cluster over the kernel UDP stack, running this command is unnecessary.
{% endhint %}

If a high-performance client is required and the appropriate network NIC is available, use the following command to configure the networking interface used by the client to communicate with the WEKA cluster:

{% code overflow="wrap" %}
```bash
weka cluster container net add <container-id> <device> --ips=<ips> --netmask=<netmask> --gateway=<gateway>
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="189">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>A valid identifier of the container to add to the cluster.</td></tr><tr><td><code>device</code>*</td><td>A valid network interface device name (for example, <code>eth1</code>).</td></tr><tr><td><code>ips</code>*</td><td>A valid IP address of the new interface.</td></tr><tr><td><code>gateway</code></td><td><p>The IP address of the default routing gateway.<br>The gateway must reside within the same IP network of <code>ips</code> (as described by <code>netmask</code>). </p><p>Not relevant for IB / L2 non-routable networks.</p></td></tr><tr><td><code>netmask</code></td><td>The number of bits that identify a network ID (also known as CIDR). For example, the netmask of <code>255.255.0.0</code> has <code>16</code> netmask bits.</td></tr></tbody></table>

{% hint style="info" %}
When configuring an InfiniBand client, do not pass the `--ips`, `--netmask` and `--gateway` parameters.
{% endhint %}

{% hint style="info" %}
InfiniBand/Ethernet clients can only join a cluster with the same network technology connectivity. It is possible to mix InfiniBand and Ethernet clients in the same cluster as long as the cluster backends are connected to both network technologies.
{% endhint %}

### 5. Apply the container configuration

**Command:** `weka cluster container apply`

After successfully configuring the container and its network device, run the following command to finalize the configuration by activating the container:

```bash
weka cluster container apply <container-id> [--force]
```

**Parameters**

<table><thead><tr><th width="188">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>container-id</code>*</td><td>A comma-separated string of valid identifiers of the containers to add to the cluster.</td></tr><tr><td><code>force</code></td><td>A boolean indicates not to prompt for confirmation.<br>The default is not to force a prompt.</td></tr></tbody></table>
