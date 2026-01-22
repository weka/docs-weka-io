---
description: This page describes how to view and manage filesystems using the CLI.
---

# Manage filesystems using the CLI

Using the CLI, you can perform the following actions:

* [View filesystems](managing-filesystems-1.md#view-filesystems)
* [Add a filesystem](managing-filesystems-1.md#add-a-filesystem)
* [Add a filesystem when thin-provisioning is used](managing-filesystems-1.md#add-a-filesystem-when-thin-provisioning-is-used)
* [Edit a filesystem](managing-filesystems-1.md#edit-a-filesystem)
* [Remove a filesystem](managing-filesystems-1.md#remove-a-filesystem)
* [Rewrap the filesystem encryption key](managing-filesystems-1.md#rewrap-the-filesystem-encryption-key)

{% hint style="info" %}
Several parameters in this topic relate to Key Management System (KMS) configuration, which supports both per-filesystem encryption keys and cluster encryption keys. For more information about how KMS integration works and setup guidance, see [kms-management](../../security/kms-management/ "mention").
{% endhint %}

## View filesystems

**Command:** `weka fs`

Use this command to view information on the filesystems in the WEKA system.

## Add a filesystem

**Command:** `weka fs add`

Use the following command line to create a filesystem:

`weka fs add <name> <group-name> <total-capacity> [--obs-name <obs-name>] [--ssd-capacity <ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--audit] [--kms-key-identifier kms-key-identifier] [--kms-namespace kms-namespace] [--kms-role-id kms-role-id] [--kms-secret-id kms-secret-id] [--auth-required auth-required] [--encrypted] [--data-reduction]`

**Parameters**

<table><thead><tr><th width="229.9140625">Name</th><th width="384.859375">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>A descriptive label for the filesystem, limited to 32 characters and excluding slash (<code>/</code>) or backslash (<code>\</code>).</td><td>​</td></tr><tr><td><code>group-name</code>*</td><td>Name of the filesystem group to which the new filesystem is to be connected.</td><td></td></tr><tr><td><code>total-capacity</code>*</td><td>Total capacity of the new filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>obs-name</code></td><td>Object store name for tiering.<br>Mandatory for tiered filesystems.</td><td></td></tr><tr><td><code>ssd-capacity</code></td><td><p>Specifies the SSD capacity to allocate for a tiered file system. If this parameter is not specified, the file system is fully pinned to SSD storage.</p><p>When specified, the SSD capacity defines the portion of total capacity that resides on SSD. The recommended best practice is to maintain a 1:4 ratio between the SSD capacity and the total capacity of the file system.</p><p>To create a thin-provisioned file system, use the <code>thin-provision-min-ssd</code> attribute instead.</p></td><td>As set in <code>total-capacity</code></td></tr><tr><td><code>thin-provision-min-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems/#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Must be set when defining a thin-provisioned filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>thin-provision-max-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems/#thin-provisioning">thin-provisioned</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value cannot exceed the <code>total-capacity</code>.</td><td></td></tr><tr><td><code>audit</code></td><td>Forwards this filesystem's audit logs to a configured events monitoring platform, provided that cluster-wide auditing is also enabled.</td><td></td></tr><tr><td><code>kms-key-identifier</code></td><td>Customize KMS key identifier for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-namespace</code></td><td>Customize KMS namespace for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-role-id</code></td><td>Customize KMS role-id for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-secret-id</code></td><td>Customize KMS secret-id for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>auth-required</code></td><td>Require the mounting user to be authenticated for mounting this filesystem. This flag is only effective in the root organization, users in non-root organizations must be authenticated to perform a mount operation.<br>Format: <code>yes</code> or <code>no</code>.<br>See <a href="../../operation-guide/user-management/">User management</a>.</td><td>No</td></tr><tr><td><code>encrypted</code></td><td>Encryption of filesystem.</td><td>No</td></tr><tr><td><code>data-reduction</code></td><td>Enable data reduction.<br>Data reduction can be enabled only on thin provision, non-tiered, and unencrypted filesystems on a cluster with a valid data reduction license. For details, see <a data-mention href="../../weka-system-overview/filesystems/#data-reduction-in-weka-filesystems">#data-reduction-in-weka-filesystems</a></td><td>No</td></tr></tbody></table>

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

1. Use the `weka fs reserve` CLI command to reserve the required SSD space.
2. Wait for the system to free up sufficient SSD space through either:
   * Automatic data release to object-store.
   * Manual data deletion.
3. Create the new filesystem using the reserved space.

This ensures the new filesystem has its required minimum capacity while maintaining the performance of existing filesystems.

## Edit a filesystem

**Command:** `weka fs update`

Use the following command line to edit an existing filesystem:

`weka fs update <name> [--new-name new-name] [--total-capacity total-capacity] [--ssd-capacity ssd-capacity] [--thin-provision-min-ssd thin-provision-min-ssd] [--thin-provision-max-ssd thin-provision-max-ssd] [--audit] [--data-reduction data-reduction] [--auth-required auth-required] [--kms-key-identifier kms-key-identifier] [--kms-namespace kms-namespace] [--kms-role-id kms-role-id] [--kms-secret-id kms-secret-id] [--use-cluster-kms-key-identifier]`

**Parameters**

<table><thead><tr><th width="299.95703125">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the filesystem to edit.</td></tr><tr><td><code>new-name</code></td><td>New name for the filesystem.</td></tr><tr><td><code>total-capacity</code></td><td>Total capacity of the edited filesystem.</td></tr><tr><td><code>ssd-capacity</code></td><td>SSD capacity of the edited filesystem.<br>Minimum value: 1GiB.</td></tr><tr><td><code>thin-provision-min-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems/#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Minimum value: 1GiB.</td></tr><tr><td><code>thin-provision-max-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems/#thin-provisioning">thin-proviosined</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value must not exceed the <code>total-capacity</code>.</td></tr><tr><td><code>audit</code></td><td>Forwards this filesystem's audit logs to a configured events monitoring platform, provided that cluster-wide auditing is also enabled.</td></tr><tr><td><code>data-reduction</code></td><td>Enable data reduction.<br>Data reduction can be enabled only on thin provision, non-tiered, and unencrypted filesystems on a cluster with a valid data reduction license. For details, see <a data-mention href="../../weka-system-overview/filesystems/#data-reduction-in-weka-filesystems">#data-reduction-in-weka-filesystems</a>.</td></tr><tr><td><code>auth-required</code></td><td>Determines if mounting the filesystem requires being authenticated to Weka (<a href="../../operation-guide/user-management/#user-log-in">weka user login</a>).<br>Possible values: <code>yes</code> or <code>no</code>.</td></tr><tr><td><code>kms-key-identifier</code></td><td>Customize KMS key identifier for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-namespace</code></td><td>Customize KMS namespace for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-role-id</code></td><td>Customize KMS role-id for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-secret-id</code></td><td>Customize KMS secret-id for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>use-cluster-kms-key-identifier</code></td><td>Enable cluster KMS configuration for this filesystem, which removes any custom KMS settings previously applied to it.</td></tr></tbody></table>

## Remove a filesystem

**Command:** `weka fs remove`

Use the following command line to remove a filesystem:

`weka fs remove <name> [--purge-from-obs]`

**Parameters**

| Name             | Value                                                                                         | Default |
| ---------------- | --------------------------------------------------------------------------------------------- | ------- |
| `name`\*         | Name of the filesystem to delete.                                                             |         |
| `purge-from-obs` | For a tiered filesystem, if set, all filesystem data is deleted from the object store bucket. | False   |

{% hint style="danger" %}
Using `purge-from-obs` removes all data from the object-store. This includes any backup data or snapshots created from this filesystem (if this filesystem has been downloaded from a snapshot of a different filesystem, it will leave the original snapshot data intact).

* If any of the removed snapshots have been (or are) downloaded and used by a different filesystem, that filesystem will stop functioning correctly, data might be unavailable and errors might occur when accessing the data.

It is possible to either un-tier or migrate such a filesystem to a different object store bucket before deleting the snapshots it has downloaded.
{% endhint %}

## Rewrap the filesystem encryption key

**Command:** `weka fs kms-rewrap`

Rewrap operations can be performed per filesystem, enabling each key to be re-encrypted with a new version if there are concerns about key compromise. Use the following command to run this operation:

`weka fs kms-rewrap <name>`

**Parameters**

<table><thead><tr><th width="252">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Filesystem name</td></tr></tbody></table>
