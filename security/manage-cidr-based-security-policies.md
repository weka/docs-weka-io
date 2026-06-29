---
description: >-
  Manage CIDR-based security policies to control access to WEKA clusters based
  on client IP address ranges, enhancing security and simplifying
  administration.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/security/manage-cidr-based-security-policies
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

<table><thead><tr><th width="245">Policy attributes</th><th width="167">Attach to tenant</th><th width="177">Attach to filesystem</th><th>Attach to join list</th></tr></thead><tbody><tr><td>IP range only</td><td>Yes</td><td>Yes</td><td>Yes</td></tr><tr><td>Roles (with or without IP range)</td><td>Yes</td><td>No</td><td>No</td></tr><tr><td><code>read-only</code> or <code>squash-mode</code> (with or without IP range)</td><td>No</td><td>Yes</td><td>No</td></tr><tr><td>Roles combined with <code>read-only</code> or <code>squash-mode</code></td><td>Not permitted at creation</td><td>Not permitted at creation</td><td>Not permitted at creation</td></tr></tbody></table>

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

**Command:** `weka security policy list`

Use the following command line to list security policies defined in the WEKA cluster.

{% code overflow="wrap" %}
```sh
weka security policy list [--action action] [--roles roles]...[--ips ips]...[--squash-mode squash-mode] [--anon-uid anon-uid]  [--anon-gid anon-gid]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="194">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>action</code></td><td>Lists security policies that match a specific action. (format: <code>allow</code> or <code>deny</code>).</td></tr><tr><td><code>roles</code>...</td><td>Lists security policies that include specific roles. (format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated).</td></tr><tr><td><code>ips</code>...</td><td>Lists security policies that include specific IP address ranges. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated).</td></tr><tr><td><code>squash-mode</code></td><td>Filters policies by squash mode. For a description of each value, see <a href="manage-cidr-based-security-policies.md#squash-mode">Squash mode</a>.</td></tr><tr><td><code>anon-uid</code></td><td><p>Filters by the anonymous UID configured in the policy.</p><p>Default: <code>65534</code></p></td></tr><tr><td><code>anon-gid</code></td><td>Filters by the anonymous GID configured in the policy.<br>Default: <code>65534</code></td></tr></tbody></table>

### Display information of a security policy

**Command:** `weka security policy show`

Displays information about a specific security policy.

```sh
weka security policy show <policy>
```

**Parameters**

<table><thead><tr><th width="190">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of security policy.</td></tr></tbody></table>

### Add a new security policy

**Command:** `weka security policy add`

Use the following command line to add a new security policy.

{% code overflow="wrap" %}
```sh
weka security policy add <name> [--description description] [--action action] [--read-only read-only]  [--anon-uid anon-uid] [--anon-gid anon-gid] [--squash-mode squash-mode] [--ips ips]...[--roles roles]...
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="192">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the new security policy. (up to 64 alphanumeric characters, hyphens (<code>-</code>), underscores (<code>_</code>), and periods (<code>.</code>), starting with a letter).</td></tr><tr><td><code>description</code></td><td>Description of the security policy. (up to 256 characters).</td></tr><tr><td><code>action</code></td><td>Whether access is granted or denied when the security policy matches. (format: <code>allow</code> or <code>deny</code>).</td></tr><tr><td><code>read-only</code></td><td><p>The security policy allows read-only mounts only.</p><p>Cannot be combined with <code>squash-mode</code> or <code>roles</code> attributes.</p><p>(format: <code>yes</code>, <code>no</code>, <code>true</code>, <code>false</code>, <code>on</code>, <code>off</code>, <code>y</code> or <code>n</code>).</p></td></tr><tr><td><code>squash-mode</code></td><td><p>Specifies how the storage system maps incoming UIDs and GIDs. Cannot be combined with <code>read-only</code> or <code>roles</code> attributes. For a description of each value, see <a href="manage-cidr-based-security-policies.md#squash-mode">Squash mode</a>.</p><p>Default: <code>none</code></p></td></tr><tr><td><code>anon-uid</code></td><td><p>An anonymous UID to replace the root user when root squashing is enabled.</p><p>Default: <code>65534</code></p></td></tr><tr><td><code>anon-gid</code></td><td>An anonymous GID to replace the root user when root squashing is enabled.<br>Default: <code>65534</code></td></tr><tr><td><code>ips</code>...</td><td><p>IP address ranges to which the security policy applies. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated).</p><p>If omitted, the default range is <code>0.0.0.0/0</code>.</p></td></tr><tr><td><code>roles</code>...</td><td><p>User roles to which the security policy applies.</p><p>Cannot be combined with <code>read-only</code> or <code>squash-mode</code> attributes.</p><p>(format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated).</p></td></tr></tbody></table>

