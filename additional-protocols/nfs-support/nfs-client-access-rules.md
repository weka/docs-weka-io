---
description: >-
  Control which NFS clients can reach an export with IP, DNS, and netgroup
  rules.
---

# NFS client access rules

Client access rules decide which NFS clients can mount an export and with which access. An NFS export grants access to client groups. Each client group holds rules that describe the clients that belong to it. A rule matches a client in one of three ways:

| Rule type | Example | Matches a client when |
| --- | --- | --- |
| IP address or subnet | `10.1.2.0/24` | The client's source address is inside the network. |
| DNS name or pattern | `node07.lab.example.com`, `*.lab.example.com` | A hostname resolves to the client's address, or a pattern matches the client's reverse DNS name. |
| Netgroup | `@gpu-nodes` | The client's reverse DNS name is a member of the netgroup. |

A client group can mix all three rule types. Listings show a netgroup rule as `@<netgroup name>`.

## Choose a rule type

The right rule type depends on how many clients the rule must cover and which DNS records your environment keeps. Each rule type relies on different DNS records and covers a different number of clients:

| Rule type | Clients per rule | DNS records the rule relies on |
| --- | --- | --- |
| IP address or subnet | All addresses in the network | None |
| DNS name | One | A forward (A) record for the name |
| DNS pattern | Any number of names that match the pattern | A reverse (PTR) record for each client address |
| Netgroup | Up to 512 members per netgroup | A reverse (PTR) record for each member address |

Each netgroup rule counts as one rule toward the client group rule maximum, regardless of the number of members.

## Evaluation order

When several rules in a client group can match a client, the evaluation order decides which one applies. Within a client group, the NFS server checks the IP rules first, then the DNS rules, and then the netgroup rules. The first rule that matches applies. The order in which the rules were created has no effect. When several client groups grant different access to the same export path, the permission priority determines the access the client gets.

## Netgroups

Netgroups give many clients the same access with a single rule, and let you change that access for all of them at once. A netgroup is a named list of client hostnames. One netgroup rule on a client group admits every member of the netgroup, so a single rule replaces one hostname rule per client. You add and remove members in bulk, from the command line or from a file, and every export that uses the client group applies the change. Several client groups can use the same netgroup, for example, one client group with read-write access and one with read-only access.

### How the NFS server matches a netgroup member

When a client connects, the NFS server resolves the client's address to a hostname and checks whether that name is a member of the netgroup. Members are therefore hostnames, not IP addresses. Add each member exactly as the NFS server resolves it. The resolver order in `/etc/nsswitch.conf` on the NFS server determines the name:

* **DNS resolves the address:** The PTR record returns a fully qualified name, for example, `node01.cluster.internal`.
* **Local files (`/etc/hosts`) or NIS come before DNS:** The returned name can be a short name, if the primary name in `/etc/hosts` has no domain.

{% hint style="info" %}
To find the name to add for a client, run `getent hosts <client-ip>` on an NFS server. The first name after the IP address is the canonical name. Use this check when the environment mixes resolvers, has dual-homed interfaces, or moves between local files and DNS.
{% endhint %}

### Membership check

The membership check finds netgroup members whose names no longer resolve, so you can fix their DNS records. One NFS server checks every netgroup member every 10 minutes: whether the hostname resolves, and whether the PTR record of its address returns the member name. A member that fails two consecutive checks is counted as unresolved, and the cluster raises the `NfsNetgroupUnresolvedMembers` alert. The check reports the status only. Access is decided by the name a client's PTR record returns when the client connects.

## Netgroup requirements and maximums

Check the requirements before you create netgroups, and plan the netgroups within the maximums.

### Requirements

* The cluster upgrade is complete on all containers. Adding netgroups, members, and netgroup rules is available after every container runs the upgraded version.
* An NFS configuration filesystem is set. See [#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations](../additional-protocols-overview.md#dedicated-filesystem-requirement-for-cluster-wide-persistent-protocol-configurations "mention").
* Changing netgroups requires the Tenant Admin role or higher. Listing and showing netgroups requires the Read Only role or higher.

{% hint style="info" %}
**Multi-tenancy:** When NFS multi-tenancy is enabled, netgroups are available only in the root tenant. See [manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention").
{% endhint %}

### Maximums

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

### Considerations

* A netgroup rule matches a client only through the PTR record of the client's address. Keep a PTR record for each member address. To give access to a client without a PTR record, use an IP rule.
* An IP rule matches first. A client that an IP rule admits is not checked against the netgroup rules of the same client group.
* Netgroups are managed from the CLI only. The GUI does not support netgroups in this version.

**Related topics**

[#manage-the-nfs-export-level-permissions](manage-nfs-using-the-cli.md#manage-the-nfs-export-level-permissions "mention") (CLI)

[#manage-nfs-netgroups](manage-nfs-using-the-cli.md#manage-nfs-netgroups "mention") (CLI)

[#configure-the-nfs-export-level-permissions](manage-nfs-using-the-gui.md#configure-the-nfs-export-level-permissions "mention") (GUI)
