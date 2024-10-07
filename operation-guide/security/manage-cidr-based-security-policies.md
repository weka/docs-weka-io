---
description: >-
  Manage CIDR-based security policies to control access to WEKA clusters based
  on client IP address ranges, enhancing security and simplifying
  administration.
---

# Manage CIDR-based security policies

## Overview

CIDR[^1]-based policies enable administrators to control access to WEKA clusters by setting rules that allow or deny connections based on client IP address ranges. This network-based restriction provides greater control over which servers or devices can access the cluster, offering a more flexible alternative to traditional user authentication. Policies are managed at the organization level, ensuring only authorized clients can connect.

**Key benefits:**

* **Enhanced security**: Restrict access to the cluster by controlling which clients can connect based on their IP addresses.
* **No authentication required**: Secure access through network-level restrictions, simplifying management for trusted environments.
* **Simplified management**: Centralized control over client access without needing user credentials.

## Guidelines and considerations

When implementing CIDR-based security policies in WEKA, consider the following:

* **Role requirement:** Only users with the **Cluster Admin** role can manage security policies, ensuring that access control remains in the hands of authorized administrators.
* **Applicable to all organizations**: CIDR-based security policies apply to all organizations, ensuring centralized control across the cluster.
* **Active mounts remain unaffected**: Client revocation is disabled, meaning any changes to policies do not impact active mounts. This ensures ongoing connections remain stable until they are manually disconnected.
* **Policy order matters**: The order in which policies are attached determines the filtering sequence. For example, if the first policy denies access from IP1 and IP2, and the second policy allows IP1, the first policy takes precedence, overriding subsequent policies. Always review the order to ensure the desired access control.
* **Default access behavior**: Clients without a related policy are allowed by default. To secure your organization, always include a final policy that denies access to all other IPs after attaching the necessary policies.
* **Policy capacity:**&#x20;
  * 16 policies can be assigned per organization.
  * 8 policies are allowed per client or backend join.
  * Each policy supports up to 32 IP address ranges.
  * A total of 5,120 policies can be defined system-wide.

## Manage security policies using the CLI

Create and manage security policies so that you can apply them on the organization. You can perform the following:

* List security policies defined in the WEKA cluster.
* Display information about a specific security policy.
* Create a new security policy.
* Delete a security policy.
* Duplicate an existing security policy, creating a new one.
* Update the settings of an existing security policy.
* Simulate the effect of one or more security policies.
* List security policies applied when joining containers.
* Set security policies for joining cluster, replacing the existing set of policies.
* Attach a security policy when joining cluster.
* Detach a security policy when joining cluster.
* Remove all security policies applied when joining cluster

### List security policies

**Command:** weka security policy list

Use the following command line to list security policies defined in the WEKA cluster.

```sh
weka security policy list [--action action] [--roles roles]...[--ips ips]...
```

**Parameters**

<table><thead><tr><th width="194">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>action</code></td><td>Lists security policies that match a specific action. (format: <code>allow</code> or <code>deny</code>)</td></tr><tr><td><code>roles</code>...</td><td>Lists security policies that include specific roles. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated)</td></tr><tr><td><code>ips</code>...</td><td>Lists security policies that include specific IP address ranges. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated)</td></tr></tbody></table>

### Display information of a security policy

**Command:** `weka security policy show`

Displays information about a specific security policy.

```sh
weka security policy show <policy>
```

**Parameters**

<table><thead><tr><th width="190">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of security policy.</td></tr></tbody></table>

### Create a new security policy

**Command:** `weka security policy create`

Use the following command line to  create a new security policy.

{% code overflow="wrap" %}
```sh
weka security policy create <name> [--description description] [--action action]
[--ips ips]...[--roles roles]...
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="192">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the new security policy. (up to 64 alphanumeric characters, hyphens (-), underscores (_), and periods (.), starting with a letter)</td></tr><tr><td><code>description</code></td><td>Description of the security policy. (up to 256 characters)</td></tr><tr><td><code>action</code></td><td>Whether access is granted or denied when the security policy matches. (format: <code>allow</code> or '<code>deny</code>)</td></tr><tr><td><code>ips</code>...</td><td>IP address ranges to which the security policy applies. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated)</td></tr><tr><td><code>roles</code>...</td><td>User roles to which the security policy applies. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated)</td></tr></tbody></table>

Example:

{% code overflow="wrap" %}
```
weka security policy create admin_network --action allow --ips 10.1.0.0/16,10.2.1.0/24 --role clusteradmin
```
{% endcode %}

### Delete a security policy

**Command:** `weka security policy delete`

Use the following command line to delete a security policy.

```sh
weka security policy delete <policy>
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

<table><thead><tr><th width="204">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of the security policy to duplicate.</td></tr><tr><td><code>name</code>*</td><td>Name of the new security policy. (up to 64 alphanumeric characters, hyphens (-), underscores (_), and periods (.), starting with a letter)</td></tr></tbody></table>

Example:&#x20;

```
weka security policy duplicate sourcePolicy newPolicyName
```

### Update security policy settings

**Command:** `weka security policy update`

Use the following command line to update the settings of an existing security policy.

