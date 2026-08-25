---
description: Complete the required configuration tasks after creating a WEKA cluster.
---

# Perform post-configuration

Once the WEKA cluster is installed and configured, perform the following:

1. [Enable event notifications to the cloud (optional)](perform-post-configuration-procedures.md#id-1.-enable-event-notifications-to-the-cloud-optional).
2. [Set the license](perform-post-configuration-procedures.md#id-2.-set-the-license).
3. [Start the cluster IO service](perform-post-configuration-procedures.md#id-3.-start-the-cluster-io-service).
4. [Check the cluster configuration](perform-post-configuration-procedures.md#id-4.-check-the-cluster-configuration).
5. [Bypass the proxy server (optional)](perform-post-configuration-procedures.md#id-5.-bypass-the-proxy-server-optional).
6. [Configure default data networking (optional)](perform-post-configuration-procedures.md#id-6.-configure-default-data-networking-optional).

## 1. Enable event notifications to the cloud (optional)

Enable event notifications to the cloud for support purposes using one of the following options:

* Enable support through WEKA Home
* Enable support through a private instance of WEKA Home

### Enable support through Weka Home

Connects the cluster to WEKA Home so it can upload diagnostics and events for support.

**Command:** `weka cloud enable`

```sh
weka cloud enable [--cloud-url <string>]
```

**Parameters**

| Parameter               | Description                    |
| --- | --- |
| `--cloud-url` \<string> | Base URL of the cloud service. |

### Enable support through Local WEKA Home

Connects the cluster to a locally hosted WEKA Home instead of the cloud service.

**Command:** `weka cloud enable`

```sh
weka cloud enable [--cloud-url <string>]
```

**Parameters**

| Parameter               | Description                    |
| --- | --- |
| `--cloud-url` \<string> | Base URL of the cloud service. |

{% hint style="info" %}
For details, see [local-weka-home-overview.md](../../monitor-the-weka-cluster/the-wekaio-support-cloud/local-weka-home-overview.md "mention").
{% endhint %}

## 2. Set the license

Applies the cluster license.

**Command:** `weka cluster license set`

```sh
weka cluster license set <license>
```

**Parameters**

| Parameter   | Description             |
| --- | --- |
| `license`\* | License key to install. |

## 3. Start the cluster IO service

Starts the cluster's I/O service, making filesystems available to clients.

**Command:** `weka cluster start-io`

```sh
weka cluster start-io [--force]
```

**Parameters**

| Parameter       | Description                                                                                                                            |
| --- | --- |
| `-f`, `--force` | Do not prompt before starting I/O for the first time. The prompt is only shown for interactive use; non-interactive use never prompts. |

## 4. Check the cluster configuration


### Check the cluster container

Lists the containers in the cluster with their status and roles.

**Command:** `weka cluster container`

```sh
weka cluster container [<container-ids>…] [--backends] [--clients] [--council] [--hostnames <strings>…] [--leader] [--leadership] [--local]
```

**Parameters**

| Parameter                 | Description                                                                                                                    |
| --- | --- |
| `container-ids`… | Only return these container IDs. |
| `-b`, `--backends` | Only return backend containers. |
| `-c`, `--clients` | Only return client containers. |
| `--council` | Get result from cluster leadership members. |
| `--hostnames` \<strings>… | Only return containers on these hostnames. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `-L`, `--leader` | Only return the cluster leader. |
| `-l`, `--leadership` | Only return containers that are part of the cluster leadership. |
| `--local` | Get result from local weka host. |

</details>

**Related topic**

[container-state-and-status-fields.md](../../operation-guide/expanding-and-shrinking-cluster-resources/container-state-and-status-fields.md "mention")

### Check cluster container resources

Shows the cores, memory, and network resources assigned to a container.

**Command:** `weka cluster container resources`

```sh
weka cluster container resources <container> [--stable]
```

**Parameters**

| Parameter     | Description                               |
| --- | --- |
| `container`\* | Container ID. |
| `--stable` | Show stable resources instead of staging. |

</details>

<details>

<summary>Example of a compute container resources output</summary>

```bash
$ weka cluster container resources 10
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
COMPUTE     1        16
COMPUTE     2        4
COMPUTE     3        18
COMPUTE     4        26
COMPUTE     5        28
COMPUTE     6        10

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:04.0  0000:00:04.0  10.108.0.1       10.108.145.137  16
0000:00:05.0  0000:00:05.0  10.108.0.1       10.108.212.87   16
0000:00:06.0  0000:00:06.0  10.108.0.1       10.108.199.231  16
0000:00:07.0  0000:00:07.0  10.108.0.1       10.108.86.172   16
0000:00:08.0  0000:00:08.0  10.108.0.1       10.108.190.88   16
0000:00:09.0  0000:00:09.0  10.108.0.1       10.108.77.31    16

Allow Protocols         false
Bandwidth               <auto>
Base Port               14300
Dedicate Memory         true
Disable NUMA Balancing  true
Failure Domain          DOM-000
Hardware Watchdog       false
Management IPs          10.108.79.121
Mask Interrupts         true
Memory                  20224982280
Mode                    BACKEND
Set CPU Governors       PERFORMANCE
```

</details>

<details>

<summary>Example of a frontend container resources output</summary>

```bash
$ weka cluster container resources 20
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
FRONTEND    1        24

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:13.0  0000:00:13.0  10.108.0.1       10.108.217.249  16

Allow Protocols         true
Bandwidth               <auto>
Base Port               14200
Dedicate Memory         true
Disable NUMA Balancing  true
Failure Domain          DOM-000
Hardware Watchdog       false
Management IPs          10.108.79.121
Mask Interrupts         true
Memory                  <dedicated>
Mode                    BACKEND
Set CPU Governors       PERFORMANCE
```

</details>

#### Check cluster drives

Lists the drives in the cluster with their status and the container each belongs to.

**Command:** `weka cluster drive`

```sh
weka cluster drive [<drive>…] [--container <container-ids>…] [--show-removed]
```

**Parameters**

| Parameter                       | Description                                                                                                                                                                 |
| --- | --- |
| `drive`… | Drive IDs or UUIDs to list. If no ID is specified, all drives are listed. |
| `--container` \<container-ids>… | Only return the drives of these container IDs. If not specified, all drives are listed. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--show-removed` | Show drives that were removed from the cluster. |

</details>

### Check the Weka cluster status

Shows overall cluster health, capacity, protection level, and I/O activity.

**Command:** `weka status`

```sh
weka status [--detailed-capacity]
```

**Parameters**

| Parameter             | Description                                        |
| --- | --- |
| `--detailed-capacity` | Include capacity details including data reduction. |

## 5. Bypass the proxy server (optional)

If the WEKA cluster is deployed in an environment with a proxy server, a WEKA client trying to mount or download the client installation from the WEKA cluster may be blocked by the proxy server. You can disable the proxy for specific URLs using the shell `no_proxy` environment variable.

#### Procedure

1. Connect to one of the WEKA backend servers (configuration changes made on this server are synchronized with all other servers in the cluster).
2. Open the `/etc/wekaio/service.conf` file.
3.  In the `[downloads_proxy]` section, add to the `no_proxy` parameter a comma-separated list of IP addresses or qualified domain names of your WEKA clients and cluster backend servers. Do not use wildcards (\*).

    ```makefile
    [downloads_proxy]
    force_no_proxy=true
    proxy=
    no_proxy=<comma-separated list of IPs or domains>
    ```
4.  Restart the agent service using the command:

    ```bash
    service weka-agent restart
    ```

## 6. Configure default data networking (optional)

Sets the default network range, gateway, and netmask used for cluster data traffic.

**Command:** `weka cluster default-net set`

```sh
weka cluster default-net set [--gateway <ip>] [--netmask <uint8>] [--range <ip-range>]
```

**Parameters**

| Parameter             | Description                     |
| --- | --- |
| `--gateway` \<ip> | Default gateway IP address. |
| `--netmask` \<uint8> | Netmask length in bits. |
| `--range` \<ip-range> | IP addresses in format IP1-IP2. |

**View current settings:** To view the current default data networking settings, use the command:\
`weka cluster default-net`

**Remove default data networking:** If a default data networking configuration was previously set up on a cluster and is no longer needed, you can remove it using the command:\
`weka cluster default-net reset`

**End of the installation and configuration for all workflow paths**

{% hint style="info" %}
**Mixed approach for Ethernet networking:** For Ethernet networking, a mixed approach is supported. Administrators can explicitly assign IP addresses for specific network devices, while others in the cluster can receive automatic allocations from the specified IP range. This feature is particularly useful in environments with automated client spawning.
{% endhint %}

## **What do next?**

[adding-clients-bare-metal.md](adding-clients-bare-metal.md "mention")
