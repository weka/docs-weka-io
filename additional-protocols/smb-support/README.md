---
description: The WEKA configuration of the SMB protocol for shared Windows clients.
---

# Manage the SMB protocol

SMB (Server Message Block) is a network file-sharing protocol facilitating connections to shared file and print services from remote systems. WEKA's implementation features a modern SMB-W stack, with the option to use the legacy open-source Samba stack if required. Both SMB implementations in WEKA fully support SMB versions 2 and 3.

WEKA's SMB implementation enables seamless access to storage services for both Windows and macOS clients. It facilitates shared access from multiple clients, supporting a multi-protocol approach that allows files to be accessed simultaneously through SMB, NFS, and WEKA native filesystem drivers.

## Key features of SMB implementation in WEKA

The implementation of SMB in the WEKA system is characterized by scalability, resilience, and distribution.

* **Scalability:** WEKA supports an SMB cluster ranging from 3 to 8 servers, with the SMB gateway service running on these servers. The backend filesystem can be any WEKA filesystem, making it virtually unlimited in size and performance.
* **Resilience:** WEKA's SMB implementation provides clustered access to files in a WEKA filesystem, allowing multiple servers to collaborate. In a server failure, another can seamlessly take over operations, ensuring failover support and high availability. The standard resiliency of WEKA against failures also extends to SMB filesystems, with SMB-W supporting transparent failover for enhanced resilience compared to legacy SMB.
* **Distribution:** A WEKA implementation is distributed over a cluster, where all servers manage all SMB filesystems concurrently. This design allows the performance supported by SMB to scale with additional hardware resources, ensuring high availability. SMB-W introduces support for SMB Multichannel and SMB Direct, providing advanced capabilities compared to the legacy SMB.

## Additional features of SMB-W

In addition to legacy SMB features, SMB-W introduces the following capabilities:

* **SMB Multichannel:** WEKA supports SMB clients configured with multichannel, enhancing performance in such configurations.
* **SMB Transparent Failover:** This feature ensures continuous IO availability during failover scenarios.
* **SMB Direct:** SMB over Remote Direct Memory Access (RDMA). To enable SMB Direct, ensure the following prerequisites are met:
  * SMB-W servers are RDMA-enabled in both hardware and OS.
  * For Windows clients, configure the SMB client as multichannel.
  * When configuring a CIFS client to work with RDMA, perform the mounting on the host IP (not the floating IP).

## SMB user mapping in the WEKA system

Authentication in the WEKA SMB system is supported by a single Active Directory with multiple trusted domains. To enable SMB access, the Active Directory must resolve POSIX users (uid) and groups (gid) mapping.

### **Id-mapping from Active Directory**

The WEKA system automatically pulls user and group information from the Active Directory, supporting two types of id-mapping:

* **RFC2307:** Requires `uidNumbe`r and `gidNumbe`r to be defined in the AD user attributes.
* **rid:** Creates a local mapping with AD users and groups. Using rid mapping simplifies configuration as user IDs are automatically tracked. All domain user accounts and groups become available on the domain member without additional attribute settings. However, changes to the rid AD range configuration may result in altered user mapping and incorrect uid/gid resolution.

### **Active Directory attributes**

For RFC2307, the following Active Directory attributes are relevant for users:

<table data-header-hidden><thead><tr><th width="265">AD Attribute</th><th>Description</th></tr></thead><tbody><tr><td><strong>AD attribute</strong></td><td><strong>Description</strong></td></tr><tr><td><code>uidNumber</code></td><td>0-4290000000</td></tr><tr><td><code>gidNumber</code></td><td>0-4290000000; must correlate with a real group</td></tr></tbody></table>

For groups of users according to RFC2307:

<table data-header-hidden><thead><tr><th width="266">AD Attribute</th><th>Description</th></tr></thead><tbody><tr><td><strong>AD attribute</strong></td><td><strong>Description</strong></td></tr><tr><td><code>gidNumber</code></td><td>0-4290000000</td></tr></tbody></table>

### **ID range configuration**

The default configuration for the WEKA system's AD server IDs can be changed, and it serves as the primary AD range (if additional trusted domains are defined).

To avoid ID overlapping and collisions, set the range or ranges for multiple domains.

