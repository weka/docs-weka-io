# Perform post-configuration procedures

Once the WEKA cluster is installed and configured, perform the following:

1. [Enable event notifications to the cloud (optional)](perform-post-configuration-procedures.md#id-1.-enable-event-notifications-to-the-cloud-optional).
2. [Set the license](perform-post-configuration-procedures.md#id-2.-set-the-license).
3. [Start the cluster IO service](perform-post-configuration-procedures.md#id-3.-start-the-cluster-io-service).
4. [Check the cluster configuration](perform-post-configuration-procedures.md#id-4.-check-the-cluster-configuration).
5. [Bypass the proxy server (optional)](perform-post-configuration-procedures.md#id-5.-bypass-the-proxy-server-optional).
6. [Configure default data networking (optional)](perform-post-configuration-procedures.md#id-6.-configure-default-data-networking-optional).

## 1. Enable event notifications to the cloud (optional)

Enable event notifications to the cloud for support purposes using one of the following options:

* Enable support through Weka Home
* Enable support through a private instance of Weka Home

### **Enable support through Weka Home**

**Command:** `weka cloud enable`

This command enables cloud event notification (via Weka Home), which allows the WEKA Customer Success Team to resolve any issues that may occur.

To learn more about this and how to enable cloud event notification, see [the-wekaio-support-cloud](../../monitor-the-weka-cluster/the-wekaio-support-cloud/ "mention").

### **Enable support through** Local Weka Home

In closed environments, such as dark sites and private VPCs, it is possible to install Local WEKA Home, which is a private instance of WEKA Home.

**Command:** `weka cloud enable --cloud-url=http://<weka-home-ip>:<weka-home-port>`

This command enables the WEKA cluster to send event notifications to the Local WEKA Home.

{% hint style="info" %}
For details, see [local-weka-home-overview.md](../../monitor-the-weka-cluster/the-wekaio-support-cloud/local-weka-home-overview.md "mention").
{% endhint %}

## 2. Set the license

**Command:** `weka cluster license set`

To run IOs against the cluster, a valid license must be applied. Obtain a valid license and apply it to the WEKA cluster. For details, see [overview.md](../../licensing/overview.md "mention").&#x20;

## 3. Start the cluster IO service

**Command:** `weka cluster start-io`

To start the system IO and exit from the initialization state, use the following command line:

`weka cluster start-io`

## 4. Check the cluster configuration

### Check the cluster container

**Command:** `weka cluster container`

Use this command to display the list of containers and their details.

<details>

<summary>Example of a list of containers and their details</summary>

```bash
$ weka cluster container
HOST ID  HOSTNAME  CONTAINER  IPS             STATUS  RELEASE   FAILURE DOMAIN  CORES  MEMORY    LAST FAILURE  UPTIME
0        av299-0   drives0    10.108.79.121   UP      4.3.0     DOM-000         7      10.45 GB                1:08:30h
1        av299-1   drives0    10.108.115.194  UP      4.3.0     DOM-001         7      10.45 GB                1:08:30h
2        av299-2   drives0    10.108.2.136    UP      4.3.0     DOM-002         7      10.45 GB                1:08:29h
3        av299-3   drives0    10.108.165.185  UP      4.3.0     DOM-003         7      10.45 GB                1:08:30h
4        av299-4   drives0    10.108.116.49   UP      4.3.0     DOM-004         7      10.45 GB                1:08:29h
5        av299-5   drives0    10.108.7.63     UP      4.3.0     DOM-005         7      10.45 GB                1:08:30h
6        av299-6   drives0    10.108.80.75    UP      4.3.0     DOM-006         7      10.45 GB                1:08:29h
7        av299-7   drives0    10.108.173.56   UP      4.3.0     DOM-007         7      10.45 GB                1:08:30h
8        av299-8   drives0    10.108.253.194  UP      4.3.0     DOM-008         7      10.45 GB                1:08:29h
9        av299-9   drives0    10.108.220.115  UP      4.3.0     DOM-009         7      10.45 GB                1:08:29h
10       av299-0   compute0   10.108.79.121   UP      4.3.0     DOM-000         6      20.22 GB                1:08:08h
11       av299-1   compute0   10.108.115.194  UP      4.3.0     DOM-001         6      20.22 GB                1:08:08h
12       av299-2   compute0   10.108.2.136    UP      4.3.0     DOM-002         6      20.22 GB                1:08:09h
13       av299-3   compute0   10.108.165.185  UP      4.3.0     DOM-003         6      20.22 GB                1:08:09h
14       av299-4   compute0   10.108.116.49   UP      4.3.0     DOM-004         6      20.22 GB                1:08:09h
15       av299-5   compute0   10.108.7.63     UP      4.3.0     DOM-005         6      20.22 GB                1:08:08h
16       av299-6   compute0   10.108.80.75    UP      4.3.0     DOM-006         6      20.22 GB                1:08:09h
17       av299-7   compute0   10.108.173.56   UP      4.3.0     DOM-007         6      20.22 GB                1:08:08h
18       av299-8   compute0   10.108.253.194  UP      4.3.0     DOM-008         6      20.22 GB                1:08:09h
19       av299-9   compute0   10.108.220.115  UP      4.3.0     DOM-009         6      20.22 GB                1:08:08h
20       av299-0   frontend0  10.108.79.121   UP      4.3.0     DOM-000         1      1.47 GB                 1:06:57h
21       av299-1   frontend0  10.108.115.194  UP      4.3.0     DOM-001         1      1.47 GB                 1:06:57h
22       av299-2   frontend0  10.108.2.136    UP      4.3.0     DOM-002         1      1.47 GB                 1:06:57h
23       av299-3   frontend0  10.108.165.185  UP      4.3.0     DOM-003         1      1.47 GB                 1:06:56h
24       av299-4   frontend0  10.108.116.49   UP      4.3.0     DOM-004         1      1.47 GB                 1:06:57h
25       av299-5   frontend0  10.108.7.63     UP      4.3.0     DOM-005         1      1.47 GB                 1:06:56h
26       av299-6   frontend0  10.108.80.75    UP      4.3.0     DOM-006         1      1.47 GB                 1:06:57h
27       av299-7   frontend0  10.108.173.56   UP      4.3.0     DOM-007         1      1.47 GB                 1:06:56h
28       av299-8   frontend0  10.108.253.194  UP      4.3.0     DOM-008         1      1.47 GB                 1:06:57h
29       av299-9   frontend0  10.108.220.115  UP      4.3.0     DOM-009         1      1.47 GB                 1:06:56h
```

</details>

### Check cluster container resources

**Command:** `weka cluster container resources`

Use this command to check the resources of each container in the cluster.

`weka cluster container resources <container-id>`

<details>

<summary>Example for a drive container resources output</summary>

```bash
$ weka cluster container resources 1
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
DRIVES      1        4

NET DEVICE    IDENTIFIER    DEFAULT GATEWAY  IPS             NETMASK  NETWORK LABEL
0000:00:06.0  0000:00:06.0  10.108.0.1       10.108.115.194  UP  16

Allow Protocols           false
Bandwidth                 <auto>
Base Port                 14000
Dedicate Memory           true
Disable NUMA Balancing    true
Failure Domain            DOM-001
Hardware Watchdog         false
Management IPs            10.108.238.217
Mask Interrupts           true
Memory                    <dedicated>
Mode                      BACKEND
Non-Weka Reserved Memory  20
Set CPU Governors         PERFORMANCE
```

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

**Command:** `weka cluster drive`

Use this command to check all drives in the cluster.

<details>

<summary>Example</summary>

```bash
$ weka cluster drive
DISK ID  UUID                                  HOSTNAME  NODE ID  SIZE        STATUS  LIFETIME % USED  ATTACHMENT  DRIVE STATUS
0        d3d000d4-a76b-405d-a226-c40dcd8d622c  av299-4   87       399.99 GiB  ACTIVE  0                OK          OK
1        c68cf47a-f91d-499f-83c8-69aa06ed37d4  av299-7   143      399.99 GiB  ACTIVE  0                OK          OK
2        c97f83b5-b9e3-4ccd-bfb8-d78537fa8a6f  av299-1   23       399.99 GiB  ACTIVE  0                OK          OK
3        908dadc5-740c-4e08-9cc2-290b4b311f81  av299-0   7        399.99 GiB  ACTIVE  0                OK          OK
.
.
.
68       1c4c4d54-6553-44b2-bc61-0f0e946919fb  av299-4   84       399.99 GiB  ACTIVE  0                OK          OK
69       969d3521-9057-4db9-8304-157f50719683  av299-3   62       399.99 GiB  ACTIVE  0                OK          OK
```

</details>

### Check the Weka cluster status

**Command:** `weka status`

The `weka status` command displays the overall status of the WEKA cluster.

For details, see [#cluster-status](../../getting-started-with-weka/manage-the-system-using-weka-cli/#cluster-status "mention").

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

**Command:** `weka cluster default-net set`

Instead of individually configuring IP addresses for each network device, WEKA supports dynamic IP address allocation. Users can define a range of IP addresses to create a dynamic pool, and these addresses can be automatically allocated on demand.

{% hint style="info" %}
**Mixed approach for Ethernet networking:** For Ethernet networking, a mixed approach is supported. Administrators can explicitly assign IP addresses for specific network devices, while others in the cluster can receive automatic allocations from the specified IP range. This feature is particularly useful in environments with automated client spawning.
{% endhint %}

Use the following command to configure default data networking:

`weka cluster default-net set --range <range> [--gateway=<gateway>] [--netmask-bits=<netmask-bits>]`

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>range</code>*</td><td><p>A range of IP addresses reserved for dynamic allocation across the entire cluster..<br>Format: <code>A.B.C.D-E</code> </p><p>Example: <code>10.10.0.1-100</code></p></td></tr><tr><td><code>netmask-bits</code>*</td><td>Number of bits in the netmask that define a network ID in CIDR notation.</td></tr><tr><td><code>gateway</code></td><td>The IP address assigned to the default routing gateway. It is imperative that the gateway resides within the same IP network as defined by the specified range and netmask-bits.<br>This parameter is not applicable to InfiniBand (IB) or Layer 2 (L2) non-routable networks.</td></tr></tbody></table>

**View current settings:** To view the current default data networking settings, use the command: \
`weka cluster default-net`

**Remove default data networking:** If a default data networking configuration was previously set up on a cluster and is no longer needed, you can remove it using the command:\
`weka cluster default-net reset`

**End of the installation and configuration for all workflow paths**

## **What do next?**

[adding-clients-bare-metal.md](adding-clients-bare-metal.md "mention")
