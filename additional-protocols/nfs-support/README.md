---
description: >-
  Provide file access over NFS, without installing a client on the host.
---

# Manage the NFS protocol

NFS (Network File System) is a protocol that enables clients to access the filesystem without requiring the WEKA client software. This leverages the standard NFS implementation of the client's operating system.

The NFS implementation is compatible with NFSv3 or NFSv4[^1] protocols and overcomes inherent limitations in the NFS protocol, including support for more than 16 user security groups and NFS file-locking.

{% hint style="info" %}
**Multi-tenancy:** When NFS multi-tenancy is enabled, each tenant gets isolated client groups, exports, and floating IP addresses, and several NFS features become available only in the root organization. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

## NFS service deployment guidelines and requirements

Adhere to the following guidelines and requirements when deploying the NFS service.

### **Configuration filesystem**

A persistent cluster-wide configuration filesystem is required for the protocol's internal operations using NFSv4 or Kerberos integration. See [#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations](../additional-protocols-overview.md#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations "mention").

### **Interface groups**

An interface group provides resilience and high availability for NFS services by enabling transparent failover between NFS servers.

* **Resilience:** An interface group requires a minimum of two servers to ensure continuous NFS availability. If a server becomes unavailable, its floating IPs automatically migrate to a healthy server in the group.
* **Server membership:** An interface group consists of a set of servers, each with a designated network port. All ports must be associated with the same subnet.
* **Floating IP management:** The group includes one or more floating IP addresses used by the NFS service. All floating IPs must reside in the same subnet, and each server must already have a static IP configured on the corresponding network interface.
* **Routing configuration:** Floating IPs must comply with the network routing configuration to ensure proper reachability and failover behavior.

{% hint style="info" %}
Floating IPs are supported on AWS but not on Azure, GCP, and OCI cloud environments.
{% endhint %}

An interface group can have only a single port. Therefore, two interface groups are required to support High Availability (HA) in NFS. When assigning the other server ports to these interface groups, consider the network topology to ensure no single point of failure exists in the switch.

You can define up to 10 different interface groups. Use multiple interface groups if the cluster connects to multiple subnets. You can set up to 50 servers in each interface group.

The system automatically distributes the IP addresses evenly across the servers and ports. If a server fails, its IP addresses are redistributed to the remaining servers.

{% hint style="warning" %}
Floating IP addresses used by the NFS service are configured automatically on the appropriate server. Refrain from manually configuring or using the floating IP.
{% endhint %}

{% hint style="info" %}
**Multi-tenancy:** These limits apply to the root organization. A tenant network space supports a maximum of 8 floating IP addresses, and a tenant is assigned to an interface group rather than owning one. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

### Round-robin DNS server configuration

To ensure load balancing between the NFS clients on the different servers serving NFS, it is recommended that a round-robin DNS entry be resolved to the list of floating IPs.

{% hint style="info" %}
Set the TTL (Time to Live) for all records assigned to the NFS servers to 0 (Zero). This action ensures that the client or the DNS server does not cache the IP.
{% endhint %}

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin_DNS)

### NFS client mount

The NFS client mount is configured using the standard NFS stack operating system. The NFS server IP address must point to the round-robin DNS name.

### Access Control List (ACL) in NFS

Access Control List (ACL) in NFS (Network File System) provide fine-grained control over file permissions, offering more flexibility than traditional POSIX permissions. NFS supports multiple ACL flavors, each serving different use cases and interoperability needs.

{% hint style="info" %}
To enable ACL functionality, you must configure LDAP to manage user and group information.
{% endhint %}

{% hint style="warning" %}
**Multi-tenancy:** ACLs are available only in the root organization. On a tenant export, an explicitly requested ACL type is rejected, and an ACL type left at its default is silently set to `NONE`. An export created without naming an ACL type therefore has weaker access control than the default described here. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

**ACL flavors in NFS**

NFS supports the following ACL flavors:

