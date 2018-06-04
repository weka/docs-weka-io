---
description: >-
  This page describes the hardware requirements for installation of the Weka
  system on dedicated hosts.
---

# Prerequisites for Installation

{% hint style="info" %}
**Note:** Client installation is described in [Adding Clients](adding-clients-bare-metal.md).
{% endhint %}

### CPU {#cpu}

* CPU: Intel V2 or above / AMD EPYC
* Hyper-threading: Disabled in BIOS

### Memory {#memory}

* Enough memory to support Weka needs as described in [memory requirements ](https://docs.weka.io/~/edit/primary/installation/planning-a-weka-system-installation#memory-resource-planning)
* More memory support for the OS kernel or any other application

### Operation System {#operation-system}

* RHEL / CentOS \(and it variations\): 7.2, 7.3, 7.4
* Ubuntu: 14.04, 16.04

SELINUX must be disabled.

### Weka Install Directory {#weka-install-directory}

* Directory: /opt/weka
* Should be on an SSD or SSD-like performance, e.g., SATADOM. Cannot be shared remotely NFS mounted or on RAM drive
* At least 20 GB available for the Weka system installation

### Networking – Ethernet {#networking-ethernet}

* Ethernet speeds: 10 GbE / 25 GbE / 40 GbE / 50GBE / 100 GbE
* Ethernet NICs: Intel 82599, Intel X710, Mellanox CX4 & CX5
* Mellanox OFED 4.2: Installed
* NICs bonding: Not configured
* Jumbo frames: Enabled on switch and on network port
* Weka system management IP address: One per server
* Weka system data plane IP address: One per server per Weka system core
* Weka system management IP: Ability to communicate with all Weka system data plane IPs
* Connectivity between nodes: Ports 14000-14100
* [NetworkManager](https://en.wikipedia.org/wiki/NetworkManager): Disabled
* Maximum number of [virtual functions](https://en.wikipedia.org/wiki/Network_function_virtualization) supported by the device must be bigger than the number of physical cores on the host; some configuration may be required in the BIOS
* SR-IOV: Enabled in BIOS

{% hint style="info" %}
When assigning a network device to Weka, no other application may create [virtual functions \(VFs\)](https://en.wikipedia.org/wiki/Network_function_virtualization) on that device.
{% endhint %}

### Networking – InfiniBand {#networking-infiniband}

* InfiniBand speeds: FDR / EDR
* Mellanox: CX4 & CX5
* Mellanox OFED 4.2: installed
* Subnet manager: Configured to 4092
* One Weka system IP address for management and data plane

### SSDs {#ssds}

* Support PLP \(Power Loss Protection\)
* Dedicated for Weka system storage \(partition not supported\)

