---
description: This page reviews the theory of operation for WekaIO networking.
---

# WekaIO Networking

## Overview

The WekaIO system supports the following types of networking technologies:

1. InfiniBand \(IB\)
2. Ethernet.

The choice between the two is dictated by the currently-available networking infrastructure.

For networking, the WekaIO system does not use standard kernel-based TCP/IP services, but a proprietary infrastructure based on the following:

* Use of [DPDK](https://www.dpdk.org/) to map the network device in the user space and make use of the network device without any context switches and with zero-copy access. This bypassing of the kernel stack eliminates the consumption of kernel resources for networking operations and can be scaled to run on multiple hosts. It applies to both backend and client hosts and enables the WekaIO system to fully saturate 200 GB links.
* Implementation of a proprietary WekaIO protocol over UDP, i.e., the underlying network may involve routing between subnets or any other networking infrastructure that supports UDP.

The use of DPDK delivers operations with extremely low-latency and high throughput. Low latency is achieved by bypassing the kernel and sending and receiving packages directly from the NIC. High throughput is achieved because multiple cores in the same host can work in parallel, without a common bottleneck.

## Typical WekaIO Configuration

A number of functions are traditionally implemented by the DPDK layer, such as reliability and retransmission, and congestion control. In a typical WekaIO system configuration, the WekaIO backend hosts access the network function in two different methods:

1. Standard TCP/UDP network for management and control operations.
2. High performance network function for use by data path traffic.

{% hint style="info" %}
**Note:** To run both functions on the same physical interface, contact the WekaIO Support Team.
{% endhint %}

The DPDK-based network used to connect all the backend hosts has its own MAC addresses \(known as virtual functions in DPDK\). Consequently, the same NIC can support multiple MAC addresses, some handled by the operating system and others by WekaIO.

This internal WekaIO network also requires a separate IP address space \(see [Network Planning](../install/bare-metal/planning-a-weka-system-installation.md#network-planning) and [Configuration of Networking](../install/bare-metal/using-cli.md#stage-5-configuration-of-networking)\). For this, the WekaIO system maintains a separate ARP database for its IP addresses and virtual functions, and does not use the kernel or operating system ARP services.

## UDP Mode

The WekaIO system can also be configured to work over UDP through the kernel. This allows the use of a core not solely for WekaIO and can be useful when throughout is not very high and the extra core is needed for other purposes. However, this reduces performance and should only be used when there is an issue concerning DPDK functionality.

## HA

To support HA, the WekaIO system must be configured with no single component representing a single point of failure. Multiple switches are required and hosts must have one leg on each switch. 

HA for hosts is achieved through the implementation of two network interfaces on the same host. This is not LACP, which configures a single IP interface on a single host, but a redundancy that enables the WekaIO software to utilize two interfaces for HA and bandwidth, respectively. Consequently, it is necessary to validate the compatibility of other applications running on the same ports.

HA performs fail-over and fail-back for reliability and load balancing on both interfaces, and is operational for both Ethernet and InfiniBand. It currently requires doubling of the number of IPs on both the host and the IO nodes.