* **None**: No ACL enforcement or updates occur, even if POSIX ACLs exist on a file or directory. This flavor is used when ACL management is unnecessary.
* **POSIX**: NFS enforces POSIX ACLs, ensuring compatibility with other protocols. However, the finer granularity of NFSv4 ACLs is lost when mapped to POSIX ACLs. This option is suitable for environments requiring basic ACL management across multiple protocols.
* **NFSv4**: NFSv4 ACLs are enforced directly, without mapping to POSIX ACLs. This flavor preserves the full granularity of NFSv4 ACLs but does not support interoperability with other protocols. ACLs are stored as extended attributes and mapped to user and group IDs (UID/GID). Use NFSv4 when full NFSv4 ACL granularity is required, and interoperability with other protocols is not a concern.
* **Hybrid**: This flavor combines both POSIX and NFSv4 ACLs to support interoperability. NFS ensures consistency between the two ACL flavors, and if any inconsistency arises, POSIX ACL is used for enforcement. Hybrid is ideal for environments requiring both interoperability and full NFSv4 ACL functionality.

{% hint style="info" %}
**NFSv3 and ACLs:** The NFSv3 implementation does not support ACLs. Access control for NFSv3 clients is enforced by the underlying filesystem using standard POSIX file permissions.
{% endhint %}

**Managing ACLs in NFS**

ACL configuration and management in NFS can be done through various interfaces:

* **CLI**: The `weka nfs permission` and `weka nfs global-config` commands allow users to configure ACLs at the permission and cluster level. NFS permissions exporting files from the same backend file system must share the same ACL flavor.
* **GUI**: The NFS settings in the user interface include options to enable ACLs and configure default ACL flavors (None, POSIX, NFSv4, Hybrid). Changes to ACL settings may require restarting the NFS containers.
* **Configuration filesystem**:\
  ACL flavors and related configurations are tracked in the global configuration filesystem, ensuring consistent management of permissions across the system.

{% hint style="info" %}
**ACL flavors and shared filesystems:** NFS exports backed by the same filesystem must use the same ACL flavor. To use ACL flavors (POSIX, NFSv4, or Hybrid), ensure all exports on that filesystem use NFSv4.
{% endhint %}

**Upgrading and ACLs**

When upgrading, the default ACL flavor for all permissions sets to **POSIX**. ACLs are enabled by default. To ensure proper ACL functionality, both `.config_fs` and LDAP must be configured.

## NFS client access rules

An NFS export grants access to client groups. Each client group holds rules that describe the clients that belong to it. A rule matches a client in one of three ways:

| Rule type | Example | Matches a client when |
| --- | --- | --- |
| IP address or subnet | `10.1.2.0/24` | The client's source address is inside the network. |
| DNS name or pattern | `node07.lab.example.com`, `*.lab.example.com` | A hostname resolves to the client's address, or a pattern matches the client's reverse DNS name. |
| Netgroup | `@gpu-nodes` | The client's reverse DNS name is a member of the netgroup. |

A client group can mix all three rule types. Listings show a netgroup rule as `@<netgroup name>`.

**Evaluation order**

Within a client group, the NFS server checks the IP rules first, then the DNS rules, and then the netgroup rules. The first rule that matches applies. The order in which the rules were created has no effect. When several client groups grant different access to the same export path, the permission priority determines the access the client gets.

### Netgroups

A netgroup is a named list of client hostnames. One netgroup rule on a client group admits every member of the netgroup, so a single rule replaces one hostname rule per client. You add and remove members in bulk, from the command line or from a file, and every export that uses the client group applies the change. Several client groups can use the same netgroup, for example, one client group with read-write access and one with read-only access.

When a client connects, the NFS server looks up the PTR record of the client's address and checks whether the returned name is a member of the netgroup. Members are therefore hostnames, not IP addresses. Add each member exactly as its PTR record returns it: if the PTR record returns a fully qualified name, add the fully qualified name.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Is "add each member exactly as its PTR record returns it, short or fully qualified" the rule to publish? The admin guide (5.2) says so; the matching code in the NFS server was not read.
{% endhint %}

**Membership check**

One NFS server checks every netgroup member every 10 minutes: whether the hostname resolves, and whether the PTR record of its address returns the member name. A member that fails two consecutive checks is counted as unresolved, and the cluster raises the `NfsNetgroupUnresolvedMembers` alert. The check reports the status only. Access is decided by the name a client's PTR record returns when the client connects.

