---
description: >-
  This page describes the Weka implementation of the SMB protocol for shared
  Windows clients.
---

# SMB

## About SMB

SMB (Server Message Block) is a network file sharing protocol that allows remote systems to connect to shared file and print services. Weka's implementation is based on the open-source Samba package and provides support for SMB versions 2 and 3.

The Weka implementation of SMB makes storage services available to Windows and macOS clients. Weka provides shared access from multiple clients, as well as multi-protocol access to the same files from SMB, NFS, and Weka native filesystem drivers.

## Key Features of Weka Implementation of SMB

Implementation of the SMB feature in the Weka system is scalable, resilient, and distributed.

* **Scalable:** The Weka system currently supports an SMB cluster of between 3 to 8 hosts. These hosts run the SMB gateway service, while the backend filesystem can be any Weka filesystem. Therefore, it is practically unlimited in size and performance.
* **Resilient:** The Weka system implementation of SMB provides clustered access to files in a Weka file store, enabling multiple servers to work together. Consequently, if a server failure occurs, another server is available to take over operations, thereby ensuring failover support and high availability. Weka standard resiliency against failures also protects the SMB filesystems.
* **Distributed:** A Weka implementation is distributed over a cluster, where all nodes in the cluster handle all SMB filesystems concurrently. Therefore, performance supported by SMB can scale with more hardware resources, and high availability is ensured.

## SMB User-Mapping

The Weka system SMB stack supports authentication via a single Active Directory with multiple trusted domains. The POSIX users (uid) and groups (gid) mapping for the SMB access should be resolved from the Active Directory. 

The Weka system pulls users and groups information from Active Directory automatically and supports two types of id-mapping from the Active Directory:

1. `RFC2307` - where `uidNumber` and `gidNumber` must be defined in the AD user attributes
2. `rid` - which creates local mapping with the AD users and groups

Using `rid` can ease the configuration, where user IDs are tracked automatically, all domain user accounts and groups are automatically available on the domain member and no attributes need to be set for domain users and groups. On the other hand, if the `rid` AD range configuration changes the user mapping might change and result in wrong uids/gids resolution. 

### Active Directory Attributes

The following are the Active Directory attributes relevant for users according to `RFC2307`:

| AD Attribute | Description                                    |
| ------------ | ---------------------------------------------- |
| `uidNumber`  | 0-4290000000                                   |
| `gidNumber`  | 0-4290000000; must correlate with a real group |

The following are the Active Directory attributes relevant for groups of users according to `RFC2307`:

| AD Attribute | Description  |
| ------------ | ------------ |
| `gidNumber`  | 0-4290000000 |

The above range is the default configuration for the Weka system for the AD server IDs and can be changed. This is the main AD range (if additional trusted domains are defined).

Setting the range (and ranges, in case of multiple domains) is required to avoid ID overlapping and collisions.

When joining multiple domains, it is required to set the ID range for each one of them, and the ranges cannot overlap. There is also a (configurable) default mapping range for users that are not part of any domain.

Read more about Active Directory properties [here](https://blogs.technet.microsoft.com/activedirectoryua/2016/02/09/identity-management-for-unix-idmu-is-deprecated-in-windows-server/).

## Configuring SMB Support

### Work Flow

The Weka SMB support is established either through the Weka system GUI or a series of CLIs. When configuring SMB support, it is necessary to:

1. Define the Weka hosts to participate in the SMB cluster, i.e., the configuration of the SMB cluster.
2. Join the SMB cluster to the Active Directory, i.e., connection and definition of Weka in the Active Directory.
3. Create shares and their folders, and set permissions. By default, the filesystem permissions are root/root/755 and initially can only be set via a WekaFS/NFS mount.

After completing these steps, it is possible to connect as an administrator and define permissions via Windows.

### Establishing an SMB Cluster

Establishing an SMB cluster is performed as follows:

1. Select the Weka hosts that will participate in the SMB cluster and set the domain name.
2. In on-premises deployments, it is possible to configure a list of public IP addresses that will be distributed across the SMB cluster. If a node fails, the IP addresses from that node will be reassigned to another node.

{% hint style="info" %}
**Notes:** Each Weka cluster can only support a single SMB cluster.
{% endhint %}

{% hint style="info" %}
**Note:** The DNS "nameserver" of the hosts participating in the SMB cluster should be configured to the Active Directory server.
{% endhint %}

### Configuring the Round-Robin DNS Server

To ensure that the various SMB clients will balance the load on the various Weka hosts serving SMB, it is recommended to define a [Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin_DNS) entry which will resolve to the list of floating IPs, ensuring that client loads will be equally distributed across all hosts.

{% hint style="info" %}
**Note:** Make sure to set the TTL (Time to Live) for all A records assigned to the SMB servers to 0 (Zero), this ensures that the IP won't be cached by the client or the DNS server.
{% endhint %}

### Creating SMB Shares

After establishing an SMB cluster, it is possible to declare SMB shares. Each share should have a name and a share path, i.e., the path into the Weka filesystem, which can be the root of the Weka filesystem or a subdirectory. This is created in the shell using either a WekaFS mount or an NFS mount.

If the share uses the root, it is not necessary to create a root folder (it already exists). If the share is declared without providing a sub-directory, the WekaFS root will be used. If sub-folders have to be created (an operation that is performed manually), the permissions have to be adjusted accordingly.

### Filesystem Permissions and Access Rights

Once the SMB cluster is connected to the Active Directory, it is possible to assign permissions and access rights of SMB cluster filesystems to specific users or groups of users. This is performed according to POSIX permissions i.e., the Windows permissions system stored in the POSIX permissions system. Any change in the Windows permissions will be adapted in the POSIX permissions.

{% hint style="info" %}
**Note:** The initial set of POSIX permissions is performed via the driver/NFS.
{% endhint %}

{% hint style="info" %}
**Note:** To obtain root access to the SMB shares, assign an Active Directory user with `uidNumber` and `gidNumber` of 0.
{% endhint %}

### Integration with Windows Previous Versions

[Creating snapshots](../../fs/snapshots.md#creating-a-snapshot) of the Weka filesystem and naming the access point in the `@GMT_%Y.%m.%d-%H.%M.%S` format will expose those to the windows previous versions mechanism. Right-click a file or a folder in the Weka SMB share in the windows client, select `Properties->Previous Versions` , and see a list of available previous versions that correspond to the filesystem snapshots.

For example, creating a snapshot via the CLI:

```
$ weka fs snapshot create fs_name snapshot_name --access-point `TZ=GMT date +@GMT-%Y.%m.%d-%H.%M.%S`
```

