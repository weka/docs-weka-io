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
| :--- | :--- |
| Define a set of hosts that will provide the NFS service, which can be the whole cluster or a subset of the cluster. | By defining an interface group. |
| Define Ethernet ports on each of the defined hosts that will be used to provide the NFS service. | By defining an interface group. |
| Allocate a pool of IP addresses that will be used by the Weka software to provide the NFS service. | By defining an interface group. |
| Define a Round-robin DNS name that will resolve to the floating IPs. | On the local DNS service configuration; does not involve Weka management. |
| Define the list of client hosts that will be permitted to access file systems via NFS. | By creating a client permission group. |
| Configure which client hosts can access which file system. | By creating a client permission group. |
| Mount the file systems on the client hosts using the NFS mount operating system support. | On the client operating system; does not involve Weka management. |

### Defining the NFS Networking Configuration \(Interface Groups\)

{% hint style="info" %}
**Note:** Since only a single port can be added to an interface group, for HA support in NFS, two interface groups must be created, with each of the host ports assigned to a different interface group. Additionally, the network topology \(switches\) must be considered when assigning the other host ports to these interface groups, to ensure that a single point of failure is not created in the switch.
{% endhint %}

## Implementing NFS Service from a Weka Cluster

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

{% hint style="info" %}
**Note:** Make sure to set the TTL \(Time to Live\) for all A records assigned to the NFS servers to 0 \(Zero\), this ensures that the IP won't be cached by the client or the DNS server.
{% endhint %}

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

## Managing NFS Networking Configuration \(Interface Groups\)

### Defining Interface Groups

#### Defining Interface Groups Using the GUI <a id="uploading-a-snapshot-using-the-ui"></a>

Access the NFS IP Interfaces screen.

![NFS IP Interfaces Screen](../.gitbook/assets/nfs-interface-3.4.png)

To define an interface group, click the '+' button at the top left-hand side of the screen. The add Interface Groups dialog box will be displayed.

![Add Interface Group Dialog Box](../.gitbook/assets/nfs-interfaces-3.4.png)

Enter the Group Name \(this has to be unique\) and the Gateway / Mask Bits. Then click Save.

#### Defining Interface Groups Using the CLI <a id="uploading-a-snapshot-using-the-cli"></a>

**Command:** `weka nfs interface-group add`

Use the following command line to add an interface group:

`weka nfs interface-group add <name> <type> [--subnet=<subnet>] [--gateway=<gw>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Unique interface group name | None | Yes |  |
| `type` | String | Group type | Can only be  NFS | Yes | NFS |
| `subnet` | String | Subnet mask in the 255.255.0.0 format | Valid netmask | No | 255.255.255.255 |
| `gw` | String | Gateway IP | Valid IP | No | 255.255.255.255 |

### Setting Interface Group Ports

**Setting Interface Group Ports using the GUI**

Access the Group Ports table.

![Group Ports Table](../.gitbook/assets/image%20%2812%29.png)

To set interface group ports, click the '+' button on the top right-hand side of the Group Ports table. Then select the relevant hosts and ports and click Save.

To remove an interface group port, click the trash symbol displayed next to the host's status.

**Setting Interface Group Ports using the CLI**

**Commands:** `weka nfs interface-group port add`and `weka nfs interface-group port delete`

Use the following command lines to add/delete an interface group port:`weka nfs interface-group port add <name> <host-id> <port>    
weka nfs interface-group port delete <name> <host-id> <port>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Interface group name | None | Yes |  |
| `host-id` | String | Host ID on which the port resides\* | Valid host ID | Yes |  |
| `port` | String | Port's device, e.g., eth1 | Valid device | Yes |  |

{% hint style="info" %}
\*It is possible to obtain host IDs using the following command:  
`weka cluster host -H=<hostname>`
{% endhint %}

### **Setting Interface Group IPs**

**Setting Interface Group IPs using the GUI**

Access the Group IPs table.

![Group IPs Table](../.gitbook/assets/image%20%282%29.png)

To set IPs for the selected group, click the '+' button on the top right-hand side of Group IPs table. Then enter the relevant IP range and click Save.

To remove an IP, click the the trash symbol displayed next to the IP in the table.

**Setting Interface Group IPs using the CLI**

**Commands:** `weka nfs interface-group ip-range add`and `weka nfs interface-group ip-range delete`

Use the following command lines to add/delete an interface group IP:  
`weka nfs interface-group ip-range add <name> <ips>    
weka nfs interface-group ip-range delete <name> <ips>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Interface group name | None | Yes |  |
| `ips` | String | IP range | Valid IP range | Yes |  |

## **Managing NFS Access Control \(Client Access Groups\)**

### Defining Client Access Groups

#### Defining Client Access Groups Using the GUI <a id="uploading-a-snapshot-using-the-ui"></a>

Access the NFS Client Permissions screen.

![NFS Client Permissions Screen](../.gitbook/assets/screen-shot-2019-08-12-at-10.12.27.png)

To define a client access group, click the '+' button on the top left-hand side of the screen. Enter the client access group name and click Save.

#### Defining Client Access Groups Using the CLI <a id="uploading-a-snapshot-using-the-ui"></a>

**Command:** `weka nfs client-group`

Use the following command lines to add/delete a client access group:  
`weka nfs client-group add <name>    
weka nfs client-group delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Group name | Valid name | Yes |  |

