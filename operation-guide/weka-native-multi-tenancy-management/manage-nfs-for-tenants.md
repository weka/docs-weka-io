---
description: >-
  Give tenants NFS access without a client installation. Enable NFS
  multi-tenancy, assign tenants to interface groups, and understand which NFS
  features are available to a tenant.
---

# Manage NFS for tenants

## Overview

NFS multi-tenancy gives each tenant its own NFS service: isolated client groups, isolated exports, and dedicated floating IP addresses reached through the tenant's network space. Tenants gain filesystem access without installing any client software.

Tenant NFS access works differently from tenant POSIX access, and the difference matters before you provision anything:

| Access path | How a tenant is isolated |
| --- | --- |
| **POSIX (wekafs)** | Authentication. Users obtain a mount token through `weka user login --tenant`, and mounting is limited to stateless clients. |
| **NFS** | Network topology. The tenant's floating IPs live in its network space and VLAN. Connections use `sec=sys` and carry no token. |

Both paths keep tenants separated from each other, but they rely on different mechanisms. An NFS export is reachable by anything that can route to the tenant's floating IPs, so the network space boundary is the security boundary. Size and segment the network space accordingly.

All tasks in this topic require the **ClusterAdmin** role unless stated otherwise.

**Related topics**

[multi-tenancy-cluster-level-administration.md](multi-tenancy-cluster-level-administration.md "mention")

[README.md](../../additional-protocols/nfs-support/README.md "mention")

## Enable NFS multi-tenancy

NFS multi-tenancy is disabled by default and applies to the whole cluster. Enabling it changes how every NFS object is scoped, so review the prerequisites before you switch it on.

#### Before you begin

Enabling fails if any of the following exist in the cluster:

* Kubernetes NFS integration is enabled cluster-wide.
* An NFS export on a tenant filesystem uses `manage_gids`.
* A client group belonging to a tenant has a name-based (DNS) rule.

Resolve these first. The three conditions are unrelated to each other, and the error names only the one it encountered.

{% hint style="warning" %}
Enabling or disabling NFS multi-tenancy requires an NFS container restart to take effect. Plan the change for a maintenance window.
{% endhint %}

#### **GUI procedure**

1. From the menu, select **Manage > Protocols**.
2. Select **NFS**, then open the **Settings** tab.
3. In the **Global settings** section, select **Update**.
4. Set **Multi-Tenancy** to on.
5. Select **Submit**, then restart the NFS containers.

#### CLI alternative

```bash
weka nfs global-config set --enable-multi-tenant on
```

To confirm the current state:

```bash
weka nfs global-config show
```

{% hint style="info" %}
Mutating NFS commands wait for the configuration to propagate to every NFS server before returning. This typically takes about 55 seconds and can take up to 120 seconds. A command that appears to hang is usually waiting for propagation.
{% endhint %}

## Assign a tenant to an interface group

An interface group owns a set of floating IP addresses. Assigning a tenant to an interface group allocates floating IPs from that group's network space to the tenant, which is what makes the tenant's exports reachable.

#### Before you begin

