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
| ---------------------------- | ----------------------------------------------------------------------------- |
| `path` | Filesystem name or path (filesystem:/directory) to set the default quota for. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--grace` \<duration> | Soft limit grace period. Default: unlimited |
| `--hard` \<capacity> | Hard limit. Specify 0 for unlimited. Default: unlimited |
| `--name` \<string> | Quota name, a filesystem-unique label. Specify an empty string to clear it. |
| `--owner` \<string> | Quota owner. For example, an email address. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--soft` \<capacity> | Soft limit. Specify 0 for unlimited. Default: unlimited |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group Default: directory |

{% hint style="info" %}
* To set advisory only quotas, use a `soft` quota limit without setting a `grace` period.
* When `hard` and `soft` quotas exist, setting the value of one of them to `0` clears this quota.
{% endhint %}

## Set quota

Sets a quota on a directory, or on a specific user or group within it. Set a mount point to the filesystem before running this command.

**Command:** `weka fs quota set`

```sh
weka fs quota set [<path>] [--filesystem <filesystem>] [--grace <duration>] [--hard <capacity>] [--id <uint32>] [--name <string>] [--owner <string>] [--snap-name <string>] [--soft <capacity>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------- |
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

## Enable or disable user quota accounting

Turns per-user and per-group quota accounting on or off for a filesystem.

**Command:** `weka fs quota enable-users`

```sh
weka fs quota enable-users <filesystem> [--force] [--snap-name <string>]
```

**Parameters**

| Parameter               | Description                                        |
| ----------------------- | -------------------------------------------------- |
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
| ------------------------- | ----------------------------------------------------------------------------------------- |
| `filesystem` | Filesystem name or path to list quotas for. If not specified, all filesystems are listed. Default: All filesystems |
| `--all` | Include all quotas, not just those over limit. Default: False |
| `--over` \<uint8> | Show only quotas over this percentage of usage. Possible values: 0-100 |
| `-p`, `--path` \<string> | Show only the quota for this path. |
| `-q`, `--quick` | Skip resolving inodes to paths. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group Default: directory |
| `-u`, `--under` \<string> | List quotas under (and including) this path. |

## Unset default quota

Removes the default quota from a directory. Quotas already assigned from that default are unaffected.

**Command:** `weka fs quota unset-default`

```sh
weka fs quota unset-default [<path>] [--filesystem <filesystem>] [--snap-name <string>] [--type <quota-type>]
```

**Parameters**

| Parameter                    | Description                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------- |
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
| ---------------------------- | --------------------------------------------------------------------------------- |
| `path` | Filesystem path, either filesystem:/directory or path to mounted WEKA filesystem. |
| `--filesystem` \<filesystem> | Name of filesystem. |
| `--generation` \<uint8> | Remove a specific generation of quota. |
| `--id` \<uint32> | User or group ID (UID or GID). For user or group quotas. |
| `--snap-name` \<string> | Optional snapshot name. |
| `--type` \<quota-type> | Quota type (directory, user, or group). Possible values: directory, user, or group |
