---
description: >-
  Manage CIDR-based security policies to control access to WEKA clusters based
  on client IP address ranges, enhancing security and simplifying
  administration.
---

# Manage CIDR-based security policies

## Overview

CIDR[^1]-based policies allow administrators to control access to WEKA cluster management and filesystems over POSIX clients by specifying permitted and restricted IP address ranges. This network-level security measure complements traditional user authentication, providing tenants with finer control over cluster access.

Key benefits:

* **Enhanced security**: Restrict access to the cluster by controlling which clients can connect based on their IP addresses.
* **No authentication required**: Secure access through network-level restrictions, simplifying management for trusted environments.
* **Simplified management**: Centralized control over client access without needing user credentials.

## Guidelines and considerations

When implementing CIDR-based security policies in WEKA, consider the following:

* **Role requirement:** Only users with the **ClusterAdmin** role can manage security policies for the root tenant. For non-root tenant, only the **TenantAdmin** can manage security policies.
* **Active mounts remain unaffected**: Client revocation is disabled, meaning any changes to policies do not impact active mounts. This ensures ongoing connections remain stable until they are manually disconnected.
* **Policy order matters**: The order in which policies are attached determines the filtering sequence. For example, if the first policy denies access from IP1 and IP2, and the second policy allows IP1, the first policy takes precedence, overriding subsequent policies. Always review the order to ensure the desired access control.
* **Default access behavior**: Clients without a related policy are allowed by default. To secure your tenant or filesystem, always include a final policy that denies access to all other IPs after attaching the necessary policies.

#### Policy type restrictions

Security policies have discrete scopes. The scope of a policy is determined by the attributes it contains, and that scope controls where the policy can be attached. Mixing attributes from different scopes in a single policy is not permitted.

WEKA enforces three discrete policy types:

* **API authentication policies** include roles and can only be attached to tenants. They cannot be attached to filesystems or used as join policies.
* **Filesystem policies** include a `read-only` or `squash-mode` attribute and can only be attached to filesystems. They cannot include roles.
* **Join policies** can only contain an IP range. They cannot include roles or filesystem attributes.

Combining attributes from more than one policy type in a single policy is not permitted.

#### Policy creation and update rules

When creating or updating a security policy, the following restrictions apply:

* A policy cannot combine `roles` with `read-only` or `squash-mode` attributes. These attributes belong to different scopes and cannot coexist in a single policy.
* A policy that includes `read-only` or `squash-mode` must use `allow` as its action. The `deny` action is not permitted for filesystem-scoped policies.
* Updating an in-use policy is subject to scope restrictions:
  * If a policy is attached to a filesystem or join list, its `roles` attribute cannot be modified.
  * If a policy is attached to a tenant or join list, its `read-only` or `squash-mode` attributes cannot be modified.
  * The `description` and IP address ranges can always be updated regardless of where a policy is in use.

#### Policy attachment rules

The following table summarizes where each policy type can be attached:

| Policy attributes | Attach to tenant | Attach to filesystem | Attach to join list |
| --- | --- | --- | --- |
| IP range only | Yes | Yes | Yes |
| Roles (with or without IP range) | Yes | No | No |
| `read-only` or `squash-mode` (with or without IP range) | No | Yes | No |
| Roles combined with `read-only` or `squash-mode` | Not permitted at creation | Not permitted at creation | Not permitted at creation |

In addition, a policy already in use by one scope cannot be attached to a different scope:

* A policy attached to a filesystem cannot be attached to a tenant or join list.
* A policy attached to a tenant cannot be attached to a filesystem or join list.
* A policy attached to a join list cannot be attached to a tenant or filesystem.

#### Legacy policies

Existing policies that contain attributes incompatible with current scope restrictions remain functional without modification. However, they are restricted from further changes to the conflicting attributes. Only unaffected fields, such as `description` and IP address ranges, can be updated on these policies. To change restricted attributes, create a new policy that conforms to current scope requirements.

#### Squash mode

Squash mode specifies how the storage system maps incoming User IDs (UID) and Group IDs (GID) to manage access permissions and security. The following values are supported:

