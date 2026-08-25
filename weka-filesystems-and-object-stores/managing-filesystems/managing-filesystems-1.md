---
description: View, create, edit, and remove filesystems using the CLI.
---

# Manage filesystems using the CLI

{% hint style="info" %}
Several parameters in this topic relate to Key Management System (KMS) configuration, which supports both per-filesystem encryption keys and cluster encryption keys. For more information about how KMS integration works and setup guidance, see [kms-management](../../security/kms-management/ "mention").
{% endhint %}

## View filesystems

Lists the filesystems defined on the cluster, with the group each belongs to, its capacity usage, and whether it is thin-provisioned.

**Command:** `weka fs`

```sh
weka fs [--force-fresh] [--local] [--name <string>]
```

**Parameters**

| Parameter          | Description                                                                                                                                  |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `--force-fresh` | Refresh capacities to make sure information is most current. |
| `--local` | Serve the listing from the container this command connects to, without redirecting to the cluster leader. Capacity information may be stale. |
| `--name` \<string> | Show only the named filesystem. |

## Add a filesystem

Creates a filesystem with the specified total capacity. Place it in a filesystem group with `--fs-group`, and make it tiered by naming an object store with `--obs-name`.

**Command:** `weka fs add`

```sh
weka fs add <name> <total-capacity> [--allow-no-kms] [--audit-enabled] [--auth-required] [--data-reduction] [--encrypted] [--fs-group <filesystem-group>] [--index-enabled] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--max-iops <uint>] [--max-throughput <capacity>] [--obs-name <string>] [--ssd-capacity <capacity>] [--thin-provision-max-ssd <capacity>] [--thin-provision-min-ssd <capacity>]
```

**Parameters**

| Parameter                              | Description                                                                                                                      |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `name`\* | Name of filesystem for this operation. |
| `total-capacity`\* | Total filesystem capacity. value: 1GiB |
| `--allow-no-kms` | Allow creation of an encrypted filesystem without a KMS configured. This is insecure. |
| `--audit-enabled` | Enable filesystem auditing. |
| `--auth-required` | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate. For details, see user-management |
| `--data-reduction` | Enable data reduction. For details, see Filesystems, object stores, and filesystem groups |
| `--encrypted` | Create an encrypted filesystem. |
| `--fs-group` \<filesystem-group> | Filesystem group to create the filesystem in. |
| `--index-enabled` | Enable catalog indexing for the filesystem. |
| `--kms-key-identifier` \<string> | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-namespace` \<string> | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-role-id` \<string> | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-secret-id` \<string> | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--max-iops` \<uint> | Maximum filesystem IOPS. For details, see Filesystems, object stores, and filesystem groups |
| `--max-throughput` \<capacity> | Maximum filesystem throughput per second (e.g. 1GiB). For details, see Filesystems, object stores, and filesystem groups |
| `--obs-name` \<string> | Object store bucket name. Mandatory for tiered filesystems. |
| `--ssd-capacity` \<capacity> | SSD capacity for the filesystem. |
| `--thin-provision-max-ssd` \<capacity> | Maximum SSD budget for thin provisioning. |
| `--thin-provision-min-ssd` \<capacity> | Minimum SSD budget for thin provisioning. value: 1GiB. For details, see Filesystems, object stores, and filesystem groups |

{% hint style="info" %}
To create an encrypted filesystem, you must define a KMS.

If a KMS is unavailable for a POC, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) for guidance.
{% endhint %}

## Add a filesystem with thin-provisioning

When adding a new filesystem, you need unprovisioned SSD space. With thin provisioning, existing filesystems may be using their provisioned SSD space in two ways:

* Actively storing data.
* Holding space available for potential data promotions from object-store.

Even if existing filesystems are tiered, their SSD space might remain occupied due to:

* Continuous new data writes.
* Ongoing data promotions from object-store to SSD tier.

To ensure space for a new filesystem, follow these steps:

1. Use the `weka fs reserve set <ssd-capacity>` CLI command to reserve the required SSD space.
2. Wait for the system to free up sufficient SSD space through either:
   * Automatic data release to object-store.
   * Manual data deletion.
3. Create the new filesystem using the reserved space.

This ensures the new filesystem has its required minimum capacity while maintaining the performance of existing filesystems.

## Edit a filesystem

Changes an existing filesystem's name, capacity, group membership, or feature settings such as data reduction and auditing.

**Command:** `weka fs update`

