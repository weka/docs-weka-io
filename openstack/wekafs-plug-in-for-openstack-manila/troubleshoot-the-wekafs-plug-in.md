---
description: >-
  Identify and resolve common WekaFS plug-in problems on the Manila server by
  symptom, cause, and resolution.
---

# Troubleshoot the WekaFS plug-in

To collect the share service log for any issue, run:

```bash
sudo journalctl -u openstack-manila-share --since "1 hour ago"
```

<details>

<summary>WekaFS kernel module fails to build on kernel 6.17 or later</summary>

**Symptom:** The WekaFS client fails to compile with an incompatible pointer type error, and WekaFS shares cannot mount.

**Cause:** Linux kernel 6.17 changed an internal filesystem interface that the WekaFS kernel module depends on.

**Resolution:** Pin the Manila server kernel to a version earlier than 6.17, or use the NFS protocol. For example, on Ubuntu:

```bash
uname -r
sudo apt-mark hold linux-image-$(uname -r) linux-headers-$(uname -r)
apt-mark showhold
```

Ubuntu 22.04 with the 5.15 LTS kernel is not affected.

</details>

<details>

<summary>WekaMountError: mount command failed</summary>

**Cause:** The WekaFS kernel module is not loaded on the Manila server.

**Resolution:** Load the module, and confirm that it is loaded:

```bash
sudo modprobe wekafsio
lsmod | grep wekafsio
```

</details>

<details>

<summary>WekaAuthError: Weka authentication failed</summary>

**Cause:** The `weka_username`, `weka_password`, or `weka_organization` value in `manila.conf` is incorrect.

**Resolution:** Confirm the credentials against the cluster:

```bash
curl -k -X POST https://<weka-ip>:14000/api/v2/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"manila-driver","password":"<password>","org":"Root"}'
```

</details>

<details>

<summary>Access rule in the error state</summary>

**Cause:** The rule uses an unsupported access type. `access_type=user` and `access_type=cert` are not supported on either protocol.

**Resolution:** Delete the failed rule, and create an IP-based rule:

```bash
openstack share access delete <share> <rule-id>
openstack share access create <share> ip <cidr> --access-level rw
```

</details>

<details>

<summary>ShareShrinkingPossibleDataLoss</summary>

**Cause:** The filesystem holds more data than the target shrink size.

**Resolution:** Free space on the share, and then retry the shrink operation.

</details>

<details>

<summary>SSL certificate errors</summary>

**Cause:** The plug-in cannot verify the cluster TLS certificate.

**Resolution:** In test environments only, set `weka_ssl_verify = false`.

{% hint style="warning" %}
Do not disable certificate verification in production.
{% endhint %}

</details>

<details>

<summary>FileSystemNotFound in ensure_share</summary>

**Cause:** The filesystem backing the share was deleted outside Manila.

**Resolution:** Restore the filesystem, or remove the orphaned share from Manila:

```bash
openstack share delete <share-id>
```

</details>

<details>

<summary>Snapshot copy fails with an NFS mount error</summary>

**Cause:** When creating a share from a snapshot, the plug-in waits a short grace period for the NFS gateway to apply temporary permissions. On a heavily loaded cluster, that period can be too short.

**Resolution:** Retry the operation. If the error recurs, reduce the NFS gateway load during share creation.

</details>

<details>

<summary>Orphan manila-snap- resources on the cluster</summary>

**Cause:** A create-share-from-snapshot operation was interrupted after the plug-in created temporary NFS client groups and permissions, but before cleanup ran.

**Resolution:** Remove orphan client groups whose names start with `manila-snap-` and that do not belong to an in-progress operation:

```bash
weka nfs client-group list | grep manila-snap-
weka nfs client-group delete <group-name>
```

</details>

### Related topics

[configure-the-wekafs-plug-in-for-manila.md](configure-the-wekafs-plug-in-for-manila.md "mention")

[wekafs-plug-in-configuration-options.md](wekafs-plug-in-configuration-options.md "mention")

[manage-manila-shares-on-a-weka-cluster.md](manage-manila-shares-on-a-weka-cluster.md "mention")
