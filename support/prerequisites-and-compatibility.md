---
description: >-
  This page describes the prerequisites and compatibility for the installation
  and upgrade of the Weka system.
---

# Prerequisites and compatibility

{% hint style="info" %}
The versions specified in the prerequisites and compatibility page apply to the latest minor version of the Weka system. See the relevant release notes in [get.weka.io ](https://get.weka.io/ui/releases/)for more details.
{% endhint %}

## CPU

* Intel Icelake+ processors
* AMD 2nd, 3rd Gen EPYC processors

{% hint style="info" %}
Ensure the BIOS settings meet the following requirements:

* AES must be enabled.
* Secure Boot must be disabled.&#x20;
{% endhint %}

## Memory

* Enough memory to support the Weka system needs as described in [memory requirements](../install/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
* More memory support for the OS kernel or any other application.

## Operating system

### Types

#### Backends and Clients:

* **RHEL:**&#x20;
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
  * 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0&#x20;
* **CentOS:**&#x20;
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2&#x20;
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **Rocky Linux**
  * 8.7, 8.6
* **Ubuntu:**&#x20;
  * 18.04.6, 18.04.5, 18.04.4, 18.04.3, 18.04.2, 18.04.1, 18.04.0
  * 20.04.3, 20.04.2, 20.04.1, 20.04.0
* **Amazon Linux:** 18.03, 17.09
* **Amazon Linux 2 LTS** (formerly Amazon Linux 2 LTS 17.12)

{% hint style="info" %}
Ensure using an OS with a supported kernel. Do not use an OS with kernel 5.13 for backends in MCB architecture.
{% endhint %}

#### Clients only:

* **SuSe:**&#x20;
  * 15 SP2
  * 12 SP5

{% hint style="info" %}
For kernel 5.13 in clients, do not use applications that use 1GB hugepages.
{% endhint %}

### Configuration

#### General

* All Weka nodes must be synchronized in date/time (NTP recommended)
* A watchdog driver should be installed in /dev/watchdog (hardware watchdog recommended); search the Weka knowledge-base in the [Weka support portal](http://support.weka.io) for more information and how-to articles
* If using `mlocate` or alike, it's advisable to exclude `wekafs` from `updatedb` filesystems lists; search the Weka knowledge-base in the [Weka support portal](http://support.weka.io) for more information and how-to articles

#### SELinux&#x20;

* SELinux is supported in both `permissive` and `enforcing` mode
  * `targeted` policy is supported
  * `mls` policy is not supported yet

{% hint style="info" %}
**Note:** To set the SELinux security context for files, `-o acl` should be used in the mount command, and `wekafs` should be defined to use extended attributes in the SELinux policy configuration (`fs_use_xattr`).
{% endhint %}

### Kernel

* 5.3-5.13
* 4.4.0-1106 to 4.19
* 3.10

{% hint style="info" %}
**Note:** It is advisable to turn off auto kernel updates, so it will not get upgraded to an unsupported version.
{% endhint %}

## Weka installation directory

* Directory: `/opt/weka`
* Must be on an SSD or SSD-like performance, for example, M.2.&#x20;
  * Cannot be shared remotely, NFS mounted, or on a RAM drive.
* If there are two boot drives available, it is recommended to dedicate one for the OS and one for the Weka  `/opt/weka` directory (there is no need to set software RAID, and some of its implementations are also known to have issues).
* At least 26 GB is available for the Weka system installation, with an additional 10 GB for each core used by Weka.
* Use a separate filesystem on a separate partition for /opt/weka.

## Networking

{% hint style="info" %}
**Note:** At least 4k MTU is advised on Weka cluster hosts NICs, and the switches the hosts are connected to.

A Weka system can be configured without jumbo frames for both Ethernet and Infiniband configurations. However, it will provide very limited performance and will not be able to handle high loads of data; please consult the Weka Sales or Support teams before running in this mode.

Jumbo Frames are not required for clients. However, performance might be limited.
{% endhint %}

### Ethernet <a href="#networking-ethernet" id="networking-ethernet"></a>

#### NIC

* Amazon ENA
* Broadcom 57810S
* Intel E810 2CQDA2
* Intel X540
* Intel X550-T1
* Intel X710
* Intel X710-DA2
* Intel XL710
* Intel XL710-Q2
* Intel XXV710
* Intel 82599ES
* Intel 82599
* Mellanox ConnectX-6-Lx
* Mellanox ConnectX-6-Dx
* Mellanox ConnectX-6
* Mellanox ConnectX-5-Ex
* Mellanox ConnectX-5-Bf
* Mellanox ConnectX-5
* Mellanox ConnectX-4-Lx
* Mellanox ConnectX-4

{% hint style="info" %}
Intel E810 NIC has specific requirements and certain limitations:

* The ice Linux Base Driver version 1.9.11 and firmware version 4.0.0.
* Working with this NIC is only supported on RHEL 8.6 and Rocky Linux 8.6. For other operating systems, contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
* Only non-routed network is supported with this NIC.
{% endhint %}

{% hint style="info" %}
**Note:** LACP (link aggregation, also known as  bond interfaces) is currently supported between ports on a single Mellanox NIC and is not supported when using VFs (virtual functions).
{% endhint %}

#### NIC drivers

Supported Mellanox OFED versions:

* 5.8-1.1.2.1 LTS
* 5.6-2.0.9.0
* 5.6-1.0.3.3
* 5.4-3.4.0.0 (LTS)
* 5.1-2.6.2.0
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

Supported ice drivers:

* 1.9.11

#### Ethernet configuration

* Ethernet speeds: 200 GbE / 100 GbE /  50GbE / 40 GbE / 25 GbE / 10 GbE&#x20;
* NICs bonding: Can bond dual ports on the same NIC (modes 1 or 4)
* VLAN: Not supported
* Connectivity between hosts: Ports 14000-14100
* Mellanox NICs:
  * One Weka system IP address for management and data plane
* Other vendors NICs
  * Weka system management IP address: One IP per server (configured prior to Weka installation)&#x20;
  * Weka system data plane IP address: One IP address for each [Weka core](../install/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (Weka will apply these IPs during the cluster initialization)
  * Weka system management IP: Ability to communicate with all Weka system data plane IPs
  * [Virtual Functions (VFs)](https://en.wikipedia.org/wiki/Network\_function\_virtualization): The maximum number of virtual functions supported by the device must be bigger than the number of physical cores on the host; you should set the number of VFs to the number of cores you wish to dedicate to Weka; some configuration may be required in the BIOS
  * SR-IOV: Enabled in BIOS

{% hint style="info" %}
**Note:** When assigning a network device to the Weka system, no other application can create [virtual functions (VFs)](https://en.wikipedia.org/wiki/Network\_function\_virtualization) on that device.
{% endhint %}

### InfiniBand <a href="#networking-infiniband" id="networking-infiniband"></a>

#### NIC

* Mellanox ConnectX-6
* Mellanox ConnectX-5
* Mellanox ConnectX-5-Ex
* Mellanox ConnectX-4
* Mellanox ConnectX-4-Lx

#### NIC Drivers

Supported Mellanox OFED versions:

* 5.8-1.1.2.1 LTS
* 5.6-2.0.9.0
* 5.6-1.0.3.3
* 5.4-3.4.0.0 (LTS)
* 5.1-2.6.2.0
* 5.1-2.5.8.0

#### Infiniband Configuration

* InfiniBand speeds: FDR / EDR / HDR
* Subnet manager: Configured to 4092
* One Weka system IP address for management and data plane
* PKEYs: Supported
* Dual InfiniBand can be used for both HA and higher bandwidth

{% hint style="info" %}
**Note:** If it is necessary to change PKEYs, contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}

### HA

* Network configured as described in [Weka Networking - HA](../overview/networking-in-wekaio.md#ha).

## SSDs

* Support PLP (Power Loss Protection)
* Dedicated for Weka system storage (partition not supported)
* Supported drive capacity: Up to 17 TiB
* IOMMU mode for SSD drives is not supported; When IOMMU configuration is required on the Weka cluster servers (e.g., due to specific applications when running the Weka cluster in converged mode), contact the Weka support team.

{% hint style="info" %}
**Note:** To get the best performance, make sure [TRIM](https://en.wikipedia.org/wiki/Trim\_\(computing\)) is supported by the device and enabled in the operating system.
{% endhint %}

## Object store

* API must be S3 compatible:&#x20;
  * GET
    * Including byte-range support with expected performance gain when fetching partial objects
  * PUT
    * Supports any byte size of up to 65 MiB
  * DELETE
* Data Consistency: [AWS S3 consistency guarantee](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):
  * GET after single PUT should be fully consistent
  * Multiple PUTs should be eventually consistent

Certified object stores:

* AWS S3
  * S3 Standard
  * S3 Intelligent-Tiering
  * S3 Standard-IA
  * S3 One Zone-IA
  * S3 Glacier Instant Retrieval
* Google Cloud Storage (GCS)
* Cloudian HyperStore (version 7.3 and up)
* Dell EMC ECS v3.5 and up
* HCP Classic V9.2 and up (with versioned buckets only)
* HCP for Cloud-Scale V2.x
* IBM Cloud Object Storage System (version 3.14.7 and up)
* Quantum ActiveScale (version 5.5.1 and up)
* Red Hat Ceph Storage (version 5.0 and up)
* Scality (version 7.4.4.8 and up)
* SwiftStack (version 6.30 and up)

## Virtual machines

VMs can be used as clients only, assuming they meet the following prerequisite:

### &#xD;For UDP clients:

* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the Weka process by both reserving the CPU in the virtual platform and dedicating a core to the Weka client.
* The root filesystem should handle a 3K IOPS load by the Weka client.

### **For DPDK clients (on top of the UDP requirements):**

* The virtual platform interoperability (hypervisor, NICs, CPUs, different versions, etc.) must support DPDK and SR-IOV VFs passthrough to the VM.
* The hypervisor hosts and the client VMs must run the same OFED version.

#### For the VMWare platform:

* If using `vmxnet3` devices, do not enable the SR-IOV feature (which prevents vMotion). Each FrontEnd process requires a `vmxnet3` device and IP, with an additional device and IP per client VM (for the management process).
* Using `vmxnet3` is only supported with core dedication.

For additional information and how-to articles, search the Weka knowledgebase in the [Weka support portal](http://support.weka.io) or contact the Weka support team.

## KMS

* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) (version 1.1.5 up to 1.9.x)
* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) compliant KMS (protocol version 1.2 and up)
  * The KMS should support encryption-as-a-service (KMIP encrypt/decrypt APIs)
  * KMIP certification has been conducted with [Equinix SmartKey](https://www.equinix.com/services/edge-services/smartkey/) (powered by [Fortanix KMS](https://fortanix.com/products/sdkms/))