{% hint style="info" %}
A policy cannot combine `roles` with `read-only` or `squash-mode`. A policy that includes `read-only` or `squash-mode` must use `allow` as its action. The `deny` action is not permitted for filesystem-scoped policies.
{% endhint %}

**Example**

The following example creates a policy that allows access by users with the `clusteradmin` role from two specific subnets:

{% code overflow="wrap" %}
```bash
weka security policy create admin_network --action allow --ips 10.1.0.0/16,10.2.1.0/24 --roles clusteradmin
```
{% endcode %}

### Remove a security policy

**Command:** `weka security policy remove`

Use the following command line to delete a security policy.

```sh
weka security policy remove <policy>
```

**Parameters**

<table><thead><tr><th width="211">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of security policy.</td></tr></tbody></table>

### Duplicate an existing security policy

**Command:** `weka security policy duplicate`

Use the following command line to duplicate an existing security policy, creating a new one.

```sh
weka security policy duplicate <policy> <name>
```

**Parameters**

<table><thead><tr><th width="204">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of the security policy to duplicate.</td></tr><tr><td><code>name</code>*</td><td>Name of the new security policy. (up to 64 alphanumeric characters, hyphens (-), underscores (_), and periods (.), starting with a letter).</td></tr></tbody></table>

**Example**

```bash
weka security policy duplicate sourcePolicy newPolicyName
```

### Update security policy settings

**Command:** `weka security policy update`

Use the following command line to update the settings of an existing security policy.

