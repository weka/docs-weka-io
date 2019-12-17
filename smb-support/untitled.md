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

## SMB User-Mapping Prerequisites

WekaIO maps Windows users and groups to a UID’s and GID’s for access to the filesystem. WekaIO pulls users and groups information from Active Directory automatically.

WekaIO requires the users and groups accessing the file system to have `uidNumber` and `gidNumber` attributes populated in active directory.

### Active Directory Attributes

The following are the Active Directory attributes relevant for users according to RFC2307:

| AD Attribute | Description |
| :--- | :--- |
| `uidNumber` | 0-4290000000 |
| `gidNumber` | 0-4290000000; must correlate with real group |

The following are the Active Directory attributes relevant for groups of users according to RFC2307:

| AD Attribute | Description |
| :--- | :--- |
| `gidNumber` | 0-4290000000 |

Read more about Active Directory properties [here](https://blogs.technet.microsoft.com/activedirectoryua/2016/02/09/identity-management-for-unix-idmu-is-deprecated-in-windows-server/).

## Configuring SMB Support

### Work Flow

The WekaIO SMB support is established either through the WekaIO system GUI or a series of CLIs. When configuring SMB support, it is necessary to:

1. Define the WekaIO hosts to participate in the Samba cluster, i.e., configuration of the Samba cluster.
2. Join the Samba cluster to the Active Directory, i.e., connection and definition of WekaIO in the Active Directory.
3. Create shares and their folders, and set permissions. By default, the filesystem permission are root/root/755 and initially can only be set via a WekaFS/NFS mount.

After completing these steps, it is possible to connect as an administrator and define permissions via Windows.

### Establishing an SMB Cluster

Establishing an SMB cluster is performed as follows:

1. Select the WekaIO hosts that will participate in the SMB cluster and set the domain name.
2. In on-premises deployments, it is possible to configure a list of public IP addresses which will be distributed across the SMB cluster. If a node fails, the IP addresses from that node will be reassigned to another node.

{% hint style="info" %}
**Notes:** Each WekaIO cluster can only support a single SMB cluster.
{% endhint %}

{% hint style="info" %}
**Note:** The DNS "nameserver" of the hosts participating in the SMB cluster should be configured to the Active Directory server.
{% endhint %}

### 

### Creating SMB Shares

After establishing an SMB cluster, it is possible to declare SMB shares. Each share should have a name and a share path, i.e., the path into the WekaIO filesystem, which can be the root of the WekaIO filesystem or a subdirectory. This is created in the shell using either a WekaFS mount or an NFS mount.

If the share uses the root, it is not necessary to create a root folder \(it already exists\). If the share is declared without providing a sub-directory, the WekaFS root will be used. If sub-folders have to be created \(an operation that is performed manually\), the permissions have to be adjusted accordingly. 

### Filesystem Permissions and Access Rights

Once the Samba cluster is connected to the Active Directory, it is possible to assign permissions and access rights of Samba cluster filesystems to specific users or groups of users. This is performed according to POSIX permissions i.e., the Windows permissions system stored in the POSIX permissions system. Any change in the Windows permissions will be adapted in the POSIX permissions.

{% hint style="info" %}
**Note:** The initial set of POSIX permissions is performed via the driver/NFS.
{% endhint %}

{% hint style="info" %}
**Note:** To obtain root access to the SMB shares, assign an Active Directory user with `uidNumber` and `gidNumber` of 0.
{% endhint %}

