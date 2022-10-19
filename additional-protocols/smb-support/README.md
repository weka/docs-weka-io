---
description: >-
  This page describes the Weka configuration of the SMB protocol for shared
  Windows clients.
---

# SMB

SMB (Server Message Block) is a network file-sharing protocol that allows remote systems to connect to shared file and print services. Weka's implementation is based on a new stack named **SMB-W** in addition to the legacy open-source Samba stack. Both SMB flavors support SMB versions 2 and 3.

The Weka implementation of SMB makes storage services available to Windows and macOS clients. Weka provides shared access from multiple clients, including multi-protocol access to the same files from SMB, NFS, and Weka native filesystem drivers.

## SMB implementation key features&#x20;

The implementation of the SMB feature in the Weka system is scalable, resilient, and distributed.

* **Scalable:** The Weka system supports an SMB cluster of between 3 to 8 hosts. These hosts run the SMB gateway service, while the backend filesystem can be any Weka filesystem. Therefore, it is practically unlimited in size and performance.
* **Resilient:** The Weka system implementation of SMB provides clustered access to files in a Weka file store, enabling multiple servers to work together. Consequently, if a server failure occurs, another server is available to take over operations, thereby ensuring failover support and high availability. Weka standard resiliency against failures also protects the SMB filesystems. SMB-W supports transparent failover, thus providing more resiliency than legacy SMB.
* **Distributed:** A Weka implementation is distributed over a cluster, where all nodes in the cluster handle all SMB filesystems concurrently. Therefore, performance supported by SMB can scale with more hardware resources, and high availability is ensured. SMB-W supports SMB Multichannel and SMB Direct (as opposed to the legacy SMB).

## SMB-W additional features

The SMB-W provides the following features in addition to the legacy SMB features:

* **SMB Multichannel**: Weka supports SMB clients configured with multichannel. Therefore increasing the performance in such a configuration.&#x20;
* **SMB Direct:** SMB over Remote Direct Memory Access (RDMA). To use the SMB Direct feature, make sure that the following pre-requisites are met:
  * The SMB-W servers are RDMA-enabled (both HW and OS).
  * For Windows clients, the SMB client must be configured as multichannel.
* **SMB Transparent Failover:** This feature enables continuous IO availability during failover.

## SMB user mapping

The Weka system SMB supports authentication by a single Active Directory with multiple trusted domains. The POSIX users (uid) and groups (gid) mapping for the SMB access must be resolved by the Active Directory.&#x20;

The Weka system pulls users and groups information from the Active Directory automatically and supports two types of id-mapping from the Active Directory:

* **RFC2307:** Where `uidNumber` and `gidNumber` must be defined in the AD user attributes.
* **rid:** Creates a local mapping with the AD users and groups.

Using **rid** mapping can ease the configuration, where user IDs are tracked automatically. All domain user accounts and groups are automatically available on the domain member, and no attributes need to be set for domain users and groups. On the other hand, if the **rid** AD range configuration changes, user mapping might change and result in wrong uids/gids resolution.&#x20;

### Active Directory attributes

The following are the Active Directory attributes relevant for users according to **RFC2307**:

| **AD attribute** | **Description**                                |
| ---------------- | ---------------------------------------------- |
| `uidNumber`      | 0-4290000000                                   |
| `gidNumber`      | 0-4290000000; must correlate with a real group |

The following are the Active Directory attributes relevant for groups of users according to **RFC2307**:

| **AD attribute** | **Description** |
| ---------------- | --------------- |
| `gidNumber`      | 0-4290000000    |

The range specified above is the default configuration for the Weka system for the AD server IDs and can be changed. This is the main AD range (if additional trusted domains are defined).

To avoid ID overlapping and collisions, set the range or ranges (for multiple domains).

When joining multiple domains, it is required to set the ID range for each of them, and the ranges cannot overlap. There is also a (configurable) default mapping range for users not part of any domain.

For more details about Active Directory properties, see the Microsoft site.

## Workflow: configure SMB support

To configure the Weka SMB support, you can use either the Weka system GUI or CLI commands.

**Workflow**

1. **Configure SMB cluster**: Set the Weka system servers that participate in the SMB cluster.
2. **Join the SMB cluster in the Active Directory**: Connect and define the Weka system in the Active Directory.
3. Create shares and folders, and set permissions. By default, the filesystem permissions are root/root/755 and initially can only be set by a WekaFS/NFS mount.

Once these steps are done, it is possible to connect as an administrator and define permissions through the Windows operating system.

### Establish an SMB cluster

Each Weka cluster only supports a single SMB cluster.

**Before you begin**

Verify that the DNS "nameserver" of the servers participating in the SMB cluster is configured to the Active Directory server.

**Procedure**

1. Select the Weka servers participating in the SMB cluster and set the domain name.
2. In on-premises deployments, it is possible to configure a list of public IP addresses distributed across the SMB cluster. If a server fails, the IP addresses from that server are reassigned to another server.

### Configure the round-robin DNS server

To ensure that the various SMB clients balance the load on the different Weka servers serving SMB, it is recommended to define a [Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS) entry that resolves to the list of floating IPs, ensuring that client loads are equally distributed across all servers.

{% hint style="info" %}
**Note:** Make sure to set the TTL (Time to Live) for all A records assigned to the SMB servers to 0 (Zero). This ensures that the client or the DNS server does not cache the IP.
{% endhint %}

### Create SMB shares

After establishing an SMB cluster, it is possible to declare SMB shares. Each share must have a name and a shared path. That is the path into the Weka filesystem. It can be the root of the Weka filesystem or a sub-directory.

If the share is declared without providing a sub-directory, the WekaFS root is used and it is not required to create a root folder (it already exists). If you need to create sub-directories, you can create the sub-directory in the shell using either a WekaFS mount or an NFS mount. Adjust the permissions of the sub-directory accordingly.&#x20;

### Filesystem permissions and access rights

Once the SMB cluster is connected to the Active Directory, it can assign permissions and access rights of SMB cluster filesystems to specific users or user groups. This is performed according to POSIX permissions (Windows permissions are stored in the POSIX permissions system). Any change in the Windows permissions is adapted to the POSIX permissions.

{% hint style="info" %}
**Note:** The initial set of POSIX permissions is done by the user through the driver/NFS.&#x20;
{% endhint %}

{% hint style="info" %}
**Note:** To obtain root access to the SMB shares, assign an Active Directory user with `uidNumber` and `gidNumber` of 0.
{% endhint %}

### Integration with previous versions of Windows&#x20;

Creating snapshots of the Weka filesystem and naming the access point in the `@GMT_%Y.%m.%d-%H.%M.%S` format exposes those to the previous windows versions mechanism.

To view a list of available previous versions that correspond to the filesystem snapshots, right-click a file or a folder in the Weka SMB share in the windows client, and select **Properties** -> **Previous Versions**.

**Example**: creating a snapshot using the CLI:

```
$ weka fs snapshot create fs_name snapshot_name --access-point `TZ=GMT date +@GMT-%Y.%m.%d-%H.%M.%S` 
```



**Related topics**

****[snapshots](../../fs/snapshots/ "mention")
