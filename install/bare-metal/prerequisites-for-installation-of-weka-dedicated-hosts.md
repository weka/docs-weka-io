---
description: >-
  This page describes the hardware requirements for installation of the WEKA
  system on dedicated hosts.
---

# Prerequisites for Installation

{% hint style="info" %}
**Note:** Client installation is described in [Adding Clients](adding-clients-bare-metal.md).
{% endhint %}

## CPU

* Intel SandyBridge+ and AMD processors with equivalent instructions sets

## Memory

* Enough memory to support WEKA system needs as described in [memory requirements ](planning-a-weka-system-installation.md#memory-resource-planning)
* More memory support for the OS kernel or any other application

## Operating System

### Types

* **RHEL:** 6.8, 6.9, 6.10, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 8.0, 8.1
* **CentOS:** 6.8, 6.9, 6.10, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 8.0, 8.1
* **Ubuntu:** 16.04, 18.04
* **Amazon Linux:** 17.09, 18.03
* **Amazon Linux 2 LTS** \(formerly Amazon Linux 2 LTS 17.12\)

### Configuration

* SELinux with MLS policy is not supported
* All WEKA nodes must be synchronized in date/time \(NTP recommended\)
* A watchdog driver should be installed in /dev/watchdog \(hardware watchdog recommended\); search the WEKA knowledgebase in the [WEKA support portal](http://support.weka.io) for more information and how-to articles 

### Kernel

* 2.6.32
* 3.10
* 4.4 - 4.18

## WEKA Install Directory

* Directory: /opt/weka
* Should be on an SSD or SSD-like performance, e.g., M.2. 
  * Cannot be shared remotely, NFS mounted or on RAM drive
* At least 26 GB available for the WEKA system installation, with additional 10GB for each core used by WEKA

## Networking

{% hint style="info" %}
**Note:** For both Ethernet and Infiniband configurations, the WEKA system can work with any MTU larger than 1400. For best performance, enable jumbo frames both on the switch and the network ports.
{% endhint %}

### Ethernet <a id="networking-ethernet"></a>

#### NIC

* Intel 10 Gbit
* Intel 40 Gbit \(PoC Grade\)
* Amazon ENA
* Mellanox ConnectX4 \(Ethernet and InfiniBand\)
* Mellanox ConnectX5 \(Ethernet and InfiniBand\)
* Mellanox ConnectX6 \(Ethernet and InfiniBand\)

#### NIC Drivers

Supported Mellanox OFED versions:

* 4.2-1.0.0.0
* 4.2-1.2.0.0
* 4.3-1.0.1.0
* 4.4-1.0.0.0
* 4.4-2.0.7.0
* 4.5-1.0.1.0
* 4.6-1.0.1.1
* 4.7-1.0.0.1
* 4.7-3.2.9.0

Supported ENA drivers:

* 1.0.2 - 2.0.2
* Current driver from official OS repository is recommended

Supported ixgbevf drivers:

* 3.2.2 - 4.1.2
* Current driver from official OS repository is recommended

Supported Intel 40 drivers:

* 3.0.1-k - 4.1.0
* Current driver from official OS repository is recommended

#### Ethernet Configuration

* Ethernet speeds: 10 GbE / 25 GbE / 40 GbE / 50GbE / 100 GbE
* NICs bonding: Not configured
* VLAN: Not supported
* Connectivity between hosts: Ports 14000-14100
* [NetworkManager](https://en.wikipedia.org/wiki/NetworkManager): Disabled
* Mellanox NICs:
  * One WEKA system IP address for management and data plane
* Other vendors NICs
  * WEKA system management IP address: One IP per server \(configured prior to WEKA installation\) 
  * WEKA system data plane IP address: One IP address for each [WEKA core](planning-a-weka-system-installation.md#cpu-resource-planning) in each server \(WEKA will apply these IPs during the cluster initialization\)
  * WEKA system management IP: Ability to communicate with all WEKA system data plane IPs
  * [Virtual Functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization): The maximum number of virtual functions supported by the device must be bigger than the number of physical cores on the host; you should set the number of VFs to the number of cores you wish to dedicate to WEKA; some configuration may be required in the BIOS
  * SR-IOV: Enabled in BIOS

{% hint style="info" %}
**Note:** When assigning a network device to the WEKA system, no other application can create [virtual functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization) on that device.
{% endhint %}

### InfiniBand <a id="networking-infiniband"></a>

#### NIC

* Mellanox ConnectX4 \(Ethernet and InfiniBand\)
* Mellanox ConnectX5 \(Ethernet and InfiniBand\)
* Mellanox ConnectX6 \(Ethernet and InfiniBand\)

#### NIC Drivers

Supported Mellanox OFED versions:

* 4.2-1.0.0.0
* 4.2-1.2.0.0
* 4.3-1.0.1.0
* 4.4-1.0.0.0
* 4.4-2.0.7.0
* 4.5-1.0.1.0
* 4.6-1.0.1.1
* 4.7-1.0.0.1
* 4.7-3.2.9.0

#### Infiniband Configuration

* InfiniBand speeds: FDR / EDR / HDR
* Subnet manager: Configured to 4092
* One WEKA system IP address for management and data plane
* PKEYs: Supported
* Support PLP \(Power Loss Protection\)
* Dedicated for WEKA system storage \(partition not supported\)
* Dual InfiniBand can be used for both HA and higher bandwidth

{% hint style="info" %}
**Note:** If it is necessary to change PKEYs, contact the WEKA Support Team.
{% endhint %}

### HA

* Network configured as described in [WEKA Networking - HA](../../overview/networking-in-wekaio.md#ha).

## SSDs

* Support PLP \(Power Loss Protection\)
* Dedicated for WEKA system storage \(partition not supported\)
* Supported drive capacity: Up to 128 TiB
* IOMMU mode for SSD drives is not supported; When IOMMU configuration is required on the WEKA cluster servers \(e.g., due to specific applications when running the WEKA cluster in converged mode\), contact the WEKA support team.

## Object Store

* API should be S3 compatible: 
  * GET
    * Including byte-range support with expected performance gain when fetching partial objects
  * PUT
    * Supports any byte size of up to 65 MiB
  * DELETE
* Data Consistency: [AWS S3 consistency guarantee](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):
  * GET after single PUT should be fully consistent
  * Multiple PUTs should be eventually consistent

Certified Object Stores:

* AWS S3
* Quantum ActiveScale \(version 5.5.1 and up\)
* Scality \(version 7.4.4.8 and up\)
* SwiftStack \(version 6.30 an up\)

