---
description: >-
  This page describes the prerequisites and compatibility for the installation
  of the WEKA system.
---

# Prerequisites and compatibility

{% hint style="warning" %}
**Important:** The versions mentioned on the prerequisites and compatibility page apply to the WEKA system's **latest minor version** (4.4.**X**). For information on new features and supported prerequisites released with each minor version, refer to the relevant release notes available at [get.weka.io](https://get.weka.io/).

Check the release notes for details about any updates or changes accompanying the latest releases.
{% endhint %}

{% hint style="info" %}
In certain instances, WEKA collaborates with Strategic Server Partners to conduct platform qualifications alongside complementary components. If you have any inquiries, contact your designated WEKA representative.
{% endhint %}

## Minimal server configuration for a WEKA cluster

The minimal configuration for a new WEKA cluster installation is **8 servers**. This ensures optimal performance, resilience, and scalability for most deployments.

{% hint style="info" %}
For cloud-based installations, WEKA supports a minimal configuration of **6 servers** to accommodate the unique requirements of cloud environments.
{% endhint %}

## CPU

<table><thead><tr><th width="356">CPU family/architecture</th><th width="202">Supported on backends</th><th>Supported on clients</th></tr></thead><tbody><tr><td>Intel Xeon E5 v3 (Haswell) through Xeon 6 (Granite Rapids / Sierra Forest) with up to 256 total CPU cores</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Dual-socket</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Single-socket and dual-socket</td></tr><tr><td>AMD EPYC™ processor families 2nd (Rome) through 5th (Turin) Generations with up to 256 total CPU cores</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Single-socket</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Single-socket and dual-socket</td></tr><tr><td>ARM (AArch64) - Nvidia Grace single or dual-processor with up to 144 total CPU cores</td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Nvidia Grace</td></tr></tbody></table>

{% hint style="info" %}
The following requirements must be met:

