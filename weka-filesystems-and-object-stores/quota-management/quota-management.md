---
description: >-
  Manage directory, user, and group quotas for your filesystems using the WEKA
  CLI.
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

<details>

<summary>Set and display default user and group quotas</summary>

**Set a default user quota**

A default user quota is automatically applied to any new user who starts consuming space in the filesystem. Use the following command to set it:

```bash
weka fs quota set-default --type user --soft <soft-limit> --hard <hard-limit> <path>
```

**Example:** Set a default 90 GB soft limit and a 100 GB hard limit for all new users writing to `/mnt/default`:

```bash
weka fs quota set-default --type user --soft 90GB --hard 100GB /mnt/default
```

**Set a default group quota**

A default group quota is automatically applied to any new group that starts consuming space in the filesystem. Use the following command to set it:

```bash
weka fs quota set-default --type group --soft <soft-limit> --hard <hard-limit> <path>
```

**Example:** Set a default 450 GB soft limit and a 500 GB hard limit for all new groups writing to `/mnt/default`:

```bash
weka fs quota set-default --type group --soft 450GB --hard 500GB /mnt/default
```

**Display default user quotas**

Use the following command to list all default user quotas:

```bash
weka fs quota list-default --type user
```

To list default user quotas for a specific filesystem:

```bash
weka fs quota list-default <filesystem-name> --type user
```

**Display default group quotas**

Use the following command to list all default group quotas:

```bash
weka fs quota list-default --type group
```

To list default group quotas for a specific filesystem:

```bash
weka fs quota list-default <filesystem-name> --type group
```

</details>

## Set quota

**Command**: `weka fs quota set`

Before setting a quota, check which scenario applies:

* **Directory quota:** A Data Services container is required to run the `QUOTA_COLORING` background task.
* **User or group quota on filesystems created in WEKA 5.1.20 or later:** User quota accounting is enabled automatically. No Data Services container is required.
* **User or group quota on filesystems created before WEKA 5.1.20:** Run `weka fs quota enable-users` before setting the quota. A Data Services container is required for this one-time operation.

**Related topic**

[set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention").

Use the following command to set a quota:

`weka fs quota set <path> [--type type] [--id id] [--soft soft] [--hard hard] [--grace grace] [--owner owner] [--filesystem filesystem] [--snap-name snap-name] [--color color]`

**Parameters**

<table><thead><tr><th width="134">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>path</code>*</td><td>Path to the directory to set the quota. Required for directory quota only.<br>The relevant filesystem must be mounted when setting the quota.</td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>id</code></td><td>The UID or GID the quota applies to. Required when <strong><code>type</code></strong> is <code>user</code> or <code>group</code>.</td></tr><tr><td><code>soft</code></td><td>Soft quota limit.<br>Exceeding this number is displayed as an exceeded quota, but it is not enforced until the <code>grace</code> period is over.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>hard</code></td><td>Hard quota limit.<br>Exceeding this number does not allow more writes before clearing some space in the directory.<br>The capacity can be in decimal or binary units.<br>Format: <code>1GB</code>, <code>1TB</code>, <code>1GiB</code>, <code>1TiB</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>grace</code></td><td>Specify the grace period before the soft limit is treated as a hard limit.<br>Format: <code>1d</code>, <code>1w</code>, <code>unlimited</code><br>Default: <code>unlimited</code></td></tr><tr><td><code>owner</code></td><td>A unique string identifying the directory owner (can be a name, email, slack ID, and so on.) This owner will be shown in the quota report and can be notified upon exceeding the quota.<br>Supports up to 48 characters.</td></tr><tr><td><code>filesystem</code></td><td>Specifies the target filesystem for applying the quota. This parameter only applies for user or group quota. Use this parameter when the quota must be enforced outside of a mount point, or in cases where the POSIX user does not have direct access to the directory through a mounted path.<br>For requirement details, see <a data-mention href="./#guidelines-for-quota-management">#guidelines-for-quota-management</a>.</td></tr><tr><td><code>snap-name</code></td><td>Name of the writable snapshot. Use this parameter to set a quota outside the mount point.</td></tr></tbody></table>

<details>

<summary>Set and display user and group quotas</summary>

**Set a user quota**

Use the following command to set a quota for a specific user:

```bash
weka fs quota set --type user --id <UID> --soft <soft-limit> --hard <hard-limit> --filesystem <filesystem-name>
```

**Example:** Set a 90 GB soft limit and a 100 GB hard limit for user ID 1001 on the filesystem `default`:

```bash
weka fs quota set --type user --id 1001 --soft 90GB --hard 100GB --filesystem default
```

**Set a group quota**

Use the following command to set a quota for a specific group:

```bash
weka fs quota set --type group --id <GID> --soft <soft-limit> --hard <hard-limit> --filesystem <filesystem-name>
```

**Example:** Set a 450 GB soft limit and a 500 GB hard limit for group ID 2001 on the filesystem `default`:

```bash
weka fs quota set --type group --id 2001 --soft 450GB --hard 500GB --filesystem default
```

**Display user quotas**

Use the following command to list all user quotas across all filesystems:

```bash
weka fs quota list --type user
```

To list user quotas for a specific filesystem:

```bash
weka fs quota list <filesystem-name> --type user --all
```

By default, only quotas that exceed their limits are displayed. Use `--all` to display all user quotas, including those within their limits.

**Display group quotas**

Use the following command to list all group quotas across all filesystems:

```bash
weka fs quota list --type group
```

To list group quotas for a specific filesystem:

```bash
weka fs quota list <filesystem-name> --type group --all
```

</details>

## Enable or disable user quota accounting

**Command**: `weka fs quota enable-users` / `weka fs quota disable-users`

User quota accounting applies to both user quotas and group quotas.

* **Filesystems created in WEKA 5.1.20 or later:** User quota accounting is enabled automatically. User and group quotas can be set immediately.
* **Filesystems created before WEKA 5.1.20:** Enable user quota accounting before setting user or group quotas. Run the following command:

```bash
weka fs quota enable-users <filesystem>
```

This triggers a one-time background `QUOTA_COLORING` task that stamps existing objects with UID quota identifiers. A Data Services container must be running on the cluster for this operation to complete.

There is no fallback mode for this operation. If no Data Services container is available, the command does not complete.

Per-user and per-group quota limits can be set after accounting is enabled.

To disable user quota accounting, run the following command:

```bash
weka fs quota disable-users <filesystem>
```

{% hint style="info" %}
Only a Data Services container is required to enable user quota accounting on an existing filesystem. A frontend container on the backend server is not required for this operation.
{% endhint %}

**Parameters**

| Name | Value |
| --- | --- |
| `filesystem`* | Filesystem name. |
| `snap-name` | Name of the writable snapshot. |

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
