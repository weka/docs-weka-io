---
description: This page describes how to add clients to a bare-metal cluster.
---

# Add clients to an on-premises WEKA cluster

## cgroups configuration

Clients run applications that access the WEKA filesystem but do not contribute CPUs or drives to the cluster. They connect solely to use the filesystems.

By default, WEKA uses cgroups to limit or isolate resources for its exclusive use, such as assigning specific CPUs.

cgroups (Control Groups) is a Linux kernel feature that allows you to limit, prioritize, and isolate a collection of processes' resource usage (CPU, memory, disk I/O, network). It helps allocate resources among user-defined groups of tasks and manage their performance effectively.

**Versions of cgroups:**

* **cgroupsV1**: Uses multiple hierarchies for different resource controllers, offering fine-grained control but with increased complexity.
* **cgroupsV2**: Combines all resource controllers into a single unified hierarchy, simplifying management and providing better resource isolation and a more consistent interface.

{% hint style="info" %}
**Hybrid mode**: If the OS is configured with hybrid mode (cgroupsV1 and cgroupsV2), WEKA defaults to using cgroupsV1.
{% endhint %}

**WEKA requirements:**

* **Backends and clients serving protocols:** Must run on an OS with cgroupsV1 support. cgroupsV2 is supported on backends and clients but is incompatible with protocol cluster deployments.
* **cgroups mode compatibility:** When setting up cgroups on clients or backends, ensure that the cgroups configuration (whether using cgroupsV1 or cgroupsV2) aligns with the operating system's capabilities and configuration.

### cgroups configuration and compatibility

The configuration of cgroups depends on the installed operating system, and it is important that the cluster server settings match the OS configuration to ensure proper resource management and compatibility.

Customers using a supported OS with cgroupsV2 or wanting to modify the cgroups usage can set the cgroups usage during the agent installation or by editing the service configuration file. The specified mode must match the existing cgroups configuration in the OS.

The cgroups setting includes the following modes:

* `auto`: WEKA tries using cgroupsV1 (default). If it fails, the cgroups is set to none automatically.
* `force`: WEKA uses cgroupsV1. If the OS does not support it, WEKA fails.
* `force_v2`: WEKA uses cgroupsV2. If the OS does not support it, WEKA fails. This mode is not supported in protocol cluster deployments.
* `none`: WEKA never uses cgroups, even if it runs on an OS with cgroupsV1.

### Set the cgroups mode during the client or backend installation

In the installation command line, specify the required cgroups mode (`WEKA_CGROUPS_MODE`).

Example:

```bash
curl http://Backend-1:14000/dist/v1/install | WEKA_CGROUPS_MODE=none sh
```

### Set the cgroups mode in the service configuration file

You can set the cgroups mode in the service configuration file for clients and backends.

1. Open the service configuration file `/etc/wekaio/service.conf` and add one of the following:
   * `cgroups_mode=auto`
   * `cgroups_mode=force`
   * `cgroups_mode=force_v2`
   * `cgroups_mode=none`
2. Restart the WEKA agent service: Run `service weka-agent restart`.
3. Restart the containers to apply the cgroups settings:
   * Run `weka local restart` to restart all containers, or specify a container, for example, `weka local restart client` for the client container. If WEKA is mounted, unmount it before restarting.
4. Verify the cgroups settings by running the `weka local status` command.

Example:

```bash
[root@weka-cluster] #weka local status
Weka v4.2.0 (CLI build 4.2.0)
cgroups: mode=auto, enabled=true

Containers: 1/1 running (1 weka)
Nodes: 2/2 running (2 READY)
Mounts: 1
```

## Add a stateless client to the cluster

A **stateless client** is a client that does not persistently store any software or configuration state locally. Instead, it dynamically installs the required software and configuration each time it interacts with the WEKA system. This approach simplifies client management by eliminating the need for persistent local installations, though the client still temporarily joins the cluster during operations. Stateless clients are particularly useful for deployment on lightweight, diskless servers.

To enable a stateless client to use the WEKA filesystem, the `mount` command is used. This command installs the WEKA software automatically and configures the client without requiring manual intervention.

**Before you begin**

Ensure each client has a unique IP address and fully qualified domain name (FQDN) for proper cluster identification.

**Procedure**

1.  **Install the WEKA agent (One-time setup):**\
    Install the WEKA agent from one of the backend instances. This step prepares the client to interact with the WEKA system. Run the following command (where `backend-1` resolves to the IP address of one of the WEKA backend servers):

    ```bash
    curl http://backend-1:14000/dist/v1/install | sh
    ```
2.  **Create a mount point (one-time setup):**\
    Create a directory on the client system where the WEKA filesystem will be mounted. For example:

    ```bash
    mkdir -p /mnt/weka
    ```
3.  **Mount the WEKA filesystem:**\
    Use the `mount` command to attach the WEKA filesystem to the client (where `my_fs` is the name of the WEKA filesystem). For example:

    ```bash
    mount -t wekafs -o net=eth0 backend-1/my_fs /mnt/weka
    ```

    * During the first mount, the required WEKA software is installed, and the client is configured automatically.

**Additional configuration**