When joining multiple domains, it is necessary to set the ID range for each, ensuring they do not overlap. Additionally, there is a configurable default mapping range for users not part of any domain.

For more details about Active Directory properties, refer to the Microsoft site.

## Workflow overview: configure SMB support

This workflow provides a concise overview of the essential steps to configure SMB support in the WEKA system. Detailed procedures for both GUI and CLI implementations can be found in the following "How-To" sections.

**Before you begin**

* Verify a persistent cluster-wide configuration filesystem for protocols is set. If the filesystem is not already created, create a filesystem with 100 GB capacity.
* Verify that the DNS "nameserver" of the servers participating in the SMB cluster is configured to the Active Directory server.

**Workflow**

1. **Configure SMB cluster**: Set the WEKA system servers participating in the SMB cluster and set the domain name.
   * In on-premises deployments, it is possible to configure a list of public IP addresses distributed across the SMB cluster. If a server fails, the IP addresses from that server are reassigned to another server.
2. **Join the SMB cluster in the Active Directory:** Connect and define the WEKA system in the Active Directory.
3. **Create shares and folders, and set permissions:** By default, the filesystem permissions are root/root/755 and initially can only be set by a WekaFS/NFS mount.

Once these steps are done, it is possible to connect as an administrator and define permissions through the Windows operating system.

## **Round-robin DNS server configuration for SMB load balancing**

For effective load balancing across multiple WEKA servers serving SMB, it is recommended to configure a round-robin DNS entry that resolves to the list of floating IPs.

Follow these steps to optimize the round-robin DNS configuration:

1. **Configure round-robin DNS entry:** Set up a round-robin DNS entry to distribute the load evenly among the different WEKA servers. This entry must resolve to the list of floating IPs associated with the SMB servers.
2. **Adjust TTL (Time to Live):** To prevent caching of IP addresses by clients or DNS servers, set the TTL for all records assigned to the SMB servers to 0 (Zero). This ensures dynamic and real-time resolution of IPs for efficient load balancing.

**Related information**

For more details on round-robin DNS configurations, refer to the relevant documentation or resources related to round-robin DNS.

## SMB shares creation

After setting up the SMB cluster, you can create SMB shares. Each share must be assigned a name and a shared path to the filesystem, which can be the filesystem's root or a sub-directory.

* If the share is declared without specifying a sub-directory, the WekaFS root is automatically used. In this case, there's no need to create a root folder, as it already exists.
* To create sub-directories, use either a WekaFS mount or an NFS mount in the shell. Adjust the permissions of the sub-directory accordingly.

This approach ensures flexibility and ease of use when defining SMB shares within the WEKA environment.

## Filesystem permissions and access rights configuration

When integrating the SMB cluster with Active Directory, administrators can assign permissions and access rights for SMB cluster filesystems to specific users or user groups. These assignments adhere to POSIX permissions guidelines, as Windows permissions are stored within the POSIX permissions system. Any changes to Windows permissions are automatically reflected in the POSIX permissions.

To manage these permissions effectively, follow these guidelines:

* **Initial POSIX permissions setup:** Configure initial POSIX permissions through the driver/NFS.
* **Root access to SMB shares:** Grant root access to SMB shares by assigning an Active Directory user with a `uidNumber` and `gidNumber` set to `0`.
* **Windows permissions configuration:** Specify Windows permissions for shares, folders, and files by enabling or disabling Full Control, Modify, and Write collectively. This ensures a seamless translation into POSIX permissions.

## WEKA filesystem snapshots integration with Windows' previous versions

Generating WEKA filesystem snapshots and labeling the access point in the `@GMT_%Y.%m.%d-%H.%M.%S` format makes them accessible through the Windows previous versions mechanism.

To access a list of previous versions associated with the filesystem snapshots, right-click on a file or folder within the WEKA SMB share on the Windows client and navigate to **Properties -> Previous Versions**.

**Example**: Create snapshots using CLI with the required access point syntax.

{% code overflow="wrap" %}
```bash
$ weka fs snapshot create fs_name snapshot_name --access-point `TZ=GMT date +@GMT-%Y.%m.%d-%H.%M.%S` 
```
{% endcode %}



**Related topics**

[snapshots](../../fs/snapshots/ "mention")
