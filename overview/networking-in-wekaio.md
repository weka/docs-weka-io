---
description: This page reviews the theory of operation for Weka networking.
---

# Weka Networking

## Overview

The Weka system supports the following types of networking technologies:

1. ‌InfiniBand \(IB\)
2. Ethernet.

‌The currently-available networking infrastructure dictates the choice between the two.

For networking, the Weka system does not use standard kernel-based TCP/IP services, but a proprietary infrastructure based on the following:

* Use of [DPDK](networking-in-wekaio.md#dpdk) to map the network device in the user space and make use of the network device without any context switches and with zero-copy access. This bypassing of the kernel stack eliminates the consumption of kernel resources for networking operations and can be scaled to run on multiple hosts. It applies to both backend and client hosts and enables the Weka system to fully saturate 200 GB links.
* Implementation of a proprietary Weka protocol over UDP, i.e., the underlying network may involve routing between subnets or any other networking infrastructure that supports UDP.

The use of DPDK delivers operations with extremely low-latency and high throughput. Low latency is achieved by bypassing the kernel and sending and receiving packages directly from the NIC. High throughput is achieved because multiple cores in the same host can work in parallel, without a common bottleneck.

Before proceeding, it is important to understand several key terms used in this section, namely DPDK, SR-IOV, and UDP mode.

### DPDK

‌[Data Plane Development Kit \(DPDK\)](http://dpdk.org/) is a set of libraries and network drivers for highly efficient, low latency packet processing. This is achieved through several techniques, such as kernel TCP/IP bypass, NUMA locality, multi-core processing and device access via polling to eliminate the performance overhead of interrupt processing. In addition, DPDK ensures transmission reliability, handles retransmission and controls congestion.

DPDK implementations are available from several sources. OS vendors such as [Redhat](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-pci_devices-pci_passthrough) and [Ubuntu](https://help.ubuntu.com/lts/serverguide/DPDK.html) provide their DPDK implementations through their distribution channels. [Mellanox OpenFabrics Enterprise Distribution for Linux](https://www.mellanox.com/page/products_dyn?product_family=26) \(Mellanox OFED\), which is a suite of libraries, tools, and drivers supporting Mellanox NICs, offers its own DPDK implementation.

The Weka system relies on the DPDK implementation provided by Mellanox OFED on hosts equipped with Mellanox NICs. For hosts equipped with Intel NICs, DPDK support is through the Intel driver for the card.‌

### SR-IOV

Single Root I/O Virtualization \(SR-IOV\) is an extension to the PCI Express \(PCIe\) specification that enables PCIe virtualization. It works by allowing a PCIe device, such as a network adapter, to appear as multiple PCIe devices, or _functions_. There are two categories of functions - Physical Function \(PF\) and Virtual Function \(VF\). PF is a full-fledged PCIe function that can also be used for configuration. VF is a virtualized instance of the same PCIe device and is created by sending appropriate commands to the device PF. Typically, there are many VFs, but only one PF per physical PCIe device. Once a new VF is created, it can be mapped by an object such as a virtual machine, container, or, in the Weka system, by a 'compute' process.

SR-IOV technology should be supported by both the software and hardware to take advantage of it. Software support is included in the Linux kernel, as well as the Weka system software. Hardware support is provided by the computer BIOS and the network adapter, but is usually disabled out of the factory. Consequently, it should be enabled before installing the Weka system software.‌

### UDP Mode

‌On legacy platforms lacking support for virtualization \(SR-IOV\) and kernel offloading technologies \(DPDK\), the Weka system software relies on in-kernel processing and UDP as the transport protocol. This mode of operation is commonly referred to as the 'UDP mode' \_\_and is typically used with older hardware such as the Mellanox CX3 family of NICs.

‌In addition to being compatible with older platforms, the UDP mode yields CPU resources to other applications. This can be useful when the extra CPU cores are needed for other purposes. However, it should be noted that the lack of CPU resources dedicated to the Weka system reduces overall performance and should only be used when there is an issue concerning DPDK functionality.

## Typical Weka Configuration

### Backend Hosts

In a typical Weka system configuration, the Weka backend hosts access the network function in two different methods:

1. Standard TCP/UDP network for management and control operations.
2. High-performance network for data-path traffic.

{% hint style="info" %}
**Note:** To run both functions on the same physical interface, contact the Weka Support Team.
{% endhint %}

The high-performance network used to connect all the backend hosts must be DPDK-based. This internal Weka network also requires a separate IP address space \(see [Network Planning](../install/bare-metal/planning-a-weka-system-installation.md#network-planning) and [Configuration of Networking](../install/bare-metal/using-cli.md#stage-5-configuration-of-networking)\). For this, the Weka system maintains a separate ARP database for its IP addresses and virtual functions and does not use the kernel or operating system ARP services.

#### Backend Hosts with DPDK-Supporting Intel NICs

For backend hosts equipped with DPDK-supporting Intel NICs, the following conditions must be met:

* Intel driver with DPDK support must be installed and loaded.
* SR-IOV must be enabled in the hardware \(BIOS + NIC\).
* The number of IPs allocated to the backend hosts on the internal network should be the total number of Weka software processes plus the total number of backend hosts. For example, a cluster consisting of 8 machines running 10 Weka processes each requires 88 \(80 + 8\) IPs on the internal network. The IP requirements for the Weka clients are outlined below in the Client Hosts section.‌

#### Backend Hosts with DPDK-Supporting Mellanox NICs

‌For backend hosts equipped with DPDK-supporting Mellanox NICs \(CX-4 or newer\), the following conditions must be met:

* Mellanox OFED must be installed and loaded.
* There is no need to use SR-IOV, so the number of IPs allocated to the backend hosts on the internal network should be the total number of backend hosts, i.e., 8 IPs for 8 backend hosts \(using the example above\).

{% hint style="info" %}
**Note:** SR-IOV enablement in the hardware is optional. If enabled, DPDK generates its own MAC addresses for the VFs \(Virtual Functions\) of the NIC and the same NIC can support multiple MAC addresses, some handled by the operating system and others by the Weka system.
{% endhint %}

### Client Hosts

Unlike Weka backend nodes that must be DPDK/SR-IOV based, the Weka client hosts \(application servers\) can use either DPDK-based or UDP modes. The DPDK mode is the natural choice for the newer, high-performing platforms that support it.

#### Client Hosts with DPDK-Supporting Intel NICs

For client hosts equipped with DPDK-supporting Intel NICs, the following conditions must be met to use the DPDK mode:

* Intel driver with DPDK support must be installed and loaded.
* SR-IOV must be enabled in the hardware \(BIOS + NIC\).
* The number of IPs allocated to the Intel client hosts on the internal network should be the total number of Weka system FrontEnd \(FE\) processes \(typically no more than 2 per host\) plus the total number of client hosts. For example, 10 client hosts with 1 FE process per client require 20 IPs \(10 FE IPs + 10 IPs\). ‌

#### Client Hosts with DPDK-Supporting Mellanox NICs

‌For client hosts equipped with DPDK-supporting Mellanox NICs \(CX-4 or newer\), the following conditions must be met:

* Mellanox OFED must be installed and loaded.
* There is no need to use SR-IOV, so the number of IPs allocated to the client hosts on the internal network should be the total number of client hosts, i.e., 10 IPs for 8 client hosts \(using the example above\).

#### Client Hosts in UDP Mode

The UDP mode is available for legacy clients lacking SR-IOV or DPDK support, or where there is no requirement for low latency, high throughput IO.

For client hosts in the UDP mode, the following conditions must be met:

* The native driver must be installed and loaded.
* The number of IPs allocated to the client hosts on the internal network should be equal to the total number of client hosts. For example, 10 client hosts in the UDP mode require 10 IPs on the internal network.

## HA

For HA support, the Weka system must be configured with no single component representing a single point of failure. Multiple switches are required, and hosts must have one leg on each switch.

HA for hosts is achieved through the implementation of two network interfaces on the same host. This is not LACP, which configures a single IP interface on a single host, but a redundancy that enables the Weka software to utilize two interfaces for HA and bandwidth, respectively. Consequently, it is necessary to validate the compatibility of other applications running on the same ports.

HA performs failover and failback for reliability and load balancing on both interfaces and is operational for both Ethernet and InfiniBand. It currently requires doubling the number of IPs on both the host and the IO nodes.‌