{% code overflow="wrap" %}
```sh
weka security policy update <policy> [--description description] [--action action] [--new-name new-name] [--roles roles]... [--add-roles add-roles]... [--remove-roles remove-roles]... [--ips ips]... [--add-ips add-ips]... [--remove-ips remove-ips]...[--squash-mode squash-mode] 
P
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="212">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of security policy.</td></tr><tr><td><code>--description</code></td><td>Updates the description of the security policy. (up to 256 characters).</td></tr><tr><td><code>--action</code></td><td>Changes whether access is granted when the security policy matches. (format: <code>allow</code> or <code>deny</code>).</td></tr><tr><td><code>--new-name</code></td><td>New name of the security policy. (up to 64 alphanumeric characters, hyphens (-), underscores (_), and periods (.), starting with a letter).</td></tr><tr><td><code>--roles</code>...</td><td>User roles to which the security policy applies. (format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated).</td></tr><tr><td><code>--add-roles</code>...</td><td>User roles to append to the security policy. (format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated).</td></tr><tr><td><code>--remove-roles</code>...</td><td>User roles to remove from the security policy. (format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated).</td></tr><tr><td><code>ips</code></td><td>IP address ranges to which the security policy applies. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated).</td></tr><tr><td><code>add-ips</code></td><td>IP address ranges to append to the security policy. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated).</td></tr><tr><td><code>remove-ips</code></td><td>IP address ranges to remove from the security policy. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated).</td></tr><tr><td><code>squash-mode</code></td><td><p>Updates the squash mode of the security policy. Cannot be combined with <code>read-only</code> or <code>roles</code> attributes. For a description of each value, see <a href="manage-cidr-based-security-policies.md#squash-mode">Squash mode</a>.</p><p>Default: <code>none</code></p></td></tr></tbody></table>

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

**Command:** `weka security policy test`

Use the following command line to simulates the effect of one or more security policies.

```sh
weka security policy test [--role role] [--ip ip] [--join] [<policy>]...
```

**Parameters**

<table><thead><tr><th width="193">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>...</td><td>Policies to evaluate, with access verified in the order listed.</td></tr><tr><td><code>role</code></td><td>Simulate effect of policies on API access from the given user role. (format: <code>clusteradmin</code>, <code>tenantadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>)</td></tr><tr><td><code>ip</code></td><td>IP address to evaluate as the source address.</td></tr><tr><td><code>join</code></td><td>Simulate effect of policies when joining the cluster.</td></tr></tbody></table>

**Example**

```shell
weka security policy test policy1 policy2 policy3 --ip 10.2.1.0 --role clusteradmin
```

### List security policies applied when joining containers

**Command:** `weka security policy join list`

Use the following command line to list security policies applied when joining containers.

```sh
weka security policy join list [--client] [--backend]
```

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>client</code></td><td>List policies for clients.</td></tr><tr><td><code>backend</code></td><td>List policies for backends.</td></tr></tbody></table>

### Set security policies for joining cluster

**Command:** `weka security policy join set`

Use the following command line to set security policies for joining cluster, replacing the existing set of policies.

```bash
weka security policy join set [--client] [--backend] [<policies>]...
```

**Parameters**

<table><thead><tr><th width="201">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policies</code>...</td><td>Security policy names or IDs applied to cluster join process.</td></tr><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

### Attach a security policy when joining cluster

**Command:** `weka security policy join attach`

Use the following command line to attach security policies applied when joining cluster, adding them to the existing policies.

```sh
weka security policy join attach [--client] [--backend] [<policies>]...
```

**Parameters**

<table><thead><tr><th width="205">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policies</code>...</td><td>Security policy names or IDs to attach to cluster join process.</td></tr><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

{% hint style="info" %}
Only policies that contain IP ranges only, with no `roles`, `read-only`, or `squash-mode` attributes, can be attached to the join list. Policies already in use by a filesystem or tenant cannot be attached to the join list.
{% endhint %}

### Detach a security policy when joining cluster

**Command:** `weka security policy join detach`

Use the following command line to remove security policies applied when joining cluster.

```sh
weka security policy join detach [--client] [--backend] [<policies>]...
```

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policies</code>...</td><td>Security policy names or IDs to remove from cluster join process.</td></tr><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

### Remove all security policies applied when joining cluster

**Command:** `weka security policy join reset`

Use the following command line to remove all security policies applied when joining cluster.

```sh
weka security policy join reset [--client] [--backend]
```

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

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

<table><thead><tr><th width="227">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr></tbody></table>

### Set security policies for a tenant

Command: `weka tenant security policy set`

Use the following command to set security policies for a tenant, **replacing** the existing list of policies. If setting multiple policies, separate each with a space.

```bash
weka tenant security policy set <tenant> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to assign them to the tenant, separated by spaces.</td></tr></tbody></table>

### Remove all security policies from a tenant

**Command:** `weka tenant security policy reset`

Use the following command to removes all security policies from a tenant.

```sh
weka tenant security policy reset <tenant>
```

**Parameters**

<table><thead><tr><th width="227">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr></tbody></table>

### Attach new security policies to a tenant

**Command:** `weka tenant security policy attach`

Use the following command to attach new security policies to an tenant, **adding** them to the existing policies. If attaching multiple policies, separate each with a space.

