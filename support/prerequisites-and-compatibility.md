---
description: >-
  This page describes the prerequisites and compatibility for the installation
  of the WEKA system.
---

# Prerequisites and compatibility

{% hint style="info" %}
The versions specified in the prerequisites and compatibility page apply to the latest minor version of the WEKA system. See the relevant release notes in [get.weka.io ](https://get.weka.io/ui/releases/)for more details.
{% endhint %}

## CPU

* Intel SandyBridge+ processors
* AMD 2nd and 3rd Gen EPYC processors

{% hint style="info" %}
Ensure the BIOS settings meet the following requirements:

* AES must be enabled.
* Secure Boot must be disabled.&#x20;
{% endhint %}

## Memory

* Sufficient memory to support the WEKA system needs as described in [memory requirements](../install/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
* More memory support for the OS kernel or any other application.

## Operating system

{% tabs %}
{% tab title="Backends and Clients" %}
The following operating systems are supported for backend servers and clients:

* **RHEL:**
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
  * 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 9.1, 9.0
* **CentOS:**
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **Rocky Linux:**
  * 8.7, 8.6
* **Ubuntu:**
  * 18.04
  * 20.04
* **Amazon Linux:** 18.03, 17.09
* **Amazon Linux 2 LTS** (formerly Amazon Linux 2 LTS 17.12)

{% hint style="info" %}
**Note:** Ensure using an OS with a supported kernel. Do not use an OS with kernel 5.13 and higher for backends.
{% endhint %}
{% endtab %}

{% tab title="Clients only" %}
The following operating systems are supported for clients only:

**SuSe:**

* 15 SP2
* 12 SP5

**RHEL:**

* 9.1, 9.0

**Rocky Linux:**&#x20;

* 9.1, 9.0

**Ubuntu:**&#x20;

* 22.04&#x20;

{% hint style="info" %}
**Note:** For kernels 5.13 and higher, do not use applications that use 1GB hugepages. RHEL/Rocky Linux 9.1, 9.0 and Ubuntu 22.04 use kernels higher than 5.13.
{% endhint %}
{% endtab %}

{% tab title="Kernel" %}
The following kernel versions are supported:

* 5.3-5.15
* 4.4.0-1106 to 4.19
* 3.10

{% hint style="warning" %}
**Notes:**

* Kernel 5.15 is not supported with Amazon Linux operating systems.
* For kernels 5.13 and higher, do not use applications that use 1GB hugepages.
{% endhint %}

{% hint style="info" %}
**Note:** It is recommended to turn off auto kernel updates, so it will not get upgraded to an unsupported version.
{% endhint %}
{% endtab %}

{% tab title="Configuration" %}
#### General

* All WEKA servers must be synchronized in date/time (NTP recommended)
* A watchdog driver should be installed in /dev/watchdog (hardware watchdog recommended); search the WEKA knowledge base in the [WEKA support portal](http://support.weka.io) for more information and how-to articles.
* If using `mlocate` or alike, it's advisable to exclude `wekafs` from `updatedb` filesystems lists; search the WEKA knowledge base in the [WEKA support portal](http://support.weka.io) for more information and how-to articles.

#### SELinux

* SELinux is supported in both `permissive` and `enforcing` modes.
  * `The targeted` policy is supported.
  * The `mls` policy is not supported yet.

{% hint style="info" %}
**Note:** To set the SELinux security context for files,  use the `-o acl` in the mount command, and define the `wekafs` to use extended attributes in the SELinux policy configuration (`fs_use_xattr`).
{% endhint %}

#### cgroups

* WEKA backends and clients that serve protocols must be deployed on a supported OS with **cgroups V1** (legacy).
{% endtab %}
{% endtabs %}

## Weka installation directory

* Directory: `/opt/weka`
* Must be on an SSD or SSD-like performance, for example, M.2.
  * Cannot be shared remotely, NFS mounted, or on a RAM drive.
* If two boot drives are available, it is recommended to dedicate one for the OS and one for the WEKA `/opt/weka` directory (there is no need to set software RAID, and some of its implementations are also known to have issues).
* At least 26 GB is available for the WEKA system installation, with an additional 10 GB for each core used by WEKA.
* Use a separate filesystem on a separate partition for /opt/weka.

## Networking

{% hint style="info" %}
**Note:** At least 4k MTU is advised on WEKA cluster servers NICs and the switches the servers are connected to.

A WEKA system can be configured without jumbo frames for Ethernet and Infiniband configurations. However, it will provide minimal performance and cannot handle high data loads. Consult with the Customer Success Team before running in this mode.

Jumbo Frames are not required for clients. However, performance might be limited.
{% endhint %}

### Ethernet <a href="#networking-ethernet" id="networking-ethernet"></a>

{% tabs %}
{% tab title="NIC" %}
WEKA supports the following Ethernet NICs:

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
**Note:** Intel E810 NIC has specific requirements and certain limitations:

* The ice Linux Base Driver version 1.9.11 and firmware version 4.0.0.
* Working with this NIC is only supported on RHEL 8.6 and Rocky Linux 8.6. For other operating systems, contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
* [Multiple containers architecture](../overview/weka-containers-architecture-overview.md) is not yet supported with this NIC.
{% endhint %}

{% hint style="info" %}
**Note:** Connecting Ethernet and IB clients to the same cluster is not supported with E810 NIC and Mellanox ConnectX-6-Dx on the cluster backends.
{% endhint %}

{% hint style="info" %}
**Note:** LACP (link aggregation, also known as bond interfaces) is currently supported between ports on a single Mellanox NIC and is not supported when using virtual functions (VFs).
{% endhint %}
{% endtab %}

{% tab title="NIC drivers" %}
Supported Mellanox OFED versions for the Ethernet NICs:

* 5.9-0.5.6.0
* 5.8-1.1.2.1 LTS
* 5.7-1.0.2.0
* 5.6-2.0.9.0
* 5.6-1.0.3.3
* 5.4-3.5.8.0 LTS
* 5.4-3.4.0.0 LTS
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
{% endtab %}

{% tab title="Ethernet configuration" %}
* Ethernet speeds: 200 GbE / 100 GbE / 50GbE / 40 GbE / 25 GbE / 10 GbE
* NICs bonding: Can bond dual ports on the same NIC (modes 1 or 4)
* VLAN: Not supported
* Connectivity between servers:
  * For multiple containers architecture, the default for the Resources Generator is 14000-14100, 14200-14300, and 14400-14500 for the first three containers (these values can be customized).
  * For single container architecture: Ports 14000-14300.
* Mellanox NICs:
  * One Weka system IP address for management and data plane
* Other vendors NICs
  * Weka system management IP address: One IP per server (configured before Weka installation)
  * Weka system data plane IP address: One IP address for each [Weka core](../install/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (Weka will apply these IPs during the cluster initialization)
  * Weka system management IP: Ability to communicate with all Weka system data plane IPs
  * [Virtual Functions (VFs)](https://en.wikipedia.org/wiki/Network\_function\_virtualization): The maximum number of VFs supported by the device must be bigger than the number of physical cores on the server; you should set the number of VFs to the number of cores you wish to dedicate to Weka; some configurations may be required in the BIOS
  * SR-IOV: Enabled in BIOS

{% hint style="info" %}
**Note:** When assigning a network device to the Weka system, no other application can create VFs on that device.
{% endhint %}
{% endtab %}
{% endtabs %}

### InfiniBand <a href="#networking-infiniband" id="networking-infiniband"></a>

{% tabs %}
{% tab title="NIC" %}
WEKA supports the following InfiniBand NICs:

* Mellanox ConnectX-6
* Mellanox ConnectX-5
* Mellanox ConnectX-5-Ex
* Mellanox ConnectX-4
* Mellanox ConnectX-4-Lx
{% endtab %}

{% tab title="NIC Drivers" %}
WEKA supports the following Mellanox OFED versions for the InfiniBand NICs:

* 5.9-0.5.6.0
* 5.8-1.1.2.1 LTS
* 5.7-1.0.2.0
* 5.6-2.0.9.0
* 5.6-1.0.3.3
* 5.4-3.5.8.0 LTS
* 5.4-3.4.0.0 LTS
* 5.1-2.6.2.0
* 5.1-2.5.8.0
{% endtab %}

{% tab title="Configuration" %}
WEKA supports the following InfiniBand configurations:

* InfiniBand speeds: FDR / EDR / HDR
* Subnet manager: Configured to 4092
* One Weka system IP address for management and data plane
* PKEYs: Supported
* Dual InfiniBand can be used for both HA and higher bandwidth

{% hint style="info" %}
**Note:** If it is necessary to change PKEYs, contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}
{% endtab %}
{% endtabs %}

### HA

* The network is configured as described in [Weka Networking - HA](../overview/networking-in-wekaio.md#ha).

## SSDs

* Support PLP (Power Loss Protection)
* Dedicated for Weka system storage (partition not supported)
* Supported drive capacity: Up to 128 TiB
* IOMMU mode for SSD drives is not supported; When IOMMU configuration is required on the Weka cluster servers (e.g., due to specific applications when running the Weka cluster in converged mode), contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).

{% hint style="info" %}
**Note:** To get the best performance, ensure [TRIM](https://en.wikipedia.org/wiki/Trim\_\(computing\)) is supported by the device and enabled in the operating system.
{% endhint %}

## Object store

* API must be S3 compatible:
  * GET
    * Including byte-range support with expected performance gain when fetching partial objects
  * PUT
    * Supports any byte size of up to 65 MiB
  * DELETE
* Data Consistency: [AWS S3 consistency guarantee](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):
  * GET after a single PUT must be entirely consistent
  * Multiple PUTs should eventually be consistent

### Certified object stores

* AWS S3
  * S3 Standard
  * S3 Intelligent-Tiering
  * S3 Standard-IA
  * S3 One Zone-IA
  * S3 Glacier Instant Retrieval
* Azure Blob Storage
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

## Virtual Machines

Virtual Machines (VMs) can be used as **clients** only. Ensure the following prerequisites are met for the relevant client type:

{% tabs %}
{% tab title="UDP clients" %}
* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the Weka process by reserving the CPU in the virtual platform and dedicating a core to the WEKA client.
* The root filesystem must handle a 3K IOPS load by the WEKA client.

\

{% endtab %}

{% tab title="DPDK clients" %}
* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the Weka process by reserving the CPU in the virtual platform and dedicating a core to the WEKA client.
* The root filesystem must handle a 3K IOPS load by the WEKA client.
* The virtual platform interoperability, such as a hypervisor, NICs, CPUs, and different versions, must support DPDK and virtual network driver.
{% endtab %}
{% endtabs %}

<details>

<summary>Special note for a VMware platform</summary>

* If using `vmxnet3` devices, do not enable the SR-IOV feature (which prevents the `vMotion` feature). Each frontend process requires a `vmxnet3` device and IP, with an additional device and IP per client VM (for the management process).
* Using `vmxnet3` is only supported with core dedication.

</details>

For additional information and how-to articles, search the Weka Knowledge Base in the [WEKA support portal](http://support.weka.io) or contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).

## KMS

* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) (version 1.1.5 up to 1.9.x)
* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html)-compliant KMS (protocol version 1.2 and up)
  * The KMS should support encryption-as-a-service (KMIP encrypt/decrypt APIs)
  * KMIP certification has been conducted with [Equinix SmartKey](https://www.equinix.com/services/edge-services/smartkey/) (powered by [Fortanix KMS](https://fortanix.com/products/sdkms/))