* The tenant must already exist and have at least one network space assigned. See [Create a tenant environment](multi-tenancy-cluster-level-administration.md#create-a-tenant-environment).
* The network space must define a floating IP range through `--fip-range`. <!-- TBD [Is `--fip-range` available on `weka cluster network-space add`, on `update`, or on both? The prerequisite assumes it can be set at creation.] -->
* A tenant network space supports a maximum of **8 floating IP addresses**.

{% hint style="info" %}
The root organization is never assigned to an interface group. It uses the interface group's floating IPs directly. Only tenants require an explicit assignment.
{% endhint %}

#### CLI procedure

<!-- TBD [Do GUI screens exist for tenant-to-interface-group assignment and for the Tenants column? This section is CLI-only because no captures were available. If the screens exist, this section needs a GUI procedure to match the rest of the multi-tenancy topics.] -->

<!-- TBD [Confirm the argument order for `weka nfs interface-group tenant add|move|delete`. Documented here as `<interface-group> <tenant>`; the review supplied the verbs but not the signature.] -->

List the tenants currently assigned to interface groups:

```bash
weka nfs interface-group tenant list
```

Assign a tenant to an interface group:

{% code overflow="wrap" %}
```bash
weka nfs interface-group tenant add <interface-group> <tenant>
```
{% endcode %}

Move a tenant to a different interface group:

{% code overflow="wrap" %}
```bash
weka nfs interface-group tenant move <interface-group> <tenant>
```
{% endcode %}

Remove a tenant from an interface group:

{% code overflow="wrap" %}
```bash
weka nfs interface-group tenant delete <interface-group> <tenant>
```
{% endcode %}

{% hint style="warning" %}
This command uses `delete`. Most other NFS subcommands were renamed from `delete` to `remove` in this version, and there are no aliases. `weka nfs interface-group tenant delete` is the exception.
{% endhint %}

The interface group listing gains a **Tenants** column showing which tenants each group serves.

## Inspect tenant network space assignment

Each tenant network space is hosted on a specific server. Use this command to see the current mapping, for example when diagnosing why a tenant's floating IP is unreachable:

```bash
weka nfs interface-group ns-assignment
```

{% hint style="info" %}
Network space operations produce **two** events: one when the change is committed, and one when it is verified on all backend servers. Seeing a pair of events for a single operation is expected, not a duplicate.

During a floating IP takeover, a 30-second grace window suppresses transient duplicate-address detection, so `ArpServerDuplicateIPDetected` does not fire for the brief period when two servers can both answer for the address.
{% endhint %}

## Feature availability: root organization and tenants

Several NFS features remain available only in the root organization while NFS multi-tenancy is enabled. A tenant attempting to configure one receives an error naming the feature.

| Feature | Root organization | Tenant |
| --- | --- | --- |
| Kerberos authentication | Yes | No — connections using `RPCSEC_GSS` are rejected with `AUTH_TOOWEAK` |
| LDAP for NFS group resolution | Yes | No |
| Manage GIDs | Yes | No |
| Name-based (DNS) client rules | Yes | No — use IP-based rules |
| Kubernetes NFS integration | Yes | No |
| ACLs | Yes | No |
| NFSv3 file locking (NLM) | Yes | No — NFSv4.1 locking is available |

<!-- TBD [Is `NFSv3 lock service ports` reachable by a user action, or only through internal port registration? If it is internal only, this table lists six root-organization-only features rather than seven, and the row above covers it.] -->

{% hint style="warning" %}
**Two different LDAP configurations exist, and only one of them is available to a tenant.**

A tenant administrator can configure LDAP or Active Directory for tenant **user accounts**, as described in [multi-tenancy-tenant-level-administration.md](multi-tenancy-tenant-level-administration.md "mention").

The LDAP used for **NFS group resolution** — the configuration that supports more than 16 user groups — is available only in the root organization. As a result, NFS requests from a tenant always use numeric owner and group strings. Names are not resolved, and unknown names map to `anon`. On a tenant mount, `ls -l` shows numeric UIDs and GIDs unless the client performs its own mapping.

Configuring tenant LDAP successfully does not change NFS identity behavior.
{% endhint %}

Two further consequences for tenant exports:

* An explicitly requested ACL type or Kerberos flavor is rejected with an error. A **defaulted** ACL type is silently set to `NONE`, so an export created without naming an ACL type has weaker access control than the pre-multi-tenancy default.
* Kerberos flavors are removed from the tenant view of `weka nfs global-config`. A cluster administrator and a tenant administrator running the same command see different output.

## Per-tenant limits

Tenants have lower NFS object limits than the root organization.

| Object | Root organization | Tenant |
| --- | --- | --- |
| Client groups | 50 | 8 |
| Client group rules | 200 | 16 |
| Exports (permissions) | 1024 | 64 |
| Floating IPs per network space | — | 8 |

{% hint style="info" %}
The rule limit is counted across the whole organization, not per client group. A tenant with 8 client groups has 16 rules to distribute among them.
{% endhint %}

## Remove NFS resources before deleting a tenant

Deleting a tenant is blocked while the tenant still holds NFS resources. Remove the tenant's exports and client groups, and remove the tenant from its interface group, before deleting it.

A network space cannot be edited or deleted while a tenant is attached to it.
