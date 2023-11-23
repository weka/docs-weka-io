---
description: This page reviews the theory of operation for WEKA networking.
---

# WEKA networking

## Overview

The WEKA system supports the following types of networking technologies:

* ‌InfiniBand (IB)
* Ethernet

‌The networking infrastructure dictates the choice between the two. If a WEKA cluster is connected to both infrastructures, it is possible to connect WEKA clients from both networks to the same cluster.&#x20;

The WEKA system networking can be configured as _performance-optimized_ or _CPU-optimized_. In [performance-optimized](networking-in-wekaio.md#performance-optimized-networking-dpdk) networking, the CPU cores are dedicated to WEKA, and the networking uses DPDK. In [CPU-optimized](networking-in-wekaio.md#cpu-optimized-networking-udp-mode) networking, the CPU cores are not dedicated to WEKA, and the networking uses DPDK (when supported by the NIC drivers) or in-kernel (UDP mode).

### Performance-optimized networking (DPDK)

For performance-optimized networking, the WEKA system does not use standard kernel-based TCP/IP services but a proprietary infrastructure based on the following:

* Use [DPDK](networking-in-wekaio.md#dpdk) to map the network device in the user space and use the network device without any context switches and with zero-copy access. This bypassing of the kernel stack eliminates the consumption of kernel resources for networking operations. It applies to backends and clients and lets the WEKA system saturate 200 GB links.
* Implementing a proprietary WEKA protocol over UDP, i.e., the underlying network, may involve routing between subnets or any other networking infrastructure that supports UDP.

The use of DPDK delivers operations with extremely low latency and high throughput. Low latency is achieved by bypassing the kernel and sending and receiving packages directly from the NIC. High throughput is achieved because multiple cores in the same server can work in parallel without a common bottleneck.

Before proceeding, it is important to understand several key terms used in this section, namely DPDK and SR-IOV.

#### DPDK

‌[Data Plane Development Kit (DPDK)](http://dpdk.org/) is a set of libraries and network drivers for highly efficient, low-latency packet processing. This is achieved through several techniques, such as kernel TCP/IP bypass, NUMA locality, multi-core processing, and device access via polling to eliminate the performance overhead of interrupt processing. In addition, DPDK ensures transmission reliability, handles retransmission, and controls congestion.

DPDK implementations are available from several sources. OS vendors like [Red Hat](https://access.redhat.com/documentation/en-us/red\_hat\_enterprise\_linux/7/html/virtualization\_deployment\_and\_administration\_guide/sect-pci\_devices-pci\_passthrough) and [Ubuntu](https://help.ubuntu.com/lts/serverguide/DPDK.html) provide DPDK implementations through distribution channels. [Mellanox OpenFabrics Enterprise Distribution for Linux](https://www.mellanox.com/page/products\_dyn?product\_family=26) (Mellanox OFED), a suite of libraries, tools, and drivers supporting Mellanox NICs, offers its own DPDK implementation.

The WEKA system relies on the DPDK implementation provided by Mellanox OFED on servers equipped with Mellanox NICs. For servers equipped with Intel NICs, DPDK support is through the Intel driver for the card.‌

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

For CPU-optimized networking, when [mounting filesystems using stateless clients](../fs/mounting-filesystems.md#mounting-filesystems-using-stateless-clients), it is possible to use DPDK networking without dedicating cores. This mode is recommended when available and supported by the NIC drivers. The DPDK networking uses RX interrupts instead of dedicating the cores in this mode.&#x20;

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

The high-performance network used to connect all the backend servers must be DPDK-based. This internal WEKA network also requires a separate IP address space. For details, see [Network planning](../install/bare-metal/planning-a-weka-system-installation.md#network-planning) and [Configure the networking](../install/bare-metal/setting-up-the-hosts/#configure-the-networking).

The WEKA system maintains a separate ARP database for its IP addresses and virtual functions and does not use the kernel or operating system ARP services.

### Clients

While WEKA backend servers must include DPDK and SR-IOV, WEKA clients in application servers have the flexibility to use either DPDK or UDP modes. DPDK mode is the preferred choice for newer, high-performing platforms that support it. UDP mode is available for clients without SR-IOV or DPDK support or when there is no need for low-latency and high-throughput I/O.

### Configuration guidelines

* **DPDK backends and clients using NICs supporting shared IP:**
  * Require one IP address per client for both management and data plane.
  * SR-IOV enabled is not required.
* **DPDK backends and clients using NICs supporting non-shared IP:**
  * IP address for management: One per NIC (configured before WEKA installation).
  * IP address for data plane: One per [WEKA core](../install/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (applied during cluster initialization).
  * [Virtual Functions](https://en.wikipedia.org/wiki/Network\_function\_virtualization) (VFs):
    * Ensure the device supports a maximum number of VFs greater than the number of physical cores on the server.
    * Set the number of VFs to match the cores you intend to dedicate to WEKA.
    * Note that some BIOS configurations may be necessary.
  * SR-IOV: Enabled in BIOS.
* **UDP clients:**
  * Use a single IP address for all purposes.

## High Availability (HA)

To support HA, the WEKA system must be configured with no single component representing a single point of failure. Multiple switches are required, and servers must have one leg on each.

HA for servers is achieved either through implementing two network interfaces on the same server or by LACP (ethernet only, modes 1 and 4). A non-LACP approach sets a redundancy that enables the WEKA software to use two interfaces for HA and bandwidth.&#x20;

HA performs failover and failback for reliability and load balancing on both interfaces and is operational for Ethernet and InfiniBand. Not using LACP requires doubling the number of IPs on both the backend containers and the IO processes.

When working with HA networking, labeling the system to send data between servers through the same switch is helpful rather than using the ISL or other paths in the fabric. This can reduce the overall traffic in the network. To label the system for identifying the switch and network port, use the `label` parameter in the `weka cluster container net add` command.&#x20;

{% hint style="info" %}
LACP (link aggregation, also known as bond interfaces) is currently supported between ports on a single Mellanox NIC and is not supported when using VFs (virtual functions).
{% endhint %}

## RDMA and GPUDirect storage

GPUDirect Storage enables a direct data path between storage and GPU memory. GPUDirect Storage avoids extra copies through a bounce buffer in the CPU’s memory. It allows a direct memory access (DMA) engine near the NIC or storage to move data directly into or out of GPU memory without burdening the CPU or GPU.

When RDMA and GPUDirect storage are enabled, the WEKA system automatically uses the RDMA data path and GPUDirect Storage in supported environments. When the system identifies it can use RDMA, both in UDP and DPDK modes, it employs the use for workload it can benefit from RDMA (with regards to IO size: 32K+ for reads and 256K+ for writes).

By leveraging RDMA/GPUDirect Storage, you can achieve enhanced performance. A UDP client, which doesn't necessitate dedicating a core to the WEKA system, can yield significantly higher performance. Additionally, a DPDK client can receive an extra performance boost. Alternatively, in DPDK mode, you can assign fewer cores to the WEKA system while maintaining the same level of performance.

### Limitations

For the RDMA/GPUDirect Storage technology to take effect, the following requirements must be met:

* All the cluster servers support RDMA networking.
* For a client:
  * GPUDirect Storage: The IB interfaces added to the Nvidia GPUDirect configuration should support RDMA.
  * RDMA: All the Infiniband Host Channel Adapters (HCA) used by WEKA must support RDMA networking.
* Encrypted filesystems: The framework is not used for encrypted filesystems and falls back to work without RDMA/GPUDirect for IOs to encrypted filesystems.
* An HCA is considered to support RDMA networking if the following requirements are met:
  * For GPUDirect Storage only: InfiniBand network.
  * Mellanox ConnectX5 or ConnectX6.
  * OFED 4.6-1.0.1.1 or higher.
    * For GPUDirect Storage: install with `--upstream-libs` and `--dpdk`.

{% hint style="info" %}
GPUDirect Storage bypasses the kernel and does not use the page cache. Standard RDMA clients still use the page cache.
{% endhint %}

{% hint style="warning" %}
RDMA/GPUDirect Storage technology is unsupported when working with a mixed IB and Ethernet networking cluster.
{% endhint %}

Running `weka cluster processes` indicates if the RDMA is used.

Example:

```
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
GPUDirect Storage is auto-enabled and detected by the system. Contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to enable or disable RDMA networking on the cluster or a specific client.
{% endhint %}
