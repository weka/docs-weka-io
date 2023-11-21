---
description: >-
  This page describes the prerequisites and compatibility for the installation
  of the WEKA system.
---

# Prerequisites and compatibility

{% hint style="info" %}
* The versions specified in the prerequisites and compatibility page apply to the latest minor version of the WEKA system. See the relevant release notes in [get.weka.io ](https://get.weka.io/ui/releases/)for more details.
* In certain instances, WEKA collaborates with Strategic Server Partners to conduct platform qualifications alongside complementary components. Contact your designated WEKA representative with any inquiries.
{% endhint %}

## CPU

* 2013 Intel® Core™ processor family (formerly Haswell) and later (dual-socket)
* AMD EPYC™ processor families 2nd (Rome), 3rd (Milan-X), and 4th (Genoa) Generations (Backends: single-socket; Clients: single-socket and dual-socket)

{% hint style="warning" %}
Intel processor families SandyBridge (2011) and IvyBridge (2012) have been deprecated, and support for these processors will be discontinued in version 4.3.
{% endhint %}

{% hint style="info" %}
Ensure the BIOS settings meet the following requirements:

* AES must be enabled.
* Secure Boot must be disabled.
{% endhint %}

## Memory

* Sufficient memory to support the WEKA system needs as described in [memory requirements](../install/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning).
* More memory support for the OS kernel or any other application.

## Operating system

{% tabs %}
{% tab title="Backends" %}
* **RHEL:**
  * 8.8, 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Rocky Linux:**
  * 9.1, 9.0
  * 8.7, 8.6
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
  * 9.1, 9.0
  * 8.8. 8.7, 8.6, 8.5, 8.4, 8.3, 8.2, 8.1, 8.0
  * 7.9, 7.8, 7.7, 7.6, 7.5, 7.4, 7.3, 7.2
* **Rocky Linux:**
  * 9.1, 9.0
  * 8.8. 8.7, 8.6
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

* 5.3-5.15
* 4.4.0-1106 to 4.19
* 3.10

{% hint style="info" %}
* Kernel 5.15 is not supported with Amazon Linux operating systems.
* It is recommended to turn off auto kernel updates, so it will not get upgraded to an unsupported version.
* Confirm that both the kernel version and the operating system version are listed as supported, as these are distinct components with their own compatibility considerations.
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
To set the SELinux security context for files,  use the `-o acl` in the mount command, and define the `wekafs` to use extended attributes in the SELinux policy configuration (`fs_use_xattr`).
{% endhint %}

#### cgroups

* WEKA backends and clients that serve protocols must be deployed on a supported OS with **cgroups V1** (legacy).
{% endtab %}
{% endtabs %}

## WEKA installation directory

* **WEKA installation directory**: `/opt/weka`
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

* **LACP:**  Link aggregation, also known as bond interfaces, is supported between ports on a single Mellanox NIC and is not supported when using Virtual Functions (VFs).
* **Intel E810:**
  * Only supported on RHEL 8.6 and Rocky Linux 8.6. For other operating systems, consult with the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
  * The ice Linux Base Driver version 1.9.11 and firmware version 4.0.0 are required.
* **MTU:** At least 4k MTU is advised on WEKA cluster servers NICs, and the switches the servers are connected to.
*   **Jumbo frames:** You can set up the WEKA cluster without jumbo frames for Ethernet and InfiniBand, but this will result in minimal performance and an inability to handle high data loads. Before using this mode, it's advisable to consult with the Customer Success Team.

    For clients, jumbo frames are not necessary, but performance may be limited.

### Supported network adapters <a href="#networking-ethernet" id="networking-ethernet"></a>

The following table provides the supported network adapters along with their supported features for backends and clients, and clients-only.

For more information about the supported features, see [networking-in-wekaio.md](../overview/networking-in-wekaio.md "mention").

{% hint style="info" %}
Right-scroll the table to view all columns.
{% endhint %}

#### Supported network adapters for backends and clients

<table><thead><tr><th width="176">Adapters</th><th width="125">Protocol</th><th width="158">Mixed networks</th><th width="87">LACP</th><th width="108">Shared IP</th><th width="104">SRIOV VF</th><th width="154">rx interrupts</th><th width="117">RDMA</th><th width="74">HA</th><th width="122">PKEY</th><th width="155">Routed network</th></tr></thead><tbody><tr><td>Amazon ENA</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel E810 2CQDA2</td><td>Ethernet</td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td></tr><tr><td>NVIDIA Mellanox CX-7 single port</td><td>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td></tr><tr><td>NVIDIA Mellanox CX-7 dual ports</td><td>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td></tr><tr><td>NVIDIA Mellanox CX-6 LX</td><td>Ethernet</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr><tr><td>NVIDIA Mellanox CX-6 DX</td><td>Ethernet</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr><tr><td>NVIDIA Mellanox CX-6</td><td>Ethernet<br>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr><tr><td>NVIDIA Mellanox CX-5 EX</td><td>Ethernet<br>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td></td></tr><tr><td>NVIDIA Mellanox CX-5 BF</td><td>Ethernet</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td></tr><tr><td>NVIDIA Mellanox CX-5</td><td>Ethernet<br>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(IB only)</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr><tr><td>NVIDIA Mellanox CX-4 LX</td><td>Ethernet<br>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr><tr><td>NVIDIA Mellanox CX-4</td><td>Ethernet<br>InfiniBand</td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span>(ETH only)</td></tr></tbody></table>

#### Supported network adapters for clients-only

<table><thead><tr><th width="176">Adapters</th><th width="125">Protocol</th><th width="158">Mixed networks</th><th width="87">LACP</th><th width="108">Shared IP</th><th width="104">SRIOV VF</th><th width="154">rx interrupts</th><th width="117">RDMA</th><th width="74">HA</th><th width="122">PKEY</th><th width="155">Routed network</th></tr></thead><tbody><tr><td>Intel X540</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel X550-T1</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel X710</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel X710-DA2</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel XL710</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel XL710-Q2</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel XXV710</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel 82599ES</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr><tr><td>Intel 82599</td><td>Ethernet</td><td></td><td></td><td></td><td><span data-gb-custom-inline data-tag="emoji" data-code="1f44d">👍</span></td><td></td><td></td><td></td><td></td><td></td></tr></tbody></table>

### Ethernet drivers and configurations

{% tabs %}
{% tab title="Ethernet drivers" %}
*   **Supported Mellanox OFED versions for the Ethernet NICs:**

    * 23.04-1.1.3.0
    * 5.9-0.5.6.0
    * 5.8-1.1.2.1 LTS
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
* Ethernet speeds: 200 GbE / 100 GbE / 50GbE / 40 GbE / 25 GbE / 10 GbE.
* NICs bonding: Can bond dual ports on the same NIC (modes 1 and 4). Only supported on NVIDIA Mellanox NICs.
* VLAN: Not supported.
* Shared IP supported NICs (DPDK):
  * One IP address for management and data plane.
* Non-shared IP supported NICs (DPDK):
  * IP address for management: One IP address per NIC (configured before WEKA installation).
  * IP address for data plane: One IP address per [WEKA core](../install/bare-metal/planning-a-weka-system-installation.md#cpu-resource-planning) in each server (WEKA applies these IPs during the cluster initialization).
  * [Virtual Functions](https://en.wikipedia.org/wiki/Network\_function\_virtualization) (VFs): Ensure that the device supports a maximum number of VFs greater than the number of physical cores on the server. Set the number of VFs to match the cores you intend to dedicate to WEKA, and note that some BIOS configurations may be necessary.
  * SR-IOV: Enabled in BIOS.
* For UDP, one IP address is used for all purposes.

{% hint style="info" %}
When assigning a network device to the WEKA system, no other application can create VFs on that device.
{% endhint %}
{% endtab %}
{% endtabs %}

### InfiniBand drivers and configurations <a href="#networking-infiniband" id="networking-infiniband"></a>

{% tabs %}
{% tab title="InfiniBand drivers" %}
WEKA supports the following Mellanox OFED versions for the InfiniBand adapters:

* 23.04-1.1.3.0
* 5.9-0.5.6.0
* 5.8-1.1.2.1 LTS
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

* InfiniBand speeds: FDR / EDR / HDR
* Subnet manager: Configured to 4092
* One WEKA system IP address for management and data plane
* PKEYs: Supported
* Dual InfiniBand can be used for both HA and higher bandwidth

{% hint style="info" %}
If it is necessary to change PKEYs, contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).
{% endhint %}
{% endtab %}
{% endtabs %}

### Required ports

When configuring firewall ingress and egress rules the following access must be allowed.

{% hint style="info" %}
Right-scroll the table to view all columns.
{% endhint %}

<table><thead><tr><th width="211">Purpose</th><th width="124">Source</th><th width="135">Target</th><th width="150">Target Ports</th><th width="136">Protocol</th><th width="352">Comments</th></tr></thead><tbody><tr><td>WEKA server traffic for bare-metal deployments</td><td>All WEKA server IPs </td><td>All WEKA server IPs</td><td>14000-14100<br>14200-14300<br>14300-14400</td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default for the Resources Generator for the first three containers. You can customize these values.</td></tr><tr><td>WEKA server traffic for cloud deployments</td><td>All WEKA server IPs</td><td>All WEKA server IPs</td><td><p>14000-14100</p><p>15000-15100</p><p>16000-16100</p></td><td>TCP and UDP<br>TCP and UDP<br>TCP and UDP</td><td>These ports are the default. You can customize these values.</td></tr><tr><td>WEKA SSH management traffic</td><td>All WEKA server IPs </td><td>All WEKA server IPs</td><td>22</td><td>TCP</td><td></td></tr><tr><td>WEKA clients traffic</td><td>Client host IPs</td><td>All WEKA server IPs</td><td>14000-14100</td><td>TCP and UDP</td><td></td></tr><tr><td>WEKA GUI access </td><td></td><td>All WEKA management IPs</td><td>14000</td><td>TCP</td><td>User web browser IP</td></tr><tr><td>NFS</td><td>NFS client IPs</td><td>WEKA Server NFS IPs</td><td>2049<br>&#x3C;mountd port></td><td>TCP and UDP<br>TCP and UDP</td><td>You can set the mountd port using the command: <code>weka nfs global-config set --mountd-port</code></td></tr><tr><td>SMB</td><td>SMB client IPs</td><td>WEKA Server SMB IPs</td><td>139<br>445</td><td>TCP<br>TCP</td><td></td></tr><tr><td>S3</td><td>S3 client IPs</td><td>WEKA Server S3 IPs</td><td>9000</td><td>TCP</td><td></td></tr><tr><td>wekatester</td><td>All WEKA server IPs</td><td>All WEKA server IPs</td><td>8501<br>9090</td><td>TCP<br>TCP</td><td>Port 8501 is used by wekanetperf.</td></tr><tr><td>WEKA Management Station</td><td>User web browser IP</td><td>WEKA Management Station IP</td><td>8501<br>9090</td><td>TCP<br>TCP</td><td></td></tr><tr><td>Cloud WEKA Home, Local WEKA Home</td><td>All WEKA server IPs </td><td>Cloud WEKA Home or Local WEKA Home</td><td>80<br>443</td><td>HTTP<br>HTTPS</td><td>Open according to the directions in the deployment scenario:<br>- WEKA server IPs to CWH or LWH.<br>- LWH to CWH (if forwarding data from LWH to CWH)</td></tr><tr><td>Troubleshooting by the Customer Success Team (CST).</td><td>All WEKA server IPs </td><td>CST remote access</td><td>4000<br>4001</td><td>TCP<br>TCP</td><td></td></tr></tbody></table>

## HA

See [#high-availability-ha](../overview/networking-in-wekaio.md#high-availability-ha "mention").

## SSDs

* The SSDs must support PLP (Power Loss Protection).
* WEKA system storage must be dedicated, and partitioning is not supported.
* The supported drive capacity is up to 30 TiB.
* IOMMU mode is not supported for SSD drives.\
  If you need to configure IOMMU on WEKA cluster servers, for instance, due to specific applications when running the WEKA cluster in converged mode, contact our [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team) for assistance.

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
* Lenovo MagnaScale (version 3.0 and up)
* Quantum ActiveScale (version 5.5.1 and up)
* Red Hat Ceph Storage (version 5.0 and up)
* Scality Ring (version 7.4.4.8 and up)
* Scality Artesca (version 1.5.2 and up)
* SwiftStack (version 6.30 and up)

## Virtual Machines

Virtual Machines (VMs) can be used as **clients** only. Ensure the following prerequisites are met for the relevant client type:

{% tabs %}
{% tab title="UDP clients" %}
* To avoid irregularities, crashes, and inability to handle application load, make sure there is no CPU starvation to the WEKA process by reserving the CPU in the virtual platform and dedicating a core to the WEKA client.
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

For additional information and how-to articles, search the WEKA Knowledge Base in the [WEKA support portal](http://support.weka.io) or contact the [Customer Success Team](getting-support-for-your-weka-system.md#contacting-weka-technical-support-team).

## KMS

* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) (version 1.1.5 up to 1.14.x)
* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html)-compliant KMS (protocol version 1.2 and up)
  * The KMS should support encryption-as-a-service (KMIP encrypt/decrypt APIs)
  * KMIP certification has been conducted with [Equinix SmartKey](https://www.equinix.com/services/edge-services/smartkey/) (powered by [Fortanix KMS](https://fortanix.com/products/sdkms/))
