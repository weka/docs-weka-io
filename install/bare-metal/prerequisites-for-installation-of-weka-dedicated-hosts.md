---
description: >-
  This page describes the hardware requirements for installation of the WekaIO
  system on dedicated hosts.
---

# Prerequisites for Installation

{% hint style="info" %}
**Note:** Client installation is described in [Adding Clients](adding-clients-bare-metal.md).
{% endhint %}

### CPU <a id="cpu"></a>

* CPU: Intel V2 or above / AMD EPYC
* Hyper-threading: Disabled in BIOS

### Memory <a id="memory"></a>

* Enough memory to support WekaIO system needs as described in [memory requirements ](planning-a-weka-system-installation.md#memory-resource-planning)
* More memory support for the OS kernel or any other application

### Operation System <a id="operation-system"></a>

* RHEL / CentOS \(and its variations\): 6.8, 6.9, 6.10, 7.2, 7.3, 7.4, 7.5
* Ubuntu: 14.04, 16.04, 18.04
* AWS Linux: 1703, 1709,  1712, 1803

SELINUX must be disabled.

### WekaIO Install Directory <a id="weka-install-directory"></a>

* Directory: /opt/weka
* Should be on an SSD or SSD-like performance, e.g., SATADOM. Cannot be shared remotely NFS mounted or on RAM drive
* At least 26 GB available for the WekaIO system installation, with additional 10GB for each core used by Weka

### Networking – Ethernet <a id="networking-ethernet"></a>

* Ethernet speeds: 10 GbE / 25 GbE / 40 GbE / 50GBE / 100 GbE
* Ethernet NICs: Intel 82599, Intel X710, Mellanox CX4 & CX5
* Mellanox OFED 4.2: Installed
* NICs bonding: Not configured
* Jumbo frames: Enabled on switch and on network port
* WekaIO system management IP address: One per server
* WekaIO system data plane IP address: One IP address for each [WekaIO core](planning-a-weka-system-installation.md#cpu-resource-planning) in each server
* WekaIO system management IP: Ability to communicate with all WekaIO system data plane IPs
* Connectivity between hosts: Ports 14000-14100
* [NetworkManager](https://en.wikipedia.org/wiki/NetworkManager): Disabled
* [Virtual Functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization): The maximum number of virtual functions supported by the device must be bigger than the number of physical cores on the host; some configuration may be required in the BIOS
* SR-IOV: Enabled in BIOS

{% hint style="info" %}
When assigning a network device to the WekaIO system, no other application can create [virtual functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization) on that device.
{% endhint %}

### Networking – InfiniBand <a id="networking-infiniband"></a>

* InfiniBand speeds: FDR / EDR
* Mellanox: CX4 & CX5
* Mellanox OFED 4.2: installed
* Subnet manager: Configured to 4092
* One WekaIO system IP address for management and data plane

### SSDs <a id="ssds"></a>

* Support PLP \(Power Loss Protection\)
* Dedicated for WekaIO system storage \(partition not supported\)

