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

Five NFS API endpoints now require a higher role. Calls made with the previous role return HTTP 403 immediately.

The one most likely to surprise you is **`getNfsCustomOptions`, which moved from Read Only to Cluster Admin**. It is a read operation, so monitoring and reporting scripts that never wrote anything can break. Audit any automation using a Read Only token against NFS endpoints before upgrading.

TBD [Confirm the full list of five endpoints and their before/after roles, so this section can name them rather than describing the pattern. Also confirm whether the conditional gate applies — the review found some NFS reads require Cluster Admin only when the cluster has more than one organization, which would mean a single-org cluster sees no change until a second tenant is created.]

### REST API response change

`POST /api/v2/networkSpaces` now returns a **single object** instead of an array. Clients that index into the response, for example `response[0].id`, must be updated.

### JSON output key renames

Fifteen keys in `-J` output were renamed. Any script parsing `weka nfs ... -J` should be re-checked against the new output before the upgrade.

One to watch specifically: in permission list output, `export_id` now appears as `id`.

TBD [Provide the full before/after list of the fifteen `-J` key renames so they can be tabulated here. Scripts parsing JSON output are the least visible breakage in this release and the hardest for a customer to audit without a list.]

### What does not change

Worth stating explicitly, because it is the most common upgrade concern for NFS:

* Clients in the root organization keep the existing NFSv4 recovery layout. **Lock reclaim survives the upgrade.**
* Export IDs embedded in file handles are preserved, so clients do not see mass `ESTALE` errors after the upgrade.

**Related topic**

[manage-nfs-for-tenants.md](../weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention")