* AES[^1] is enabled.
* [Secure Boot](#user-content-fn-2)[^2] is disabled.
* AVX2[^3] is enabled.
{% endhint %}

## Memory

* Sufficient memory to support the WEKA system needs as described in [memory requirements](bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
* More memory support for the OS kernel or any other application.

## Operating system

{% hint style="info" %}
Every effort is made to support upcoming releases of the operating systems in the lists within one quarter (three months) of their respective General Availability (GA) dates. When an operating system version is deprecated, WEKA will cease to ensure its software continues to work with that operating system version.
{% endhint %}

{% tabs %}
{% tab title="Backends" %}
* **Rocky Linux:**
  * 9.4, 9.3, 9.2, 9.1, 9.0
  * 8.10, 8.9, 8.8, 8.7, 8.6
* **RHEL:**
  * 9.5, 9.4, 9.3, 9.2, 9.1, 9.0
  * 8.10, 8.9, 8.8, 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **CentOS:**
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **Ubuntu:**
  * 24.04
  * 22.04
  * 20.04
  * 18.04
* **Amazon Linux:**
  * AMI 2018.03
  * AMI 2017.09
* **Amazon Linux 2 LTS** (formerly Amazon Linux 2 LTS 17.12)
  * Latest update package that was tested: 5.10.176-157.645.amzn2.x86\_64
{% endtab %}

{% tab title="Clients" %}
* **Rocky Linux:**
  * 9.5 (ARM), 9.5, 9.4, 9.3, 9.2, 9.1, 9.0
  * 8.10, 8.9, 8.8, 8.7, 8.6
* **RHEL:**
  * 9.5, 9.4, 9.3, 9.2, 9.1, 9.0
  * 8.10, 8.9, 8.8, 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **CentOS:**
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
* **Ubuntu:**
  * 24.04
  * 22.04
  * 20.04
  * 18.04
* **Amazon Linux:**
  * AMI 2018.03
  * AMI 2017.09
* **Amazon Linux 2 LTS** (formerly Amazon Linux 2 LTS 17.12)
  * Latest update package that was tested: 5.10.176-157.645.amzn2.x86\_64
* **SLES:**
  * 15 SP6
  * 15 SP5
  * 15 SP4
  * 15 SP2
  * 12 SP5
* **Oracle Linux:**
  * 9
  * 8.9
* **Debian:**
  * 12 (with Linux kernel 6.6)
  * 10
* **AlmaLinux OS:**
  * 9.6, 9.4
  * 8.10
* **Proxmox Virtual Environment**:
  * 8.2
  * 8.14
{% endtab %}

{% tab title="Kernel" %}
The following kernel versions are supported:

* 6.14
* 6.8
* 6.0 to 6.5
* 5.3 to 5.19
* 4.4.0-1106 to 4.19
* 3.10

{% hint style="info" %}
- Kernels 5.15 and higher are not supported with Amazon Linux operating systems.
- It is recommended to turn off auto kernel updates, so it will not get upgraded to an unsupported version.
- Confirm that both the kernel version and the operating system version are listed as supported, as these are distinct components with their own compatibility considerations.
- For clarity, the range of supported versions is inclusive.
{% endhint %}
{% endtab %}

{% tab title="Configuration" %}
**General**

* All WEKA servers must be synchronized in date/time (NTP recommended)
* A watchdog driver should be installed in /dev/watchdog (hardware watchdog recommended); search the WEKA knowledge base in the [WEKA support portal](http://support.weka.io) for more information and how-to articles.
* If using `mlocate` or alike, it's advisable to exclude `wekafs` from `updatedb` filesystems lists; search the WEKA knowledge base in the [WEKA support portal](http://support.weka.io) for more information and how-to articles.

**SELinux**

* SELinux is supported in both `permissive` and `enforcing` modes.
  * `The targeted` policy is supported.
  * The `mls` policy is not supported yet.

{% hint style="info" %}
- To set the SELinux security context for files, use the `-o acl` in the mount command, and define the `wekafs` to use extended attributes in the SELinux policy configuration (`fs_use_xattr`).
- The maximum size for the Extended Attributes (xattr) is limited to 1024. This attribute is crucial in supporting Access Control Lists (ACL) and Alternate Data Streams (ADS) in SMB. Given its finite capacity, exercise caution when using ACLs and ADS on a filesystem using SELinux.
{% endhint %}

**cgroups**

* WEKA backends and clients that serve protocols must be deployed on a supported OS with **cgroupsV1**.
* **cgroupsV2** is supported on backends and clients, but not in deployments with protocol clusters.
{% endtab %}
{% endtabs %}

{% hint style="info" %}
As of version 4.3.2, RHEL 7.X and CentOS 7.X are no longer supported due to their end-of-life status. If you need assistance upgrading your operating system, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for guidance.
{% endhint %}

## WEKA installation directory

* **WEKA installation directory**:
  * The WEKA installation directory must be set to `/opt/weka`.
  * Use a direct path; symbolic links (symlinks) are not supported.
  * The `/opt/weka` directory is critical for proper WEKA operation. If it resides on shared storage, the storage must be highly available.
* **Boot drive minimum requirements**:
  * Capacity: NVMe SSD with 960 GB capacity
  * Durability: 1 DWPD (Drive Writes Per Day)
  * Write throughput: 1 GB/s
* **Boot drive considerations**:
  * Do not share the boot drive.
  * Do not mount using NFS.
  * Do not use a RAM drive remotely.
  * If two boot drives are available:
    * It is recommended to dedicate one boot drive for the OS and the other for the `/opt/weka` directory.
    * Do not use software RAID to have two boot drives.
* **Software required space**:
  * Ensure that at least 26 GB is available for the WEKA system installation.
  * Allocate an additional 10 GB per core used by WEKA.
* **Filesystem requirement**:
  * Set a separate filesystem on a separate partition for `/opt/weka`.

## Networking

Adhere to the following considerations when choosing the adapters:

* [**LACP**](#user-content-fn-4)[^4]**:** LACP is supported when bonding ports from dual-port Mellanox NICs into a single Mellanox device but is not compatible when using Virtual Functions (VFs).
* [**MTU**](#user-content-fn-5)[^5]\
  It is recommended to set the MTU to at least 4k on the NICs of WEKA cluster servers and the connected switches.
* [**Jumbo Frames**](#user-content-fn-6)[^6]\
  If any network connection, irrespective of whether it’s InfiniBand or Ethernet, on a given backend possess the capability to transmit frames exceeding 4 KB in size, it is mandatory for all network connections used directly by WEKA on that same backend to have the ability to transmit frames of at least 4 KB.
* [**IOMMU**](#user-content-fn-7)[^7] **support**\
  WEKA automatically detects and enables IOMMU for the server and PCI devices. Manual enablement is not required.

{% hint style="info" %}
When the Linux operating system is configured with `iommu=1`, IOMMU is enabled system-wide, and all PCI devices operate under IOMMU control. It is not possible to selectively exclude specific PCI devices from IOMMU when this mode is active.
{% endhint %}

* **Single IP**\
  Single IP (also known as shared networking) allows a single IP address to be assigned to the Physical Function (PF) and shared across multiple Virtual Functions (VFs). This means that a single IP can be shared by every WEKA process on that server, while still being available to the host operating system.
*   **SR-IOV VF**

    Single Root I/O Virtualization Virtual Functions enable direct hardware access for virtual machines, improving network performance by reducing CPU overhead.

{% hint style="info" %}
Shared networking configuration for NIC models:

* NVIDIA NICs: When implementing Shared Networking (Single IP), Virtual Functions (VFs) are not required.
* Broadcom NICs: VFs must be configured when deploying Shared Networking architecture.
{% endhint %}

*   **Mixed networks**

    A mixed network configuration refers to a setup where a WEKA cluster connects to both InfiniBand and Ethernet networks.

    Certain features and configurations are not supported in mixed network setups. Review the following limitations and supported settings:

    * **Non-supported features in mixed networks:**
      * RDMA
      * VLAN
      * IPv6
    * **Supported MTU settings in mixed networks:**
      * Ethernet (9000) + InfiniBand (4K)
    * **Non-supported MTU settings in mixed networks:**
      * Ethernet (1500) + InfiniBand (4K)
      * Ethernet (9000) + InfiniBand (2K)
*   **Routed network**

    Enables communication between subnets using Layer 3 routing, allowing WEKA clusters to span multiple network segments.
*   **HA (High Availability)**

    Ensures system uptime through redundant components and automatic failover.
*   **RX Interrupts**

    Receive interrupts that notify the CPU when network packets arrive, critical for optimizing network processing performance.
* **IP addressing for dataplane NICs**\
  Exclusively use static IP addressing. DHCP is not supported for dataplane NICs.
*   **WEKA peer connectivity requires NAT-free networking**

    WEKA requires visibility and connectivity to all peers, without interference from networking technologies like Network Address Translation (NAT).
* **PKEY (Partition Key)**\
  A feature specific to InfiniBand networks that enables the creation of isolated virtual networks (partitions) on a single physical fabric, controlling which endpoints can communicate.

**Related topics**

[networking-in-wekaio.md](../weka-system-overview/networking-in-wekaio.md "mention")

### Supported network adapters for backends and clients <a href="#networking-ethernet" id="networking-ethernet"></a>

The WEKA system is compatible with various network adapters for both backend servers and clients. The following table lists these adapters, detailing their protocol type and a breakdown of both supported and unsupported features. Use this information to verify hardware compatibility and understand the specific capabilities of each adapter within a WEKA environment.

<table><thead><tr><th width="193">Adapter</th><th width="126">Protocol</th><th width="252">Supported features</th><th>Unsupported features</th></tr></thead><tbody><tr><td>Amazon ENA</td><td>Ethernet</td><td>✅ SR-IOV VF</td><td><p>❌ Single IP</p><p>❌ HA</p><p>❌ Routed network</p><p>❌ LACP</p><p>❌ Mixed networks</p><p>❌ RX interrupts</p><p>❌ RDMA</p><p>❌ IOMMU</p></td></tr><tr><td>NVIDIA Mellanox CX-7 single-port</td><td>InfiniBand</td><td><p>✅ Single IP</p><p>✅ RX interrupts</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ PKEY</p><p>✅ IOMMU</p></td><td><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p><p>❌ Routed network</p></td></tr><tr><td>NVIDIA Mellanox CX-7 dual-port</td><td>InfiniBand</td><td><p>✅ Single IP</p><p>✅ RX interrupts</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ PKEY</p><p>✅ IOMMU</p></td><td><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p><p>❌ Routed network</p></td></tr><tr><td>NVIDIA Mellanox CX-7-ETH single-port</td><td>Ethernet</td><td><p>✅ Single IP</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ Routed network (ETH only)</p><p>✅ IOMMU</p></td><td><p>❌ LACP</p><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p><p>❌ RX interrupts</p></td></tr><tr><td>NVIDIA Mellanox CX-7-ETH dual-port</td><td>Ethernet</td><td><p>✅ LACP</p><p>✅ Single IP</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ Routed network (ETH only)</p><p>✅ IOMMU</p></td><td><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p><p>❌ RX interrupts</p></td></tr><tr><td>NVIDIA Mellanox CX-6 LX</td><td>Ethernet</td><td><p>✅ Single IP</p><p>✅ RDMA</p><p>✅ RX interrupts</p><p>✅ HA</p><p>✅ Routed network (ETH only)</p><p>✅ IOMMU</p></td><td><p>❌ LACP</p><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p></td></tr><tr><td>NVIDIA Mellanox CX-6 DX</td><td>Ethernet</td><td><p>✅ LACP</p><p>✅ Single IP</p><p>✅ RX interrupts</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ Routed network (ETH only)</p><p>✅ IOMMU</p></td><td><p>❌ Mixed networks</p><p>❌ SR-IOV VF</p></td></tr><tr><td>NVIDIA Mellanox CX-6</td><td>Ethernet InfiniBand</td><td><p>✅ Mixed networks</p><p>✅ Single IP</p><p>✅ RX interrupts</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ IOMMU</p></td><td><p>❌ Routed network</p><p>❌  LACP</p><p>❌ SR-IOV VF</p></td></tr><tr><td>NVIDIA Mellanox CX-5 EX</td><td>Ethernet InfiniBand</td><td><p>✅ Mixed networks</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ PKEY (IB only)</p><p>✅ IOMMU</p></td><td><p>❌ Single IP</p><p>❌ Routed network</p><p>❌ LACP</p><p>❌ SR-IOV VF</p><p>❌ RX interrupts</p></td></tr><tr><td>NVIDIA Mellanox CX-5 BF</td><td>Ethernet</td><td><p>✅ Mixed networks</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ IOMMU</p></td><td><p>❌ Single IP</p><p>❌ Routed network</p><p>❌ LACP</p><p>❌ SR-IOV VF</p><p>❌ RX interrupts</p></td></tr><tr><td>NVIDIA Mellanox CX-5</td><td>Ethernet InfiniBand</td><td><p>✅ Mixed networks</p><p>✅ RX interrupts</p><p>✅ RDMA</p><p>✅ HA</p><p>✅ Routed network (ETH only)</p><p>✅ PKEY (IB only)</p><p>✅ IOMMU</p></td><td><p>❌ Single IP</p><p>❌ LACP</p><p>❌ SR-IOV VF</p><p>❌ Routed network (IB)</p></td></tr><tr><td>VirtIO</td><td>Ethernet</td><td><p>✅ HA</p><p>✅ Routed network</p></td><td><p>❌ Single IP</p><p>❌ LACP</p><p>❌ Mixed networks</p><p>❌ RX interrupts</p><p>❌ SR-IOV VF</p><p>❌ IOMMU</p></td></tr></tbody></table>

### Supported network adapters for clients-only

The following network adapters support Ethernet and SR-IOV VF for clients only:

* Intel X540
* Intel X550-T1 (avoid using this adapter in a single client connected to multiple clusters)
* Intel X710
* Intel X710-DA2
* Intel XL710
* Intel XL710-Q2
* Intel XXV710
* Intel 82599ES
* Intel 82599
* Broadcom BCM957508-P2100G
* Broadcom BCM957608-P2200G

### Ethernet drivers and configurations

{% tabs %}
{% tab title="Ethernet drivers" %}
*   **Supported Mellanox OFED versions for the Ethernet NICs:**

    * 24.04-0.7.0.0
    * 23.10-0.5.5.0
    * 23.04-1.1.3.0
    * 5.9-0.5.6.0
    * 5.8-1.1.2.1 LTS
    * 5.8-3.0.7.0
    * 5.7-1.0.2.0
    * 5.6-2.0.9.0
    * 5.6-1.0.3.3
    * 5.4-3.5.8.0 LTS
    * 5.4-3.4.0.0 LTS
    * 5.1-2.6.2.0
    * 5.1-2.5.8.0

    **Note:** Subsequent OFED minor versions are expected to be compatible with Nvidia hardware due to Nvidia's commitment to backwards compatibility.
* **Supported ENA drivers:**
  * 1.0.2 - 2.0.2
  * A current driver from an official OS repository is recommended
* **Supported ixgbevf drivers:**
  * 3.2.2 - 4.1.2
  * A current driver from an official OS repository is recommended
* **Supported Broadcom drivers**:
  * 228: Minimum required for 100/200 Gbps 57508 NIC
  * 231: Minimum required for 200/400 Gbps 57608 NIC
{% endtab %}

{% tab title="Ethernet configurations" %}
* **Ethernet speeds:**
  * 400 GbE / 200 GbE / 100 GbE / 50GbE / 40 GbE / 25 GbE / 10 GbE.
* **NICs bonding:**
  * Supports bonding dual ports on the same NVIDIA Mellanox NIC using mode 4 (LACP) to enhance redundancy and performance.
* **IEEE 802.1Q VLAN encapsulation:**
  * Supports VLAN tagging with a single VLAN tag on NVIDIA Mellanox NICs.
* **VXLAN:**
  * Virtual Extensible LANs are not supported.
* **DPDK backends and clients using NICs supporting shared networking (single IP):**
  * Require one IP address per client for both management and data plane.
  * SR-IOV enabled is not required.
* **DPDK backends clients using NICs supporting non-shared networking:**
  * IP address for management: One per NIC (configured before WEKA installation).
  * IP address for data plane: One per [WEKA core](bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (applied during cluster initialization).
  * [Virtual Functions](https://en.wikipedia.org/wiki/Network_function_virtualization) (VFs):
    * Ensure the device supports a maximum number of VFs greater than the number of physical cores on the server.
    * Set the number of VFs to match the cores you intend to dedicate to WEKA.
    * Note that some BIOS configurations may be necessary.
  * SR-IOV: Enabled in BIOS.
* **UDP clients:**
  * Use a single IP address for all purposes.

{% hint style="info" %}
When assigning a network device to the WEKA system, no other application can create VFs on that device.
{% endhint %}
{% endtab %}
{% endtabs %}

### InfiniBand drivers and configurations <a href="#networking-infiniband" id="networking-infiniband"></a>

{% tabs %}
{% tab title="InfiniBand drivers" %}
WEKA supports the following Nvidia major OFED versions for the InfiniBand adapters:

* 24.04
* 23.10
* 23.04
* 5.9
* 5.8
* 5.7
* 5.6
* 5.4
* 5.1

{% hint style="info" %}
Subsequent OFED minor versions are expected to be compatible with Nvidia hardware due to Nvidia's commitment to backwards compatibility.
{% endhint %}
{% endtab %}

{% tab title="InfiniBand configurations" %}
WEKA supports the following InfiniBand configurations:

* InfiniBand speeds: Determined by the InfiniBand adapter supported speeds (FDR / EDR / HDR / NDR).
* Subnet manager: Configured to 4092.
* One WEKA system IP address for management and data plane.
* PKEYs: One partition key is supported by WEKA.
* Redundant InfiniBand ports can be used for both HA and higher bandwidth.

{% hint style="info" %}
If it is necessary to change PKEYs, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}
{% endtab %}
{% endtabs %}

### Required ports

When configuring firewall ingress and egress rules the following access must be allowed.

{% hint style="info" %}
Right-scroll the table to view all columns.
{% endhint %}

<table><thead><tr><th width="211">Purpose</th><th width="124">Source</th><th width="135">Target</th><th width="228">Target Ports</th><th width="135">Protocol</th><th width="352">Comments</th></tr></thead><tbody><tr><td>WEKA server traffic for bare-metal deployments</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td>14000-14100 (drives)<br>14200-14300 (frontend)<br>14300-14400 (compute)</td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default for the Resources Generator for the first three containers. You can customize the ports.</td></tr><tr><td>WEKA client traffic</td><td>Client host IPs</td><td>All WEKA backend IPs</td><td>14000-14100 (drives)<br>14300-14400 (compute)</td><td>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA backend to client traffic</td><td>All WEKA backend IPs</td><td>Client host IPs</td><td>14000-14100 (frontend)</td><td>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA SSH management traffic</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td>22</td><td>TCP</td><td></td></tr><tr><td>WEKA server traffic for cloud deployments</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td><p>14000-14100 (drives)</p><p>15000-15100 (compute)</p><p>16000-16100 (frontend)</p></td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA client traffic (on cloud)</td><td>Client host IPs</td><td>All WEKA backend IPs</td><td><p>14000-14100 (drives)</p><p>15000-15100 (compute)</p></td><td>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA backend to client traffic (on cloud)</td><td>All WEKA backend IPs</td><td>Client host IPs</td><td>14000-14100 (frontend)</td><td>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA GUI access</td><td>Admin workstation IPs</td><td>All WEKA management IPs</td><td>14000</td><td>TCP</td><td>User web browser IP</td></tr><tr><td>NFS</td><td>NFS client IPs</td><td>WEKA NFS backend IPs</td><td>2049<br>&#x3C;mountd port></td><td>TCP and UDP<br>TCP and UDP</td><td>You can set the <code>mountd</code> port using the command: <code>weka nfs global-config set --mountd-port</code></td></tr><tr><td>NFSv3 (used for locking)</td><td>NFS client IPs</td><td>WEKA NFS backend IPs</td><td>46999 (status monitor)<br>47000 (lock manager)</td><td>TCP and UDP</td><td></td></tr><tr><td>SMB/SMB-W</td><td>SMB client IPs</td><td>WEKA SMB backend IPs</td><td>139<br>445</td><td>TCP<br>TCP</td><td></td></tr><tr><td>SMB-W</td><td>All WEKA SMB-W backend IPs</td><td>All WEKA SMB-W backend IPs</td><td>2224</td><td>TCP</td><td>This port is required for internal clustering processes.</td></tr><tr><td>SMB/SMB-W</td><td>WEKA SMB backend IPs</td><td>All Domain Controllers for the selected Active Directory Domain</td><td><p>88</p><p>389<br>464<br>636<br>3268<br>3269</p></td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are required for SMB/SMB-W to use Active Directory as the identity source. Furthermore, every Domain Controller within the selected AD domain must be accessible from the WEKA SMB servers.</td></tr><tr><td>SMB/SMB-W</td><td>WEKA SMB backend IPs</td><td>DNS servers</td><td>53</td><td>TCP and UDP</td><td></td></tr><tr><td>S3</td><td>S3 client IPs</td><td>WEKA S3 backend IPs</td><td>9000</td><td>TCP</td><td>This port is the default. You can customize the port.</td></tr><tr><td>wekatester</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td>8501<br>9090</td><td>TCP<br>TCP</td><td>Port 8501 is used by wekanetperf.</td></tr><tr><td>WEKA Management Station</td><td>User web browser IP</td><td>WEKA Management Station IP</td><td><p>80 &#x3C;LWH></p><p>443 &#x3C;LWH></p><p>3000 &#x3C;mon></p><p>7860 &#x3C;admin UI></p><p>8760 &#x3C;deploy></p><p>8090 &#x3C;snap></p><p>8501 &#x3C;mgmt><br>9090 &#x3C;mgmt></p><p>9091 &#x3C;mon><br>9093 &#x3C;alerts></p></td><td><p>HTTP</p><p>HTTPS</p><p>TCP</p><p>TCP</p><p>TCP</p><p>TCP<br>TCP</p><p>TCP<br>TCP</p></td><td></td></tr><tr><td>Cloud WEKA Home, Local WEKA Home</td><td>All WEKA backend IPs</td><td>Cloud WEKA Home or Local WEKA Home</td><td>80<br>443</td><td>HTTP<br>HTTPS</td><td><p>Open according to the directions in the deployment scenario:<br>- WEKA server IPs to CWH or LWH.<br>- LWH to CWH (if forwarding data from LWH to CWH)<br>Endpoint URLs:</p><ul><li><code>api.home.weka.io</code></li><li><code>get.weka.io</code></li></ul></td></tr><tr><td>Troubleshooting by the Customer Success Team (CST)</td><td>All WEKA backend IPs</td><td>CST remote access</td><td>4000<br>4001</td><td>TCP<br>TCP</td><td></td></tr><tr><td>Traces remote viewer</td><td>All WEKA backend IPs</td><td>CST remote access</td><td>443</td><td>TCP</td><td></td></tr><tr><td>KMS: Hashicorp Vault</td><td>All WEKA backend IPs</td><td>Hashicorp Vault server</td><td>8200<br>8201</td><td>TCP<br>TCP</td><td>Default vault ports: 8200 is configurable for client requests, while 8201 (base_port+1) handles internal cluster communication.</td></tr><tr><td>KMS: KMIP</td><td>All WEKA backend IPs</td><td>KMIP server</td><td>5696</td><td>TCP</td><td>The default KMIP port, 5696, is configurable. Per the KMIP specification, servers must use this port when operating with the <a data-footnote-ref href="#user-content-fn-8">TTLV</a> encoding format.</td></tr></tbody></table>

## HA

See [#high-availability](../weka-system-overview/networking-in-wekaio.md#high-availability "mention")

## SSD requirements

Review the requirements for SSDs used in a WEKA cluster.

* SSDs must support Power Loss Protection (PLP).
* Dedicate the entire SSD for WEKA system storage. Partitioning the drive is not supported.
* Use SSDs with a capacity of up to 30 TB.
* Maintain a capacity ratio of 8:1 or less between the smallest and largest SSDs in the cluster.
* Maintain a ratio of 8000:1 or less between the total SSD capacity and the total RAM of the cluster.

{% hint style="info" %}
To get the best performance, ensure [TRIM](https://en.wikipedia.org/wiki/Trim_\(computing\)) is supported by the device and enabled in the operating system.
{% endhint %}

## Object store

* API must be S3 compatible:
  * GET
    * Including byte-range support with expected performance gain when fetching partial objects
  * PUT
    * Supports any byte size of up to 65 MiB
  * DELETE
* Data consistency: [Amazon S3 consistency model](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):
  * GET after a single PUT is strongly consistent
  * Multiple PUTs are eventually consistent

WEKA integrates with object stores for two primary purposes: extending the filesystem capacity with a lower-cost tier and creating remote backups for disaster recovery. Support for these functions varies by the object store provider and its specific configuration.

* **Tiering:** Moves inactive data from the high-performance SSD tier to a designated object store bucket. This frees up SSD capacity while keeping the data accessible within the unified filesystem namespace. Tiering requires high performance and consistency from the object store.
* **Snap-to-Object:** Sends immutable snapshots of a filesystem to a remote object store. This provides an efficient and secure method for remote backup and disaster recovery.

### Certified object stores and support status

The following table details the support status for certified object store solutions.

<table><thead><tr><th width="187.92578125">Object Store</th><th width="186.94921875">Storage Class / Version</th><th>Supportability notes</th></tr></thead><tbody><tr><td>Amazon S3</td><td><p>S3 Standard</p><p>S3 Intelligent-Tiering</p></td><td>Tiering and snap-to-object</td></tr><tr><td></td><td>S3 Standard-IA<br>S3 One Zone-IA<br>S3 Glacier Instant Retrieval</td><td>Snap-to-object supported; tiering not recommended (slow retrieval, storage period, access costs). Best for backups/DR. Use Intelligent-Tiering if unsure.</td></tr><tr><td>Azure Blob Storage</td><td></td><td>Tiering and snap-to-object</td></tr><tr><td>Cloudian HyperStore</td><td>7.3</td><td>Tiering and snap-to-object</td></tr><tr><td>CoreWeave AI Object Storage (CAIOS)</td><td></td><td>Snap-to-object; tiering not supported</td></tr><tr><td>Google Cloud Storage (GCS)</td><td></td><td>Tiering and snap-to-object</td></tr><tr><td>Dell EMC ECS</td><td>3.5</td><td>Tiering and snap-to-object</td></tr><tr><td>Dell PowerScale S3</td><td>9.8.0.0</td><td>Tiering and snap-to-object (all-flash models only)</td></tr><tr><td>HCP Classic</td><td>9.2+ (versioned buckets)</td><td>Tiering and snap-to-object</td></tr><tr><td>HCP for Cloud-Scale</td><td>2.x</td><td>Tiering and snap-to-object</td></tr><tr><td>IBM Cloud Object Storage</td><td>3.14.7</td><td>Tiering and snap-to-object</td></tr><tr><td>Lenovo MagnaScale</td><td>3</td><td>Tiering and snap-to-object</td></tr><tr><td>Quantum ActiveScale</td><td>5.5.1</td><td>Tiering and snap-to-object</td></tr><tr><td>Red Hat Ceph Storage</td><td>5</td><td>Tiering and snap-to-object</td></tr><tr><td>Scality Artesca</td><td>1.5.2</td><td>Tiering and snap-to-object</td></tr><tr><td>Scality RING S3 Connector</td><td>8.5</td><td>Tiering and snap-to-object</td></tr><tr><td>Scality RING WEKA Connector</td><td>9.5</td><td>Tiering and snap-to-object</td></tr><tr><td>SwiftStack</td><td>6.3</td><td>Tiering and snap-to-object</td></tr><tr><td>WEKA S3</td><td></td><td>Tiering and snap-to-object</td></tr></tbody></table>

### S3-Compatible object store requirements

To ensure stability, performance, and data integrity, any S3-compatible object store used with WEKA must meet the following minimum requirements.

**API requirements**

The object store must provide a fully S3-compatible API that supports the following operations:

* **GET**: Must include support for byte-range requests to allow for efficient fetching of partial objects.
* **PUT**: Must support uploads of any object size up to 65 MiB.
* **DELETE**: Must support standard object deletion.

**Data consistency requirements**

The object store must adhere to the [Amazon S3 data consistency model](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):

* **Strong read-after-write consistency:** A `GET` request for an object that occurs after a successful `PUT` request has created that object must immediately return the new object's data.
* **Eventual consistency:** `PUT` requests that overwrite existing objects, or `DELETE` requests, are eventually consistent. This means that a subsequent `GET` request might temporarily return the older version of the data before the update or deletion has fully propagated across the system.

## Virtual Machines

This section outlines the use of virtual machines (VMs) with WEKA, covering backends, clients, VMware platforms, and cloud environments. While VMs can be used in certain configurations, there are specific limitations and best practices to follow.

### Backends

Virtual machines may be used as backends for internal training purposes only and are not recommended for production environments.

WEKA provides best-effort support for backends deployed on virtual machines, but full support is not guaranteed. Additionally, WEKA does not guarantee support for components or configurations outside of our documented and supported cloud environments, and performance may vary.

### Clients

Virtual Machines (VMs) can be used as clients. Ensure the following prerequisites are met for each client type:

* **UDP clients**:
  * Reserve CPU resources and dedicate a core to the client to prevent CPU starvation of the WEKA process.
  * Ensure the root filesystem supports a 3K IOPS load for the WEKA client.
* **DPDK clients**:
  * Meet all the requirements for UDP clients.
  * Additionally, verify that the virtual platform (hypervisor, NICs, CPUs, and their respective versions) fully supports DPDK and the required virtual network drivers.

### **VMware platform (**&#x63;lient only)

When using **vmxnet3** devices, do not enable the SR-IOV feature, because it disables the vMotion functionality. Each frontend process requires a dedicated **vmxnet3** device and IP address, with an additional device and IP for each client VM to support the management process.

Core dedication is required when using **vmxnet3** devices.

### VMs and instances on cloud environments

Refer to the cloud deployment sections for the most up-to-date list of supported virtual machines and instances in various cloud environments.

**Related topics**

AWS: [supported-ec2-instance-types.md](aws/supported-ec2-instance-types.md "mention")

Azure: [supported-virtual-machine-types.md](weka-installation-on-azure/supported-virtual-machine-types.md "mention")

GCP: [supported-machine-types-and-storage.md](weka-installation-on-gcp/supported-machine-types-and-storage.md "mention")

\
**Related information**

For additional information and how-to articles, search the WEKA Knowledge Base in the [WEKA support portal](http://support.weka.io) or contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).

## KMS

{% include "../.gitbook/includes/supported-kms-types.md" %}

[^1]: **AES (Advanced Encryption Standard)** in BIOS settings refers to hardware acceleration for AES encryption. Enabled by default, it speeds up encryption tasks using AES-NI. Disabling it may affect performance in encryption-heavy applications.

[^2]: **Secure Boot** is a BIOS/UEFI feature that ensures only trusted software is loaded during startup. If Secure Boot is disabled, the system allows any software to run.

[^3]: **AVX2 (Advanced Vector Extensions 2)** is a CPU instruction set that enhances performance on floating-point and integer operations. It is enabled by default on supported hardware, but can be disabled in virtual machines, depending on the hypervisor configuration. Ensure your VM settings allow AVX2.

[^4]: LACP stands for "Link Aggregation Control Protocol." It is a networking protocol that enables the bundling of multiple network connections in parallel to increase bandwidth and provide redundancy.

[^5]: MTU (Maximum Transmission Unit) represents the maximum size of a data packet that can be transmitted over a network.

[^6]: Jumbo Frames refer to network frames that exceed the standard Maximum Transmission Unit (MTU) size, allowing for larger data packets to be transmitted over a network.

[^7]: The IOMMU (Input/Output Memory Management Unit) is a hardware component that manages and controls data transfers between devices (like graphics cards) and a computer's main memory, enhancing system security and performance.

[^8]: **TTLV (Tag-Length-Value)** is a binary encoding format used in KMIP for structured and efficient messaging between a KMS and its clients. It consists of a tag (data type), length (size), and value (data).