* **none:** The filesystem trusts and preserves the original UID/GID provided by the client. Use this mode when precise POSIX permission enforcement is needed across the cluster.
* **root:** Maps all requests from UID 0 (root) to an anonymous, non-privileged user (typically `nobody`). Use this to prevent a user with root access on a client machine from gaining administrative privileges on the WEKA filesystem.
* **all:** Maps every incoming request, regardless of the original UID/GID, to a single anonymous identity. Use this to simplify access for shared or public data repositories where individual user tracking is not required.

Default: `none`

{% hint style="info" %}
Squash mode governs the native WEKA client only. For other protocols (NFS, SMB, S3), configure squash settings independently within their respective export or share settings.
{% endhint %}

#### Root-squash enforcement and client version compatibility

* Root-squash is enforced only on clients that were either freshly installed or upgraded using a standard umount/mount cycle (not a hot upgrade).
* For clients upgraded by hot upgrade, perform a umount/mount cycle on the affected client after the upgrade.

#### Policy capacity

* 16 policies can be assigned per tenant.
* 16 policies can be assigned per filesystem.
* 8 policies are allowed per client or backend join.
* Each policy supports up to 32 IP address ranges.
* A total of 5,120 policies can be defined system-wide.

## Manage security policies

Add and manage security policies so that you can apply them on the tenant or filesystem. You can perform the following:

* List security policies defined in the WEKA cluster.
* Display information about a specific security policy.
* Add a new security policy.
* Remove a security policy.
* Duplicate an existing security policy, creating a new one.
* Update the settings of an existing security policy.
* Simulate the effect of one or more security policies.
* List security policies applied when joining containers.
* Set security policies for joining cluster, replacing the existing set of policies.
* Attach a security policy when joining cluster.
* Detach a security policy when joining cluster.
* Remove all security policies applied when joining cluster

### List security policies

Lists the CIDR-based security policies defined on the cluster.

**Command:** `weka security policy list`

```sh
weka security policy list [--action <security-action>] [--ips <ip-ranges>…] [--roles <user-roles>…]
```

**Parameters**

| Parameter                     | Description                                                                                                                                |
| --- | --- |
| `--action` \<security-action> | Only show policies that match a specific action. |
| `--ips` \<ip-ranges>… | Only show policies include specific IP address ranges. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--roles` \<user-roles>… | Only show policies naming these user roles. Multiple values may be supplied separated by commas, or the option may be repeated. |

### Display information of a security policy

Shows a single policy's action, IP ranges, roles, and access attributes.

**Command:** `weka security policy show`

```sh
weka security policy show <policy>
```

**Parameters**

| Parameter  | Description                            |
| --- | --- |
| `policy`\* | Name or ID of security policy to show. |

### Add a new security policy

Creates a security policy that allows or denies access from named IP ranges, optionally restricting roles or filesystem access.

**Command:** `weka security policy add`

```sh
weka security policy add <name> [--action <security-action>] [--anon-gid <uint32>] [--anon-uid <uint32>] [--description <string>] [--ips <strings>…] [--read-only <on-off>] [--roles <user-roles>…] [--squash-mode <squash-mode>]
```

**Parameters**

| Parameter                      | Description                                                                                                                                                                                                |
| --- | --- |
| `name`\* | Name of the new security policy. |
| `--action` \<security-action> | Whether access is granted or denied when the security policy matches. |
| `--anon-gid` \<uint32> | Anonymous group ID to which accesses are squashed. Default: 65534 |
| `--anon-uid` \<uint32> | Anonymous user ID to which accesses are squashed. Default: 65534 |
| `--description` \<string> | Security policy description. |
| `--ips` \<strings>… | IPs (or ranges of IPs) to which the security policy applies. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--read-only` \<on-off> | The security policy allows read-only mounts only. |
| `--roles` \<user-roles>… | User roles to which the security policy applies. Used only for administrative interfaces. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--squash-mode` \<squash-mode> | Dictates whether user and group IDs accessing mounted filesystems are squashed. If 'root' then converts accesses by root (UID 0/GID 0) to the anonymous UID and GID. If 'all', then converts all accesses. Default: none |

{% hint style="info" %}
A policy cannot combine `roles` with `read-only` or `squash-mode`. A policy that includes `read-only` or `squash-mode` must use `allow` as its action. The `deny` action is not permitted for filesystem-scoped policies.
{% endhint %}

**Example**

The following example creates a policy that allows access by users with the `clusteradmin` role from two specific subnets:

{% code overflow="wrap" %}
```bash
weka security policy add admin_network --action allow --ips 10.1.0.0/16,10.2.1.0/24 --roles clusteradmin
```
{% endcode %}

### Remove a security policy

Deletes a security policy. Detach it from all tenants, filesystems, and the join list first.

**Command:** `weka security policy remove`

```sh
weka security policy remove <policy> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `policy`\* | Policy ID or name of the policy to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### Duplicate an existing security policy

