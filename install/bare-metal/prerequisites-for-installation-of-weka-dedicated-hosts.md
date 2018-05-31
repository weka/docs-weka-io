---
description: >-
  This page describes the hardware requirements for installation of the Weka
  system on dedicated hosts.
---

# Prerequisites for Installation

{% hint style="info" %}
**Note:** Client installation will be described in [A](https://docs.weka.io/~/edit/drafts/-LAl1k_1hGk6BAYkmB9J/adding-clients)dding Clients.
{% endhint %}

### CPU {#cpu}

* CPU: Intel V2 or above / AMD EPYC
* Hyper-threading: Disabled in BIOS
* SR-IOV: Enabled in BIOS for Ethernet installations \(not required for IB installations\)

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
* Network Manager: Disabled

### Networking – InfiniBand {#networking-infiniband}

* InfiniBand speeds: FDR / EDR
* Mellanox: CX4 & CX5
* Mellanox OFED 4.2: installed
* Subnet manager: Configured to 4092
* One Weka system IP address for management and data plane

{% hint style="info" %}
Note that you can't mix **Ethernet** and **Infiniband** in the same cluster
{% endhint %}

### SSDs {#ssds}

* Support PLP \(Power Loss Protection\)
* Dedicated for Weka system storage \(partition not supported\)

