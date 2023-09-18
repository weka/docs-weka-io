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

`weka fs create <name> <group-name> <total-capacity> [--ssd-capacity <ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--max-files <max-files>] [--encrypted] [--obs-name <obs-name>] [--auth-required <auth-required>] [--data-reduction]`

**Parameters**

| Name                     | Value                                                                                                                                                                                                                                                                                  | Default                               |
| ------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------- |
| `name`\*                 | Name of the filesystem being created.                                                                                                                                                                                                                                                  | ​                                     |
| `group-name`\*           | Name of the filesystem group to which the new filesystem is to be connected.                                                                                                                                                                                                           |                                       |
| `total-capacity`\*       | <p>Total capacity of the new filesystem.<br>Minimum value: 1GiB.</p>                                                                                                                                                                                                                   |                                       |
| `ssd-capacity`           | <p>For tiered filesystems, this is the SSD capacity. If not specified, the filesystem is pinned to SSD.<br>To set a thin provisioned filesystem, the <code>thin-provision-min-ssd</code> attribute must be used instead.</p>                                                           | SSD capacity is set to total capacity |
| `thin-provision-min-ssd` | <p>For <a href="../../overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Must be set when defining a thin-provisioned filesystem.<br>Minimum value: 1GiB.</p> |                                       |
| `thin-provision-max-ssd` | <p>For <a href="../../overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value cannot exceed the <code>total-capacity</code>.</p>                                                         |                                       |
| `max-files`              | <p>Metadata allocation for this filesystem.<br>Automatically calculated by the system based on the SSD capacity.</p>                                                                                                                                                                   |                                       |
| `encrypted`              | Encryption of filesystem                                                                                                                                                                                                                                                               | No                                    |
| `obs-name`\*             | <p>Object store name for tiering.<br>Mandatory for tiered filesystems.</p>                                                                                                                                                                                                             |                                       |
| `auth-required`          | Determines if mounting the filesystem requires to be authenticated to WEKA (see [User management](../../usage/user-management/)).                                                                                                                                                      | no                                    |
| data-reduction           | <p>Enable data reduction.<br>The filesystem must be non-tired and thin-provisioned. A license with data reduction is required.<br></p>                                                                                                                                                 | No                                    |



{% hint style="info" %}
When creating an encrypted filesystem a KMS must be defined.
{% endhint %}

{% hint style="warning" %}
To define an encrypted filesystem without a KMS, it is possible to use the`--allow-no-kms` parameter in the command. This can be useful when running POCs but should not be used in production since the security chain is compromised when a KMS is not used.

If filesystem keys exist when adding a KMS, they are automatically re-encrypted by the KMS for any future use.
{% endhint %}

## Add a filesystem when thin-provisioning is used&#x20;

To create a new filesystem, the SSD space for the filesystem must be free and unprovisioned. When using thin-provisioned filesystems, that might not be the case. SSD space can be occupied for the thin-provisioned portion of other filesystems. Even if those are tiered, and data can be released (to object-store) or deleted, the SSD space can still get filled when data keeps being written or rehydrated from the object-store.

To create a new filesystem, in this case, use the `weka fs reserve` CLI command. Once enough space is cleared from the SSD (either by releasing to object-store or explicitly deleting data), it is possible to create the new filesystem using the reserved space.

## Edit a filesystem

**Command:** `weka fs update`

Use the following command line to edit an existing filesystem:

`weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total-capacity>] [--ssd-capacity=<ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--max-files=<max-files>] [--auth-required=<auth-required>]`

**Parameters**

| Name                     | Value                                                                                                                                                                                                                             |
| ------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                 | Name of the filesystem to edit.                                                                                                                                                                                                   |
| `new-name`               | New name for the filesystem                                                                                                                                                                                                       |
| `total-capacity`         | Total capacity of the edited filesystem                                                                                                                                                                                           |
| `ssd-capacity`           | <p>SSD capacity of the edited filesystem.<br>Minimum value: 1GiB.</p>                                                                                                                                                             |
| `thin-provision-min-ssd` | <p>For <a href="../../overview/filesystems.md#thin-provisioning">thin-provisioned</a> filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem.<br>Minimum value: 1GiB.</p>        |
| `thin-provision-max-ssd` | <p>For <a href="../../overview/filesystems.md#thin-provisioning">thin-proviosined</a> filesystem, this is the maximum SSD capacity the filesystem can consume.<br>The value can cannot exceed the <code>total-capacity</code></p> |
| `max-files`              | Metadata limit for the filesystem                                                                                                                                                                                                 |
| `auth-required`          | <p>Determines if mounting the filesystem requires being authenticated to Weka (<a href="../../usage/user-management/#user-log-in">weka user login</a>).<br>Possible values: <code>yes</code> or <code>no</code></p>               |

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