Copies an existing policy under a new name, as a starting point for a variant.

**Command:** `weka security policy duplicate`

```sh
weka security policy duplicate <policy> <new-name>
```

**Parameters**

| Parameter    | Description                               |
| --- | --- |
| `policy`\* | Policy ID or name of the policy to clone. |
| `new-name`\* | Name for the new policy. |

**Example**

```bash
weka security policy duplicate sourcePolicy newPolicyName
```

### Update security policy settings

Changes a policy's action, IP ranges, roles, or access attributes.

**Command:** `weka security policy update`

```sh
weka security policy update <policy> [--action <security-action>] [--add-ips <ip-ranges>…] [--add-roles <user-roles>…] [--anon-gid <uint32>] [--anon-uid <uint32>] [--description <string>] [--force] [--ips <ip-ranges>…] [--new-name <string>] [--read-only <on-off>] [--remove-ips <ip-ranges>…] [--remove-roles <user-roles>…] [--roles <user-roles>…] [--squash-mode <squash-mode>]
```

**Parameters**

| Parameter                       | Description                                                                                                                                                                                                |
| --- | --- |
| `policy`\* | Policy ID or name of policy to update. |
| `--action` \<security-action> | Whether access is granted or denied when the security policy matches. |
| `--add-ips` \<ip-ranges>… | IP addresses or ranges to add to the end of the security policy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--add-roles` \<user-roles>… | These user roles are added to the security policy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--anon-gid` \<uint32> | Anonymous group ID to which accesses are squashed. |
| `--anon-uid` \<uint32> | Anonymous user ID to which accesses are squashed. |
| `--description` \<string> | Security policy description. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--ips` \<ip-ranges>… | IPs (or ranges of IPs) to which the security policy applies. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--new-name` \<string> | New name of security policy. |
| `--read-only` \<on-off> | The security policy allows read-only mounts only. |
| `--remove-ips` \<ip-ranges>… | IP addresses or IP address ranges to remove from the security policy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--remove-roles` \<user-roles>… | These user roles are removed from the security policy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--roles` \<user-roles>… | User roles to which the security policy applies. Used only for administrative interfaces. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--squash-mode` \<squash-mode> | Dictates whether user and group IDs accessing mounted filesystems are squashed. If 'root' then converts accesses by root (UID 0/GID 0) to the anonymous UID and GID. If 'all', then converts all accesses. Default: none |

{% hint style="info" %}
* Modifying `roles`, `squash-mode`, or `read-only` on a policy may be restricted depending on where the policy is currently attached.
* If the policy is attached to a filesystem or join list, `roles` cannot be modified.
* If the policy is attached to a tenant or join list, `squash-mode` and `read-only` cannot be modified.
* The `description` and IP address ranges can always be updated. To change restricted attributes, create a new policy with the required configuration.
{% endhint %}

**Example**

The following example adds the `readonly` role and updates the description of the existing `admin_network` policy:

{% code overflow="wrap" %}
```bash
weka security policy update admin_network --add-roles readonly --description "Limit Cluster Admin Access to HQ Network"
```
{% endcode %}

### Simulate the effect of one or more security policies

Reports whether a given client IP and role would be allowed, without changing anything.

**Command:** `weka security policy test`

```sh
weka security policy test <policies>… [--ip <ip>] [--join] [--role <user-role>]
```

**Parameters**

| Parameter             | Description                                                         |
| --- | --- |
| `policies`\*… | Policies to evaluate, with access verified in the order listed. |
| `--ip` \<ip> | Use this IP address to evaluate as the source address. |
| `--join` | Simulate effect of policies when joining the cluster. |
| `--role` \<user-role> | Simulate effect of policies on API access from the given user role. |

**Example**

```shell
weka security policy test policy1 policy2 policy3 --ip 10.2.1.0 --role clusteradmin
```

### List security policies applied when joining containers

Lists the policies applied to containers joining the cluster.

**Command:** `weka security policy join list`

```sh
weka security policy join list [--backend] [--client]
```

**Parameters**

| Parameter         | Description                  |
| --- | --- |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client` | Apply to client containers. |

