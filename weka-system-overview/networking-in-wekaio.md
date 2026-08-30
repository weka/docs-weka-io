---
description: >-
  Explore network technologies in WEKA, including DPDK, SR-IOV, CPU-optimized
  networking, UDP mode, high availability, and RDMA/GPUDirect Storage, with
  configuration guidelines.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-system-overview/networking-in-wekaio
---

# Networking

## Overview

The WEKA system supports the following types of networking technologies:

* ‌InfiniBand (IB)
* Ethernet

‌The networking infrastructure dictates the choice between the two. If a WEKA cluster is connected to both infrastructures, it is possible to connect WEKA clients from both networks to the same cluster.

The WEKA system networking can be configured as _performance-optimized_ or _CPU-optimized_. In [performance-optimized](networking-in-wekaio.md#performance-optimized-networking-dpdk) networking, the CPU cores are dedicated to WEKA, and the networking uses DPDK. In [CPU-optimized](networking-in-wekaio.md#cpu-optimized-networking-udp-mode) networking, the CPU cores are not dedicated to WEKA, and the networking uses DPDK (when supported by the NIC drivers) or in-kernel (UDP mode).

### Performance-optimized networking (DPDK)

For performance-optimized networking, the WEKA system does not use standard kernel-based TCP/IP services but a proprietary infrastructure based on the following:

* Use [DPDK](networking-in-wekaio.md#dpdk) to map the network device in the user space and use it without any context switches and with zero-copy access. This bypassing of the kernel stack eliminates the consumption of kernel resources for networking operations. It applies to backends and clients and lets the WEKA system saturate network links (including, for example, 200 Gbps or 400 Gbps).
* Implementing a proprietary WEKA protocol over UDP, i.e., the underlying network, may involve routing between subnets or any other networking infrastructure that supports UDP.

The use of DPDK delivers operations with extremely low latency and high throughput. Low latency is achieved by bypassing the kernel and sending and receiving packages directly from the NIC. High throughput is achieved because multiple cores in the same server can work in parallel without a common bottleneck.

Before proceeding, it is important to understand several key terms used in this section, namely DPDK and SR-IOV.

#### DPDK

‌[Data Plane Development Kit (DPDK)](http://dpdk.org/) is a set of libraries and network drivers for highly efficient, low-latency packet processing. This is achieved through several techniques, such as kernel TCP/IP bypass, NUMA locality, multi-core processing, and device access via polling to eliminate the performance overhead of interrupt processing. In addition, DPDK ensures transmission reliability, handles retransmission, and controls congestion.

DPDK implementations are available from several sources. OS vendors like [Red Hat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-pci_devices-pci_passthrough) and [Ubuntu](https://help.ubuntu.com/lts/serverguide/DPDK.html) provide DPDK implementations through distribution channels. [Mellanox OpenFabrics Enterprise Distribution for Linux](https://www.mellanox.com/page/products_dyn?product_family=26) (Mellanox OFED), a suite of libraries, tools, and drivers supporting Mellanox NICs, offers its own DPDK implementation.

The WEKA system relies on the DPDK implementation provided by Mellanox OFED on servers equipped with Mellanox NICs.

#### SR-IOV

Single Root I/O Virtualization (SR-IOV) extends the PCI Express (PCIe) specification that enables PCIe virtualization. It allows a PCIe device, such as a network adapter, to appear as multiple PCIe devices or _functions_.

There are two function categories:

* Physical Function (PF): PF is a full-fledged PCIe function that can also be configured.
* Virtual Function (VF): VF is a virtualized instance of the same PCIe device created by sending appropriate commands to the device PF.

Typically, there are many VFs, but only one PF per physical PCIe device. Once a new VF is created, it can be mapped by an object such as a virtual machine, container, or, in the WEKA system, by a 'compute' process.

To take advantage of SR-IOV technology, the software and hardware must be supported. The Linux kernel provides SR-IOV software support. The computer BIOS and the network adapter provide hardware support (by default, SR-IOV is disabled and must be enabled before installing WEKA).

### CPU-optimized networking

For CPU-optimized networking, WEKA can yield CPU resources to other applications. That is useful when the extra CPU cores are needed for other purposes. However, the lack of CPU resources dedicated to the WEKA system comes with the expense of reduced overall performance.

#### DPDK without the core dedication

For CPU-optimized networking, when [mounting filesystems using stateless clients](../weka-filesystems-and-object-stores/mounting-filesystems/#mounting-filesystems-using-stateless-clients), it is possible to use DPDK networking without dedicating cores. This mode is recommended when available and supported by the NIC drivers. The DPDK networking uses RX interrupts instead of dedicating the cores in this mode.

{% hint style="info" %}
This mode is supported in most NIC drivers. Consult [https://doc.dpdk.org/guides/nics/overview.html](https://doc.dpdk.org/guides-18.11/nics/overview.html) for compatibility.

AWS (ENA drivers) does not support this mode. Hence, in CPU-optimized networking in AWS, use the [UDP mode](networking-in-wekaio.md#udp-mode).
{% endhint %}

#### UDP mode

WEKA can also use in-kernel processing and UDP as the transport protocol. This operation mode is commonly referred to as _UDP mode_.

UDP mode is compatible with older platforms that lack support for kernel offloading technologies (DPDK) or virtualization (SR-IOV) due to its use of in-kernel processing. This includes legacy hardware, such as the Mellanox CX3 family of NICs.

## Typical WEKA configuration

### Backend servers

In a typical WEKA system configuration, the WEKA backend servers access the network function in two different methods:

* Standard TCP/UDP network for management and control operations.
* High-performance network for data-path traffic.

{% hint style="info" %}
To run both functions on the same physical interface, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

The high-performance network used to connect all the backend servers must be DPDK-based. This internal WEKA network also requires a separate IP address space. For details, see [Network planning](../planning-and-installation/bare-metal/planning-a-weka-system-installation.md#network-planning) and [Configure the networking](../planning-and-installation/bare-metal/setting-up-the-hosts/#configure-the-networking).

The WEKA system maintains a separate ARP database for its IP addresses and virtual functions and does not use the kernel or operating system ARP services.

### Clients

While WEKA backend servers must include DPDK and SR-IOV, WEKA clients in application servers have the flexibility to use either DPDK or UDP modes. DPDK mode is the preferred choice for newer, high-performing platforms that support it. UDP mode is available for clients without SR-IOV or DPDK support or when there is no need for low-latency and high-throughput I/O.

### Configuration guidelines

* **DPDK backends and clients using NICs supporting shared networking (single IP):**
  * Require one IP address per client for data plane.
  * SR-IOV enabled is not required.
* **DPDK backends and clients using NICs supporting dedicated networking:**
  * IP address for management process on data plane: One per NIC (configured before WEKA installation).
  * IP address for data plane: One per [WEKA core](../planning-and-installation/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (applied during cluster initialization).
  * [Virtual Functions](https://en.wikipedia.org/wiki/Network_function_virtualization) (VFs):
    * Ensure the device supports a maximum number of VFs greater than the number of physical cores on the server.
    * Set the number of VFs to match the cores you intend to dedicate to WEKA.
    * Note that some BIOS configurations may be necessary.
  * SR-IOV: Enabled in BIOS.
* **UDP clients:**
  * Use a shared networking (single IP) for all purposes.
* **Servers with mixed adapter roles (IP-only, IP and RDMA, or RDMA-only):**
  * IP address for data plane: Required only on adapters assigned the IP-only or IP and RDMA role.
  * RDMA-only adapters do not require an IP address in the WEKA data plane.
  * SR-IOV: Required only on adapters that carry DPDK-based IP traffic.

{% hint style="info" %}
Management IPs in these networking guidelines serve management processes on the data plane network. They do not serve external management interfaces such as the CLI or REST API.
{% endhint %}

## Network **High Availability** <a href="#high-availability" id="high-availability"></a>

Network High Availability (HA) in a WEKA cluster is designed to eliminate single points of failure by leveraging redundancy across network components. This configuration ensures the system remains operational even in the event of hardware or connection failures.

**Network redundancy**

To achieve HA, the WEKA system requires multiple network switches with servers connected to at least two interfaces of the same type. Dual connectivity is provided either through two independent interfaces or through Link Aggregation Control Protocol (LACP) in Ethernet environments (mode 4).

**Interface configuration**

* **Non-LACP configuration**: Each server uses two network interfaces for redundancy and bandwidth enhancement. This approach doubles the number of IP addresses required on backend containers and IO processes.
*   **LACP configuration (Ethernet-only)**: LACP aggregates interfaces on a single Mellanox NIC for improved reliability and load balancing in Ethernet-only setups.

    Specifications and requirements:

    * LACP is not supported with Virtual Functions (VFs).
    * NIC must be set to `HW_LAG` (IEEE 802.3ad) with `queue_affinity` enabled and hashing disabled.
    * At least two WEKA processes must use DPDK.
    * Switch must support IEEE 802.3ad in active/active mode.

**Failover and load balancing**

Network HA ensures reliability and optimizes load balancing through failover and failback mechanisms. These mechanisms operate independently for InfiniBand and Ethernet networks. If an interface fails, another interface of the same type (InfiniBand or Ethernet) seamlessly takes over the workload.

{% hint style="info" %}
**Mixed-mode behavior:** In a cluster with servers equipped with both Ethernet and InfiniBand connections, the system remains operational even if a single server loses one of its connections. However, that server is excluded from participating in cluster-level operations. The cluster will continue I/O operations unless all servers lose connectivity on **either** the Ethernet or InfiniBand network; in that case, I/O operations will pause.
{% endhint %}

**Traffic optimization**

To optimize network traffic, the WEKA system can be configured to prioritize intra-switch communication over inter-switch links (ISL). This can be achieved by labeling connections using the `label` parameter in the `weka cluster container net add` command, which helps route data efficiently within the cluster.

## RDMA, RoCE, and GPUDirect Storage

RDMA, RoCE, and GPUDirect Storage (GDS) establish a direct data path between storage and memory (GPU memory in case of GDS) bypassing unnecessary data copies through the operating system. This approach allows Direct Memory Access (DMA) through the NIC to transfer data directly to or from application or GPU memory bypassing the operating system.

When RDMA and GDS are enabled, the WEKA system automatically uses the RDMA data path and GDS in supported environments. The system dynamically detects when RDMA is available—including in [RoCE v1](#user-content-fn-1)[^1], [RoCE v2](#user-content-fn-2)[^2], UDP, and DPDK modes—and applies it to workloads that can benefit from RDMA. Typically, RDMA is advantageous for I/O sizes of 32KB or larger for reads and 256KB or larger for writes.

By leveraging RDMA and GDS, you can achieve enhanced performance. A UDP client, which doesn't require dedicating a core to the WEKA system, can deliver significantly higher performance. Additionally, a DPDK client can experience an extra performance boost, or you can assign fewer cores to the WEKA system while maintaining the same level of performance in DPDK mode.

{% hint style="warning" %}
Priority Flow Control (PFC) and 802.3x global pause are mutually exclusive. A switch port with PFC enabled ignores global pause frames entirely, so a server that emits them runs with no working flow control.

On RoCE deployments, set link-level flow control fully off on the server dataplane interfaces: `ethtool -A <interface> autoneg off rx off tx off`. Autonegotiated flow control is not sufficient, because negotiation can re-enable pause. Apply this as part of the fabric QoS configuration, after the switch no-drop class for the RoCE priority is in place.
{% endhint %}

**Adapter roles for RDMA-capable interfaces**

When a server includes RDMA-capable network adapters, each adapter can be assigned one of the following roles that define how it handles traffic:

<table><thead><tr><th width="168">Role</th><th>Description</th></tr></thead><tbody><tr><td>IP-only</td><td>Handles management process and data-path IP traffic. RDMA is not used on this adapter.</td></tr><tr><td>IP and RDMA</td><td>Handles both IP traffic and RDMA operations.</td></tr><tr><td>RDMA-only</td><td>Dedicated exclusively to RDMA traffic. Does not carry IP traffic.</td></tr></tbody></table>

Assigning dedicated roles allows you to isolate RDMA traffic from IP traffic, improving network utilization and predictability. Adapters without RDMA capability can coexist on the same server when assigned to the IP-only role.

RDMA-capable adapters can be discovered and configured automatically during container setup using the `--scan-rdma` flag, without specifying device names explicitly.

### Requirements and considerations for RDMA and GDS support

RDMA, including RoCE, is enabled by default. To support RDMA and GDS technologies, the following requirements and considerations must be met:

* **Cluster requirements**
  * **RDMA networking:** Servers that use RDMA networking must include at least one RDMA-capable network adapter. Adapters without RDMA capability can coexist on the same server when explicitly assigned to the IP-only role.
* **Client requirements**
  * **GDS support:** The InfiniBand or Ethernet interfaces included in the GDS configuration must support RDMA networking.
  * **RDMA support:** All InfiniBand and Ethernet interfaces assigned the IP and RDMA or RDMA-only role must support RDMA networking. Interfaces assigned the IP-only role do not require RDMA capability.

**Fallback to standard I/O**

* GDS is not supported for encrypted filesystems.
* If any requirement for RDMA or GDS is not met, the system automatically reverts to standard I/O operations without RDMA or GDS acceleration.

{% hint style="info" %}
**Kernel bypass:** GDS bypasses the kernel and does not use the page cache. In contrast, standard RDMA clients continue to use the page cache.
{% endhint %}

#### Verification

To confirm RDMA usage, run the following command:

```
weka cluster processes
```

Example:

```bash
# weka cluster processes
PROCESS ID  HOSTNAME  CONTAINER   IPS         STATUS  ROLES       NETWORK      CPU  MEMORY   UPTIME
0           weka146   default     10.0.1.146  UP      MANAGEMENT  UDP                        16d 20:07:42h
1           weka146   default     10.0.1.146  UP      FRONTEND    DPDK / RDMA  1    1.47 GB  16d 23:29:00h
2           weka146   default     10.0.3.146  UP      COMPUTE     DPDK / RDMA  12   6.45 GB  16d 23:29:00h
3           weka146   default     10.0.1.146  UP      COMPUTE     DPDK / RDMA  2    6.45 GB  16d 23:29:00h
4           weka146   default     10.0.3.146  UP      COMPUTE     DPDK / RDMA  13   6.45 GB  16d 23:29:00h
5           weka146   default     10.0.1.146  UP      COMPUTE     DPDK / RDMA  3    6.45 GB  16d 22:28:58h
6           weka146   default     10.0.3.146  UP      COMPUTE     DPDK / RDMA  14   6.45 GB  16d 23:29:00h
7           weka146   default     10.0.3.146  UP      DRIVES      DPDK / RDMA  18   1.49 GB  16d 23:29:00h
8           weka146   default     10.0.1.146  UP      DRIVES      DPDK / RDMA  8    1.49 GB  16d 23:29:00h
9           weka146   default     10.0.3.146  UP      DRIVES      DPDK / RDMA  19   1.49 GB  16d 23:29:00h
10          weka146   default     10.0.1.146  UP      DRIVES      DPDK / RDMA  9    1.49 GB  16d 23:29:00h
11          weka146   default     10.0.3.146  UP      DRIVES      DPDK / RDMA  20   1.49 GB  16d 23:29:07h
12          weka147   default     10.0.1.147  UP      MANAGEMENT  UDP                        16d 22:29:02h
13          weka147   default     10.0.1.147  UP      FRONTEND    DPDK / RDMA  1    1.47 GB  16d 23:29:00h
14          weka147   default     10.0.3.147  UP      COMPUTE     DPDK / RDMA  12   6.45 GB  16d 23:29:00h
15          weka147   default     10.0.1.147  UP      COMPUTE     DPDK / RDMA  2    6.45 GB  16d 23:29:00h
16          weka147   default     10.0.3.147  UP      COMPUTE     DPDK / RDMA  13   6.45 GB  16d 23:29:00h
17          weka147   default     10.0.1.147  UP      COMPUTE     DPDK / RDMA  3    6.45 GB  16d 23:29:00h
18          weka147   default     10.0.3.147  UP      COMPUTE     DPDK / RDMA  14   6.45 GB  16d 23:29:00h
19          weka147   default     10.0.3.147  UP      DRIVES      DPDK / RDMA  18   1.49 GB  16d 23:29:00h
20          weka147   default     10.0.1.147  UP      DRIVES      DPDK / RDMA  8    1.49 GB  16d 23:29:00h
21          weka147   default     10.0.3.147  UP      DRIVES      DPDK / RDMA  19   1.49 GB  16d 23:29:07h
22          weka147   default     10.0.1.147  UP      DRIVES      DPDK / RDMA  9    1.49 GB  16d 23:29:00h
23          weka147   default     10.0.3.147  UP      DRIVES      DPDK / RDMA  20   1.49 GB  16d 23:29:07h
. . .
```

{% hint style="info" %}
GDS is automatically enabled and detected by the system. To enable or disable RDMA networking for the cluster or a specific client, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

**Related topic**

[#networking](../planning-and-installation/prerequisites-and-compatibility.md#networking "mention") (in the **Prerequisites and compatibility** topic)

[^1]: RoCE v1 (RDMA over Converged Ethernet) in a single subnet.

[^2]: RoCE v2 (RDMA over Converged Ethernet) across multiple single subnets.