```sh
weka fs update <name> [--access <access>] [--audit-enabled] [--auth-required] [--data-reduction] [--event-log-enabled] [--event-log-max-age-seconds <uint>] [--event-log-max-size-bytes-per-fs-shard <uint>] [--force] [--fs-group <filesystem-group>] [--index-enabled] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--max-iops <uint>] [--max-throughput <capacity>] [--new-name <filesystem>] [--remove-fs-group] [--ssd-capacity <capacity>] [--thin-provision-max-ssd <capacity>] [--thin-provision-min-ssd <capacity>] [--total-capacity <capacity>] [--use-cluster-kms-key-identifier]
```

**Parameters**

| Parameter                                         | Description                                                                                                                                                                       |
| ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\* | Name of filesystem for this operation. |
| `--access` \<access> | Set the filesystem access mode: ro (read-only) or rw (read-write). A replication target cannot be set to rw while its pair is active; pause the pair on the source cluster first. |
| `--audit-enabled` | Enable filesystem auditing. |
| `--auth-required` | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate. [weka user login](../../operation-guide/user-management/#user-log-in)). Possible values: `yes` or `no` |
| `--data-reduction` | Enable data reduction. For details, see [Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/#data-reduction-in-weka-filesystems) |
| `--event-log-enabled` | Enable the reliable event-change log for the filesystem. |
| `--event-log-max-age-seconds` \<uint> | Set the maximum age in seconds before event-log records are trimmed (0 disables age trim). |
| `--event-log-max-size-bytes-per-fs-shard` \<uint> | Set the maximum on-disk event-log size in bytes per filesystem shard (minimum 1 MiB; smaller values, including 0, are rejected). |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--fs-group` \<filesystem-group> | Move the filesystem into the specified filesystem group. |
| `--index-enabled` | Enable catalog indexing for the filesystem. |
| `--kms-key-identifier` \<string> | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-namespace` \<string> | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-role-id` \<string> | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--kms-secret-id` \<string> | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault. |
| `--max-iops` \<uint> | Limit I/O operations per second. This affects how much CPU is used by the filesystem on cluster servers. |
| `--max-throughput` \<capacity> | Limit throughput per second. This affects how much bandwidth is available to the filesystem. |
| `--new-name` \<filesystem> | Rename the filesystem. |
| `--remove-fs-group` | Reset the filesystem to have no group. |
| `--ssd-capacity` \<capacity> | New SSD capacity for the filesystem. value: 1GiB |
| `--thin-provision-max-ssd` \<capacity> | Maximum SSD budget for thin provisioning. |
| `--thin-provision-min-ssd` \<capacity> | Minimum SSD budget for thin provisioning. value: 1GiB. For details, see [Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/#thin-provisioning-in-weka-filesystems) |
| `--total-capacity` \<capacity> | New total capacity for the filesystem. |
| `--use-cluster-kms-key-identifier` | Use the cluster KMS configuration for this filesystem, removing any custom KMS configuration. |

## Filesystem QoS using the CLI

Use filesystem QoS parameters to cap per-filesystem throughput and IOPS.

Look for these parameters in both filesystem workflows:

* In [Add a filesystem](managing-filesystems-1.md#add-a-filesystem), use `--max-throughput` and `--max-iops` when you create a new filesystem.
* In [Edit a filesystem](managing-filesystems-1.md#edit-a-filesystem), use `--max-throughput` and `--max-iops` to change limits on an existing filesystem.

## Remove a filesystem

Deletes a filesystem and all its data. This action cannot be undone.

**Command:** `weka fs remove`

```sh
weka fs remove <name> [--force] [--purge-from-obs]
```

**Parameters**

| Parameter          | Description                                                                                                           |
| ------------------ | --------------------------------------------------------------------------------------------------------------------- |
| `name`\* | Name of filesystem for this operation. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--purge-from-obs` | Delete the filesystem's objects from the local writable Object Store, making all locally uploaded snapshots unusable. |

{% hint style="danger" %}
Using `purge-from-obs` removes all data from the object-store. This includes any backup data or snapshots created from this filesystem (if this filesystem has been downloaded from a snapshot of a different filesystem, it will leave the original snapshot data intact).

* If any of the removed snapshots have been (or are) downloaded and used by a different filesystem, that filesystem will stop functioning correctly, data might be unavailable and errors might occur when accessing the data.

It is possible to either un-tier or migrate such a filesystem to a different object store bucket before deleting the snapshots it has downloaded.
{% endhint %}

## Rewrap the filesystem encryption key

Re-encrypts a filesystem's encryption key with the current KMS master key. Use it after rotating the master key in the KMS.

**Command:** `weka fs kms-rewrap`

```sh
weka fs kms-rewrap <name>
```

**Parameters**

| Parameter | Description                            |
| --------- | -------------------------------------- |
| `name`\* | Name of filesystem for this operation. |
