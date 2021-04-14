---
description: >-
  This page describes the prerequisites and compatibility for the installation
  of the Weka system.
---

# Prerequisites and Compatibility

## CPU

* Intel SandyBridge+ processors
* AMD 2nd and 3rd Gen EPYC processors

## Memory

* Enough memory to support the Weka system needs as described in [memory requirements ](../install/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning)
* More memory support for the OS kernel or any other application

## Operating System

### Types

* **RHEL:** 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0, 8.1, 8.2
* **CentOS:** 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9, 8.0, 8.1, 8.2
* **Ubuntu:** 16.04, 18.04, 20.04
* **Amazon Linux:** 17.09, 18.03
* **Amazon Linux 2 LTS** \(formerly Amazon Linux 2 LTS 17.12\)

### Configuration

* SELinux with MLS policy is not supported
* All Weka nodes must be synchronized in date/time \(NTP recommended\)
* A watchdog driver should be installed in /dev/watchdog \(hardware watchdog recommended\); search the Weka knowledgebase in the [Weka support portal](http://support.weka.io) for more information and how-to articles 

### Kernel

* 3.10
* 4.4.0-1106 to 4.19
* 5.3-5.4

{% hint style="info" %}
**Note:** It is advisable to turn off auto kernel updates so it will not get upgraded to a yet unsupported version.
{% endhint %}

## Weka Install Directory

* Directory: `/opt/weka`
* Should be on an SSD or SSD-like performance, e.g., M.2. 
  * Cannot be shared remotely, NFS mounted or on RAM drive
* If there are two boot drives available, it is recommended to dedicate one for the OS and one for the Weka  `/opt/weka` directory \(there is not need to set software RAID, and some of its implementations are also known to have issues\)
* At least 26 GB available for the Weka system installation, with an additional 10GB for each core used by Weka

## Networking

{% hint style="info" %}
**Note:** At least 4k MTU is advised on Weka cluster hosts NIC's, and the switches the hosts are connected to.

For both Ethernet and Infiniband configurations, a Weka system can be configured without jumbo frames. However, it will provide very limited performance and will not be able to handle high loads of data; please consult the Weka Sales or Support teams before running in this mode.

Jumbo Frames are not required for clients. However, performance might be limited.
{% endhint %}

### Ethernet <a id="networking-ethernet"></a>

#### NIC

* Intel 10 Gbit
* Intel 40 Gbit \(Beta\)
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
* 4.9-2.2.4.0
* 5.0-2.1.8.0
* 5.1-2.5.8.0

Supported ENA drivers:

* 1.0.2 - 2.0.2
* A current driver from an official OS repository is recommended

Supported ixgbevf drivers:

* 3.2.2 - 4.1.2
* A current driver from an official OS repository is recommended

Supported Intel 40 drivers:

* 3.0.1-k - 4.1.0
* A current driver from an official OS repository is recommended

#### Ethernet Configuration

* Ethernet speeds: 10 GbE / 25 GbE / 40 GbE / 50GbE / 100 GbE
* NICs bonding: Can bond dual ports on the same NIC \(modes 1 or 4\)
* VLAN: Not supported
* Connectivity between hosts: Ports 14000-14100
* Mellanox NICs:
  * One Weka system IP address for management and data plane
* Other vendors NICs
  * Weka system management IP address: One IP per server \(configured prior to Weka installation\) 
  * Weka system data plane IP address: One IP address for each [Weka core](../install/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server \(Weka will apply these IPs during the cluster initialization\)
  * Weka system management IP: Ability to communicate with all Weka system data plane IPs
  * [Virtual Functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization): The maximum number of virtual functions supported by the device must be bigger than the number of physical cores on the host; you should set the number of VFs to the number of cores you wish to dedicate to Weka; some configuration may be required in the BIOS
  * SR-IOV: Enabled in BIOS

{% hint style="info" %}
**Note:** When assigning a network device to the Weka system, no other application can create [virtual functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization) on that device.
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
* 4.9-2.2.4.0
* 5.0-2.1.8.0
* 5.1-2.5.8.0

#### Infiniband Configuration

* InfiniBand speeds: FDR / EDR / HDR
* Subnet manager: Configured to 4092
* One Weka system IP address for management and data plane
* PKEYs: Supported
* Dual InfiniBand can be used for both HA and higher bandwidth

{% hint style="info" %}
**Note:** If it is necessary to change PKEYs, contact the Weka Support Team.
{% endhint %}

### HA

* Network configured as described in [Weka Networking - HA](../overview/networking-in-wekaio.md#ha).

## SSDs

* Support PLP \(Power Loss Protection\)
* Dedicated for Weka system storage \(partition not supported\)
* Supported drive capacity: Up to 128 TiB
* IOMMU mode for SSD drives is not supported; When IOMMU configuration is required on the Weka cluster servers \(e.g., due to specific applications when running the Weka cluster in converged mode\), contact the Weka support team.

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
* HCP for Cloud Scale V2.x
* IBM Cloud Object Storage System \(version 3.14.7 and up\)
* Quantum ActiveScale \(version 5.5.1 and up\)
* Scality \(version 7.4.4.8 and up\)
* SwiftStack \(version 6.30 and up\)

## Virtual Machines

VMs can be used as clients only, assuming they meet the following prerequisite:

#### For UDP clients:

* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the Weka process by both reserving the CPU in the virtual platform and dedicate a core to the Weka client.
* The root filesystem should handle a 3K IOPS load by the Weka client.

#### **For DPDK clients \(on top of the UDP requirements\):**

* The virtual platform interoperability \(hypervisor, NICs, CPUs, different versions, etc.\) should support DPDK and SR-IOV VFs passthrough to the VM.
* The hypervisor hosts and the client VMs should run the same OFED version.

For additional information and how-to articles, search the Weka knowledgebase in the [Weka support portal](http://support.weka.io) or contact the Weka support team.

## KMS

* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) \(version 1.1.5 and up\)
* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) compliant KMS \(protocol version 1.2 and up\)
  * The KMS should support encryption-as-a-service \(KMIP encrypt/decrypt APIs\)
  * KMIP certification has been conducted with [Equinix SmartKey](https://www.equinix.com/services/edge-services/smartkey/) \(powered by [Fortanix KMS](https://fortanix.com/products/sdkms/)\)



