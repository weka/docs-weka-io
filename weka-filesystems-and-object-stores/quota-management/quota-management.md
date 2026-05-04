---
description: >-
  Manage directory, user, and group quotas for your filesystems using the WEKA
  CLI.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-filesystems-and-object-stores/quota-management/quota-management
---

# Manage quotas using the CLI

Using the CLI, you can:

* [Set default quota](quota-management.md#set-default-quota)
* [Set quota](quota-management.md#set-quota)
* [Enable or disable user quota accounting](quota-management.md#enable-or-disable-user-quota-accounting)
* [List quotas or default quotas](quota-management.md#list-quotas-or-default-quotas)
* [Unset default quota](quota-management.md#unset-default-quota)
* [Reset quota](quota-management.md#reset-quota)

## Set default quota

**Command**: `weka fs quota set-default`

Sets the default quota for the specified path. The default quota is automatically applied when new instances of the selected quota type are created under that path. For example, when a new subdirectory is created (`directory` type), or when a new user or group starts consuming space in the filesystem (`user` or `group` type).

Before using this command, ensure that a mount point to the relevant filesystem is set.

`weka fs quota set-default <path> [--type type] [--soft soft] [--hard hard] [--grace grace] [--owner owner]`

#### **Parameters**

<table><thead><tr><th width="107">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota. Required for directory quota only.<br>The relevant filesystem must be mounted when setting the quota.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>soft</code></td><td>Soft quota limit.<br>Exceeding this number is displayed as an exceeded quota, but it is not enforced until the <code>grace</code> period is over.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>hard</code></td><td>Hard quota limit.<br>Exceeding this number does not allow more writes before clearing some space in the directory.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>grace</code></td><td>Specify the grace period before the soft limit is treated as a hard limit.<br>Format: <code>1d</code>, <code>1w</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>owner</code></td><td>A unique string identifying the directory owner (can be a name, email, slack ID, and so on.) This owner is shown in the quota report and can be notified upon exceeding the quota. Supports up to 48 characters.</td></tr></tbody></table>

{% hint style="info" %}
* To set advisory only quotas, use a `soft` quota limit without setting a `grace` period.
* When `hard` and `soft` quotas exist, setting the value of one of them to `0` clears this quota.
{% endhint %}

## Set quota

**Command**: `weka fs quota set`

Before setting a quota, verify that at least one Data Services container is set to enable the command to run the `QUOTA_COLORING` task in the background.\
For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").

Use the following command to set a quota:

`weka fs quota set <path> [--type type] [--id id] [--soft soft] [--hard hard] [--grace grace] [--owner owner] [--filesystem filesystem] [--snap-name snap-name] [--color color]`

**Parameters**

<table><thead><tr><th width="134">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota. Required for directory quota only.<br>The relevant filesystem must be mounted when setting the quota.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>id</code></td><td>The UID or GID the quota applies to. Required when <strong><code>type</code></strong> is <code>user</code> or <code>group</code>.</td></tr><tr><td><code>soft</code></td><td>Soft quota limit.<br>Exceeding this number is displayed as an exceeded quota, but it is not enforced until the <code>grace</code> period is over.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>hard</code></td><td>Hard quota limit.<br>Exceeding this number does not allow more writes before clearing some space in the directory.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>grace</code></td><td>Specify the grace period before the soft limit is treated as a hard limit.<br>Format: <code>1d</code>, <code>1w</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>owner</code></td><td>A unique string identifying the directory owner (can be a name, email, slack ID, and so on.) This owner will be shown in the quota report and can be notified upon exceeding the quota.<br>Supports up to 48 characters.</td></tr><tr><td><code>filesystem</code></td><td>Specifies the target filesystem for applying the quota. This parameter only applies for user or group quota. Use this parameter when the quota must be enforced outside of a mount point, or in cases where the POSIX user does not have direct access to the directory through a mounted path. <br>For requirement details, see <a data-mention href="./#guidelines-for-quota-management">#guidelines-for-quota-management</a>.</td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot. Use this parameter to set a quota outside the mount point.</td></tr></tbody></table>

## Enable or disable user quota accounting

**Command**: `weka fs quota enable-users` / `weka fs quota disable-users`

User quota accounting is enabled by default on new filesystems, including filesystems created after an upgrade.

For existing filesystems that were upgraded, run `enable-users` to enable accounting explicitly. Enabling accounting on an existing filesystem triggers a background `QUOTA_COLORING` task that stamps existing objects with UID quota identifiers.

A Data Services container is required for this initial coloring. New filesystems do not require a Data Services container for quota counting.

Per-user quota limits can be set after accounting is enabled.

`weka fs quota enable-users <filesystem> [--snap-name snap-name]`

`weka fs quota disable-users <filesystem> [--snap-name snap-name]`

**Parameters**

<table><thead><tr><th width="157">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>filesystem</code>*</td><td>Filesystem name.</td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot.</td></tr></tbody></table>

## List quotas or default quotas

**Command**: `weka fs quota list` / `weka fs quota list-default`

Use the following command to list the quotas (by default, only exceeding quotas are listed):

`weka fs quota list [filesystem] [--snap-name snap-name] [--type type] [--path path] [--under under] [--over over] [--quick] [--all]`

**Parameters**

<table><thead><tr><th width="133">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>filesystem</code></td><td>Filesystem name. Use this parameter to display a quota report only on the specified filesystem.<br>Default: All filesystems</td></tr><tr><td><code>snap-name</code></td><td>Displays the quota report from the time of the snapshot.<br>It must be a valid snapshot name and be given along with the corresponding filesystem.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>path</code></td><td>Path to a directory. Shows quota report only on the specified directory.<br>The relevant filesystem must be mounted in the server running the query.</td></tr><tr><td><code>under</code></td><td>A path to a directory under a wekafs mount.<br>The relevant filesystem must be mounted in the server running the query.</td></tr><tr><td><code>over</code></td><td>Shows only quotas over this percentage of usage.<br>Possible values: <code>0</code>-<code>100</code></td></tr><tr><td><code>quick</code></td><td>Do not resolve inode to a path. Provides quicker results if the report contains many entries.<br>Default: False</td></tr><tr><td><code>all</code></td><td>Shows all the quotas, not just the exceeding ones.<br>Default: False</td></tr></tbody></table>

Use the following command to list the directory default quotas:

`weka fs quota list-default [filesystem] [--snap-name snap-name] [--type type] [--path path]`

#### **Parameters**

<table><thead><tr><th width="156">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>filesystem</code></td><td>Filesystem name. Use this parameter to display the default quotas only on the specified filesystem.<br>Default: All filesystems</td></tr><tr><td><code>snap-name</code></td><td>Displays the default quotas from the time of the snapshot.<br>It must be a valid snapshot name and specified along with the corresponding <code>fs-name.</code></td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>path</code></td><td>Path to a directory. Shows the default quotas report only on the specified directory.<br>The relevant filesystem must be mounted in the server running the query.</td></tr></tbody></table>

## Unset default quota

**Command**: `weka fs quota unset-default`

Use the following command to unset a default quota of a directory:

`weka fs quota unset-default <path> [--type type] [--filesystem filesystem] [--snap-name snap-name]`

**Parameters**

<table><thead><tr><th width="157">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota.<br>The relevant filesystem must be mounted when setting the quota.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code></p></td></tr><tr><td><code>filesystem</code></td><td>Filesystem name.<br>Required for <code>user</code> or <code>group</code> types.</td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot.<br>Only applies to <code>user</code> or <code>group</code> types.</td></tr></tbody></table>

## Reset quota

**Command**: `weka fs quota reset`

Use the following command to reset a quota:

`weka fs quota reset [path] [--type type] [--id id] [--generation generation] [--filesystem filesystem] [--snap-name snap-name]`

**Parameters**

<table><thead><tr><th width="178">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to unset the quota.<br>The relevant filesystem must be mounted when setting the quota.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code></p></td></tr><tr><td><code>id</code></td><td>The UID or GID the quota applies to. Required when <strong><code>type</code></strong> is <code>user</code> or <code>group</code>.</td></tr><tr><td><code>generation</code></td><td>The generation of the directory quota to remove. Applies to directory quotas only. If omitted, the current generation is used.</td></tr><tr><td><code>filesystem</code></td><td>Filesystem name.<br>Required for <code>user</code> or <code>group</code> types.</td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot to remove if exists.<br>Only applies to <code>user</code> or <code>group</code> types.</td></tr></tbody></table>