```sh
weka tenant security policy attach <tenant> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to attach to the tenant, separated by spaces.</td></tr></tbody></table>

{% hint style="info" %}
Only policies that do not contain `read-only` or `squash-mode` attributes can be attached to a tenant. Policies already in use by a filesystem or join list cannot be attached to a tenant.
{% endhint %}

### Detach security policies from a tenant

**Command:** `weka tenant security policy detach`

Use the following command to detach (remove) security policies from a tenant. For detaching multiple policies, separate each with a space.

```sh
weka tenant security policy detach <tenant>[<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to detach from the tenant, separated by spaces .</td></tr></tbody></table>

### Revoke all API tokens issued for a tenant

**Command:** `weka tenant security revoke-tokens`

Use the following command to revoke all API tokens issued for a specific tenant.

```sh
weka tenant security revoke-tokens <tenant>
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>tenant</code>*</td><td>Tenant name or ID.</td></tr></tbody></table>

## Manage filesystem security policies

Once security policies are defined, you can perform the following tasks at the filesystem level:

* List security policies for a specified filesystem.
* Set security policies for a specified filesystem.
* Remove all security policies from a specified filesystem.
* Attach new security policies to a specified filesystem.
* Detach security policies from a specified filesystem.

### List security policies for a filesystem

**Command:** `weka fs security policy list`

Use the following command to list security policies for a specified filesystem.

```bash
weka fs security policy list <fs-name>
```

**Parameters**

<table><thead><tr><th width="192">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name.</td></tr></tbody></table>

### Set security policies for a filesystem

**Command:** `weka fs security policy set`

Use the following command to set security policies for a specified filesystem, replacing the existing list of policies. If setting multiple policies, separate each with a space.

```bash
weka fs security policy set <fs-name> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="191">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to set for a filesystem, space separated.</td></tr></tbody></table>

Example to apply two security policies to a filesystem named <kbd>fs0</kbd>:

```bash
weka fs security policy set fs0 fs0allow denyall
```

### Remove all security policies from a filesystem

**Command:** `weka fs security policy reset`

Use the following command to remove all security policies from a specified filesystem.

```bash
weka fs security policy reset <fs-name>
```

**Parameters**

<table><thead><tr><th width="183">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name.</td></tr></tbody></table>

### Attach new security policies to a filesystem

**Command:** `weka fs security policy attach`

Use the following command to attach additional security policies to the specified filesystem. If attaching multiple policies, separate each with a space.

```bash
weka fs security policy attach <fs-name> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="176">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to attach new security policies to the specified filesystem, space separated.</td></tr></tbody></table>

{% hint style="info" %}
Only policies that do not contain `roles` attributes can be attached to a filesystem. Policies already in use by a tenant or join list cannot be attached to a filesystem.
{% endhint %}

### Detach security policies from a filesystem

**Command:** `weka fs security policy detach`

Use the following command to detach (remove) security policies from a filesystem. If detaching multiple policies, separate each with a space.

```bash
weka fs security policy detach <fs-name> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="176">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to remove from the specified filesystem, space separated.</td></tr></tbody></table>

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
weka fs add fs0 default 10gb
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

<table><thead><tr><th width="207">Parameter</th><th width="282">Description</th><th>Supported values</th></tr></thead><tbody><tr><td><code>volumeType</code></td><td>Defines the underlying WEKA storage architecture.</td><td><code>dir/v1</code>, <code>weka/v2</code></td></tr><tr><td><code>filesystemName</code></td><td>Specifies the source filesystem for snapshot-backed volumes.</td><td>Existing filesystem name, to be used with Snapshot Backed or Directory backed PVC</td></tr><tr><td><code>filesystemGroupName</code></td><td>Specifies the group where new filesystems are created.</td><td>Existing group name, to be used with Filesystem Backed PVC</td></tr></tbody></table>

**Related topic**

[storage-class-configurations.md](../appendices/weka-csi-plugin/storage-class-configurations.md "mention") (for root-squash configuration with CSI)

[^1]: Classless Inter-Domain Routing
