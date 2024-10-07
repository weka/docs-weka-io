---
description: This page describes how to manage quotas using the CLI.
---

# Manage quotas using the CLI

Using the CLI, you can:

* [Set default quota](quota-management.md#set-default-quota)
* [Set directory quota](quota-management.md#set-directory-quota)
* [List directory quotas/default quotas](quota-management.md#list-directory-quotas-default-quotas)
* [Unset default quota](quota-management.md#unset-default-quota)
* [Unset directory quota](quota-management.md#unset-directory-quota)

## Set default quota

**Command**: `weka fs quota set-default`

Before using this command, verify a mount point to the relevant filesystem is set.

Default quotas apply to newly created subdirectories, not the directory or existing children.

Use the following command to set a default quota of a directory:

`weka fs quota set-default <path>  [--soft soft] [--hard hard] [--grace grace] [--owner owner]`

#### &#x20;**Parameters**

<table><thead><tr><th width="166">Name</th><th width="369">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota.<br>The relevant filesystem must be mounted when setting the quota. </td><td>​</td></tr><tr><td><code>soft</code></td><td>Soft quota limit.<br>Exceeding this number is displayed as an exceeded quota, but it is not enforced until the <code>grace</code> period is over.<br>The capacity can be in decimal or binary units.<br>Format:  <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>hard</code></td><td>Hard quota limit.<br>Exceeding this number does not allow more writes before clearing some space in the directory.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>grace</code></td><td>Specify the grace period before the soft limit is treated as a hard limit.<br>Format: <code>1d</code>, <code>1w</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>owner</code></td><td>A unique string identifying the directory owner (can be a name, email, slack ID, etc.) This owner will be shown in the quota report and can be notified upon exceeding the quota.<br>Supports up to 48 characters.</td><td></td></tr></tbody></table>

{% hint style="info" %}
* To set advisory only quotas, use a `soft` quota limit without setting a `grace` period.
* When `hard` and `soft` quotas exist, setting the value of one of them to `0` clears this quota.
{% endhint %}

## Set directory quota

**Command**: `weka fs quota set`

Before using the commands, verify that at least one Data Services container is set to enable the command to run the `QUOTA_COLORING` task in the background.\
For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").

Use the following command to set a directory quota:

`weka fs quota set <path> [--soft soft] [--hard hard] [--grace grace] [--owner owner] [--file-system file-system] [--snap-name snap-name] [--color color]`

#### **Parameters**

<table><thead><tr><th width="166">Name</th><th width="369">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota.<br>The relevant filesystem must be mounted when setting the quota. </td><td>​</td></tr><tr><td><code>soft</code></td><td>Soft quota limit.<br>Exceeding this number is displayed as an exceeded quota, but it is not enforced until the <code>grace</code> period is over.<br>The capacity can be in decimal or binary units.<br>Format:  <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>hard</code></td><td>Hard quota limit.<br>Exceeding this number does not allow more writes before clearing some space in the directory.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>grace</code></td><td>Specify the grace period before the soft limit is treated as a hard limit.<br>Format: <code>1d</code>, <code>1w</code>, <code>unlimited</code></td><td><code>unlimited</code></td></tr><tr><td><code>owner</code></td><td>A unique string identifying the directory owner (can be a name, email, slack ID, etc.) This owner will be shown in the quota report and can be notified upon exceeding the quota.<br>Supports up to 48 characters.</td><td></td></tr><tr><td><code>file-system</code></td><td>Filesystem name. Use this parameter to set a quota outside the mount point.</td><td></td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot. Use this parameter to set a quota outside the mount point.</td><td></td></tr></tbody></table>

## List directory quotas/default quotas

**Command**: `weka fs quota list` / `weka fs quota list-default`

Use the following command to list the directory quotas (by default, only exceeding quotas are listed) :

`weka fs quota list [fs-name] [--snap-name snap-name] [--path path] [--under under] [--over over] [--quick] [--all]`

#### **Parameters**

<table><thead><tr><th width="192">Name</th><th width="389">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>fs-name</code>*</td><td>Filesystem name. Use this parameter to display a quota report only on the specified filesystem.</td><td>All filesystems</td></tr><tr><td><code>snap-name</code></td><td>Displays the quota report from the time of the snapshot.<br>It must be a valid snapshot name and be given along with the corresponding <code>fs-name.</code></td><td></td></tr><tr><td><code>path</code></td><td>Path to a directory. Shows quota report only on the specified directory.<br>The relevant filesystem must be mounted in the server running the query.</td><td></td></tr><tr><td><code>under</code></td><td>A path to a directory under a wekafs mount.<br>The relevant filesystem must be mounted in the server running the query.</td><td></td></tr><tr><td><code>over</code></td><td>Shows only quotas over this percentage of usage.<br>Possible values: <code>0</code>-<code>100</code></td><td></td></tr><tr><td><code>quick</code></td><td>Do not resolve inode to a path. Provides quicker results if the report contains many entries.</td><td>False</td></tr><tr><td><code>all</code></td><td>Shows all the quotas, not just the exceeding ones.</td><td>False</td></tr></tbody></table>

Use the following command to list the directory default quotas:

`weka fs quota list-default [fs-name] [--snap-name snap-name] [--path path]`

#### **Parameters**

<table><thead><tr><th width="197.33333333333331">Name</th><th width="388">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>fs-name</code></td><td>Filesystem name. Use this parameter to display the default quotas only on the specified filesystem.</td><td>All filesystems</td></tr><tr><td><code>snap-name</code></td><td>Displays the default quotas from the time of the snapshot.<br>It must be a valid snapshot name and be given along with the corresponding <code>fs-name.</code></td><td></td></tr><tr><td><code>path</code></td><td>Path to a directory. Shows the default quotas report only on the specified directory.<br>The relevant filesystem must be mounted in the server running the query.</td><td></td></tr></tbody></table>

## Unset default quota

**Command**: `weka fs quota unset-default`

Use the following command to unset a default quota of a directory:

`weka fs quota unset-default <path>`

#### **Parameters**

<table><thead><tr><th width="244">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota.<br>The relevant filesystem must be mounted when setting the quota.</td></tr></tbody></table>

## Unset directory quota

**Command**: `weka fs quota unset`

Use the following command to unset a directory quota:

`weka fs quota unset <path>`

#### **Parameters**

<table><thead><tr><th width="244">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to unset the quota.<br>The relevant filesystem must be mounted when setting the quota.</td></tr></tbody></table>
