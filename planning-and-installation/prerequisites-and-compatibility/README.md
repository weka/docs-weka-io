---
description: >-
  This page describes the prerequisites and compatibility for the installation
  of the WEKA system.
---

# Prerequisites and compatibility

{% hint style="warning" %}
**Important:** The versions mentioned on the prerequisites and compatibility page apply to the WEKA system's **latest minor version** (4.3.**X**). For information on new features and supported prerequisites released with each minor version, refer to the relevant release notes available at [get.weka.io](https://get.weka.io/).

Check the release notes for details about any updates or changes accompanying the latest releases.
{% endhint %}

{% hint style="info" %}
In certain instances, WEKA collaborates with Strategic Server Partners to conduct platform qualifications alongside complementary components. If you have any inquiries, contact your designated WEKA representative.
{% endhint %}

## CPU

<table><thead><tr><th width="338">CPU family/architecture</th><th width="210">Supported on backends</th><th>Supported on clients</th></tr></thead><tbody><tr><td>2013 Intel® Core™ processor family and later</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Dual-socket</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Dual-socket</td></tr><tr><td>AMD EPYC™ processor families 2nd (Rome), 3rd (Milan-X), and 4th (Genoa) Generations</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span><br>Single-socket</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span> <br>Single-socket and dual-socket</td></tr></tbody></table>

{% hint style="info" %}
Ensure the BIOS settings meet the following requirements:

* AES must be enabled.
* Secure Boot must be disabled.
{% endhint %}

## Memory