* **Automatic mounting at boot:**\
  To configure the client OS to automatically mount the filesystem at boot time, you can use traditional methods or configure `autofs`. For more details, refer to the relevant documentation on  [#mounting-filesystems-using-stateless-clients](../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-stateless-clients "mention") **Mount a filesystem using the traditional method** or **Mount filesystems using autofs**.
* **Diskless deployment:**\
  Stateless clients can be deployed on [diskless nodes](#user-content-fn-1)[^1] by storing the WEKA client software in RAM and using an NFS mount for traces. For assistance with this setup, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

**Related topic**

[#mounting-filesystems-using-stateless-clients](../../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-stateless-clients "mention") (for detailed mount and configuration options)

## Add a persistent client to the cluster

Add a persistent client for continuous POSIX filesystem access. A persistent client, also called a stateful client, remains joined to the cluster and supports persistent mounts.

**Before you begin**

Ensure the client can reach a backend server. Reserve the CPU cores, memory, and network device for the client container.

**Procedure**

1.  **Install the WEKA agent:** Install the agent from a backend server. Replace `backend-1` with a backend server name that resolves on the client.

    <a class="button secondary">Copy</a>

    ```bash
    curl http://backend-1:14000/dist/v1/install | sh
    ```
2.  **Configure the client container:** Run `weka local setup client` with the required resources and network settings. The command designates the container as `frontend-dedicated`.

    The cluster removes an unreachable client container after one hour. The container rejoins automatically when connectivity returns.

{% hint style="info" %}
You can modify the automatic removal delay using `weka local resources auto-remove-timeout <auto-remove-timeout> [--container container]`. Specify the timeout value in seconds.
{% endhint %}

{% code overflow="wrap" %}
```bash
weka local setup client [--name name]
                        [--cores cores]
                        [--memory memory]
                        [--bandwidth bandwidth]
                        [--timeout timeout]
                        [--base-port base-port]
                        [--weka-version weka-version]
                        [--fqdn fqdn]
                        [--nvidia-vf-single-ip nvidia-vf-single-ip]
                        [--color color]
                        [--core-ids core-ids]...
                        [--management-ips management-ips]...
                        [--join-ips join-ips]...
                        [--net net]...
                        [--disable]
                        [--no-start]
                        [--allow-mix-setting]
                        [--restricted]
```
{% endcode %}

<table><thead><tr><th width="244">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>-n</code>, <code>--name</code></td><td>The name to give the container.</td></tr><tr><td><code>--cores</code></td><td>Number of CPU cores dedicated to WEKA.</td></tr><tr><td><code>--memory</code></td><td>Memory dedicated to WEKA in bytes. Set to <code>0</code> to let the system decide. Use decimal or binary units, such as <code>1GB</code> or <code>1GiB</code>.</td></tr><tr><td><code>--bandwidth</code></td><td>Bandwidth limit per second. Use <code>unlimited</code> or a decimal or binary value, such as <code>1GB</code> or <code>1GiB</code>.</td></tr><tr><td><code>-t</code>, <code>--timeout</code></td><td>Join command timeout. Use values such as <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>, <code>infinite</code>, or <code>unlimited</code>.</td></tr><tr><td><code>--base-port</code></td><td>First port used by the WEKA container. WEKA uses 100 ports starting at this port.</td></tr><tr><td><code>--weka-version</code></td><td>WEKA version used to start the container.</td></tr><tr><td><code>--fqdn</code></td><td>Fully qualified domain name used by other containers for TLS hostname verification.</td></tr><tr><td><code>--nvidia-vf-single-ip</code></td><td>Nvidia VFs work as Single IP</td></tr><tr><td><code>--color</code></td><td>Sets color output. Use <code>auto</code>, <code>disabled</code>, or <code>enabled</code>.</td></tr><tr><td><code>--core-ids</code>...</td><td>WEKA dedicated core IDs. Repeat the parameter or provide comma-separated values.</td></tr><tr><td><code>--management-ips</code>...</td><td>Management process IP addresses. Repeat the parameter or provide comma-separated values.</td></tr><tr><td><code>--join-ips</code>...</td><td>Management process IP:port pairs. If no port is specified, WEKA uses the default port. Repeat the parameter or provide comma-separated values.</td></tr><tr><td><code>--net</code>...</td><td>Network specification. Use a device name such as <code>ib1</code> or <code>eth1</code>, <code>&#x3C;device>/&#x3C;ip>/&#x3C;bits>/&#x3C;gateway></code>, <code>&#x3C;device>/rdma-only/inet4</code>, or <code>&#x3C;device>/rdma-only/inet6</code>. Use <code>udp</code> to force UDP mode. Repeat the parameter or provide comma-separated values.</td></tr><tr><td><code>--disable</code></td><td>Creates the container as disabled.</td></tr><tr><td><code>--no-start</code></td><td>Does not start the container after creation.</td></tr><tr><td><code>--allow-mix-setting</code></td><td>Allows specified core IDs when containers with automatic core-ID allocation run on the same server.</td></tr><tr><td><code>--restricted</code></td><td>Enables restricted client mode.</td></tr></tbody></table>

[^1]: A **diskless node** is a workstation or computer that lacks local disk drives and uses network booting to load its operating system from a server. For details, see [https://en.wikipedia.org/wiki/Diskless\_node](https://en.wikipedia.org/wiki/Diskless_node)
