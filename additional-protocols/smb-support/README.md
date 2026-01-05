---
description: >-
  Configure and control WEKA's SMB-W implementation for seamless cross-platform
  file access across Windows, Linux, and macOS clients with concurrent
  multi-protocol support.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/smb-support
---

# Manage the SMB protocol

SMB (Server Message Block) is a network file-sharing protocol that facilitates connections to shared file and print services from remote systems. WEKA implements a modern SMB stack, referred to as SMB-W, which supports SMB versions 2 and 3.

WEKA SMB-W is an implementation of an SMB protocol enabling Windows, Linux CIFS, and macOS clients to access WEKA storage services with support for multi-protocol concurrent file access through SMB stack.

## Key features of SMB in WEKA

The SMB-W stack is designed for scalability, resilience, and distributed performance.

* **Scalability**: WEKA supports an SMB-W cluster consisting of 3 to 8 servers, each running the SMB gateway service. The backend can be any WEKA filesystem, with no limitations on size or performance.
* **Resilience**: SMB-W provides clustered file access with transparent failover. If a server fails, another server in the cluster automatically takes over operations, maintaining high availability.
* **Distribution**: All servers in the SMB-W cluster manage SMB filesystems concurrently. Performance scales with added hardware. SMB-W supports SMB Multichannel and SMB Direct, delivering advanced throughput and reliability.

### Advanced capabilities of SMB-W

* **SMB multichannel:** Enhances performance by leveraging multiple network connections simultaneously. Supported for properly configured SMB clients.
* **High availability and failover:** If an SMB-W container becomes isolated from the cluster, it stops automatically. Other servers take over its operations. (To manually restart a stopped container, run: `weka local restart smbw`).
*   **SMB Direct:** Enables SMB over RDMA (Remote Direct Memory Access) for reduced latency and improved performance.

    To enable SMB Direct, ensure the following prerequisites are met:

    * SMB-W servers are RDMA-enabled in both hardware and OS.
    * For Windows clients, configure the SMB client as multichannel.
    * When configuring a CIFS client to work with RDMA, perform the mounting on the host IP (not the floating IP).

## **SMB usage considerations**

* When managing SMB-W clusters through the GUI, note that any CLI limitations also apply to the GUI.
* Use ASCII format for fields such as domain names and share names.
* Before deploying SMB-W, ensure Active Directory and DNS services are properly configured.
*   Public cloud requirements: For AWS, WEKA has been validated with:

    * [AWS Managed Microsoft AD](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_getting_started.html)
    * [Amazon Route 53 Resolver](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-getting-started.html)

    Follow AWS guidance to configure these services if they are not already deployed.

{% hint style="info" %}
High availability (HA) for SMB-W is not supported in public cloud environments.
{% endhint %}

## SMB-W user mapping in WEKA

Authentication in the WEKA SMB-W cluster is integrated with a single Active Directory (AD) that can include multiple trusted domains. For SMB-W access, the Active Directory must support POSIX user (UID) and group (GID) resolution.

### **ID mapping from Active Directory**

WEKA supports two types of ID mapping from Active Directory:

* **RFC2307 mapping:** Requires `uidNumber` and `gidNumber` attributes to be defined for users and groups in AD. This method provides explicit control over UID/GID values.
*   **RID mapping:** Automatically maps AD users and groups without requiring additional attribute configuration. User IDs are derived from the AD security identifier (SID), simplifying deployment.

    (Changes to RID range configuration may affect UID/GID resolution and result in mismatches.)

### **Relevant Active Directory attributes**

For **RFC2307** mapping, ensure the following attributes are met:

* Users:
  * `uidNumber`: 0-4290000000
  * `gidNumber`: 0-4290000000; must correlate with a real group
* Groups:
  * `gidNumber:` 0-4290000000

### **ID range configuration**

The WEKA system allows custom configuration of AD ID ranges to prevent UID/GID overlap across domains:

* Each trusted domain must have a distinct ID range.
* The primary domain uses a default configurable range.
* A fallback range is available for users not assigned to any domain.

To prevent ID collisions, configure non-overlapping ranges for all domains.

For authoritative reference on Active Directory schema attributes, consult Microsoft documentation.

## Workflow overview: configure SMB support

This workflow outlines the key steps to configure SMB-W support in the WEKA system. For detailed CLI and GUI procedures, refer to the related How-To sections.