### Managing Client Access Groups

#### **Managing Client Access Groups Using the GUI**

To add IPs or DNS rules to a group, access the relevant Client Groups dialog box.

![Client Groups Dialog Box](../.gitbook/assets/nfs-client-group-3.4%20%281%29.png)

Click +Add IP or +Add DNS. The appropriate dialog box will be displayed.

![Add DNS to a Client Group Dialog Box](../.gitbook/assets/nfs-client-group-dns-3.4.png)

![Add IP to a Client Group](../.gitbook/assets/nfs-client-group-ip-3.4.png)

Enter the required values - DNS or IP and Mask, respectively, and click Save.

To remove an IP or DNS from a client group, click the trash symbol displayed next to IP or DNS.

#### **Managing Client Access Groups Using the CLI**

**Adding/Deleting DNS**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group DNS:  
`weka nfs rules add dns <name> <dns>    
weka nfs rules delete dns <name> <dns>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Group name | Valid name | Yes |  |
| `dns` | String | DNS rule with \*?\[\] wildcard rules |  | Yes |  |

**Adding/Deleting an IP**

**Command:** `weka nfs rules`

Use the following command lines to add/delete a client group IP:  
`weka nfs rules add ip <name> <ip>    
weka nfs rules delete ip <name> <ip>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | Group name | Valid name | Yes |  |
| `ip` | String | IP with net mask rule, in the 1.1.1.1/255.255.0.0 format | Valid IP | Yes |  |

### **Managing NFS Client Permissions**

#### **Managing NFS Client Permissions Using the GUI**

To add client permissions, click the top right-hand '+' icon in the Client Permissions table. The Permissions dialog box will be displayed.

![NFS Permissions Dialog Box](../.gitbook/assets/screenshot-from-2018-07-04-17-52-32.png)

Define the the following parameters:

* Client Group: the client group to receive permissions.
* Filesystem: the filesystem to receive permissions.
* Path: The path that will be the root of the share.
* Type: The type of access to be provided - RO \(read only\) or RW \(Read/Write\).
* Squash Root: Set to ON or OFF.
* Anom. UID: Anonymous user ID \(relevant only for root squashing\).
* Anom. GID: Anonymous user group ID \(relevant only for root squashing\)

Then click Save.

**Managing NFS Client Permissions Using the CLI**

**Command:** `weka nfs permission`

Use the following command lines to add/update/delete NFS permissions:  
`weka nfs permission add <filesystem> <group> [--path path] [--permission-type permission-type] [--root-squashing root-squashing] [--anon-uid anon-uid] [--anon-gid anon-gid]`

`weka nfs permission update <filesystem> <group> [--path path] [--permission-type permission-type] [--root-squashing root-squashing] [--anon-uid anon-uid] [--anon-gid anon-gid]`

`weka nfs permission delete <filesystem> <group> [--path path]`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>filesystem</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Filesystem name</td>
      <td style="text-align:left">Existing filesystem</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"> <code>group</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Client group name</td>
      <td style="text-align:left">Existing client group</td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"> <code>path</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Root of the share</td>
      <td style="text-align:left">Valid path</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">/</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>permission-type</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Permission type</td>
      <td style="text-align:left">
        <p>RO: read only</p>
        <p>RW: read write</p>
      </td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">RW</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>root-squashing</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">Root squashing</td>
      <td style="text-align:left">on/off</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left">on</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>anon-uid</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Anonymous user ID (relevant only for root squashing)</td>
      <td style="text-align:left">Valid UID (between 0 and 65535)</td>
      <td style="text-align:left">Yes (if root squashing is enabled)</td>
      <td style="text-align:left">65534</td>
    </tr>
    <tr>
      <td style="text-align:left"><code>anon-gid</code>
      </td>
      <td style="text-align:left">Number</td>
      <td style="text-align:left">Anonymous user group ID (relevant only for root squashing)</td>
      <td style="text-align:left">Valid GID (between 0 and 65535)</td>
      <td style="text-align:left">Yes (if root squashing is enabled)</td>
      <td style="text-align:left">65534</td>
    </tr>
  </tbody>
</table>### Supported Mount Options for NFS Clients

#### Non-Coherent Mount Options

* `ac`
* `async`
* `noatime`
* `lookupcache=all`

#### Coherent Mount Options

* `noac`
* `sync`
* `atime`
* `lookupcache=none`

#### Common Mount Options

{% hint style="info" %}
**Note:** The following options can be changed. These values are commonly used with the Weka system:
{% endhint %}

* `rw`
* `hard`
* `rsize=524288`
* `wsize=524288`
* `namlen=255`
* `timeo=600`
* `retrans=2`

#### Fixed Mount options

{% hint style="danger" %}
**Note:** Please make sure to set these values on the mount command, as different values are not supported, and the server cannot enforce it.
{% endhint %}

* `nolock`

{% hint style="info" %}
**Note:** The following options should have fixed values, but usually are either the NFS mount defaults or will be negotiated to these values by the protocol.
{% endhint %}

* `sec=sys`
* `vers=3`
* `mountvers=3`
* `proto=tcp`
* `mountproto=tcp`

