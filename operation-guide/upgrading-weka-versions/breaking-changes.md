---
description: >-
  Version-specific changes that take effect immediately after an upgrade and can
  break existing automation.
---

# Breaking changes

Each entry takes effect as soon as the upgrade completes. None have a deprecation period, and each can break scripts, monitoring, or clients that worked on the previous version.

Review the section for your target version before running the upgrade workflow in [README.md](./ "mention").

## 6.0

### CLI verb renames

Six NFS subcommands changed from `delete` to `remove`. **There are no aliases** — the old form fails.

| Previous | Current |
| --- | --- |
| `weka nfs permission delete` | `weka nfs permission remove` |
| `weka nfs client-group delete` | `weka nfs client-group remove` |
| `weka nfs rules delete ip\|dns` | `weka nfs rules remove ip\|dns` |
| `weka nfs interface-group delete` | `weka nfs interface-group remove` |
| `weka nfs interface-group ip-range delete` | `weka nfs interface-group ip-range remove` |
| `weka nfs interface-group port delete` | `weka nfs interface-group port remove` |

{% hint style="info" %}
One command keeps `delete`: `weka nfs interface-group tenant delete`. It is the exception to the rename, not an oversight.
{% endhint %}

### Tightened role requirements

Five NFS operations now require a higher role. Calls made with the previous role return HTTP 403 immediately.

| Operation | Before | After |
| --- | --- | --- |
| Interface-group writes: create, update, and delete an interface group; add and delete an IP range; add and delete a port (`/api/v2/interfaceGroups*`) | Tenant Admin | Cluster Admin |
| `setNfsCustomOptions` — `PUT /api/v2/nfs/customOptions` | Tenant Admin | Cluster Admin |
| `getNfsCustomOptions` — `GET /api/v2/nfs/customOptions` | Read Only | Cluster Admin |
| `setNfsGlobalConfig` — `PUT /api/v2/nfs/globalConfig` | Tenant Admin | Cluster Admin |
| `addOrgNetworkSpaces` and `removeOrgNetworkSpaces` | Tenant Admin | Cluster Admin |

{% hint style="warning" %}
**`getNfsCustomOptions` is a read that was tightened**, from Read Only to Cluster Admin. Monitoring, inventory, and reporting scripts that never wrote anything will start returning 403. Audit any automation using a Read Only token against NFS endpoints before upgrading — this is the change most likely to surface as an unexplained monitoring failure rather than an obvious one.
{% endhint %}

#### Reads that depend on how many organizations exist

Separately from the five above, some NFS reads require a cluster-level user **only when the cluster has more than one organization**. On a single-organization cluster nothing changes, so this can appear months after the upgrade — the first time someone creates a second tenant.

| Read | Requires a cluster-level user when |
| --- | --- |
| `weka nfs interface-group` list, assignment, and `ns-assignment` | More than one organization exists. A tenant caller gets `nfs interface-group list is only allowed for cluster admins`. |
| `weka nfs global-config show` | More than one organization exists **and** multi-tenancy is disabled. With multi-tenancy enabled, a tenant user gets a reduced, organization-scoped view instead of an error. |

### One access loosening

Root-organization Tenant Admins are no longer force-escalated to Cluster Admin on Tenant Admin endpoints. Calls that returned 403 in 5.1.30 now succeed.

### REST API response change

`POST /api/v2/networkSpaces` now returns a **single object** instead of an array. Clients that index into the response, for example `response[0].id`, must be updated.

### JSON output key renames

Fifteen keys in `-J` output were renamed. Re-check any script that parses `-J` output before upgrading.

{% hint style="warning" %}
**`-o` column aliases do not help here.** Column aliases never affect JSON output, so there is no compatibility mode for these renames — every affected script must be updated.

Three of them fail *silently* rather than with a missing key, so they are worth checking first:

* `subnet_mask` → `netmask` also changes the **value**, from a dotted string such as `255.255.255.0` to mask bits such as `24`. A script that reads the new key still gets a number where it expected a string.
* `rangeFront` + `rangeEnd` → `ip_range`, and `fipRangeFront` + `fipRangeEnd` → `fip_range`, replace two keys with one combined value.
* `tenant network-space` list changes **shape**, from an array of name strings to an array of `{"id": <n>}` objects.
{% endhint %}

| Command | Old key | New key |
| --- | --- | --- |
| `weka nfs interface-group` | `org_ids` | `tenant_ids` |
| `weka nfs interface-group` | `subnet_mask` (dotted string) | `netmask` (mask bits) |
| `weka nfs interface-group assignment` | `host_id` | `container` |
| `weka nfs debug-level show` | `host_id` | `container` |
| `weka nfs clients show` | `hostid` | `container` |
| `weka cluster network-space` | `netspaceName` | `name` |
| `weka cluster network-space` | `orgName` | `tenant` |
| `weka cluster network-space` | `rangeFront` + `rangeEnd` | `ip_range` (combined) |
| `weka cluster network-space` | `fipRangeFront` + `fipRangeEnd` | `fip_range` (combined) |
| `weka cluster network-space` | `netmaskBits` | `netmask_bits` |
| `weka cluster network-space` | `orgId` | `tenant_id` |
| `weka cluster network-space` | `rdmaState` | `rdma_state` |
| `weka nfs custom-options` | `customNfsOptions`, `customExportOptions`, `customClientOptions` | `global_options`, `export_options`, `client_options` |
| `weka tenant network-space` | array of name strings | array of `{"id": <n>}` objects |
| `weka nfs permission` (list) | export ID not emitted | emitted as `id` |

On that last row, note the inconsistency: `weka nfs permission add` and the REST API emit the same value as `export_id`, while the list output calls it `id`.

### What does not change

Worth stating explicitly, because it is the most common upgrade concern for NFS:

* Clients in the root organization keep the existing NFSv4 recovery layout. **Lock reclaim survives the upgrade.**
* Export IDs embedded in file handles are preserved, so clients do not see mass `ESTALE` errors after the upgrade.

**Related topic**

[manage-nfs-for-tenants.md](../weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention")
