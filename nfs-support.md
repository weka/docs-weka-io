---
description: >-
  This page describes how the Weka system enables file access through the NFS
  protocol, instead of the Weka client. The Weka system supports NFS v3.
---

# NFS Support

## Overview

The NFS protocol allows client hosts to access the Weka filesystem without installing Weka’s client software using the standard NFS implementation of the client host operating system. While this implementation is easier to deploy, it does not compare in performance to the Weka client.

In order to implement NFS service from a Weka cluster, the following steps must be implemented:

| **Step** | **Method of Implementation** |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Define a set of hosts that will provide the NFS service, which can be the whole cluster or a subset of the cluster. | By defining an interface group. |
| Define Ethernet ports on each of the defined hosts that will be used to provide the NFS service. | By defining an interface group. |
| Allocate a pool of IP addresses that will be used by the Weka software to provide the NFS service. | By defining an interface group. |
| Define a Round-robin DNS name that will resolve to the floating IPs. | On the local DNS service configuration; does not involve Weka management. |
| Define the list of client hosts that will be permitted to access file systems via NFS. | By creating a client permission group. |
| Configure which client hosts can access which file system. | By creating a client permission group. |
| Mount the file systems on the client hosts using the NFS mount operating system support. | On the client operating system; does not involve Weka management. |

## Implementing NFS Service from a Weka Cluster

### Defining the NFS Networking Configuration \(Interface Groups\)

In order to define the NFS service, one or more interface groups must be defined. An interface group consists of the following:

* A collection of Weka hosts with an Ethernet port for each host, where all the ports must belong to the same layer 2 subnet.
* A collection of floating IPs that serve the NFS protocol on the hosts and ports. All IP addresses must belong to the layer 2 subnet above.
* A routing configuration for the IPs which must comply with the IP network configuration.

Up to 10 different Interface groups can be defined, where multiple interface groups can be used if the cluster needs to connect to multiple layer 2 subnets. Up to 50 hosts can be defined in each interface group.

The Weka system will automatically distribute the IP addresses evenly on each host and port. On a failure of the host, the Weka system will reasonably redistribute the IP addresses associated with the failed host on other hosts. To minimize the effect of any host failures, it is recommended to define sufficient floating IPs so that the Weka system can assign 4 floating IPs per host.

{% hint style="info" %}
**Note:** The Weka system will configure the host IP networking for the NFS service on the host operating system. It should not be defined by the user.
{% endhint %}

### Configuring the Round-Robin DNS Server

To ensure that the various NFS clients will balance the load on the various Weka hosts serving NFS, it is recommended to define a [Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin_DNS) entry which will resolve to the list of floating IPs, ensuring that client loads will be equally distributed across all hosts.

### Defining NFS Access Control \(Client Access Groups\)

In order to control which host can access which file system, NFS client permission groups must be defined. Each NFS client permission group contains:

* A list of filters for IP addresses or DNS names of clients that can be connected to the Weka system via NFS.
* A collection of rules that control access to specific filesystems.

### Configuring NFS on the Client

The NFS mount should be configured on the client host via the standard NFS stack operating system. The NFS server IP address should point to the Round-robin DNS name defined above.

## Load Balancing and Resiliency of the NFS Service

The Weka NFS service is a scalable, fully load-balanced and resilient service which provides continuous service through failures of any kind.

Scalability is implemented by defining many hosts that serve the NFS protocol, thereby enabling the scaling of performance by adding more hosts to the interface group.

Load balancing is implemented via floating IPs. By default, the floating IPs are evenly distributed over all the interface group hosts/ports. When different clients resolve the DNS name into an IP service, each of them receives a different IP address, thereby ensuring that different clients will access different hosts. This allows the Weka system to scale and service thousands of clients.

The same mechanism ensures the resiliency of the service. On a host failure, all IP addresses associated with the failed host will be reassigned to other hosts \(using the GARP network messages\) and the clients will reconnect to the new hosts without any reconfiguration or service interruption.

## Managing NFS Support

### Defining the NFS Networking Configuration \(Interface Groups\) {#defining-the-nfs-networking-configuration-interface-groups-1}

#### Defining Interface Groups Using the GUI {#uploading-a-snapshot-using-the-ui}

At the IP interfaces view, click the '+' button on the top-left side of the screen. Interface Group addition dialog box will be displayed.

![IP Interfaces view screen](.gitbook/assets/screenshot-from-2018-07-04-16-25-02.png)

Input Group Name \(name has to be unique\), define default gateway and subnet mask, then click 'Save'.

![Add Interface Group dialog box](.gitbook/assets/image%20%286%29.png)

#### ​   {#uploading-a-snapshot-using-the-cli}

