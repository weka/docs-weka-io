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

A **stateless client** is a client that does not persistently store any software or configuration state locally. Instead, it dynamically installs the required software and configuration each time it interacts with the WEKA system. This approach simplifies client management, eliminates the need to join the client to the cluster, and allows for deployment on lightweight, diskless servers.

To enable a stateless client to use the WEKA filesystem, the `mount` command is used. This command installs the WEKA software automatically and configures the client without requiring manual intervention.

#### Before you begin

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

## Add a persistent client (stateful client) to the cluster

A **persistent client** (or stateful client) is a client that remains an integral part of the cluster. It does not contribute resources to the cluster but is used for mounting filesystems or serving purposes, such as NFS/SMB servers, that require continuous availability. Adding persistent clients ensures that these servers are always up and accessible for file system operations.

There are two methods for adding a persistent client to the cluster: a **shorter**, streamlined method and a **longer**, more detailed method. Both methods achieve the same outcome but offer different levels of flexibility and control.

* **Shorter method**: Quick and efficient for most users. It sets up and joins the container with minimal configuration, ideal for persistent clients that do not require specific resource allocations or custom networking.
* **Longer method**: Provides more control and flexibility, allowing for detailed configuration of the client, making it suitable for environments with specific performance or network requirements.

Choose the method that best fits your needs based on the level of customization required.

### Option 1: Shorter method (recommended for most use cases)

This method sets up the client with all required resources in a single step and self-joins the container to the cluster using its management and join IPs.

**Procedure**

1.  **Setup container locally with resources**\
    This step sets up the client with all necessary resources, such as cores, memory, networking, and ports.

    {% code overflow="wrap" %}
    ```bash
    weka local setup container --join-ips <join-ips> --base-port <base-port> --cores <cores> --cores-ids <cores-ids> --only-frontend-cores
    ```
    {% endcode %}

    Example:

    {% code overflow="wrap" %}
    ```bash
    weka local setup container --join-ips 10.108.81.144 --base-port 14000 --cores 1 --cores-ids 2 --only-frontend-cores
    ```
    {% endcode %}

    * `join-ips`: The IP address for joining the cluster.
    * `base-port`: The base port for container communication.
    * `cores`: The number of cores to allocate.
    * `cores-ids`: The cores' identifiers.
    * `only-frontend-cores`: Indicates that only frontend cores are used.
2.  **Join the container to the cluster**\
    After setting up the container, apply the configuration to finalize the process.

    ```bash
    weka local resources --container <client> management-ips <management-ips>
    weka local resources --container <client> join-ips <join-ips>
    weka local resources --container <client> base-port <base-port>
    weka local resources --container <client> apply
    ```

    Example:

    ```bash
    weka local resources --container client management-ips 10.108.241.62
    weka local resources --container client join-ips 10.108.39.212
    weka local resources --container client base-port 14000
    weka local resources --container client apply
    ```

### Option 2: Longer method (more control and flexibility)

This method involves more detailed steps, allowing you to manually set up the client with specific configurations, including core allocation, networking settings, and container setup.

**Procedure**

1.  **Install the WEKA software**

    * Install the WEKA software on the client by running the `install.sh` script after downloading the tarball from [get.weka.io](https://get.weka.io). Follow the instructions in the Install tab to complete the installation.

    All clients in a WEKA system cluster must use the same software version as the backends or a maximum of one version back. The backend containers must run the same WEKA software version except during upgrades (as managed by the upgrade process).
2.  **Join the cluster**

    * Once the client is in stem mode, use the following command to add it to the cluster.

    ```bash
    weka -H <backend-hostname> cluster container add <client-hostname>
    ```

    Example:

    ```bash
    weka -H backend1.cluster.local cluster container add client1.cluster.local
    ```

    * `backend-hostname`: The hostname (FQDN) or IP address of an existing backend instance.
    * `client-hostname`: The unique hostname (FQDN) of the client to add.

    Once this step is complete, the `container-id` of the newly added container will be displayed. Record it for use in the following steps.
3.  **Configure the container as a client**

    * After adding the client to the cluster, configure it by setting the number of cores and frontend-dedicated cores.

    {% code overflow="wrap" %}
    ```bash
    weka cluster container cores <container-id> <cores> --frontend-dedicated-cores=<frontend-dedicated-cores>
    ```
    {% endcode %}

    Example:

    ```bash
    weka cluster container cores container1 4 --frontend-dedicated-cores=4
    ```

    * `container-id`: The unique identifier of the container.
    * `cores`: The number of physical cores to allocate to the client.
    * `frontend-dedicated-cores`: The number of physical cores dedicated to frontend processes (must match `cores` for clients). You can set up to 19 cores.
4.  **Configure client networking**

    * If needed, configure the client’s network interface for high-performance communication with the WEKA cluster. (For UDP, this step is not needed.)
    * When configuring an InfiniBand client, do not pass the `--ips`, `--netmask`, or `--gateway` parameters.
    * InfiniBand and Ethernet clients can only join a cluster with the same network technology connectivity. However, it is possible to mix InfiniBand and Ethernet clients in the same cluster as long as the cluster backends are connected to both network technologies.

    {% code overflow="wrap" %}
    ```bash
    weka cluster container net add <container-id> <device> --ips=<ips> --netmask=<netmask> --gateway=<gateway>
    ```
    {% endcode %}

    Example:

    {% code overflow="wrap" %}
    ```bash
    weka cluster container net add container1 eth1 --ips=10.108.81.100 --netmask=255.255.255.0 --gateway=10.108.81.1
    ```
    {% endcode %}

    * `container-id`: A valid identifier for the container to add to the cluster.
    * `device`: A valid network interface device name (for example, `eth1`).
    * `ips`: A valid IP address for the new interface.
    * `gateway`: The IP address of the default routing gateway.\
      The gateway must be within the same IP network as the provided `ips`, as defined by the `netmask`. Not applicable for IB / L2 non-routable networks.
    * `netmask`: The number of bits that define the network ID (CIDR notation). For example, a netmask of `255.255.0.0` corresponds to `16` netmask bits.
5.  **Apply the container configuration**

    * After configuring the container and networking, apply the changes to activate the client container.

    {% code overflow="wrap" %}
    ```bash
    weka cluster container apply <container-id> [--force]
    ```
    {% endcode %}

    Example:

    ```bash
    weka cluster container apply container1 --force
    ```

[^1]: A **diskless node** is a workstation or computer that lacks local disk drives and uses network booting to load its operating system from a server. For details, see [https://en.wikipedia.org/wiki/Diskless\_node](https://en.wikipedia.org/wiki/Diskless_node)