### Set security policies for joining cluster

Replaces the set of policies applied to joining containers.

**Command:** `weka security policy join set`

```sh
weka security policy join set <policies>… [--backend] [--client] [--force]
```

**Parameters**

| Parameter         | Description                                                   |
| --- | --- |
| `policies`\*… | Security policies to apply, by name or ID. |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client` | Apply to client containers. |
| `-f`, `--force` | Bypass safeguards when updating. May disrupt cluster members. |

### Attach a security policy when joining cluster

Adds a policy to the set applied to joining containers.

**Command:** `weka security policy join attach`

```sh
weka security policy join attach <policies>… [--backend] [--client] [--force]
```

**Parameters**

| Parameter         | Description                                                   |
| --- | --- |
| `policies`\*… | Security policies to apply, by name or ID. |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client` | Apply to client containers. |
| `-f`, `--force` | Bypass safeguards when updating. May disrupt cluster members. |

{% hint style="info" %}
Only policies that contain IP ranges only, with no `roles`, `read-only`, or `squash-mode` attributes, can be attached to the join list. Policies already in use by a filesystem or tenant cannot be attached to the join list.
{% endhint %}

### Detach a security policy when joining cluster

Removes a policy from the set applied to joining containers.

**Command:** `weka security policy join detach`

```sh
weka security policy join detach <policies>… [--backend] [--client] [--force]
```

**Parameters**

| Parameter         | Description                                                   |
| --- | --- |
| `policies`\*… | Security policies to apply, by name or ID. |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client` | Apply to client containers. |
| `-f`, `--force` | Bypass safeguards when updating. May disrupt cluster members. |

### Remove all security policies applied when joining cluster

Clears every policy from the join list.

**Command:** `weka security policy join reset`

```sh
weka security policy join reset [--backend] [--client]
```

**Parameters**

| Parameter         | Description                  |
| --- | --- |
| `-b`, `--backend` | Apply to backend containers. |
| `-c`, `--client` | Apply to client containers. |

## Manage tenant-level security policies

Once security policies are established, you can manage them at the tenant level by performing the following tasks:

* List security policies for a specific tenant.
* Set security policies for a specific tenant.
* Remove all security policies from a specific tenant.
* Attach new security policies to a specific tenant.
* Detach security policies from a specific tenant.
* Revoke all API tokens issued for a specific tenant.

{% hint style="info" %}
**Role requirement:** To manage security policies, users must hold specific roles. For the root tenant, only those with the **ClusterAdmin** role have this capability. In contrast, for non-root tenants, this responsibility is designated to users with the **TenantAdmin** role.
{% endhint %}

### List the tenant security policies

Command: `weka tenant security policy list`

Use the following command to list the security policies of a specified tenant.

<pre class="language-sh"><code class="lang-sh"><strong>weka tenant security policy list &#x3C;tenant>
</strong></code></pre>

{% hint style="info" %}
The command `weka tenant` also displays the attached policies for each tenant.
{% endhint %}

**Parameters**

| Parameter | Description |
| --- | --- |
| `tenant`* | Tenant name or ID. |

### Set security policies for a tenant

Command: `weka tenant security policy set`

Use the following command to set security policies for a tenant, **replacing** the existing list of policies. If setting multiple policies, separate each with a space.

```bash
weka tenant security policy set <tenant> [<policies>]...
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `tenant`* | Tenant name or ID. |
| `policies`... | Security policy names or IDs to assign them to the tenant, separated by spaces. |