#### Defining Interface Groups Using the CLI {#uploading-a-snapshot-using-the-cli-1}

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:`weka nfs interface-group add <name> <type> [--subnet=<subnet>] [--gateway=<gw>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- | --- | --- |
| `name` | String | Unique interface-group name | None | Yes | ​ |
| `type` | String | Group type | Can be only NFS | Yes | NFS |
| `subnet` | String | Subnet mask in the 255.255.0.0 format | Valid netmask | No | 255.255.255.255 |
| `gw` | String | Gateway IP | Valid IP | No | 255.255.255.255 |

​

**Setting group ports using GUI**

In order to set group ports. click on the `+` button displayed on the top right-hand side of the 'Group Ports' table. Choose the relevant hosts and ports and click 'save'.

Removal of an unwanted port is done by clicking the trash icon that shown next to the host's status and adding new hosts.

![Group port table](.gitbook/assets/image%20%285%29.png)

**Setting group ports using CLI**

**Commands:** `weka nfs interface-group port add`

 `weka nfs interface-group port delete`

Use the following commands line to add/delete an interface-group port:`weka nfs interface-group port add <name> <host-id> <port>`

`weka nfs interface-group port delete <name> <host-id> <port>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- | --- |
| `name` | String | Interface group name | None | Yes | ​ |
| `host-id` | String | Host ID on which the port resides\* | Valid host ID | Yes | ​ |
| `port` | String | port's device \(e.g. eth1\) | Valid device | Yes | ​ |

\*You can get hosts IDs by using the following command: `weka cluster host -H=<hostname>`

**Setting group IPs using GUI**

In order to set IPs for the selected group, click on the `+` button displayed on the top right-hand side of 'Group IP' table, input the relevant IP range and click 'save'.

Removal of an unwanted IP is done by clicking on the trash symbol displayed next to them in the table.

![Group IPs table](.gitbook/assets/image%20%282%29.png)

**Setting group ports using CLI**

**Commands:** `weka nfs interface-group ip-range add`

 `weka nfs interface-group ip-range delete`

Use the following commands line to add/delete an interface-group port:

`weka nfs interface-group ip-range add <name> <ips>`

`weka nfs interface-group ip-range delete <name> <ips>`

 **Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `name` | String | Interface group name | None | Yes | ​ |
| `ips` | String | IP range | Valid IP range | yes | ​ |

​

### **Defining NFS Access Control \(Client Access Groups\)** {#defining-nfs-access-control-client-access-groups-1}

#### Defining Client Access Groups Using the GUI {#uploading-a-snapshot-using-the-ui-1}

From the NFS client permissions view click '+' button on the top left-hand side of the screen. Input a group name and click 'save'.

![NFS Client Permissions view screen](.gitbook/assets/image%20%281%29.png)

**Managing Client Group Rules Using the GUI**

To add IPs or DNS rule: to a group click '+Add IP' / '+Add DNS' and input the required values - IP and mask or DNS respectively.  Removal is done by clicking the trash icon that shown next to the unwanted element.

![](.gitbook/assets/image%20%287%29.png)

![](.gitbook/assets/image%20%283%29.png)

![](.gitbook/assets/image.png)

 **Managing NFS Client Permissions Using the GUI**

Click the top right `+` icon from the permission table, permission rule addition dialog box will be displayed.

Fill in the following parameters:

* client group
* filesystem
* path \(the given path will be the root of the share\)
* access type: Read only or Read write
* Squash root
* Anonymous user ID \(relevant only for root squashing\)
* Anonymous user group ID \(relevant only for root squashing\)

click 'save'.

![NFS permission rule addition dialog box](.gitbook/assets/image%20%284%29.png)

#### Defining Client Access Groups Using the CLI {#uploading-a-snapshot-using-the-cli-2}

**Command:** `weka nfs client-group`

Use the following command line to add/delete client group:

 `weka nfs client-group add <name>`

`weka nfs client-group delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- |
|  `name` | String | Group name | Valid name | Yes | ​ |

​

#### Managing NFS rules Rules Using the CLI {#uploading-a-snapshot-using-the-cli-3}

**Adding/deleting dns:**

**Command:** `weka nfs rules`

Use the following commands line to add/delete dns:

`weka nfs rules add dns <name> <dns>`

`weka nfs rules delete dns <name> <dns>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
|  `name` | String | Group name | Valid name | Yes | ​ |
|  `dns` | String | DNS rule with \*?\[\] wildcards rule | ​ | Yes | ​ |

​

**Adding/deleting ip:**

**Command:** `weka nfs rules`

Use the following commands line to add/delete dns:

`weka nfs rules add ip <name> <ip>`

`weka nfs rules delete ip <name> <ip>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
|  `name` | String | Group name | Valid name | Yes | ​ |
|  `ip` | String | IP with netmask rule, in the 1.1.1.1/255.255.0.0 format | Valid IP | Yes | ​ |

​

