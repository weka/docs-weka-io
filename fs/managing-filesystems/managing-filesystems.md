---
description: This page describes how to view and manage filesystems using the CLI.
---

# Manage filesystems using the CLI

Using the CLI, you can perform the following actions:

* View filesystems
* Add a filesystem
* Add a filesystem when thin-provisioning is used
* Edit a filesystem
* Delete a filesystem

### View filesystems

**Command:** `weka fs`

Use this command to view information on the filesystems in the Weka system.

Enter the relevant parameters and click Create to create the filesystem.

### Add a filesystem

**Command:** `weka fs create`

Use the following command line to add a filesystem:

`weka fs create <name> <group-name> <total-capacity> [--ssd-capacity <ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--max-files <max-files>] [--encrypted] [--obs-name <obs-name>] [--auth-required <auth-required>]`

**Parameters in Command Line**

| **Name**                 | **Type** | **Value**                                                                                                                                                                       | **Limitations**                    | **Mandatory**                                                                                                                  | **Default**                                                      |
| ------------------------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------- |
| `name`                   | String   | Name of the filesystem being created                                                                                                                                            | Must be a valid name               | Yes                                                                                                                            | ​                                                                |
| `group-name`             | String   | Name of the filesystem group to which the new filesystem is to be connected                                                                                                     | Must be a valid name               | Yes                                                                                                                            |                                                                  |
| `total-capacity`         | Number   | Total capacity of the new filesystem                                                                                                                                            | Minimum of 1GiB                    | Yes                                                                                                                            |                                                                  |
| `ssd-capacity`           | Number   | For tiered filesystems, this is the SSD capacity. If not specified, the filesystem is pinned to SSD                                                                             | Minimum of 1GiB                    | <p>No. </p><p>To set a thin provisioned filesystem the <code>thin-provision-min-ssd</code> attribute must be used instead.</p> | SSD capacity will be set to total capacity                       |
| `thin-provision-min-ssd` | Number   | For [thin-provisioned](../../overview/filesystems.md#thin-provisioning) filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem | Minimum of 1GiB                    | <p>No. </p><p>Must be set when defining a thin-provisioned filesystem.</p>                                                     |                                                                  |
| `thin-provision-max-ssd` | Number   | For [thin-proviosined](../../overview/filesystems.md#thin-provisioning) filesystem, this is the maximum SSD capacity the filesystem can consume                                 | Cannot exceed the `total-capacity` |                                                                                                                                |                                                                  |
| `max-files`              | Number   | Metadata allocation for this filesystem                                                                                                                                         | Must be a valid number             | No                                                                                                                             | Automatically calculated by the system based on the SSD capacity |
| `encrypted`              | Boolean  | Encryption of filesystem                                                                                                                                                        |                                    | No                                                                                                                             | No                                                               |
| `obs-name`               | String   | Object store name for tiering                                                                                                                                                   | Must be a valid name               | Mandatory for tiered filesystems                                                                                               |                                                                  |
| `auth-required`          | String   | Determines if mounting the filesystem requires to be authenticated to Weka ([weka user login](../../usage/security/user-management.md#user-log-in))                             | `yes` or `no`                      | No                                                                                                                             | no                                                               |

{% hint style="info" %}
**Note:** When creating an encrypted filesystem a KMS must be defined.
{% endhint %}

{% hint style="warning" %}
**Note:** To define an encrypted filesystem without a KMS, it is possible to use the`--allow-no-kms` parameter in the command. This can be useful when running POCs but should not be used in production, since the security chain is compromised when a KMS is not used.

If filesystem keys exist when adding a KMS, they are automatically re-encrypted by the KMS for any future use.
{% endhint %}

### Add a filesystem when thin-provisioning is used&#x20;

To create a new filesystem, the SSD space for the filesystem must be free and unprovisioned. When using thin-provisioned filesystems, that might not be the case. SSD space can be occupied for the thin-provisioned portion of other filesystems. Even if those are tiered, and data can be released (to object-store) or deleted, the SSD space can still get filled when data keeps being written or rehydrated from the object-store.

To create a new filesystem in this case, use the `weka fs reserve` CLI command. Once enough space is cleared from the SSD (either by releasing to object-store or explicit deletion of data), it is possible to create the new filesystem using the reserved space.tse

### Edit a filesystem

**Command:** `weka fs update`

Use the following command line to edit an existing filesystem:

`weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total-capacity>] [--ssd-capacity=<ssd-capacity>] [--thin-provision-min-ssd <thin-provision-min-ssd>] [--thin-provision-max-ssd <thin-provision-max-ssd>] [--max-files=<max-files>] [--auth-required=<auth-required>]`

**Parameters in Command Line**

| **Name**                 | **Type** | **Value**                                                                                                                                                                       | **Limitations**                    | **Mandatory** | **Default**    |
| ------------------------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------------------------- | ------------- | -------------- |
| `name`                   | String   | Name of the filesystem being edited                                                                                                                                             | Must be a valid name               | Yes           | ​              |
| `new-name`               | String   | New name for the filesystem                                                                                                                                                     | Must be a valid name               | Optional      | Keep unchanged |
| `total-capacity`         | Number   | Total capacity of the edited filesystem                                                                                                                                         | Must be a valid number             | Optional      | Keep unchanged |
| `ssd-capacity`           | Number   | SSD capacity of the edited filesystem                                                                                                                                           | Minimum of 1GiB                    | Optional      | Keep unchanged |
| `thin-provision-min-ssd` | Number   | For [thin-provisioned](../../overview/filesystems.md#thin-provisioning) filesystems, this is the minimum SSD capacity that is ensured to be always available to this filesystem | Minimum of 1GiB                    | Optional      |                |
| `thin-provision-max-ssd` | Number   | For [thin-proviosined](../../overview/filesystems.md#thin-provisioning) filesystem, this is the maximum SSD capacity the filesystem can consume                                 | Cannot exceed the `total-capacity` | Optional      |                |
| `max-files`              | Number   | Metadata limit for the filesystem                                                                                                                                               | Must be a valid number             | Optional      | Keep unchanged |
| `auth-required`          | String   | Determines if mounting the filesystem requires to be authenticated to Weka ([weka user login](../../usage/security/user-management.md#user-log-in))                             | `yes` or `no`                      | No            | no             |

### Delete a filesystem

**Command:** `weka fs delete`

Use the following command line to delete a filesystem:

`weka fs delete <name> [--purge-from-obs]`

**Parameters in Command Line**

| **Name**         | **Type** | **Value**                                                                                     | **Limitations**      | **Mandatory** | **Default** |
| ---------------- | -------- | --------------------------------------------------------------------------------------------- | -------------------- | ------------- | ----------- |
| `name`           | String   | Name of the filesystem to be deleted                                                          | Must be a valid name | Yes           |             |
| `purge-from-obs` | Boolean  | For a tiered filesystem, if set, all filesystem data is deleted from the object store bucket. |                      | No            | False       |

{% hint style="danger" %}
**Note:** Using `purge-from-obs` will remove all data from the object-store. This includes any backup data or snapshots created from this filesystem (if this filesystem has been downloaded from a snapshot of a different filesystem, it will leave the original snapshot data intact).

* If any of the removed snapshots have been (or are) downloaded and used by a different filesystem, that filesystem will stop functioning correctly, data might be unavailable and errors might occur when accessing the data.

It is possible to either un-tier or migrate such a filesystem to a different object store bucket before deleting the snapshots it has downloaded.
{% endhint %}