### Choose a rule type

Each rule type relies on different DNS records and covers a different number of clients:

| Rule type | Clients per rule | DNS records the rule relies on |
| --- | --- | --- |
| IP address or subnet | All addresses in the network | None |
| DNS name | One | A forward (A) record for the name |
| DNS pattern | Any number of names that match the pattern | A reverse (PTR) record for each client address |
| Netgroup | Up to 512 members per netgroup | A reverse (PTR) record for each member address |

Each netgroup rule counts as one rule toward the client group rule maximum, regardless of the number of members.

### Netgroup requirements and maximums

**Requirements**

* The cluster upgrade is complete on all containers. Adding netgroups, members, and netgroup rules is available after every container runs the upgraded version.
* An NFS configuration filesystem is set. See [Configuration filesystem](#configuration-filesystem).
* When NFS multi-tenancy is enabled, netgroups are available only in the root tenant.
* Changing netgroups requires the Tenant Admin role or higher. Listing and showing netgroups requires the Read Only role or higher.

**Maximums**

| Object | Maximum |
| --- | --- |
| Netgroups | 128 |
| Members per netgroup | 512 |
| Members across all netgroups | 8,192 |
| Hostnames in one member add or remove request | 512 |
| Netgroup name length | 64 characters |
| Member hostname length | 253 characters |
| Host list file size | 1 MiB |
| Client group rules, across all client groups | 512 |

A netgroup name starts with a letter or an underscore, and contains only letters, digits, periods (`.`), underscores (`_`), and hyphens (`-`). Names are unique regardless of letter case. Member hostnames are stored in lowercase.

**Considerations**

* A netgroup rule matches a client only through the PTR record of the client's address. Keep a PTR record for each member address. To give access to a client without a PTR record, use an IP rule.
* An IP rule matches first. A client that an IP rule admits is not checked against the netgroup rules of the same client group.
* Netgroups are managed from the CLI.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Confirm that the 6.1.0 GUI has no netgroup support. The dashboard package has no netgroup code at the 6.1.0 tag.
{% endhint %}

## NFS integration with Kerberos service

NFS integrates with an existing Kerberos service to provide client authentication, data integrity, and data privacy over the wire, ensuring robust security even across untrusted networks.

The Kerberos security levels are:

* **krb5:** Implements basic Kerberos authentication.
* **krb5i:** Incorporates Kerberos authentication with data integrity assurance.
* **krb5p:** Integrates Kerberos authentication with data integrity and privacy measures.

{% hint style="info" %}
NFS exports created before configuring Kerberos are not updated automatically when using Kerberos. The Authenticator Type must be modified to one of the Kerberos types to leverage the Kerberos advantages.
{% endhint %}

{% hint style="warning" %}
**Multi-tenancy:** Kerberos is available only in the root organization. Tenant connections that attempt `RPCSEC_GSS` are rejected with `AUTH_TOOWEAK`, and tenant mounts use `sec=sys` only. The Kerberos flavors are also removed from the tenant view of `weka nfs global-config`, so a cluster administrator and a tenant administrator running that command see different output. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

### Kerberos LDAP configurations

Kerberos authentication for NFS is supported using AD and Kerberos MIT:

* **Active Directory (AD):** NFS integrates with Active Directory (AD), which includes built-in Kerberos services. The system interacts with the AD using the Kerberos protocol to authenticate service requests among trusted devices.
* **Kerberos MIT:** NFS integrates with Kerberos MIT, implementing the Kerberos protocol, which uses secret-key cryptography for authentication across insecure networks. This protocol is widely standardized and utilized.

{% hint style="info" %}
**Realm consistency:** The NFS service is registered in one Kerberos realm. With MIT Kerberos, the NFS clients and the Key Distribution Center (KDC) reside in the same realm as the NFS service. With Active Directory, clients in other domains of the same forest authenticate through the forest trusts.
{% endhint %}

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** With several Active Directory domains, do the forest trusts cover clients in the other domains, or must clients still share the NFS service's realm? The LDAP guide (1.3, 4.5) says the 6.0 single-realm rule no longer applies to AD. This was not checked in the code.
{% endhint %}

### Kerberos service interactions basic outline

The following Kerberos service interactions ensure secure communication between the client and the NFS server:

1. **Client authentication and ticket request:** The client sends a request, including encrypted credentials, to the Authentication Server for a Ticket Granting Ticket (TGT).
2. **Ticket generation and delivery:** The Authentication Server verifies the client’s identity, generates a session key, forms a TGT, and sends these to the client.
3. **Ticket extraction and service request:** The client decrypts the received message, extracts the session key and the TGT, and sends a service request to the Ticket Granting Server.
4. **Service session key generation & ticket formation:** The Ticket Granting Server verifies the TGT, generates a Service Session Key, and forms a Service Ticket.
5. **Service ticket delivery & extraction:** The Ticket Granting Server sends the Service Ticket and the Service Session Key to the client, who then decrypts the response and extracts these for later use.
6. **Service access & verification:** The client generates an authenticator for the network service and sends it along with the Service Ticket to the network service, which then verifies the Service Ticket and the authenticator.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Kerberos_process.png" alt=""><figcaption><p>Kerberos service interactions (simplified view)</p></figcaption></figure></div>

{% hint style="info" %}
This diagram illustrates the Kerberos service interactions in a simplified manner. It highlights how secure communication is established over insecure networks. Note that this is a broad representation, and actual implementations may differ.
{% endhint %}

## NFS user and group resolution

The NFS service resolves user and group names and IDs for NFSv4 ownership, ACLs, Kerberos principals, and manage-gids. With manage-gids, the NFS server looks up a user's supplementary groups instead of using the up to 16 groups that the client sends. Each NFS container runs its own identity service (SSSD), configured with `weka nfs ldap`.

| Mode | Command | Directory | How the cluster connects to the directory |
| --- | --- | --- | --- |
| Active Directory with Kerberos | `weka nfs ldap setup-ad`, after `weka nfs kerberos registration setup-ad` | Active Directory | The machine account of the NFS service, through its keytab |
| Active Directory without Kerberos | `weka nfs ldap setup-ad-nokrb` | Active Directory | A machine account that the command creates, through its keytab |
| OpenLDAP | `weka nfs ldap setup-openldap` | OpenLDAP or another RFC 2307 LDAP directory | A read-only bind user and its password |
| On-host | `weka nfs ldap setup-onhostldap` | The directory that the server's own SSSD uses | The configuration of each server |

The identity configuration is stored on the NFS configuration filesystem, so every NFS container uses the same configuration. Set the configuration filesystem before you configure any mode except on-host.

**Applying a change**

The `weka nfs ldap` commands restart the NFS containers after they succeed, unless you add `--no-restart`. The `weka nfs kerberos` commands restart the NFS containers only with `--restart`. A restart pauses I/O for connected clients during the restart and the grace period. With `--no-restart`, the running NFS containers keep the previous configuration until they restart.

**Several Active Directory domains**

After `setup-ad` or `setup-ad-nokrb`, the identity service discovers the other domains of the Active Directory forest, so users and groups from trusted domains in the forest resolve without more configuration. To list the domains explicitly, export the configuration, add the domains, and import it. See [#add-active-directory-domains](nfs-support-1.md#add-active-directory-domains "mention").

**TLS to the directory**

To verify the certificate of the directory server, import the configuration with the CA certificate. For each configured domain, the cluster then sets the certificate path, StartTLS, and certificate verification (`ldap_tls_reqcert = demand`). Other values in the imported file are kept. See [#verify-the-directory-server-certificate](nfs-support-1.md#verify-the-directory-server-certificate "mention").

**Required roles and directory privileges**

| Account | Requirement |
| --- | --- |
| Cluster user who runs the commands | The Tenant Admin role or higher. With NFS multi-tenancy enabled, run the commands in the root tenant. |
| Active Directory account for `kerberos registration setup-ad` and `ldap setup-ad-nokrb` | Can get a Kerberos ticket and create a computer object under the base OU (default `CN=Computers`). When you register the same service name again, can reset the password of that computer object and write its `servicePrincipalName` and `userPrincipalName`. The password is used once and is not stored. |
| OpenLDAP reader user for `ldap setup-openldap` | Can bind and search under the base DN. The command runs this search before it writes the configuration. |
| Machine account or reader user, while NFS runs | Can read the users and groups and their POSIX attributes (`uidNumber` and `gidNumber`). |

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Confirm the Active Directory rights above for publication, and whether Domain Admin is ever required. They come from the LDAP guide (3.3, 3.4) and the commands the registration runs. Also confirm that the registration password is not stored. Is any privilege beyond reading the POSIX attributes needed for the machine account (the ticket asks about "LDAP View")?
{% endhint %}

**Considerations**

* User and group IDs come from the POSIX attributes `uidNumber` and `gidNumber`, not from Active Directory SIDs. Populate these attributes for every user and group that accesses NFS.
* An OpenLDAP configuration covers one domain.
* To use Active Directory without Kerberos on a cluster with a Kerberos registration, reset the Kerberos registration first.
* Exports with manage-gids need a working identity source on each NFS server. The cluster raises the `NfsIdentitySourceUnavailable` alert for a server without one.
* The on-host mode uses the SSSD service of each server. Keep SSSD running on every NFS server.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Confirm two points: an OpenLDAP configuration is one domain on one server by design, and the on-host mode does not need the configuration filesystem.
{% endhint %}

## Scalability, load balancing, and resiliency

For performance scalability, add as many servers as possible to the interface group.

The cluster supports a maximum of 200 floating IPs to facilitate load balancing by distributing them evenly across all interface group servers and ports. In systems with more NFS interfaces than this limit, not every interface will have a dedicated floating IP.

When different clients resolve the DNS name into an IP service, each receives a different IP address, ensuring that other clients access different servers. This design allows the system to scale and serve thousands of clients.

To ensure service resilience, if a server fails, the system reassigns all IP addresses associated with the failed server to other servers using GARP[^2] network messages. The clients then reconnect to the new servers without any reconfiguration or service interruption.

{% hint style="info" %}
During a floating IP takeover, two servers can briefly answer for the same address. A 30-second grace window suppresses duplicate-address detection for that period, so `ArpServerDuplicateIPDetected` is not raised for a normal failover. The event still fires for a genuine address conflict.
{% endhint %}

## NFS server resources

Each NFS container serves clients within three resources: client connections, open files, and memory. The maximum of each resource applies to every NFS container on its own, not to the cluster, a tenant, or an export.

| Resource | Default | Accepted values | Setting |
| --- | --- | --- | --- |
| Client connections | Automatic: 1024 for each NFS server. With NFS multi-tenancy, the automatic value is sized from the number of NFS containers. | `0` (automatic), or 1024 to 65536 | `--max-client-connections` |
| Open files | 500000 | `0` (default), or 10000 to 10000000 | `--max-open-fds` |
| Memory ceiling | 32 GiB | 2 GiB to 512 GiB, in whole GiB | `--max-memory` |

Set these with `weka nfs global-config set`, and view the usage with `weka nfs resource-usage`. See [#configure-the-nfs-global-settings](nfs-support-1.md#configure-the-nfs-global-settings "mention") and [#view-nfs-server-resource-usage](nfs-support-1.md#view-nfs-server-resource-usage "mention").

Changes to the client connections and open files maximums apply to the running NFS servers. Set the memory ceiling before you configure the first NFS container. It then applies to every NFS container.

Each NFS server process has a file descriptor limit equal to the client connections maximum, plus the open files maximum, plus 4096. The kernel settings `fs.nr_open` and `fs.file-max` on each server must allow this value. If a server's kernel settings are lower, the cluster raises the `NfsResourceLimitNotApplied` alert, which names the setting to raise.

**Resource states**

| State | Usage of the maximum |
| --- | --- |
| `OK` | Below 70% |
| `HIGH` | 70% or more |
| `LIMIT` | 90% or more |

The cluster raises an alert for each resource that approaches its maximum. See [list-of-alerts-and-corrective-actions.md](../../operation-guide/alerts/list-of-alerts-and-corrective-actions.md "mention").

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Two NFS resource alerts name internal commands or files in their corrective action, which contradicts the rule of keeping internal commands out of customer documentation. The alerts list is generated from these texts, so they appear on docs.weka.io as written:

* `NfsFdReaperStalled`: "Collect `weka debug manhole dump_ganesha_fd_state` on the leader and open a support case; restarting the NFS container releases the descriptors."
* `NfsMappingsApproachingLimit`: "Make sure the NFS server runs with the jemalloc retain:true default (a custom nfs/custom/jemalloc.conf may override it) and restart it on this host, or raise vm.max_map_count on the host."

Can these actions point to the Customer Success Team instead (for example, "Contact the Customer Success Team. Restarting the NFS container releases the descriptors.")? If the internal commands must stay, confirm that this is intended.
{% endhint %} The `nfs_resources` statistics category records the same values over time. See [statistics-list.md](../../operation-guide/statistics/statistics-list.md "mention").

**Behavior at a maximum**

* **Client connections:** New connections wait until a connection closes. Existing connections continue.
* **Open files:** A request that needs another open file is delayed, and the client retries it.
* **Memory:** The NFS container restarts, and clients reclaim their open and lock state during the grace period.

{% hint style="danger" %}
**INTERNAL, remove before publication. TBD (Hemant):** Confirm the behavior at each maximum for publication. It comes from the resource-usage guide (3.1 to 3.3), not from the code.
{% endhint %}

**Considerations**

* Each `nconnect` channel that a client opens counts as one client connection.
* Lowering the client connections maximum below the current usage keeps the existing connections. The new maximum applies to new connections.
* Usage is reported for each NFS container. To find the clients that use a container's connections, run client-side tools such as `ss` on the clients.

## NFS file-locking support

NFS byte-range [advisory locking](#user-content-fn-3)[^3] is supported for NFS versions 3, 4, and 4.1. This mechanism ensures synchronized access to files in a networked environment by allowing multiple processes to coordinate access to shared files. It helps maintain data integrity and consistency by preventing concurrent modifications that could lead to data corruption. The implementation is interoperable with POSIX byte-range advisory locks, enabling compatibility and coordination between NFS clients and the filesystem.

{% hint style="warning" %}
**Multi-tenancy:** NFSv3 locking (NLM) is not offered on tenant floating IP addresses. Clients that mount a tenant export with NFSv3 cannot take locks. NFSv4.1 locking is available to tenants. Plan client compatibility accordingly. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

### NFS file-locking prerequisites for NFSv3

* **Port prerequisites:** Ports used by the `nlockmgr` and `status` services must be open on the clients and the servers. Use **one** of the following methods to meet this requirement:
  *   Disable and stop `firewalld` using the commands:

      ```
      systemctl stop firewalld.service
      systemctl disable firewalld.service
      ```
  *   Set fixed ports and open them:
      * On the servers, set the lock manager and status monitor ports. For example:

        ```
        weka nfs global-config set --lockmgr-port 47000 --statmon-port 46999
        ```
      * On the clients, set fixed ports for the status monitor and lock manager by using the NFS configuration of the client's operating system, and open them.
* **NFS client prerequisite:** To use NFSv3 with locking on an NFS client, ensure the `rpc.statd` service runs in the NFS client. This enables clients to mount NFSv3 shares.

#### View file locks

Inspecting active file locks is not exposed as a supported operation. If you need to identify which client holds a lock on a file, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).

## NFS service deployment high-level workflow

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/NFS_deploy_workflow.png" alt=""><figcaption><p>NFS service deployment high-level workflow</p></figcaption></figure></div>

For detailed procedures, see the related topics.

**Related topics**

[nfs-support.md](nfs-support.md "mention")

[nfs-support-1.md](nfs-support-1.md "mention")

[supported-nfs-client-mount-options.md](supported-nfs-client-mount-options.md "mention")

[manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention")

[^1]: NFSv4.0 and NFSv4.1

[^2]: **GARP (Gratuitous Address Resolution Protocol)**: Network protocol used for IP address reassignment.

[^3]: **Advisory locking**

    A file locking mechanism where processes voluntarily check for and honor locks set by others. It requires all cooperating processes to follow the locking protocol, as the operating system does not enforce it automatically.
