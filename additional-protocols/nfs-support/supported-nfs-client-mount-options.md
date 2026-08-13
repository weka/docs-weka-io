---
description: >-
  Configure mandatory and recommended NFS client mount options, based on
  real-world testing and validation for optimal performance and reliability.
---

# Supported NFS client mount parameters

To ensure optimal performance and reliability when using NFS clients, it is essential to configure specific mandatory and recommended mount parameters. These parameters have been tested and validated in various real-world scenarios.

## **Mandatory parameters**

The following parameters **must** be included alongside the client's default mount options:

* **NFSv3** and **NFSv4**: `proto=tcp`

## Recommended parameters

For enhanced performance and stability, include the following parameters in addition to the mandatory ones:

* **NFSv3**:
  * `hard`
  * `vers=3`
* **NFSv4**:
  * `hard`
  * `vers=4`

## Additional information

* **Specifying NFS Client Version:** Always explicitly define the NFS client version (`vers=3` or `vers=4`) to prevent unexpected protocol negotiation during server configuration changes.
* **Resiliency to network interruptions:** Use the `hard` option to ensure the client retries operations during temporary network interruptions, maintaining data integrity and operation continuity.
* **Improving NFS performance:** Consider setting the `nconnect` parameter to a value greater than `1` to optimize NFS performance by enabling multiple TCP connections. TBD ["For the latest WEKA versions" was removed as unactionable - a reader cannot tell which versions qualify. Confirm the minimum version that supports nconnect > 1 so it can be stated, or confirm it applies to all supported versions.]
* **Default NFS client options:** Beyond the parameters listed above, the default options negotiated by the NFS client at mount time are suitable for most use cases. For advanced configurations or additional NFS client options, refer to the documentation provided by your operating system.

## Mounting a tenant export

When NFS multi-tenancy is enabled, exports belonging to a tenant are reached through the tenant's floating IP addresses. Mounting works the same way, and no extra parameters are required:

```bash
mount -o vers=3,proto=tcp,hard,sec=sys <tenant-floating-ip>:/<export> /mnt/point
```

Each tenant floating IP runs its own portmapper on port 111, so no port overrides are needed.

The following differences apply to tenant exports and not to the root organization. They affect client compatibility, so check them before planning a migration.

| Behavior | On a tenant export |
| --- | --- |
| Security flavor | `sec=sys` only. Kerberos flavors (`krb5`, `krb5i`, `krb5p`) are available only in the root organization. A client attempting Kerberos is rejected with `AUTH_TOOWEAK`. |
| NFSv3 file locking | Not available. The NLM lock service is not offered on tenant floating IPs, so NFSv3 clients cannot take locks. Use NFSv4.1, where locking works. |
| User and group names on NFSv4 | Always numeric. `ls -l` shows numeric UIDs and GIDs rather than names, because NFS name resolution is available only in the root organization. Unknown names map to `anon`. Clients that perform their own local mapping are unaffected. |
| ACLs | Not enforced. An export created without an explicit ACL type is set to `NONE`. |
| `showmount -e` and `rpcinfo -p` | Return only the data for the tenant that owns the floating IP you query. |

{% hint style="warning" %}
The two items most likely to break an existing client are NFSv3 locking and numeric UIDs. An application relying on NFSv3 byte-range locks, or on `ls -l` resolving names, behaves differently after moving from a root-organization export to a tenant export.
{% endhint %}

**Related topics**

[mounting-filesystems](../../weka-filesystems-and-object-stores/mounting-filesystems/ "mention")

[manage-nfs-for-tenants.md](../../operation-guide/weka-native-multi-tenancy-management/manage-nfs-for-tenants.md "mention")