**Before you begin**

Ensure that a dedicated filesystem exists for storing persistent protocol configurations. If not, create one. For guidance, [#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention").

**Workflow**

1. **Configure SMB-W cluster**: Define the WEKA system servers that will participate in the SMB-W cluster and specify the Active Directory (AD) domain name.\
   In on-premises deployments, you can configure a pool of public IP addresses distributed across the SMB-W cluster. If a server fails, its IP addresses are reassigned to other servers in the cluster to maintain availability.
2. **Join the SMB-W cluster to the Active Directory domain:** Connect the WEKA system to the target AD domain. This includes required pre-configuration in AD and post-configuration in both the DNS Manager and Active Directory Users and Computers.
3. **Create SMB shares and set permissions:** Create the required shares and directories. By default, filesystem permissions are `root:root` with 755 access and must initially be set using a WEKA filesystem or NFS mount.

After the initial configuration, administrators can connect through Windows to manage and refine share-level permissions.

## **Round-robin DNS configuration for SMB-W load balancing**

To achieve effective load balancing across multiple WEKA servers running SMB-W, configure a round-robin DNS entry that resolves to the list of floating IPs assigned to the SMB-W cluster.

#### Configuration steps

1. **Create round-robin DNS entry**:
   * Define a DNS A record that maps to all floating IPs associated with the SMB-W servers.
   * The DNS entry must use the SMB-W cluster name, which must not exceed 15 characters.
2. **Set TTL to zero**:
   * Configure the TTL (Time to Live) value for each DNS record to 0.
   * This prevents client-side and recursive DNS caching, ensuring real-time IP resolution and balanced connection distribution.

#### Related Information

Refer to your DNS provider’s documentation for configuring round-robin DNS entries and TTL settings.

## SMB-W share creation

After configuring the SMB-W cluster, you can create SMB shares. Each share must include a unique name and a path within the target filesystem, either the root or a specific subdirectory.

* If no subdirectory is specified, the share maps to the root of the filesystem. Creating a separate root folder is not required in this case.
* To create subdirectories, mount the filesystem locally or through shell access. Create the required directories and set appropriate ownership and permissions before assigning them to SMB shares.

## Filesystem permissions and access rights for SMB-W

When integrating SMB-W clusters with Active Directory (AD), administrators can manage permissions and access rights for SMB-W filesystems using POSIX standards, Windows Access-Control Lists (ACLs), or a combination of both. This ensures secure, consistent access control across mixed environments.

#### **Grant root access**

To assign root-level access to an AD user:

* Set both the `uidNumber` and `gidNumber` attributes of the user to 0.

This setup grants full administrative control over all SMB-W shares.

#### **Access Control Lists (ACLs)**

ACLs in SMB-W allow fine-grained permission management for shares. Administrators can configure the following:

* **ACLs enabled:** Enables or disables Windows ACL support for the share. When enabled, the selected access control model is applied.
* **Access control model:**
  * **POSIX**: Enforces POSIX permission rules only.
  * **Windows**: Applies Windows-style security descriptors.
  * **Hybrid** _(default: POSIX)_: Supports both models, with the most recent change taking precedence.

This flexibility enables tailored access control strategies aligned with enterprise security policies and operational requirements.

## Integrate WEKA filesystem snapshots with Windows previous versions

WEKA supports integration with the Windows **Previous Version**s feature by creating filesystem snapshots using a specific access point format. When snapshots are labeled using the `@GMT_%Y.%m.%d-%H.%M.%S` syntax, they become visible to Windows clients through the Previous Versions tab.

#### Access snapshots from Windows

To view available snapshots:

1. Right-click any file or folder within a WEKA SMB-W share on a Windows client.
2. Select **Properties → Previous Versions**.

Available snapshots are listed by timestamp, corresponding to the snapshot access point labels.

#### Example: Create a snapshot using the CLI

Use the following command to create a timestamped snapshot accessible from Windows:

{% code overflow="wrap" %}
```
$ weka fs snapshot create fs_name snapshot_name --access-point `TZ=GMT date +@GMT-%Y.%m.%d-%H.%M.%S` 
```
{% endcode %}

Ensure the access point is generated in GMT to align with Windows expectations.

**Related topics**

[snapshots](../../weka-filesystems-and-object-stores/snapshots/ "mention")