### Remove all security policies from a tenant

Clears every security policy attached to a tenant.

**Command:** `weka tenant security policy reset`

```sh
weka tenant security policy reset <tenant>
```

**Parameters**

| Parameter  | Description                     |
| --- | --- |
| `tenant`\* | Name or ID of tenant to update. |

### Attach new security policies to a tenant

Attaches one or more policies to a tenant.

**Command:** `weka tenant security policy attach`

```sh
weka tenant security policy attach <tenant> <policies>…
```

**Parameters**

| Parameter     | Description                                |
| --- | --- |
| `tenant`\* | Name or ID of tenant to update. |
| `policies`\*… | Security policies to attach to the tenant. |

{% hint style="info" %}
Only policies that do not contain `read-only` or `squash-mode` attributes can be attached to a tenant. Policies already in use by a filesystem or join list cannot be attached to a tenant.
{% endhint %}

### Detach security policies from a tenant

Detaches one or more policies from a tenant.

**Command:** `weka tenant security policy detach`

```sh
weka tenant security policy detach <tenant> <policies>…
```

**Parameters**

| Parameter     | Description                                  |
| --- | --- |
| `tenant`\* | Name or ID of tenant to update. |
| `policies`\*… | Security policies to detach from the tenant. |

### Revoke all API tokens issued for a tenant

Revokes every API token issued to a tenant's users, forcing them to authenticate again.

**Command:** `weka tenant security revoke-tokens`

```sh
weka tenant security revoke-tokens [<tenant>] [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `tenant` | Tenant name or ID to revoke tokens for. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## Manage filesystem security policies

Once security policies are defined, you can perform the following tasks at the filesystem level:

* List security policies for a specified filesystem.
* Set security policies for a specified filesystem.
* Remove all security policies from a specified filesystem.
* Attach new security policies to a specified filesystem.
* Detach security policies from a specified filesystem.

### List security policies for a filesystem

Lists the security policies attached to a filesystem.

**Command:** `weka fs security policy list`

```sh
weka fs security policy list <name>
```

**Parameters**

| Parameter | Description             |
| --- | --- |
| `name`\* | Name of the filesystem. |

### Set security policies for a filesystem

Replaces the set of policies attached to a filesystem.

**Command:** `weka fs security policy set`

```sh
weka fs security policy set <name> <policies>…
```

**Parameters**

| Parameter     | Description                   |
| --- | --- |
| `name`\* | Name of the filesystem. |
| `policies`\*… | Security policy names or IDs. |

Example to apply two security policies to a filesystem named <kbd>fs0</kbd>:

```bash
weka fs security policy set fs0 fs0allow denyall
```

### Remove all security policies from a filesystem

Clears every security policy attached to a filesystem.

**Command:** `weka fs security policy reset`

```sh
weka fs security policy reset <name>
```

**Parameters**

| Parameter | Description             |
| --- | --- |
| `name`\* | Name of the filesystem. |

### Attach new security policies to a filesystem

Attaches one or more policies to a filesystem.

**Command:** `weka fs security policy attach`

```sh
weka fs security policy attach <name> <policies>…
```

**Parameters**

| Parameter     | Description                   |
| --- | --- |
| `name`\* | Name of the filesystem. |
| `policies`\*… | Security policy names or IDs. |

{% hint style="info" %}
Only policies that do not contain `roles` attributes can be attached to a filesystem. Policies already in use by a tenant or join list cannot be attached to a filesystem.
{% endhint %}

### Detach security policies from a filesystem

Detaches one or more policies from a filesystem.

**Command:** `weka fs security policy detach`

```sh
weka fs security policy detach <name> <policies>…
```

**Parameters**

| Parameter     | Description                   |
| --- | --- |
| `name`\* | Name of the filesystem. |
| `policies`\*… | Security policy names or IDs. |

## Examples: Implementing CIDR-based security policies

This section provides practical examples of implementing CIDR-based security policies for common use cases.

### Example 1: Restrict cluster admin access to backend network

This example demonstrates how to allow only `clusteradmin` access from a specific backend subnet while denying all other IP addresses.

**Scenario:** Allow cluster administrators to access the cluster only from the backend network (10.10.0.0/16) and implicitly deny access from all other IP addresses.

1. **Create the security policy:** Create an allow policy for cluster administrators from the backend subnet:

{% code overflow="wrap" %}
```bash
weka security policy add allow-cluster-admins-backend \
  --action allow \
  --ips 10.10.0.0/16 \
  --roles clusteradmin
