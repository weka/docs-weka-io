---
description: This page reviews the theory of operation for Weka networking.
---

# Weka networking

## Overview

The Weka system supports the following types of networking technologies:

1. ‌InfiniBand (IB)
2. Ethernet

‌The currently-available networking infrastructure dictates the choice between the two. If a Weka cluster is connected to both infrastructures, it is possible to connect Weka clients from both networks to the same cluster.&#x20;

The Weka system networking can be configured either as [performance-optimized](networking-in-wekaio.md#performance-optimized-networking-dpdk), where the CPU cores are dedicated to Weka and the use of DPDK networking takes place and cores, or, as [CPU-optimized](networking-in-wekaio.md#cpu-optimized-networking-udp-mode) where cores are not dedicated and we use either DPDK (when supported by the NIC drivers) or in-kernel networking (UDP mode).

### Performance-optimized networking (DPDK)

For performance-optimized networking, the Weka system does not use standard kernel-based TCP/IP services, but a proprietary infrastructure based on the following:

* Use of [DPDK](networking-in-wekaio.md#dpdk) to map the network device in the user space and make use of the network device without any context switches and with zero-copy access. This bypassing of the kernel stack eliminates the consumption of kernel resources for networking operations and can be scaled to run on multiple hosts. It applies to both backend and client hosts and enables the Weka system to fully saturate 200 GB links.
* Implementation of a proprietary Weka protocol over UDP, i.e., the underlying network may involve routing between subnets or any other networking infrastructure that supports UDP.

The use of DPDK delivers operations with extremely low-latency and high throughput. Low latency is achieved by bypassing the kernel and sending and receiving packages directly from the NIC. High throughput is achieved because multiple cores in the same host can work in parallel, without a common bottleneck.

Before proceeding, it is important to understand several key terms used in this section, namely DPDK, SR-IOV.

#### DPDK

‌[Data Plane Development Kit (DPDK)](http://dpdk.org/) is a set of libraries and network drivers for highly efficient, low latency packet processing. This is achieved through several techniques, such as kernel TCP/IP bypass, NUMA locality, multi-core processing, and device access via polling to eliminate the performance overhead of interrupt processing. In addition, DPDK ensures transmission reliability, handles retransmission, and controls congestion.

DPDK implementations are available from several sources. OS vendors such as [Redhat](https://access.redhat.com/documentation/en-us/red\_hat\_enterprise\_linux/7/html/virtualization\_deployment\_and\_administration\_guide/sect-pci\_devices-pci\_passthrough) and [Ubuntu](https://help.ubuntu.com/lts/serverguide/DPDK.html) provide their DPDK implementations through their distribution channels. [Mellanox OpenFabrics Enterprise Distribution for Linux](https://www.mellanox.com/page/products\_dyn?product\_family=26) (Mellanox OFED), which is a suite of libraries, tools, and drivers supporting Mellanox NICs, offers its own DPDK implementation.

The Weka system relies on the DPDK implementation provided by Mellanox OFED on hosts equipped with Mellanox NICs. For hosts equipped with Intel NICs, DPDK support is through the Intel driver for the card.‌

#### SR-IOV

Single Root I/O Virtualization (SR-IOV) is an extension to the PCI Express (PCIe) specification that enables PCIe virtualization. It works by allowing a PCIe device, such as a network adapter, to appear as multiple PCIe devices, or _functions_. There are two categories of functions - Physical Function (PF) and Virtual Function (VF). PF is a full-fledged PCIe function that can also be used for configuration. VF is a virtualized instance of the same PCIe device and is created by sending appropriate commands to the device PF. Typically, there are many VFs, but only one PF per physical PCIe device. Once a new VF is created, it can be mapped by an object such as a virtual machine, container, or, in the Weka system, by a 'compute' process.

SR-IOV technology should be supported by both the software and hardware to take advantage of it. Software support is included in the Linux kernel, as well as the Weka system software. Hardware support is provided by the computer BIOS and the network adapter but is usually disabled out of the factory. Consequently, it should be enabled before installing the Weka system software.‌

### CPU-optimized networking

For CPU-optimized networking Weka can yield CPU resources to other applications. That is useful when the extra CPU cores are needed for other purposes. However, the lack of CPU resources dedicated to the Weka system comes with the expense of reduced overall performance.

#### DPDK without core dedication

For CPU-optimized networking, when [mounting filesystems using stateless clients](../fs/mounting-filesystems.md#mounting-filesystems-using-stateless-clients), it is possible to use DPDK networking without dedicating cores. This mode is recommended when available and supported by the NIC drivers. In this mode, the DPDK networking uses RX interrupts instead of dedicating the cores.&#x20;

{% hint style="info" %}
**Note:** This mode is supported in most NIC drivers, but not in all, consult [https://doc.dpdk.org/guides/nics/overview.html](https://doc.dpdk.org/guides-18.11/nics/overview.html) for compatibility.

AWS (ENA drivers) does not support this mode, hence for CPU-optimized networking in AWS use the [UDP Mode](networking-in-wekaio.md#udp-mode).
{% endhint %}

#### UDP mode

Weka can also use in-kernel processing and UDP as the transport protocol. This mode of operation is commonly referred to as the 'UDP mode'.

Since the UPD-mode uses in-kernel processing, it is compatible with older platforms lacking the support of kernel offloading technologies (DPDK) or virtualization (SR-IOV), as legacy hardware such as the Mellanox CX3 family of NICs.

## Typical Weka configuration

### Backend hosts

In a typical Weka system configuration, the Weka backend hosts access the network function in two different methods:

1. Standard TCP/UDP network for management and control operations.
2. High-performance network for data-path traffic.

{% hint style="info" %}
**Note:** To run both functions on the same physical interface, contact the Weka Support Team.
{% endhint %}

The high-performance network used to connect all the backend hosts must be DPDK-based. This internal Weka network also requires a separate IP address space (see [Network Planning](../install/bare-metal/planning-a-weka-system-installation.md#network-planning) and [Configuration of Networking](../install/bare-metal/using-cli.md#stage-5-configuration-of-networking)). For this, the Weka system maintains a separate ARP database for its IP addresses and virtual functions and does not use the kernel or operating system ARP services.

#### Backend hosts with DPDK-supporting Intel NICs

For backend hosts equipped with DPDK-supporting Intel NICs, the following conditions must be met:

* Intel driver with DPDK support must be installed and loaded.
* SR-IOV must be enabled in the hardware (BIOS + NIC).
* The number of IPs allocated to the backend hosts on the internal network should be the total number of Weka software processes plus the total number of backend hosts. For example, a cluster consisting of 8 machines running 10 Weka processes each requires 88 (80 + 8) IPs on the internal network. The IP requirements for the Weka clients are outlined below in the Client Hosts section.‌

#### Backend hosts with DPDK-supporting Mellanox NICs

‌For backend hosts equipped with DPDK-supporting Mellanox NICs (CX-4 or newer), the following conditions must be met:

* Mellanox OFED must be installed and loaded.
* There is no need to use SR-IOV, so the number of IPs allocated to the backend hosts on the internal network should be the total number of backend hosts, i.e., 8 IPs for 8 backend hosts (using the example above).

{% hint style="info" %}
**Note:** SR-IOV enablement in the hardware is optional. If enabled, DPDK generates its own MAC addresses for the VFs (Virtual Functions) of the NIC and the same NIC can support multiple MAC addresses, some handled by the operating system and others by the Weka system.
{% endhint %}

### Client hosts

Unlike Weka backend nodes that must be DPDK/SR-IOV based, the Weka client hosts (application servers) can use either DPDK-based or UDP modes. The DPDK mode is the natural choice for the newer, high-performing platforms that support it.

#### Client hosts with DPDK-supporting Intel NICs

For client hosts equipped with DPDK-supporting Intel NICs, the following conditions must be met to use the DPDK mode:

* Intel driver with DPDK support must be installed and loaded.
* SR-IOV must be enabled in the hardware (BIOS + NIC).
* The number of IPs allocated to the Intel client hosts on the internal network should be the total number of Weka system FrontEnd (FE) processes (typically no more than 2 per host) plus the total number of client hosts. For example, 10 client hosts with 1 FE process per client require 20 IPs (10 FE IPs + 10 IPs). ‌

#### Client hosts with DPDK-supporting Mellanox NICs

‌For client hosts equipped with DPDK-supporting Mellanox NICs (CX-4 or newer), the following conditions must be met:

* Mellanox OFED must be installed and loaded.
* There is no need to use SR-IOV, so the number of IPs allocated to the client hosts on the internal network should be the total number of client hosts, i.e., 10 IPs for 10 client hosts (using the example above).

#### Client hosts in UDP mode

The UDP mode is available for legacy clients lacking SR-IOV or DPDK support, or where there is no requirement for low latency, high throughput IO.

For client hosts in the UDP mode, the following conditions must be met:

* The native driver must be installed and loaded.
* The number of IPs allocated to the client hosts on the internal network should be equal to the total number of client hosts. For example, 10 client hosts in the UDP mode require 10 IPs on the internal network.

## High availability (HA)

For HA support, the Weka system must be configured with no single component representing a single point of failure. Multiple switches are required, and hosts must have one leg on each switch.

HA for hosts is achieved either through the implementation of two network interfaces on the same host or via LACP (ethernet only, modes 1 and 4). Using a non-LACP approach sets a redundancy that enables the Weka software to utilize two interfaces for HA and bandwidth, respectively.&#x20;

HA performs failover and failback for reliability and load balancing on both interfaces and is operational for both Ethernet and InfiniBand. If not using LACP, it requires doubling the number of IPs on both the host and the IO nodes.

When working with HA networking, it is useful to hint the system (using the `label` parameter in `weka cluster host net add` command to identify the switch a network port is connected to) to send data between hosts through the same switch rather than using the ISL or other paths in the fabric. This can reduce the overall traffic in the network. &#x20;

{% hint style="info" %}
**Note:** LACP is currently supported between ports on a single Mellanox NIC, and is not supported when using VFs.
{% endhint %}

## RDMA and GPUDirect storage

GPUDirect Storage enables a direct data path between storage and GPU memory. GPUDirect Storage avoids extra copies through a bounce buffer in the CPU’s memory. It allows a direct memory access (DMA) engine near the NIC or storage to move data on a direct path into or out of GPU memory without burdening the CPU or GPU.

When enabled, the Weka system automatically utilizes the RDMA data path and GPUDirect Storage in supported environments. When the system identifies it can use RDMA, both in UDP and DPDK modes, it utilizes the use for workload it can benefit from RDMA (with regards to IO size: 32K+ for reads and 256K+ for writes).

Using RDMA/GPUDirect Storage, it is thus possible to get a performance gain. You can get much higher performance from a UDP client (which does not require dedicating a core to the Weka system), get an extra boost for a DPDK client, or assign fewer cores for the Weka system in the DPDK mode to get the same performance.

### Limitations

For the RDMA/GPUDirect Storage technology to take into effect, the following requirements must be met:

* All the cluster hosts must support RDMA networking
* For a client host:
  * GPUDirect Storage - the IB interfaces added to the Nvidia GPUDirect configuration should support RDMA
  * RDMA - all the NICs used by Weka must support RDMA networking
* Encrypted filesystems: The framework will not be utilized for encrypted filesystems and will fall back to work without RDMA/GPUDirect for IOs to encrypted filesystems



* A NIC is considered to support RDMA Networking if the following requirements are met:
  * For GPUDirect Storage only: InfiniBand network
  * Mellanox ConnectX5 or ConnectX6
  * OFED 4.6-1.0.1.1 or higher
    * For GPUDirect Storage: install with `--upstream-libs` and `--dpdk`

{% hint style="info" %}
**Note:** GPUDirect Storage completely bypasses the kernel and does not utilize the page cache. Standard RDMA clients still utilize the page cache.
{% endhint %}

{% hint style="warning" %}
**Note:** RDMA/GPUDirect Storage technology is not supported when working with a cluster with mixed IB and Ethernet networking.
{% endhint %}

Running `weka cluster nodes` will indicate if the RDMA is utilized, e.g.:

```
# weka cluster nodes
NODE ID         HOST ID        ROLES          NETWORK
NodeId: 0       HostId: 0      MANAGEMENT     UDP
NodeId: 1       HostId: 0      FRONTEND       DPDK / RDMA
NodeId: 2       HostId: 0      COMPUTE        DPDK / RDMA
NodeId: 3       HostId: 0      COMPUTE        DPDK / RDMA
NodeId: 4       HostId: 0      COMPUTE        DPDK / RDMA
NodeId: 5       HostId: 0      COMPUTE        DPDK / RDMA
NodeId: 6       HostId: 0      DRIVES         DPDK / RDMA
NodeId: 7       HostId: 0      DRIVES         DPDK / RDMA
```

{% hint style="info" %}
**Note:** GPUDirect Storage is auto enabled and dedected by the system. To enable/disable RDMA networking altogether on the cluster or a specific client, contact the Weka support team.
{% endhint %}
