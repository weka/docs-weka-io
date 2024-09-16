---
description: >-
  Connect a single WEKA client to multiple clusters simultaneously, optimizing
  data access and workload distribution.
---

# Mount filesystems from multiple clusters on a single client

## Overview

Mounting filesystems from multiple clusters on a single WEKA client, known as Single Client Multiple Clusters (SCMC), provides several benefits:

* **Expanded cluster connectivity:** Connect a single client to a **maximum of 7 clusters** simultaneously, enhancing storage capacity and computational capabilities.&#x20;
* **Streamlined data access:** Gain a unified view of data across multiple clusters for simplified access and management, improving data availability, flexibility, and efficient resource usage.
* **Efficient workload distribution:** Distribute workloads efficiently across multiple clusters, enabling scalable applications and optimized performance.
* **Seamless integration:** WEKA ensures a seamless integration for clients leveraging the SCMC feature.

<figure><img src="../../.gitbook/assets/single_client_multi-clusters.png" alt=""><figcaption><p>Mount filesystems from multiple clusters on a single client</p></figcaption></figure>

### **Bandwidth division considerations in SCMC**

The bandwidth division in SCMC is a universal consideration based on the specific NIC's bandwidth. It applies across various NIC types, including those using DPDK or specific models like the X500-T1.

During SCMC mounts, each active connection can use the bandwidth available on its associated NIC port. This is true during peak usage and idle cases. In scenarios where NICs are dual-ported, each connection operates independently, leveraging its dedicated port.

When working with low-bandwidth NICs such as the X500-T1, a 10Gb/s NIC, consider bandwidth calculations. In the context of SCMC, each container (representing connectivity to a different cluster) uses half of the available bandwidth (5Gb/s) for a shared port. Note that a dual-port NIC has a dedicated port for each container, optimizing bandwidth distribution. Keep these factors in mind for an optimal SCMC setup.

## Prerequisites

Ensure the following requirements are met:

* All clusters that run in this configuration must be at least version 4.2.
* All client containers in the WEKA client must run the same minor version, at least version 4.2. The client version must be the same as the cluster or one version earlier at most.
* All client containers must be of the same type, stateful or stateless clients. Mixing different client types in a single WEKA client is not allowed.
* Each client container must run on its port. The default ports are 14000, 14101, 14201, 14301, 14401, 14501, and 14601. Ensure these ports allow egress on the client and ingress on the cluster.
* For DPDK, each client container must have 5 GB of free RAM, and it is recommended to have a dedicated CPU core to get optimal performance.

&#x20;Mounting a filesystem without these requirements may fail or overload the WEKA client.

{% hint style="info" %}
* Mounting filesystems from multiple clusters on a single client with Intel E810 are only supported using UDP mode.
* Mounting a stateful client using **autofs** is only supported on filesystems on a single cluster.
{% endhint %}

## Set the client target version in the clusters

When a stateless client mounts a filesystem in a cluster, it creates a client container with the same version as provided by the cluster. Because there may be situations where some of the clusters run a different WEKA version than the others, such as during an upgrade, it is required to set the same client target version on all clusters. The client target version is retained regardless of the cluster upgrade.

{% hint style="warning" %}
The client target version must be the same in all clusters. It can be the same as in the cluster or one major version earlier and available in the cluster for download by the client.\
If you need to upgrade the cluster to a higher version than the one above the client version, you must update the `client-target-version` first in all clusters, upgrade the clients, and only then upgrade the clusters. &#x20;
{% endhint %}

#### Procedure:

1. Connect to each cluster and run the following command to set the client target version.&#x20;

```bash
weka cluster client-target-version set <version-string>
```

Where: \<version-string> is the designated client target version, which will be installed on the client container upon the mount command. Ensure this version is installed on the backend servers.

2. To display the existing client target version in the cluster, run the following command:

```bash
weka cluster client-target-version show
```

3. To reset the client target version to the cluster version, run the following command:

```bash
weka cluster client-target-version reset
```

## Mount stateless client containers on multiple clusters

Use the same commands as with a single client.

```bash
mount -t wekafs <backend-name><fs-name> <mount-point>
```

To mount a stateless client using UDP mode, add `-o net=udp -o core=<core-id>` to the command line. For example:

{% code overflow="wrap" %}
```bash
mount -t wekafs backend-server-0/my_fs /mnt/weka -o net=udp -o core=2
```
{% endcode %}

## Mount stateful client containers on multiple clusters

For stateful client containers, the `client-target-version` parameter is not relevant. The version of the client container is determined when creating the container in the WEKA client using the `weka local setup container` command. Therefore, ensure that all client containers in the WEKA client have the same minor version as in the clusters.

To mount a stateful client container to a cluster, specify the container name for that mount.&#x20;

```bash
mount -t wekafs <fs-name> <mount-point> -o container_name=<container-name>
```

## Mount with a specific port (not default)

If the cluster does not listen to the default port, add `WEKA_PORT=<port number>` before the mount command:

{% code overflow="wrap" %}
```bash
WEKA_PORT=<port number> mount -t wekafs <fs-name> <mount-point> -o container_name=<container-name>
```
{% endcode %}

## Run commands from a server with multiple client containers

When running WEKA CLI commands from a server hosting multiple client containers, each connected to a different WEKA cluster, it’s required to specify the client container port or the backend IP address/name of the cluster (linked to that client) in the command.

Consider a server with two client containers:

```bash
weka local ps
CONTAINER  STATE    DISABLED  UPTIME    MONITORING  PERSISTENT  PORT   PID    STATUS  VERSION LAST FAILURE
client1    Running  False     3:15:57h  True        False       14000  58318  Ready   4.2.10
client2    Running  False     3:14:35h  True        False       14101  59529  Ready   4.2.10
```

To run a WEKA CLI command on the second cluster (associated with `client2`), use either of the following methods:

*   By specifying the backend IP address or name linked to that client container (assuming the backend name is `DataSphere2-1`):

    ```
    weka status -H DataSphere2-1
    ```
*   By specifying the client container port:

    ```
    weka status -P 14101
    ```

This approach ensures that your WEKA CLI command targets the correct WEKA cluster associated with the specified client container.

#### Related topics

[manage-authentication-across-multiple-clusters-with-connection-profiles.md](manage-authentication-across-multiple-clusters-with-connection-profiles.md "mention")

[adding-clients-bare-metal.md](../../install/bare-metal/adding-clients-bare-metal.md "mention")

[.](./ "mention")