```
{% endcode %}

2. **Attach policy to the root tenant:** Attach the policy to the root tenant to enforce it cluster-wide:

```bash
weka tenant security policy attach root allow-cluster-admins-backend
```

**Result:** Only users with the `clusteradmin` role connecting from IP addresses within the 10.10.0.0/16 range can access the cluster. All other connections are implicitly denied.

### Example 2: Multi-network access control

This example shows how to allow access from multiple networks, such as backend infrastructure and administrative workstations, using a single policy.

**Scenario:** Allow `clusteradmin` access from both the backend network (`10.10.0.0/16`) and administrative workstations (`192.168.100.0/24`).

1. **Create a unified access policy:** Instead of creating separate rules, you can provide a comma-separated list to the `--ips` flag to cover multiple ranges in one go.

{% code overflow="wrap" %}
```bash
weka security policy add allow-admin-networks \
  --action allow \
  --ips 10.10.0.0/16,192.168.100.0/24 \
  --roles clusteradmin
```
{% endcode %}

3. **Attach both policy:** Attach the unified policy to the root tenant:

{% code overflow="wrap" %}
```bash
weka tenant security policy attach root allow-admin-networks
```
{% endcode %}

**Result:** Cluster administrators can now access the cluster from either the backend network or designated admin workstations under a single administrative rule.

### Example 3: Read-only filesystem access

This example demonstrates how to provide read-only access to filesystems from specific networks.

**Scenario:** Allow read-only access to a filesystem from a data analysis network (`172.16.0.0/12`).

1. **Create read-only access policy:** Create a policy allowing read-only access from the analysis network:

{% code overflow="wrap" %}
```bash
weka security policy add readonly-analysis-network \
   --action allow \
   --ips 172.16.0.0/12 \
   --read-only true
```
{% endcode %}

{% hint style="info" %}
Filesystem policies cannot include roles. If you need to restrict access by both role and IP range for API authentication, create a separate API authentication policy and attach it to the tenant.
{% endhint %}

2. Apply policy to specific filesystem: Apply the policy to a specific filesystem (for example, `data-warehouse`):

{% code overflow="wrap" %}
```bash
weka fs security policy attach data-warehouse readonly-analysis-network
```
{% endcode %}

**Result:** Users have read-only access to the `data-warehouse` filesystem from the IP range 172.16.0.0/12.

### Example 4: Root-squash filesystem access

This example demonstrates how to provide root-squash access to filesystems from specific networks.

**Scenario:** When a root user accesses a filesystem from a data analysis network (`172.16.0.0/12`), it will be squashed to `uid 1001` and `gid 2001`.

1. **Create root-squash access policy:** Create a policy that squashes root uid/gid when accessing from the analysis network:

```bash
weka security policy add rootsquash-analysis-network \
   --action allow \
   --ips 172.16.0.0/12 \
   --squash-mode root \
   --anon-uid 1001 \
   --anon-gid 2001
