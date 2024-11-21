---
description: This page describes how to view and manage filesystems using the CLI.
---

# Manage filesystems using the CLI

Using the CLI, you can perform the following actions:

* [View filesystems](managing-filesystems-1.md#view-filesystems)
* [Create a filesystem](managing-filesystems-1.md#add-a-filesystem)
* [Add a filesystem when thin-provisioning is used](managing-filesystems-1.md#add-a-filesystem-when-thin-provisioning-is-used)
* [Edit a filesystem](managing-filesystems-1.md#edit-a-filesystem)
* [Delete a filesystem](managing-filesystems-1.md#delete-a-filesystem)
* [Rewrap the filesystem encryption key](managing-filesystems-1.md#rewrap-the-filesystem-encryption-key)

{% hint style="info" %}
Several parameters in this topic relate to Key Management System (KMS) configuration, which supports both per-filesystem encryption keys and cluster encryption keys. For more information about how KMS integration works and setup guidance, see  [kms-management](../../operation-guide/security/kms-management/ "mention").
{% endhint %}

## View filesystems

**Command:** `weka fs`

Use this command to view information on the filesystems in the WEKA system.

## Create a filesystem

**Command:** `weka fs create`

Use the following command line to create a filesystem:

`weka fs create <name> <group-name> <total-capacity> [--obs-name <obs-name>] [--ssd-capacity <ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--kms-key-identifier kms-key-identifier]  [--kms-namespace kms-namespace] [--kms-role-id kms-role-id] [--kms-secret-id kms-secret-id] [--auth-required auth-required] [--encrypted] [--allow-no-kms] [--data-reduction]`

**Parameters**

<table><thead><tr><th>Name</th><th width="314">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>A descriptive label for the filesystem, limited to 32 characters and excluding slash (<code>/</code>) or  backslash (<code>\</code>). </td><td>​</td></tr><tr><td><code>group-name</code>*</td><td>Name of the filesystem group to which the new filesystem is to be connected.</td><td></td></tr><tr><td><code>total-capacity</code>*</td><td>Total capacity of the new filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>obs-name</code></td><td>Object store name for tiering.<br>Mandatory for tiered filesystems.</td><td></td></tr><tr><td><code>ssd-capacity</code></td><td>For tiered filesystems, this is the SSD capacity. If not specified, the filesystem is pinned to SSD.<br>To set a thin provisioned filesystem, the <code>thin-provision-min-ssd</code> attribute must be used instead.</td><td>SSD capacity is set to total capacity</td></tr><tr><td><code>thin-provision-min-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Must be set when defining a thin-provisioned filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>thin-provision-max-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value cannot exceed the <code>total-capacity</code>.</td><td></td></tr><tr><td><code>kms-key-identifier</code></td><td>Customize KMS key identifier for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-namespace</code></td><td>Customize KMS namespace for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-role-id</code></td><td>Customize KMS role-id for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>kms-secret-id</code></td><td>Customize KMS secret-id for this filesystem (only for HashiCorp Vault).</td><td></td></tr><tr><td><code>auth-required</code></td><td>Require the mounting user to be authenticated for mounting this filesystem. This flag is only effective in the root organization, users in non-root organizations must be authenticated to perform a mount operation. <br>Format: <code>yes</code> or <code>no</code>.<br>See <a href="../../operation-guide/user-management/">User management</a>.</td><td>No</td></tr><tr><td><code>encrypted</code></td><td>Encryption of filesystem.</td><td>No</td></tr><tr><td><code>allow-no-kms</code></td><td>Allows the creation of an encrypted filesystem without a KMS configured, though this is considered insecure.</td><td>No</td></tr><tr><td><code>data-reduction</code></td><td>Enable data reduction.<br>The filesystem must be non-tired and thin-provisioned. A license with data reduction is required.</td><td>No</td></tr></tbody></table>



{% hint style="info" %}
When creating an encrypted filesystem a KMS must be defined.
{% endhint %}

{% hint style="warning" %}
To define an encrypted filesystem without a KMS, it is possible to use the`--allow-no-kms` parameter in the command. This can be useful when running POCs but should not be used in production since the security chain is compromised when a KMS is not used.

If filesystem keys exist when adding a KMS, they are automatically re-encrypted by the KMS for any future use.
{% endhint %}

## Add a filesystem when thin-provisioning is used&#x20;

To create a new filesystem, the SSD space for the filesystem must be free and unprovisioned. When using thin-provisioned filesystems, that might not be the case. SSD space can be occupied for the thin-provisioned portion of other filesystems. Even if those are tiered, and data can be released (to object-store) or deleted, the SSD space can still get filled when data keeps being written or promoted from the object-store.

To create a new filesystem, in this case, use the `weka fs reserve` CLI command. Once enough space is cleared from the SSD (either by releasing to object-store or explicitly deleting data), it is possible to create the new filesystem using the reserved space.

## Edit a filesystem

**Command:** `weka fs update`

Use the following command line to edit an existing filesystem:

`weka fs update <name> [--new-name new-name] [--total-capacity total-capacity] [--ssd-capacity ssd-capacity] [--thin-provision-min-ssd thin-provision-min-ssd] [--thin-provision-max-ssd thin-provision-max-ssd] [--data-reduction data-reduction] [--auth-required auth-required] [--kms-key-identifier kms-key-identifier] [--kms-namespace kms-namespace] [--kms-role-id kms-role-id] [--kms-secret-id kms-secret-id] [--use-cluster-kms-key-identifier]`

**Parameters**

<table><thead><tr><th width="328">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the filesystem to edit.</td></tr><tr><td><code>new-name</code></td><td>New name for the filesystem.</td></tr><tr><td><code>total-capacity</code></td><td>Total capacity of the edited filesystem.</td></tr><tr><td><code>ssd-capacity</code></td><td>SSD capacity of the edited filesystem.<br>Minimum value: 1GiB.</td></tr><tr><td><code>thin-provision-min-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Minimum value: 1GiB.</td></tr><tr><td><code>thin-provision-max-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-proviosined</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value must not exceed the <code>total-capacity</code>.</td></tr><tr><td><code>data-reduction</code></td><td>Enable data reduction.<br>The filesystem must be non-tired and thin-provisioned. A license with data reduction is required.</td></tr><tr><td><code>auth-required</code></td><td>Determines if mounting the filesystem requires being authenticated to Weka (<a href="../../operation-guide/user-management/#user-log-in">weka user login</a>).<br>Possible values: <code>yes</code> or <code>no</code>.</td></tr><tr><td><code>kms-key-identifier</code></td><td>Customize KMS key identifier for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-namespace</code></td><td>Customize KMS namespace for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-role-id</code></td><td>Customize KMS role-id for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>kms-secret-id</code></td><td>Customize KMS secret-id for this filesystem (only for HashiCorp Vault).</td></tr><tr><td><code>use-cluster-kms-key-identifier</code></td><td>Enable cluster KMS configuration for this filesystem, which removes any custom KMS settings previously applied to it.</td></tr></tbody></table>

## Delete a filesystem

**Command:** `weka fs delete`

Use the following command line to delete a filesystem:

`weka fs delete <name> [--purge-from-obs]`

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
