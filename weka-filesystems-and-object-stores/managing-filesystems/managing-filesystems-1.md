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

## View filesystems

**Command:** `weka fs`

Use this command to view information on the filesystems in the WEKA system.

## Create a filesystem

**Command:** `weka fs create`

Use the following command line to create a filesystem:

`weka fs create <name> <group-name> <total-capacity> [--ssd-capacity <ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--encrypted] [--obs-name <obs-name>] [--auth-required <auth-required>] [--data-reduction]`

**Parameters**

<table><thead><tr><th>Name</th><th width="314">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Descriptive label for the filesystem, limited to 32 characters and excluding slashes (<code>/</code>) or backslashes (<code>\</code>).</td><td>​</td></tr><tr><td><code>group-name</code>*</td><td>Name of the filesystem group to which the new filesystem is to be connected.</td><td></td></tr><tr><td><code>total-capacity</code>*</td><td>Total capacity of the new filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>ssd-capacity</code></td><td>For tiered filesystems, this is the SSD capacity. If not specified, the filesystem is pinned to SSD.<br>To set a thin provisioned filesystem, the <code>thin-provision-min-ssd</code> attribute must be used instead.</td><td>SSD capacity is set to total capacity</td></tr><tr><td><code>thin-provision-min-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Must be set when defining a thin-provisioned filesystem.<br>Minimum value: 1GiB.</td><td></td></tr><tr><td><code>thin-provision-max-ssd</code></td><td>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value cannot exceed the <code>total-capacity</code>.</td><td></td></tr><tr><td><code>encrypted</code></td><td>Encryption of filesystem.</td><td>No</td></tr><tr><td><code>obs-name</code>*</td><td>Object store name for tiering.<br>Mandatory for tiered filesystems.</td><td></td></tr><tr><td><code>auth-required</code></td><td>Determines if mounting the filesystem requires to be authenticated to WEKA (see <a href="../../operation-guide/user-management/">User management</a>).</td><td>No</td></tr><tr><td><code>data-reduction</code></td><td>Enable data reduction.<br>The filesystem must be non-tired and thin-provisioned. A license with data reduction is required.<br></td><td>No</td></tr></tbody></table>



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

`weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total-capacity>] [--ssd-capacity=<ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--max-files=<max-files>] [--auth-required=<auth-required>]`

**Parameters**

| Name                     | Value                                                                                                                                                                                                                                        |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                 | Name of the filesystem to edit.                                                                                                                                                                                                              |
| `new-name`               | New name for the filesystem.                                                                                                                                                                                                                 |
| `total-capacity`         | Total capacity of the edited filesystem.                                                                                                                                                                                                     |
| `ssd-capacity`           | <p>SSD capacity of the edited filesystem.<br>Minimum value: 1GiB.</p>                                                                                                                                                                        |
| `thin-provision-min-ssd` | <p>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Minimum value: 1GiB.</p>       |
| `thin-provision-max-ssd` | <p>For <a href="../../weka-system-overview/filesystems.md#thin-provisioning">thin-proviosined</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value must not exceed the <code>total-capacity</code>.</p> |
| `max-files`              | Metadata limit for the filesystem                                                                                                                                                                                                            |
| `auth-required`          | <p>Determines if mounting the filesystem requires being authenticated to Weka (<a href="../../operation-guide/user-management/#user-log-in">weka user login</a>).<br>Possible values: <code>yes</code> or <code>no</code>.</p>               |

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