```

2. **Apply policy to specific filesystem:** Apply the policy to a specific filesystem (for example, `data-warehouse`):

{% code overflow="wrap" %}
```bash
weka fs security policy attach data-warehouse rootsquash-analysis-network
```
{% endcode %}

**Results:** The `rootsquash-analysis-network` policy is applied to the `data-warehouse` filesystem. Any root user accessing this filesystem from the `172.16.0.0/12` network is automatically squashed to `uid 1001` and `gid 2001`, preventing unrestricted root access. Users from other networks retain their original credentials.

### Example 5: Restrict filesystem access to specific hosts

This example demonstrates how to allow only specific hosts to mount a filesystem while blocking all other clients.

**Scenario:** Allow two specific hosts (`10.100.10.72` and `10.100.10.74`) to mount a filesystem, and deny access from all other IP addresses.

**Before you begin:** Run these commands as `tenantadmin` in the relevant organization, or as `admin` in the root organization.

In this example, the filesystem name is `fs0`. Replace `fs0` with your filesystem name.

1. **Create the policies:** Create an allow policy for the two hosts, and a deny policy for all other IP addresses:

```bash
weka security policy add fs0allow --action allow --ips 10.100.10.72,10.100.10.74
weka security policy add denyall --action deny
```

`--ips` default range: `0.0.0.0/0`.

2. **Verify the policies exist:**

```bash
weka security policy list
```

3. **If needed, create the filesystem:** If your filesystem already exists, skip this step.

```bash
weka fs add fs0 10gb --fs-group default
```

4. **Confirm no policies are attached to the filesystem:**

```bash
weka fs security policy list fs0
```

5. **Attach both policies to the filesystem in order**, with `fs0allow` first and `denyall` second:

```bash
weka fs security policy set fs0 fs0allow denyall
```

6. **Confirm the policies are attached in the correct order:**

```bash
weka fs security policy list fs0
```

Expected output:

```
POSITION  POLICY ID  POLICY NAME
       0  2          fs0allow
       1  3          denyall
```

**Result:** Clients at `10.100.10.72` and `10.100.10.74` can mount `fs0`. Clients outside this range receive a `permission denied` error when attempting to mount.

## Configure CSI storage classes for root-squashed filesystems

Configure the WEKA CSI plugin to support filesystems where root-squash is enabled. This configuration ensures that the CSI plugin can manage directories and snapshots even when root access is restricted.

**Storage class volume types**

Definitions for volume types used in CSI configurations:

* **dir/v1:** A backend type where multiple PVCs reside as directories within a single pre-existing WEKA filesystem.
* **weka/v2:** A backend type where each PVC corresponds to a dedicated WEKA filesystem or snapshot.

**Prerequisites**

* A running WEKA cluster.
* WEKA CSI plugin installed on the Kubernetes cluster.
* Administrative access to the WEKA CLI or GUI.

#### Configure directory-backed storage classes with root-squash

Manage storage classes where the volumeType is set to `dir/v1`.

1. Create the filesystem in the WEKA cluster.
2. Create a security policy that defines the required anonymous UID and GID.
3. Assign the security policy to the filesystem.
4. Create a directory named `csi-volumes` manually at the root of the filesystem.
5. Change the ownership of the `csi-volumes` directory to match the anonymous `UID` and `GID` defined in the security policy.
6. Create the Persistent Volume Claim (PVC).

#### Configure snapshot-backed storage classes with root-squash

Manage storage classes where the `volumeType` is set to `weka/v2` and includes a filesystemName.

1. Create the PVC to trigger the generation of a new filesystem from a snapshot.
2. Create a security policy with the desired root-squash settings using the WEKA CLI.
3. Assign the security policy to the newly created filesystem.

#### Configure filesystem-backed storage classes with root-squash

Manage storage classes where the `volumeType` is set to `weka/v2` and includes a filesystemGroupName.

1. Create the PVC.
2. Identify the name of the filesystem automatically generated by the CSI plugin.
3. Create a security policy using the WEKA CLI or API.
4. Assign the security policy to the identified filesystem.

### Storage class parameter reference

| Parameter | Description | Supported values |
| --- | --- | --- |
| `volumeType` | Defines the underlying WEKA storage architecture. | `dir/v1`, `weka/v2` |
| `filesystemName` | Specifies the source filesystem for snapshot-backed volumes. | Existing filesystem name, to be used with Snapshot Backed or Directory backed PVC |
| `filesystemGroupName` | Specifies the group where new filesystems are created. | Existing group name, to be used with Filesystem Backed PVC |

**Related topic**

[storage-class-configurations.md](../appendices/weka-csi-plugin/storage-class-configurations.md "mention") (for root-squash configuration with CSI)

[^1]: Classless Inter-Domain Routing
