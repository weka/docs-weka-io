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

Sets the default quota for a directory. The default is applied automatically to new users or groups that write under that path, rather than to the directory itself.

**Command:** `weka fs quota set-default`

```sh
weka fs quota set-default [<path>] [--filesystem <filesystem>] [--grace <duration>] [--hard <capacity>] [--name <string>] [--owner <string>] [--snap-name <string>] [--soft <capacity>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                   |
| --- | --- |
| `path` | Filesystem name or path (filesystem:/directory) to set the default quota for. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--grace` \<duration> | Soft limit grace period. |
| `--hard` \<capacity> | Hard limit. Specify 0 for unlimited. |
| `--name` \<string> | Quota name, a filesystem-unique label. Specify an empty string to clear it. |
| `--owner` \<string> | Quota owner. For example, an email address. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--soft` \<capacity> | Soft limit. Specify 0 for unlimited. |
| `--type` \<quota-type> | Quota type (directory, user, or group). |

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

Sets a quota on a directory, or on a specific user or group within it. Set a mount point to the filesystem before running this command.

**Command:** `weka fs quota set`

```sh
weka fs quota set [<path>] [--filesystem <filesystem>] [--grace <duration>] [--hard <capacity>] [--id <uint32>] [--name <string>] [--owner <string>] [--snap-name <string>] [--soft <capacity>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                       |
| --- | --- |
| `path` | Filesystem path, either filesystem:/directory or path to mounted WEKA filesystem. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--grace` \<duration> | Soft limit grace period. Default: unlimited |
| `--hard` \<capacity> | Hard limit. Specify 0 for unlimited. Default: unlimited |
| `--id` \<uint32> | User or group ID (UID or GID). For user or group quotas. |
| `--name` \<string> | Quota name, a filesystem-unique label. Specify an empty string to clear it. |
| `--owner` \<string> | Quota owner. For example, an email address. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--soft` \<capacity> | Soft limit. Specify 0 for unlimited. Default: unlimited |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group Default: directory |

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

Turns per-user and per-group quota accounting on or off for a filesystem.

**Command:** `weka fs quota enable-users`

```sh
weka fs quota enable-users <filesystem> [--force] [--snap-name <string>]
```

**Parameters**

| Parameter               | Description                                        |
| --- | --- |
| `filesystem`\* | Filesystem name to enable user quota tracking for. |
| `--force` | Skip version compatibility checks. |
| `--snap-name` \<string> | Optional snapshot name. |

{% hint style="info" %}
Only a Data Services container is required to enable user quota accounting on an existing filesystem. A frontend container on the backend server is not required for this operation.
{% endhint %}

## List quotas or default quotas

Lists the quotas defined on a filesystem, optionally filtered by type or by how full they are.

**Command:** `weka fs quota list`

```sh
weka fs quota list [<filesystem>] [--all] [--over <uint8>] [--path <string>] [--quick] [--snap-name <string>] [--type <quota-type>] [--under <string>]
```

**Parameters**

| Parameter                 | Description                                                                               |
| --- | --- |
| `filesystem` | Filesystem name or path to list quotas for. If not specified, all filesystems are listed. Default: All filesystems |
| `--all` | Include all quotas, not just those over limit. Default: False |
| `--over` \<uint8> | Show only quotas over this percentage of usage. Possible values: 0-100 |
| `-p`, `--path` \<string> | Show only the quota for this path. |
| `-q`, `--quick` | Skip resolving inodes to paths. Default: False |
| `--snap-name` \<string> | Optional snapshot name. |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group Default: directory |
| `-u`, `--under` \<string> | List quotas under (and including) this path. |

Use the following command to list the directory default quotas:

`weka fs quota list-default [filesystem] [--snap-name snap-name] [--type type] [--path path]`

#### **Parameters**

<table><thead><tr><th width="156">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>filesystem</code></td><td>Filesystem name. Use this parameter to display the default quotas only on the specified filesystem.<br>Default: All filesystems</td></tr><tr><td><code>snap-name</code></td><td>Displays the default quotas from the time of the snapshot.<br>It must be a valid snapshot name and specified along with the corresponding <code>fs-name.</code></td></tr><tr><td><code>type</code></td><td><p>Quota type.</p><p>Possible values: <code>directory</code>, <code>user</code>, or <code>group</code><br>Default: <code>directory</code></p></td></tr><tr><td><code>path</code></td><td>Path to a directory. Shows the default quotas report only on the specified directory.<br>The relevant filesystem must be mounted in the server running the query.</td></tr></tbody></table>

## Unset default quota

Removes the default quota from a directory. Quotas already assigned from that default are unaffected.

**Command:** `weka fs quota unset-default`

```sh
weka fs quota unset-default [<path>] [--filesystem <filesystem>] [--snap-name <string>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                     |
| --- | --- |
| `path` | Filesystem name or path (filesystem:/directory) to unset the default quota for. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group |

## Reset quota

Removes a quota from a directory, user, or group.

**Command:** `weka fs quota reset`

```sh
weka fs quota reset [<path>] [--filesystem <filesystem>] [--generation <uint8>] [--id <uint32>] [--snap-name <string>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                       |
| --- | --- |
| `path` | Filesystem path, either filesystem:/directory or path to mounted WEKA filesystem. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--generation` \<uint8> | Remove a specific generation of quota. |
| `--id` \<uint32> | User or group ID (UID or GID). For user or group quotas. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group |