{% code overflow="wrap" %}
```sh
weka security policy update <policy> [--description description] [--action action] [--new-name new-name] [--roles roles]... [--add-roles add-roles]... [--remove-roles remove-roles]... [--ips ips]... [--add-ips add-ips]... [--remove-ips remove-ips]...
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="212">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name or ID of security policy.</td></tr><tr><td><code>--description</code></td><td>Updates the description of the security policy. (up to 256 characters)</td></tr><tr><td><code>--action</code></td><td>Changes whether access is granted when the security policy matches. (format: <code>allow</code> or <code>deny</code>)</td></tr><tr><td><code>--new-name</code></td><td>New name of the security policy. (up to 64 alphanumeric characters, hyphens (-), underscores (_), and periods (.), starting with a letter)</td></tr><tr><td><code>--roles</code>...</td><td>User roles to which the security policy applies. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>,  may be repeated or comma-separated)</td></tr><tr><td><code>--add-roles</code>...</td><td>User roles to append to the security policy. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated)</td></tr><tr><td><code>--remove-roles</code>...</td><td>User roles to remove from the security policy. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>, may be repeated or comma-separated)</td></tr><tr><td><code>ips</code></td><td>IP address ranges to which the security policy applies. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated)</td></tr><tr><td><code>add-ips</code></td><td>IP address ranges to append to the security policy. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated)</td></tr><tr><td><code>remove-ips</code></td><td>IP address ranges to remove from the security policy. (format: IP or IP/CIDR or IP1-IP2 or A.B.C.D-E, may be repeated or comma-separated)</td></tr></tbody></table>

Example:&#x20;

{% code overflow="wrap" %}
```
weka security policy update admin-net --add-roles clusteradmin --description "Limit Cluster Admin Access to HQ Network"
```
{% endcode %}

### Simulate the effect of one or more security policies

**Command:** `weka security policy test`

Use the following command line to simulates the effect of one or more security policies.

```sh
weka security policy test [--role role] [--ip ip] [--join] [<policy>]...
```

**Parameters**

<table><thead><tr><th width="193">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policy</code>...</td><td>Policies to evaluate, with access verified in the order listed.</td></tr><tr><td><code>role</code></td><td>Simulate effect of policies on API access from the given user role. (format: <code>clusteradmin</code>, <code>orgadmin</code>, <code>regular</code>, <code>readonly</code> or <code>s3</code>)</td></tr><tr><td><code>ip</code></td><td>IP address to evaluate as the source address.</td></tr><tr><td><code>join</code></td><td>Simulate effect of policies when joining the cluster.</td></tr></tbody></table>

Example:&#x20;

```
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

```
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

### Detach a security policy when joining cluster

**Command:** `weka security policy join detach`

Use the following command line to remove security policies applied when joining cluster.

```sh
weka security policy join detach [--client] [--backend]  [<policies>]...
```

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>policies</code>...</td><td>Security policy names or IDs to remove from cluster join proces</td></tr><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

### Remove all security policies applied when joining cluster

**Command:** `weka security policy join reset`

Use the following command line to remove all security policies applied when joining cluster.

```sh
weka security policy join reset [--client] [--backend]
```

**Parameters**

<table><thead><tr><th width="195">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>client</code></td><td>Apply policies to clients.</td></tr><tr><td><code>backend</code></td><td>Apply policies to backends.</td></tr></tbody></table>

## Manage organization security policies using the CLI

Once security policies are defined, you can perform the following tasks at the organization level:

* List security policies for a specified organization.
* Set security policies for a specified organization.
* Remove all security policies from a specified organization.
* Attach new security policies to a specified organization.
* Detach security policies from a specified organization.

### List the organization security policies

Command: `weka org security policy list`

Use the following command to list the security policies of a specified organization.

```sh
weka org security policy list <org>
```

{% hint style="info" %}
The command `weka org` also displays the attached policies for each organization.
{% endhint %}

**Parameters**

<table><thead><tr><th width="227">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr></tbody></table>

### Set security policies for an organization

Command: `weka org security policy set`

Use the following command to set security policies for an organization, replacing the existing list of policies.

```
weka org security policy set <org> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to assign to the organization.</td></tr></tbody></table>

### Remove all security policies from an organization

**Command:** `weka org security policy reset`

Use the following command to removes all security policies from an organization.

```sh
weka org security policy reset <org>
```

**Parameters**

<table><thead><tr><th width="227">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr></tbody></table>

### Attach new security policies to an organization

**Command:** `weka org security policy attach`

Use the following command to attach new security policies to an organization, adding them to the existing policies.

```sh
weka org security policy attach <org> [<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to attach to the organization.</td></tr></tbody></table>

### Detach security policies from an organization

**Command:** `weka org security policy detach`

Use the following command to detach (remove) security policies from an organization.

```sh
weka org security policy detach <org>[<policies>]...
```

**Parameters**

<table><thead><tr><th width="237">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>org</code>*</td><td>Organization name or ID.</td></tr><tr><td><code>policies</code>...</td><td>Security policy names or IDs to remove from the organization.</td></tr></tbody></table>

[^1]: Classless Inter-Domain Routing
