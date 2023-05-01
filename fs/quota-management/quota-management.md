---
description: This page describes how to manage quotas using the CLI.
---

# Manage quotas using the CLI

Using the CLI, you can:

* [Set directory quota/default quota](quota-management.md#set-directory-quotas-default-quotas)
* [List directory quotas/default quotas](quota-management.md#list-directory-quotas-default-quotas)
* [Unsetting directory quota/default quota](quota-management.md#unsetting-directory-quotas-default-quotas)

## Set directory quota/default quota

**Command**: `weka fs quota set` / `weka fs quota set-default`

Before using the commands, verify that a mount point to the relevant filesystem is set.

Use the following commands to set a directory quota:

`weka fs quota set <path> [--soft soft] [--hard hard] [--grace grace] [--owner owner]`

It is also possible to set a default quota on a directory. It does not account for this directory (or existing child directories) but will automatically set the quota on **new** directories created directly under it.&#x20;

Use the following command to set a default quota of a directory:

`weka fs quota set-default <path>  [--soft soft] [--hard hard] [--grace grace] [--owner owner]`

#### &#x20;**Parameters**

| **Name** | **Type** | **Value**                                                                                                                                                                          | **Limitations**                                                                      | **Mandatory** | **Default** |
| -------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------ | ------------- | ----------- |
| `path`   | String   | Path to the directory to set the quota on.                                                                                                                                         | The relevant filesystem must be mounted when setting the quota.                      | Yes           | ​           |
| `soft`   | Number   | Soft quota limit; Exceeding this number will be shown as exceeded quota but will not be enforced until the `grace` period is over.                                                 | Capacity in decimal or binary units, e.g.: `1GB`, `1TB`, `1GiB`, `1TiB`, `unlimited` | No            | `unlimited` |
| `hard`   | Number   | Hard quota limit; Exceeding this number will not allow any more writes before clearing some space in the directory.                                                                | Capacity in decimal or binary units, e.g.: `1GB`, `1TB`, `1GiB`, `1TiB`, `unlimited` | No            | `unlimited` |
| `grace`  | Number   | Specify the grace period before the soft limit is treated as a hard limit.                                                                                                         | Format: `1d`, `1w`, `unlimited`                                                      | No            | `unlimited` |
| `owner`  | String   | An opaque string identifying the directory owner (can be a name, email, slack ID, etc.) This owner will be shown in the quota report and can be notified upon exceeding the quota. | Up to 48 characters.                                                                 | No            |             |

{% hint style="info" %}
**Note:** To set advisory only quotas, use a `soft` quota limit without setting a `grace` period.
{% endhint %}

{% hint style="info" %}
**Note:** When both `hard` and `soft` quotas exist, setting the value of one of them to `0` will clear this quota.
{% endhint %}

## List directory quotas/default quotas

**Command**: `weka fs quota list` / `weka fs quota list-default`

Use the following command to list the directory quotas (by default, only exceeding quotas are listed) :

`weka fs quota list [fs-name] [--snap-name snap-name] [--path path] [--under under] [--over over] [--quick] [--all]`

#### **Parameters**

| **Name**    | **Type** | **Value**                                                                                     | **Limitations**                                                                    | **Mandatory** | **Default**     |
| ----------- | -------- | --------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------- | --------------- |
| `fs-name`   | String   | Shows quota report only on the specified filesystem.                                          | A valid wekafs filesystem name.                                                    | No            | All filesystems |
| `snap-name` | String   | Shows the quota report from the time of the snapshot.                                         | Must be a valid snapshot name and be given along with the corresponding `fs-name.` | No            |                 |
| `path`      | String   | Path to a directory. Shows quota report only on the specified directory.                      | The relevant filesystem must be mounted in the server running the query.           | No            |                 |
| `under`     | String   | A path to a directory under a wekafs mount.                                                   | The relevant filesystem must be mounted in the server running the query.           | No            |                 |
| `over`      | Number   | Shows only quotas over this percentage of usage                                               | 0-100                                                                              | No            |                 |
| `quick`     | Boolean  | Do not resolve inode to a path (provides quicker result if the report contains many entries). |                                                                                    | No            | False           |
| `all`       | Boolean  | Shows all the quotas, not just the exceeding ones.                                            |                                                                                    | No            | False           |

Use the following command to list the directory default quotas:

`weka fs quota list-default [fs-name] [--snap-name snap-name] [--path path]`

#### **Parameters**

| **Name**    | **Type** | **Value**                                                                             | **Limitations**                                                                    | **Mandatory** | **Default**     |
| ----------- | -------- | ------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | ------------- | --------------- |
| `fs-name`   | String   | Shows the default quotas of the specified filesystem only.                            | A valid wekafs filesystem name.                                                    | No            | All filesystems |
| `snap-name` | String   | Shows the default quotas from the time of the snapshot.                               | Must be a valid snapshot name and be given along with the corresponding `fs-name.` | No            |                 |
| `path`      | String   | Path to a directory. Shows the default quotas report only on the specified directory. | The relevant filesystem must be mounted in the server running the query.           | No            |                 |

## Unsetting directory quota/default quota

**Command**: `weka fs quota unset` / `weka fs quota unset-default`

Use the following commands to unset a directory quota:

`weka fs quota unset <path>`

Use the following command to unset a default quota of a directory:

`weka fs quota unset-default <path>`

#### **Parameters**

| **Name** | **Type** | **Value**                                 | **Limitations**                                                | **Mandatory** | **Default** |
| -------- | -------- | ----------------------------------------- | -------------------------------------------------------------- | ------------- | ----------- |
| `path`   | String   | Path to the directory to set the quota on | The relevant filesystem must be mounted when setting the quota | Yes           | ​           |