* Sufficient memory to support the WEKA system needs as described in [memory requirements](../bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
* More memory support for the OS kernel or any other application.

## Operating system

{% hint style="info" %}
WEKA will support upcoming releases of the operating systems in the lists within one quarter (three months) of their respective General Availability (GA) dates.
{% endhint %}

{% tabs %}
{% tab title="Backends" %}
* **RHEL:**
  * 9.2, 9.1, 9.0
  * 8.8, 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Rocky Linux:**
  * 9.2, 9.1, 9.0
  * 8.9, 8.8, 8.7, 8.6
* **CentOS:**
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Ubuntu:**
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
* **RHEL:**
  * 9.2, 9.1, 9.0
  * 8.8, 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Rocky Linux:**
  * 9.2, 9.1, 9.0
  * 8.9, 8.8, 8.7, 8.6
* **CentOS:**
  * 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Ubuntu:**
  * 22.04
  * 20.04
  * 18.04
* **Amazon Linux:**
  * AMI 2018.03
  * AMI 2017.09
* **Amazon Linux 2 LTS** (formerly Amazon Linux 2 LTS 17.12)
  * Latest update package that was tested: 5.10.176-157.645.amzn2.x86\_64
* **SLES:**
  * 15 SP4
  * 15 SP2
  * 12 SP5
{% endtab %}

{% tab title="Kernel" %}
The following kernel versions are supported:

* 6.0 to 6.2
* 5.3 to 5.19
* 4.4.0-1106 to 4.19
* 3.10

{% hint style="info" %}
* Kernels 5.15 and higher are not supported with Amazon Linux operating systems.
* It is recommended to turn off auto kernel updates, so it will not get upgraded to an unsupported version.
* Confirm that both the kernel version and the operating system version are listed as supported, as these are distinct components with their own compatibility considerations.
* For clarity, the range of supported versions is inclusive.
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
* To set the SELinux security context for files,  use the `-o acl` in the mount command, and define the `wekafs` to use extended attributes in the SELinux policy configuration (`fs_use_xattr`).
* The maximum size for the Extended Attributes (xattr) is limited to 1024. This attribute is crucial in supporting Access Control Lists (ACL) and Alternate Data Streams (ADS) in SMB. Given its finite capacity, exercise caution when using ACLs and ADS on a filesystem using SELinux.
{% endhint %}

#### Cgroups

* WEKA backends and clients that serve protocols must be deployed on a supported OS with **CgroupsV1**.
* **CgroupsV2** is supported on backends and clients, but not in deployments with protocol clusters.
{% endtab %}
{% endtabs %}

## WEKA installation directory

* **WEKA installation directory**: `/opt/weka`
  * `/opt/weka` must be a direct path. Do not use a symbolic link (symlink).
* **Boot drive minimum requirements**:
  * Capacity: NVMe SSD with 960 GB capacity
  * Durability: 1 DWPD (Drive Writes Per Day)
  * Write throughput: 1 GB/s
* **Boot drive considerations**:
  * Do not share the boot drive.
  * Do not mount using NFS.
  * Do not use a RAM drive remotely.
  * If two boot drives are available:
    * It is recommended to dedicate one boot drive for the OS and the other for the /opt/weka directory.
    * Do not use software RAID to have two boot drives.
* **Software required space**:
  * Ensure that at least 26 GB is available for the WEKA system installation.
  * Allocate an additional 10 GB per core used by WEKA.
* **Filesystem requirement**:
  * Set a separate filesystem on a separate partition for `/opt/weka`.

## Networking

Adhere to the following considerations when choosing the adapters:

* [**LACP**](#user-content-fn-1)[^1]**:**  LACP is supported when connecting ports on a single Mellanox NIC but is not compatible when using Virtual Functions (VFs).
* **Intel E810:**
  * Only supported on RHEL 8.6 and Rocky Linux 8.6. For other operating systems, consult with the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
  * The ice Linux Base Driver version 1.9.11 and firmware version 4.0.0 are required.
* [**MTU**](#user-content-fn-2)[^2]**:** It is recommended to set the MTU to at least 4k on the NICs of WEKA cluster servers and the connected switches.
* [**Jumbo Frames**](#user-content-fn-3)[^3]**:** If any network connection, irrespective of whether it’s InfiniBand or Ethernet, on a given backend possess the capability to transmit frames exceeding 4 KB in size, it is mandatory for all network connections used directly by WEKA on that same backend to have the ability to transmit frames of at least 4 KB.
* [**IOMMU**](#user-content-fn-4)[^4] **support:** WEKA automatically detects and enable IOMMU for the server and PCI devices. Manual enablement is not required.
* **Mixed networks:** This term denotes a configuration in which a WEKA cluster is interfaced with both InfiniBand and Ethernet networks. In the event of dual connections, the system gives precedence to the InfiniBand links for managing WEKA traffic, resorting to the Ethernet links only when complications occur with the InfiniBand network. It’s important to note that in a mixed network cluster, the activation of RDMA (Remote Direct Memory Access) is not possible.
* **IP Addressing for dataplane NICs:** Exclusively use static IP addressing. DHCP is not supported for dataplane NICs.

### Supported network adapters <a href="#networking-ethernet" id="networking-ethernet"></a>

The following table provides the supported network adapters along with their supported features for backends and clients, and clients-only.

For more information about the supported features, see [networking-in-wekaio.md](../../weka-system-overview/networking-in-wekaio.md "mention").

#### Supported network adapters for backends and clients

<table><thead><tr><th>Adapter</th><th width="126">Protocol</th><th>Supported features</th></tr></thead><tbody><tr><td>Amazon ENA</td><td>Ethernet</td><td><ul><li>SRIOV VF</li></ul></td></tr><tr><td><p>Broadcom BCM957508-P2100G</p><ul><li>Dual-port (2x100Gb/s)</li><li><a data-footnote-ref href="#user-content-fn-5">Single-port (1x200Gb/s</a></li></ul></td><td>Ethernet</td><td><ul><li>Shared IP</li><li>SRIOV VF</li><li>HA</li><li>Routed network</li></ul><p>See <a data-mention href="broadcom-adapter-setup-for-weka-system.md">broadcom-adapter-setup-for-weka-system.md</a></p></td></tr><tr><td><p></p><p>Broadcom BCM957608-P2200G</p><ul><li>Dual-port (2x200Gb/s)</li><li><a data-footnote-ref href="#user-content-fn-6">Single-port (1x400Gb/s</a></li></ul></td><td>Ethernet</td><td><p></p><ul><li>Shared IP</li><li>SRIOV VF</li><li>HA</li><li>Routed network</li></ul><p>See <a data-mention href="broadcom-adapter-setup-for-weka-system.md">broadcom-adapter-setup-for-weka-system.md</a></p></td></tr><tr><td>Intel E810 2CQDA2</td><td>Ethernet</td><td><ul><li>Shared IP</li><li>HA</li><li>Routed network</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-7 single-port</td><td>InfiniBand</td><td><ul><li>Shared IP</li><li>rx interrupts</li><li>RDMA</li><li>HA</li><li>PKEY</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-7 dual-port</td><td>InfiniBand</td><td><ul><li>LACP</li><li>Shared IP</li><li>rx interrupts</li><li>RDMA</li><li>HA</li><li>PKEY</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-7-ETH single-port</td><td>Ethernet</td><td><ul><li>LACP</li><li>Shared IP</li><li>HA</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-7-ETH dual-port</td><td>Ethernet</td><td><ul><li>LACP</li><li>Shared IP</li><li>HA</li><li>Routed network  (ETH only)</li><li> IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-6 LX</td><td>Ethernet</td><td><ul><li>LACP</li><li>Shared IP</li><li>rx interrupts</li><li>HA</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-6 DX</td><td>Ethernet</td><td><ul><li>LACP</li><li>Shared IP</li><li>rx interrupts</li><li>HA</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-6</td><td>Ethernet InfiniBand</td><td><ul><li>Mixed networks</li><li>LACP</li><li>Shared IP</li><li>rx interrupts</li><li>RDMA</li><li>HA</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-5 EX</td><td>Ethernet InfiniBand</td><td><ul><li>Mixed networks</li><li>LACP</li><li>RDMA (IB only)</li><li> HA</li><li>PKEY (IB only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-5 BF</td><td>Ethernet</td><td><ul><li>Mixed networks</li><li>LACP</li><li> HA</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-5</td><td>Ethernet InfiniBand</td><td><ul><li>Mixed networks</li><li>LACP</li><li>rx interrupts</li><li>RDMA (IB only)</li><li>HA</li><li>PKEY (IB only)</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-4 LX</td><td>Ethernet InfiniBand</td><td><ul><li>Mixed networks</li><li>LACP</li><li>rx interrupts</li><li>HA</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>NVIDIA Mellanox CX-4</td><td>Ethernet InfiniBand</td><td><ul><li>Mixed networks</li><li>LACP</li><li>rx interrupts</li><li>HA</li><li>Routed network  (ETH only)</li><li>IOMMU</li></ul></td></tr><tr><td>VirtIO</td><td>Ethernet</td><td><ul><li>HA</li><li>Routed network</li></ul></td></tr></tbody></table>

#### Supported network adapters for clients-only

The following network adapters support Ethernet and SRIOV VF for clients only:

* Intel X540
* Intel X550-T1 (avoid using this adapter in a single client connected to multiple clusters)
* Intel X710
* Intel X710-DA2
* Intel XL710
* Intel XL710-Q2
* Intel XXV710
* Intel 82599ES
* Intel 82599

### Ethernet drivers and configurations

{% tabs %}
{% tab title="Ethernet drivers" %}
*   **Supported Mellanox OFED versions for the Ethernet NICs:**

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
* **Supported Intel 40 drivers:**
  * 3.0.1-k - 4.1.0
  * A current driver from an official OS repository is recommended
* **Supported ice drivers:**
  * 1.9.11
{% endtab %}

{% tab title="Ethernet configurations" %}
* **Ethernet speeds:**
  * 200 GbE / 100 GbE / 50GbE / 40 GbE / 25 GbE / 10 GbE.
* **NICs bonding:**
  * Can bond dual ports on the same NIC (modes 1 and 4). Only supported on NVIDIA Mellanox NICs.
* **IEEE 802.1Q VLAN encapsulation:**
  * Tagged VLANs are not supported.
* **VXLAN:**
  * Virtual Extensible LANs are not supported.
* **DPDK backends and clients using NICs supporting shared IP:**
  * Require one IP address per client for both management and data plane.
  * SR-IOV enabled is not required.
* **DPDK backends clients using NICs supporting non-shared IP:**
  * IP address for management: One per NIC (configured before WEKA installation).
  * IP address for data plane: One per [WEKA core](../bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (applied during cluster initialization).
  * [Virtual Functions](https://en.wikipedia.org/wiki/Network\_function\_virtualization) (VFs):
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
WEKA supports the following Mellanox OFED versions for the InfiniBand adapters:

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
{% endtab %}

{% tab title="InfiniBand configurations" %}
WEKA supports the following InfiniBand configurations:

* InfiniBand speeds: Determined by the InfiniBand adapter supported speeds (FDR / EDR / HDR / NDR).
* Subnet manager: Configured to 4092.
* One WEKA system IP address for management and data plane.
* PKEYs: One partition key is supported by WEKA.
* Redundant InfiniBand ports can be used for both HA and higher bandwidth.

{% hint style="info" %}
If it is necessary to change PKEYs, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}
{% endtab %}
{% endtabs %}

### Required ports

When configuring firewall ingress and egress rules the following access must be allowed.

{% hint style="info" %}
Right-scroll the table to view all columns.
{% endhint %}

<table><thead><tr><th width="211">Purpose</th><th width="124">Source</th><th width="135">Target</th><th width="228">Target Ports</th><th width="135">Protocol</th><th width="352">Comments</th></tr></thead><tbody><tr><td>WEKA server traffic for bare-metal deployments</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td>14000-14100 (drives)<br>14200-14300 (frontend)<br>14300-14400 (compute)</td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default for the Resources Generator for the first three containers. You can customize the ports.</td></tr><tr><td>WEKA client traffic</td><td>Client host IPs </td><td>All WEKA backend IPs</td><td>14000-14100 (drives)<br>14300-14400 (compute)</td><td>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA backend to client traffic</td><td>All WEKA backend IPs</td><td>Client host IPs </td><td>14000-14100 (frontend)</td><td>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA SSH management traffic</td><td>All WEKA backend IPs </td><td>All WEKA backend IPs</td><td>22</td><td>TCP</td><td></td></tr><tr><td>WEKA server traffic for cloud deployments</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td><p>14000-14100 (drives)</p><p>15000-15100 (compute)</p><p>16000-16100 (frontend)</p></td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA client traffic (on cloud)</td><td>Client host IPs </td><td>All WEKA backend IPs</td><td><p>14000-14100 (drives)</p><p>15000-15100 (compute)</p></td><td>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA backend to client traffic (on cloud)</td><td>All WEKA backend IPs</td><td>Client host IPs </td><td>14000-14100 (frontend)</td><td>TCP and UDP</td><td>These ports are the default. You can customize the ports.</td></tr><tr><td>WEKA GUI access </td><td></td><td>All WEKA management IPs</td><td>14000</td><td>TCP</td><td>User web browser IP</td></tr><tr><td>NFS</td><td>NFS client IPs</td><td>WEKA NFS backend  IPs</td><td>2049<br>&#x3C;mountd port></td><td>TCP and UDP<br>TCP and UDP</td><td>You can set the <code>mountd</code> port using the command: <code>weka nfs global-config set --mountd-port</code></td></tr><tr><td>SMB/SMB-W</td><td>SMB client IPs</td><td>WEKA SMB backend IPs</td><td>139<br>445</td><td>TCP<br>TCP</td><td></td></tr><tr><td>SMB-W</td><td>WEKA SMB backend IPs</td><td></td><td>2224</td><td>TCP</td><td>This port is required for internal clustering processes.</td></tr><tr><td>SMB/SMB-W</td><td>WEKA SMB backend IPs</td><td>All Domain Controllers for the selected Active Directory Domain</td><td><p>88</p><p>389<br>464<br>636<br>3268<br>3269</p></td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are required for SMB/SMB-W to use Active Directory as the identity source. Furthermore, every Domain Controller within the selected AD domain must be accessible from the WEKA SMB servers.</td></tr><tr><td>SMB/SMB-W</td><td>WEKA SMB backend IPs</td><td>DNS servers</td><td>53</td><td>TCP and UDP</td><td></td></tr><tr><td>S3</td><td>S3 client IPs</td><td>WEKA S3 backend IPs</td><td>9000</td><td>TCP</td><td>This port is the default. You can customize the port.</td></tr><tr><td>wekatester</td><td>All WEKA backend IPs</td><td>All WEKA backend IPs</td><td>8501<br>9090</td><td>TCP<br>TCP</td><td>Port 8501 is used by wekanetperf.</td></tr><tr><td>WEKA Management Station</td><td>User web browser IP</td><td>WEKA Management Station IP</td><td><p>80  &#x3C;LWH></p><p>443 &#x3C;LWH></p><p>3000 &#x3C;mon></p><p>8760 &#x3C;deploy></p><p>8090 &#x3C;snap></p><p>8501 &#x3C;mgmt><br>9090 &#x3C;mgmt></p><p>9091 &#x3C;mon><br>9093 &#x3C;alerts></p></td><td><p>HTTP</p><p>HTTPS</p><p>TCP</p><p>TCP</p><p>TCP</p><p>TCP<br>TCP</p><p>TCP<br>TCP</p></td><td></td></tr><tr><td>Cloud WEKA Home, Local WEKA Home</td><td>All WEKA backend IPs </td><td>Cloud WEKA Home or Local WEKA Home</td><td>80<br>443</td><td>HTTP<br>HTTPS</td><td>Open according to the directions in the deployment scenario:<br>- WEKA server IPs to CWH or LWH.<br>- LWH to CWH (if forwarding data from LWH to CWH)</td></tr><tr><td>Troubleshooting by the Customer Success Team (CST)</td><td>All WEKA backend IPs </td><td>CST remote access</td><td>4000<br>4001</td><td>TCP<br>TCP</td><td></td></tr></tbody></table>

## HA

See [#high-availability-ha](../../weka-system-overview/networking-in-wekaio.md#high-availability-ha "mention").

## SSDs

* The SSDs must support PLP (Power Loss Protection).
* WEKA system storage must be dedicated, and partitioning is not supported.
* The supported drive capacity is up to 30 TB.
* IOMMU mode is not supported for SSD drives.\
  If you need to configure IOMMU on WEKA cluster servers, for instance, due to specific applications when running the WEKA cluster in converged mode, contact our [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team) for assistance.
* The ratio between the cluster's smallest and the largest SSD capacity must not exceed 8:1.

{% hint style="info" %}
To get the best performance, ensure [TRIM](https://en.wikipedia.org/wiki/Trim\_\(computing\)) is supported by the device and enabled in the operating system.
{% endhint %}

## Object store

* API must be S3 compatible:
  * GET
    * Including byte-range support with expected performance gain when fetching partial objects
  * PUT
    * Supports any byte size of up to 65 MiB
  * DELETE
* Data Consistency: [Amazon S3 consistency model](https://docs.aws.amazon.com/AmazonS3/latest/dev/Introduction.html#ConsistencyModel):
  * GET after a single PUT is strongly consistent
  * Multiple PUTs are eventually consistent

### Certified object stores

* Amazon S3
  * S3 Standard
  * S3 Intelligent-Tiering
  *   These storage classes are ideal for remote buckets where data is written once and accessed in critical situations, such as during disaster recovery:

      * S3 Standard-IA
      * S3 One Zone-IA
      * S3 Glacier Instant Retrieval

      Remember, retrieval times, minimum storage periods, and potential charges due to object compaction may apply. If unsure, use S3 Intelligent-Tiering.
* Azure Blob Storage
* Google Cloud Storage (GCS)
* Cloudian HyperStore (version 7.3 and higher)
* Dell EMC ECS (version 3.5 and higher)
* HCP Classic V9.2 and up (with versioned buckets only)
* HCP for Cloud-Scale V2.x
* IBM Cloud Object Storage System (version 3.14.7 and higher)
* Lenovo MagnaScale (version 3.0 and higher)
* Quantum ActiveScale (version 5.5.1 and higher)
* Red Hat Ceph Storage (version 5.0 and higher)
* Scality Ring (version 7.4.4.8 and higher)
* Scality Artesca (version 1.5.2 and higher)
* SwiftStack (version 6.30 and higher)

## Virtual Machines

Virtual Machines (VMs) can be used as **clients** only. Ensure the following prerequisites are met for the relevant client type:

{% tabs %}
{% tab title="UDP clients" %}
* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the WEKA process by reserving the CPU in the virtual platform and dedicating a core to the WEKA client.
* The root filesystem must handle a 3K IOPS load by the WEKA client.

\

{% endtab %}

{% tab title="DPDK clients" %}
* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the WEKA process by reserving the CPU in the virtual platform and dedicating a core to the WEKA client.
* The root filesystem must handle a 3K IOPS load by the WEKA client.
* The virtual platform interoperability, such as a hypervisor, NICs, CPUs, and different versions, must support DPDK and virtual network driver.
{% endtab %}
{% endtabs %}

<details>

<summary>Special note for a VMware platform</summary>

* If using `vmxnet3` devices, do not enable the SR-IOV feature (which prevents the `vMotion` feature). Each frontend process requires a `vmxnet3` device and IP, with an additional device and IP per client VM (for the management process).
* Using `vmxnet3` is only supported with core dedication.

</details>

For additional information and how-to articles, search the WEKA Knowledge Base in the [WEKA support portal](http://support.weka.io) or contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).

## KMS

* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) (version 1.1.5 up to 1.14.x)
* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html)-compliant KMS (protocol version 1.2 and higher)
  * The KMS must support encryption-as-a-service (KMIP encrypt/decrypt APIs)
  * KMIP certification has been conducted with Equinix SmartKey (powered by [Fortanix KMS](https://fortanix.com/products/sdkms/))

[^1]: LACP stands for "Link Aggregation Control Protocol." It is a networking protocol that enables the bundling of multiple network connections in parallel to increase bandwidth and provide redundancy.

[^2]: MTU (Maximum Transmission Unit) represents the maximum size of a data packet that can be transmitted over a network.

[^3]: Jumbo Frames refer to network frames that exceed the standard Maximum Transmission Unit (MTU) size, allowing for larger data packets to be transmitted over a network.

[^4]: The IOMMU (Input/Output Memory Management Unit) is a hardware component that manages and controls data transfers between devices (like graphics cards) and a computer's main memory, enhancing system security and performance.

[^5]: Follow the vendor's guide to configure the single-port speed to 200Gb/s.

[^6]: Follow the vendor's guide to configure the single-port speed to 200Gb/s.
