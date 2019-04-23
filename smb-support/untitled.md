---
description: >-
  This page describes the WekaIO implementation of the SMB protocol for shared
  Windows clients.
---

# Overview

## About SMB

SMB \(Server Message Block\) is a network file sharing protocol that allows remote systems to connect to shared file and print services. WekaIO's implementation is based on the open-source Samba package and provides support for SMB versions 2 and 3.

The WekaIO implementation of SMB makes storage services available to Windows and MacOS clients. WekaIO provides shared access from multiple clients, as well as multi-protocol access to the same files from SMB, NFS, and WekaIO native filesystem drivers.

## Key Features of WekaIO Implementation of SMB

Implementation of the SMB feature in the WekaIO system is scalable, resilient and distributed.

* **Scalable:** The WekaIO system currently supports an SMB cluster of between 3 to 8 hosts. These hosts run the SMB gateway service, while the backend filesystem can be any WekaIO filesystem. Therefore, it is practically unlimited in size and performance.
* **Resilient:** The WekaIO system implementation of SMB provides clustered access to files in a WekaIO file store, enabling multiple servers to work together. Consequently, if a server failure occurs, another server is available to take over operations, thereby ensuring failover support and high availability. WekaIO standard resiliency against failures also protects the SMB filesystems.
* **Distributed:** A WekaIO implementation is distributed over a cluster, where all nodes in the cluster handle all SMB filesystems concurrently. Therefore, performance supported by SMB can scale with more hardware resources, and high availability is ensured.

## Configuring SMB Support

### Work Flow

The WekaIO SMB support is established either through the WekaIO system GUI or a series of CLIs. When configuring SMB support, it is necessary to:

1. Define the WekaIO hosts to participate in the Samba cluster, i.e., configuration of the Samba cluster.
2. Join the Samba cluster to the Active Directory, i.e., connection and definition of WekaIO in the Active Directory.
3. Create shares and their folders, and set permissions. Initially, permissions can only be set via the drivers/NFS.
4. Connect as an administrator and define permissions via Windows.

### Establishing an SMB Cluster

Establishing an SMB cluster is performed as follows:

1. Select the WekaIO hosts that will participate in the SMB cluster, and set the domain name.
2. Declare the shares being offered. Each share has to have a name and a share path, i.e., the path into the WekaIO filesystem, which can be the root of the WekaIO filesystem or a subdirectory. This is created in the shell using either a driver mount or an NFS mount. If the share uses the root, it is not necessary to create a root folder \(it already exists\).  If the share is declared without giving a sub-directory, the root of wekafs will be used; If sub-folders have to be created \(this is performed manually\), their ACL has to be adjusted accordingly. 
3. Configure the list of public IP addresses. These will be distributed across the SMB cluster. If a node fails, the IP addresses from that node are reassigned to another node.

{% hint style="info" %}
**Notes:**

Each WekaIO cluster can only support a single SMB cluster.

For running Samba in AWS, contact the WekaIO Support Team for more information.
{% endhint %}

### Active Directory Attributes

The following are the Active Directory attributes relevant for users according to RFC2307:

| AD Attribute | Description |
| :--- | :--- |
| uidNumber | Mandatory, in range of 1,000 to 999,999 |
| gidNumber | Mandatory, and must correlate with real group |
| Loginshell | Optional |
| unixHomeDirectory | Optional |
| MemberUID | Optional |
| ipHostNumber | Optional |

The following are the Active Directory attributes relevant for groups of users according to RFC2307:

| AD Attribute | Description |
| :--- | :--- |
| gidNumber | Mandatory, in range of 1,000 to 999,999 |
| MembersUid | Mandatory \(for members of the group, according to UID\) |
| maSFU30NisDomain | Mandatory \(for the domain to which the group belongs\) |
| NisDomain | Optional |

{% hint style="info" %}
**Note:** Read more about Active Directory properties [here](https://blogs.technet.microsoft.com/activedirectoryua/2016/02/09/identity-management-for-unix-idmu-is-deprecated-in-windows-server/).
{% endhint %}

### Filesystem Permissions and Access Rights

Once the Samba cluster is connected to the Active Directory, it is possible to assign permissions and access rights of Samba cluster filesystems to specific users or groups of users. This is performed according to POSIX permissions i.e., the Windows permissions system is stored in the POSIX permissions system, and any change in the Windows permissions will be adapted to the POSIX permissions.

{% hint style="info" %}
**Note:** The initial set of POSIX permissions is performed via the driver/NFS.
{% endhint %}

##  <a id="smb-management-using-cli-commands"></a>

