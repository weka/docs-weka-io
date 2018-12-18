---
description: >-
  This page describes the WekaIO implementation of the SMB protocol for shared
  Windows clients.
---

# Overview

## About SMB

SMB \(Server Message Block\) is a network file protocol originally created in the 1980s to allow DOS-based systems to connect to shared file and print services. It has evolved quite a bit over the years. WekaIO's implementation is based on the open-source Samba package, and provides support for SMB versions 2 and 3.

The WekaIO implementation of SMB makes storage services available to Windows and MacOS clients. WekaIO provides shared access from multiple clients, as well as multi-protocol access to the same files from SMB, NSF, and WekaIO native filesystem drivers.

## Key Features of WekaIO Implementation of SMB

Implementation of the SMB feature in the WekaIO system is scalable, resilient and distributed.

* **Scalable:** The WekaIO system currently supports an SMB cluster of between 3 to 8 hosts. These hosts run the SMB gateway service, while the backend filesystem can be any WekaIO filesystem. Therefore, it is practically unlimited in size and performance.
* **Resilient:** The WekaIO system implementation of SMB provides clustered access to files in a WekaIO file store, enabling multiple servers to work together. Consequently, if a server failure occurs, another server is available to take over operations, thereby ensuring failover support and high availability. WekaIO standard resiliency against failures also protects the SMB filesystems.
* **Distributed:** A WekaIO implementation is distributed over a cluster, where all nodes in the cluster handle all SMB filesystems concurrently. Therefore, performance supported by SMB can scale with more hardware resources, and high-availability is ensured.

## Configuring SMB Support

The WekaIO SMB support is established either through the WekaIO system GUI or a series of CLIs. When configuring SMB support, it is necessary to:

1. Define the WekaIO hosts to participate in the SMB cluster.
2. Create shares.
3. Create SMB users.

This requires setting up a cluster, which is performed as follows:

1. Selecting the WekaIO hosts that will participate in the SMB cluster, and setting the workgroup name.
2. Declaring the shares being offered. Each share has to have a name and a share path, i.e., the path into the WekaIO filesystem, which can be the root of the WekaIO filesystem or a subdirectory.
3. Configuring the list of public IP addresses. These will be distributed across the SMB cluster. If a node fails, the IP addresses from that node are reassigned to another node.
4. Configuring local authentication – provision of usernames and passwords for users of the SMB feature.

{% hint style="info" %}
**Notes:**

Each WekaIO cluster can only support a single SMB cluster.

For running Samba in AWS, contact the WekaIO Support Team for more information.
{% endhint %}

## Identity, Access Permissions and Order of Operations <a id="access-permissions-and-order-of-operations"></a>

When connecting to an SMB host from a Windows host, it is necessary to correlate the way Windows and Linux store and interpret user identities. Windows identifies users using a Security Identifier \(SID\) which must be translated to a Linux UID/GUD pair.  This translation is known as identity mapping.

Access is controlled using two different mechanisms: standard Linux permissions and the Windows Access Control Lists \(ACLs\). Access control through the WekaIO SMB is implemented in two levels:

1. Each SMB operation is validated against the ACLs, which are stored by and accessible only to the WekaIO SMB service. Access is denied if the credentials do not match the access control.
2. If the requested operation is permitted by \(1\) above, then the SMB user SID is mapped to a Linux UID/GID and access is verified against the Unix permission system.

{% hint style="info" %}
**Note:** The requested operation is only permitted after successful passing of both levels.
{% endhint %}

\*\*\*\*

##  <a id="smb-management-using-cli-commands"></a>

