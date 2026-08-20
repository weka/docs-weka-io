# weka fs

List filesystems defined in this Weka cluster.

```sh
weka fs [--force-fresh] [--local] [--name <string>]
```

| Parameter          | Description                                                                                                                                  |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------- |
| `--force-fresh`    | Refresh capacities to make sure information is most current.                                                                                 |
| `--local`          | Serve the listing from the container this command connects to, without redirecting to the cluster leader. Capacity information may be stale. |
| `--name` \<string> | Show only the named filesystem.                                                                                                              |

**Columns:** `uid`, `id`, `name`, `group`, `groupId`, `usedSSD`, `usedSSDD`, `usedSSDM`, `freeSSD`, `availableSSDM`, `availableSSD`, `usedTotal`, `usedTotalD`, `freeTotal`, `availableTotal`, `maxFiles`, `status`, `encrypted`, `stores`, `authRequired`, `thinProvisioned`, `thinProvisioningMinSSDBudget`, `thinProvisioningMaxSSDBudget`, `usedSSDWD`, `usedSSDRD`, `reductionRatio`, `pendingReduction`, `dataReduction`, `reducedProcessSize`, `reducedSize`, `kmsKey`, `kmsNamespace`, `kmsRole`, `processedReductionRatio`, `audit`, `auditOpenClose`, `permissions`, `ownerGuid`, `maxThroughput`, `maxIops`

## weka fs add

Add a new filesystem with the specified parameters.

```sh
weka fs add <name> <total-capacity> [--allow-no-kms] [--audit-enabled] [--auth-required] [--data-reduction] [--encrypted] [--fs-group <filesystem-group>] [--index-enabled] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--max-iops <uint>] [--max-throughput <capacity>] [--obs-name <string>] [--ssd-capacity <capacity>] [--thin-provision-max-ssd <capacity>] [--thin-provision-min-ssd <capacity>]
```

| Parameter                              | Description                                                                                                                      |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                               | Name of filesystem for this operation.                                                                                           |
| `total-capacity`\*                     | Total filesystem capacity.                                                                                                       |
| `--allow-no-kms`                       | Allow creation of an encrypted filesystem without a KMS configured. This is insecure.                                            |
| `--audit-enabled`                      | Enable filesystem auditing.                                                                                                      |
| `--auth-required`                      | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate. |
| `--data-reduction`                     | Enable data reduction.                                                                                                           |
| `--encrypted`                          | Create an encrypted filesystem.                                                                                                  |
| `--fs-group` \<filesystem-group>       | Filesystem group to create the filesystem in.                                                                                    |
| `--index-enabled`                      | Enable catalog indexing for the filesystem.                                                                                      |
| `--kms-key-identifier` \<string>       | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault.                                            |
| `--kms-namespace` \<string>            | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault.                                                 |
| `--kms-role-id` \<string>              | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault.                                           |
| `--kms-secret-id` \<string>            | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault.                                         |
| `--max-iops` \<uint>                   | Maximum filesystem IOPS.                                                                                                         |
| `--max-throughput` \<capacity>         | Maximum filesystem throughput per second (e.g. 1GiB).                                                                            |
| `--obs-name` \<string>                 | Object store bucket name. Mandatory for tiered filesystems.                                                                      |
| `--ssd-capacity` \<capacity>           | SSD capacity for the filesystem.                                                                                                 |
| `--thin-provision-max-ssd` \<capacity> | Maximum SSD budget for thin provisioning.                                                                                        |
| `--thin-provision-min-ssd` \<capacity> | Minimum SSD budget for thin provisioning.                                                                                        |

## weka fs download

Download a filesystem from object storage.

```sh
weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--access-point <string>] [--additional-obs-bucket <string>] [--audit-enabled] [--auth-required] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--snapshot-name <string>]
```

| Parameter                           | Description                                                                                                                      |
| ----------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                            | Name of filesystem for this operation.                                                                                           |
| `group-name`\*                      | Filesystem group to create the downloaded filesystem in.                                                                         |
| `total-capacity`\*                  | Total capacity of the downloaded filesystem.                                                                                     |
| `ssd-capacity`\*                    | SSD capacity of the downloaded filesystem.                                                                                       |
| `obs-bucket`\*                      | Object Store bucket containing the filesystem data.                                                                              |
| `locator`\*                         | Locator for the filesystem snapshot in object storage.                                                                           |
| `--access-point` \<string>          | Access point for the downloaded snapshot. Defaults to the uploaded access point.                                                 |
| `--additional-obs-bucket` \<string> | Additional Object Store bucket for the downloaded filesystem.                                                                    |
| `--audit-enabled`                   | Enable filesystem auditing.                                                                                                      |
| `--auth-required`                   | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate. |
| `--kms-key-identifier` \<string>    | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault.                                            |
| `--kms-namespace` \<string>         | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault.                                                 |
| `--kms-role-id` \<string>           | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault.                                           |
| `--kms-secret-id` \<string>         | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault.                                         |
| `--snapshot-name` \<string>         | Name for the downloaded snapshot. Defaults to the uploaded name.                                                                 |

## weka fs group

List filesystem groups.

```sh
weka fs group
```

**Columns:** `uid`, `group`, `name`, `fs_count`, `retention`, `demote`

### weka fs group add

Add a filesystem group.

```sh
weka fs group add <name> [--ssd-retention <duration>] [--start-demote <duration>]
```

| Parameter                     | Description                                             |
| ----------------------------- | ------------------------------------------------------- |
| `name`\*                      | Name of the filesystem group.                           |
| `--ssd-retention` \<duration> | How long to keep an SSD copy of the data.               |
| `--start-demote` \<duration>  | How long to wait before copying data to object storage. |

### weka fs group remove

Remove a filesystem group.

```sh
weka fs group remove <name>
```

| Parameter | Description                   |
| --------- | ----------------------------- |
| `name`\*  | Name of the filesystem group. |

### weka fs group update

Update a filesystem group's configuration.

```sh
weka fs group update <name> [--new-name <filesystem-group>] [--ssd-retention <duration>] [--start-demote <duration>]
```

| Parameter                        | Description                                             |
| -------------------------------- | ------------------------------------------------------- |
| `name`\*                         | Name of the filesystem group.                           |
| `--new-name` \<filesystem-group> | Rename the filesystem group.                            |
| `--ssd-retention` \<duration>    | How long to keep an SSD copy of the data.               |
| `--start-demote` \<duration>     | How long to wait before copying data to object storage. |

## weka fs kms-rewrap

Rewrap the KMS encryption key for a filesystem.

```sh
weka fs kms-rewrap <name>
```

| Parameter | Description                            |
| --------- | -------------------------------------- |
| `name`\*  | Name of filesystem for this operation. |

## weka fs protection

Manage filesystem protection.

```sh
weka fs protection
```

### weka fs protection snapshot-policy

Manage filesystem snapshot policies.

```sh
weka fs protection snapshot-policy
```

#### weka fs protection snapshot-policy add

Add new snapshot policy.

```sh
weka fs protection snapshot-policy add <name> <path> [--description <string>] [--enabled]
```

| Parameter                 | Description                                                                                              |
| ------------------------- | -------------------------------------------------------------------------------------------------------- |
| `name`\*                  | Snapshot policy name. (up to 12 alphanumeric characters, hyphens (-), underscores (\_), and periods (.)) |
| `path`\*                  | Path to snapshot policy file. Policy file must be in JSON format.                                        |
| `--description` \<string> | Policy description.                                                                                      |
| `--enabled`               | Set snapshot policy status.                                                                              |

#### weka fs protection snapshot-policy attach

Attach snapshot policy.

```sh
weka fs protection snapshot-policy attach <name> <filesystems>
```

| Parameter       | Description                      |
| --------------- | -------------------------------- |
| `name`\*        | Snapshot policy name.            |
| `filesystems`\* | Filesystems to attach to policy. |

#### weka fs protection snapshot-policy detach

Detach snapshot policy.

```sh
weka fs protection snapshot-policy detach <name> <filesystems> [--force] [--remove-waiting-tasks]
```

| Parameter                | Description                                                                      |
| ------------------------ | -------------------------------------------------------------------------------- |
| `name`\*                 | Snapshot policy name.                                                            |
| `filesystems`\*          | Filesystems to detach from the policy.                                           |
| `-f`, `--force`          | Force action. Perform this action without further confirmation.                  |
| `--remove-waiting-tasks` | Remove waiting tasks. Delete all waiting tasks corresponding to the filesystems. |

#### weka fs protection snapshot-policy duplicate

Duplicate snapshot policy.

```sh
weka fs protection snapshot-policy duplicate <name> <new-name> [--description <string>] [--include-attached-filesystems]
```

| Parameter                        | Description                           |
| -------------------------------- | ------------------------------------- |
| `name`\*                         | Name of snapshot policy to duplicate. |
| `new-name`\*                     | Name of new snapshot policy.          |
| `--description` \<string>        | Policy description.                   |
| `--include-attached-filesystems` | Include attached filesystems.         |

#### weka fs protection snapshot-policy export

Export snapshot policy.

```sh
weka fs protection snapshot-policy export <name> <path>
```

| Parameter | Description                                              |
| --------- | -------------------------------------------------------- |
| `name`\*  | The snapshot policy to export.                           |
| `path`\*  | The path where the exported policy file will be located. |

#### weka fs protection snapshot-policy list

List snapshot policies.

```sh
weka fs protection snapshot-policy list
```

**Columns:** `policy_id`, `name`, `enabled`, `description`, `filesystems`

#### weka fs protection snapshot-policy remove

Remove snapshot policy.

```sh
weka fs protection snapshot-policy remove <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\*        | Existing snapshot policy name.                                  |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka fs protection snapshot-policy run-once

Run snapshot policy schedule.

```sh
weka fs protection snapshot-policy run-once <name> <schedule-type>
```

| Parameter         | Description                                         |
| ----------------- | --------------------------------------------------- |
| `name`\*          | Name of snapshot policy.                            |
| `schedule-type`\* | Schedule type. This schedule type will be run once. |

#### weka fs protection snapshot-policy show

Show snapshot policy.

```sh
weka fs protection snapshot-policy show <name>
```

| Parameter | Description  |
| --------- | ------------ |
| `name`\*  | Policy name. |

#### weka fs protection snapshot-policy update

Update snapshot policy.

```sh
weka fs protection snapshot-policy update <name> [--description <string>] [--enabled] [--new-name <string>] [--path <string>]
```

| Parameter                 | Description                                                           |
| ------------------------- | --------------------------------------------------------------------- |
| `name`\*                  | Snapshot policy name.                                                 |
| `--description` \<string> | Policy description.                                                   |
| `--enabled`               | Set snapshot policy status.                                           |
| `--new-name` \<string>    | New policy name.                                                      |
| `--path` \<string>        | Path to new or modified snapshot policy file. Must be in JSON format. |

## weka fs quota

Manage directory quotas.

```sh
weka fs quota
```

### weka fs quota disable-users

Disable user quota tracking for a filesystem.

```sh
weka fs quota disable-users <filesystem> [--force] [--snap-name <string>]
```

| Parameter               | Description                                                     |
| ----------------------- | --------------------------------------------------------------- |
| `filesystem`\*          | Filesystem name to disable user quota tracking for.             |
| `-f`, `--force`         | Force action. Perform this action without further confirmation. |
| `--snap-name` \<string> | Optional snapshot name.                                         |

### weka fs quota enable-users

Enable user quota tracking for a filesystem.

```sh
weka fs quota enable-users <filesystem> [--force] [--snap-name <string>]
```

| Parameter               | Description                                        |
| ----------------------- | -------------------------------------------------- |
| `filesystem`\*          | Filesystem name to enable user quota tracking for. |
| `--force`               | Skip version compatibility checks.                 |
| `--snap-name` \<string> | Optional snapshot name.                            |

### weka fs quota list

List filesystem quotas (by default, only exceeding ones).

```sh
weka fs quota list [<filesystem>] [--all] [--over <uint8>] [--path <string>] [--quick] [--snap-name <string>] [--type <quota-type>] [--under <string>]
```

| Parameter                 | Description                                                                               |
| ------------------------- | ----------------------------------------------------------------------------------------- |
| `filesystem`              | Filesystem name or path to list quotas for. If not specified, all filesystems are listed. |
| `--all`                   | Include all quotas, not just those over limit.                                            |
| `--over` \<uint8>         | Show only quotas over this percentage of usage.                                           |
| `-p`, `--path` \<string>  | Show only the quota for this path.                                                        |
| `-q`, `--quick`           | Skip resolving inodes to paths.                                                           |
| `--snap-name` \<string>   | Optional snapshot name.                                                                   |
| `--type` \<quota-type>    | Quota type (directory, user, or group).                                                   |
| `-u`, `--under` \<string> | List quotas under (and including) this path.                                              |

**Columns:** `name`, `quota_id`, `fs_name`, `snap_name`, `path`, `total_bytes`, `data_blocks`, `metadata_blocks`, `soft_limit_bytes`, `hard_limit_bytes`, `usage`, `owner`, `grace_seconds`, `time_over_soft_limit`, `status`

### weka fs quota list-default

List filesystem default quotas.

```sh
weka fs quota list-default [<filesystem>] [--path <string>] [--snap-name <string>] [--type <quota-type>]
```

| Parameter                | Description                                                                          |
| ------------------------ | ------------------------------------------------------------------------------------ |
| `filesystem`             | Filesystem to list default quotas for. If not specified, all filesystems are listed. |
| `-p`, `--path` \<string> | Show only the default quota for this directory path.                                 |
| `--snap-name` \<string>  | Optional snapshot name.                                                              |
| `--type` \<quota-type>   | Quota type (directory, user, or group).                                              |

**Columns:** `name`, `fs_name`, `snap_name`, `path`, `soft_limit_bytes`, `hard_limit_bytes`, `owner`, `grace_seconds`

### weka fs quota reset

Reset a directory quota in a filesystem.

```sh
weka fs quota reset [<path>] [--filesystem <filesystem>] [--generation <uint8>] [--id <uint32>] [--snap-name <string>] [--type <quota-type>]
```

| Parameter                    | Description                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------- |
| `path`                       | Filesystem path, either filesystem:/directory or path to mounted WEKA filesystem. |
| `--filesystem` \<filesystem> | Name of filesystem.                                                               |
| `--generation` \<uint8>      | Remove a specific generation of quota.                                            |
| `--id` \<uint32>             | User or group ID (UID or GID). For user or group quotas.                          |
| `--snap-name` \<string>      | Optional snapshot name.                                                           |
| `--type` \<quota-type>       | Quota type (directory, user, or group).                                           |

### weka fs quota set

Set a directory quota in a filesystem.

```sh
weka fs quota set [<path>] [--filesystem <filesystem>] [--grace <duration>] [--hard <capacity>] [--id <uint32>] [--name <string>] [--owner <string>] [--snap-name <string>] [--soft <capacity>] [--type <quota-type>]
```

| Parameter                    | Description                                                                       |
| ---------------------------- | --------------------------------------------------------------------------------- |
| `path`                       | Filesystem path, either filesystem:/directory or path to mounted WEKA filesystem. |
| `--filesystem` \<filesystem> | Name of filesystem.                                                               |
| `--grace` \<duration>        | Soft limit grace period.                                                          |
| `--hard` \<capacity>         | Hard limit. Specify 0 for unlimited.                                              |
| `--id` \<uint32>             | User or group ID (UID or GID). For user or group quotas.                          |
| `--name` \<string>           | Quota name, a filesystem-unique label. Specify an empty string to clear it.       |
| `--owner` \<string>          | Quota owner. For example, an email address.                                       |
| `--snap-name` \<string>      | Optional snapshot name.                                                           |
| `--soft` \<capacity>         | Soft limit. Specify 0 for unlimited.                                              |
| `--type` \<quota-type>       | Quota type (directory, user, or group).                                           |

### weka fs quota set-default

Set a default quota in a filesystem.

```sh
weka fs quota set-default [<path>] [--filesystem <filesystem>] [--grace <duration>] [--hard <capacity>] [--name <string>] [--owner <string>] [--snap-name <string>] [--soft <capacity>] [--type <quota-type>]
```

| Parameter                    | Description                                                                   |
| ---------------------------- | ----------------------------------------------------------------------------- |
| `path`                       | Filesystem name or path (filesystem:/directory) to set the default quota for. |
| `--filesystem` \<filesystem> | Name of filesystem.                                                           |
| `--grace` \<duration>        | Soft limit grace period.                                                      |
| `--hard` \<capacity>         | Hard limit. Specify 0 for unlimited.                                          |
| `--name` \<string>           | Quota name, a filesystem-unique label. Specify an empty string to clear it.   |
| `--owner` \<string>          | Quota owner. For example, an email address.                                   |
| `--snap-name` \<string>      | Optional snapshot name.                                                       |
| `--soft` \<capacity>         | Soft limit. Specify 0 for unlimited.                                          |
| `--type` \<quota-type>       | Quota type (directory, user, or group).                                       |

### weka fs quota unset-default

Unset a default quota in a filesystem.

```sh
weka fs quota unset-default [<path>] [--filesystem <filesystem>] [--snap-name <string>] [--type <quota-type>]
```

| Parameter                    | Description                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------- |
| `path`                       | Filesystem name or path (filesystem:/directory) to unset the default quota for. |
| `--filesystem` \<filesystem> | Name of filesystem.                                                             |
| `--snap-name` \<string>      | Optional snapshot name.                                                         |
| `--type` \<quota-type>       | Quota type (directory, user, or group).                                         |

## weka fs remove

Delete a filesystem and all its data. This action cannot be undone.

```sh
weka fs remove <name> [--force] [--purge-from-obs]
```

| Parameter          | Description                                                                                                           |
| ------------------ | --------------------------------------------------------------------------------------------------------------------- |
| `name`\*           | Name of filesystem for this operation.                                                                                |
| `-f`, `--force`    | Force action. Perform this action without further confirmation.                                                       |
| `--purge-from-obs` | Delete the filesystem's objects from the local writable Object Store, making all locally uploaded snapshots unusable. |

## weka fs replication

List replication pairs with their current state and progress.

```sh
weka fs replication
```

**Columns:** `id`, `uid`, `state`, `source`, `target-cluster`, `target`, `interval`, `snapshots-to-keep`, `apply`, `access`, `copy`, `copy-paths`, `last-replication`, `current-status`, `last-error`, `last-error-time`

### weka fs replication add

Create a new replication pair between a local filesystem and a filesystem on a configured cluster peer.

```sh
weka fs replication add --interval <duration> --source-filesystem <filesystem> --target-cluster <cluster-peer> --target-filesystem <filesystem> [--access-strategy <access-strategy>] [--apply-strategy <apply-strategy>] [--copy-path <path>…] [--now] [--snapshots-to-keep <count>] [--target-total-capacity <capacity>]
```

| Parameter                              | Description                                                                                                                                                                                                    |
| -------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--interval` \<duration>\*             | Replication interval (e.g. 5m, 1h). Range: 5 minutes to 30 days.                                                                                                                                               |
| `--source-filesystem` \<filesystem>\*  | Name of the local source filesystem.                                                                                                                                                                           |
| `--target-cluster` \<cluster-peer>\*   | Name of the configured cluster peer.                                                                                                                                                                           |
| `--target-filesystem` \<filesystem>\*  | Name of the filesystem on the remote cluster.                                                                                                                                                                  |
| `--access-strategy` \<access-strategy> | When users see the target filesystem: INSTANT\_ACCESS (default) exposes the snapshot immediately and fetches data lazily; COPY\_FIRST blocks the apply until --copy-path data is local.                        |
| `--apply-strategy` \<apply-strategy>   | When the snapshot becomes visible on the target. AUTOMATIC (the default, and the only value supported in this release) applies it as soon as the prerequisite phase finishes.                                  |
| `--copy-path` \<path>…                 | Eager-copy path. Keywords: 'full', 'all' or '/' for full copy; 'none' or 'null' for no eager copy. Default: no eager copy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--now`                                | Trigger the first replication cycle immediately instead of waiting one full interval.                                                                                                                          |
| `--snapshots-to-keep` \<count>         | Number of snapshots to retain. Default: 3. Range: 2 to 25.                                                                                                                                                     |
| `--target-total-capacity` \<capacity>  | Total capacity for the target filesystem (default: same as the source filesystem). A smaller target is allowed for partial or no eager copy (--copy-path); full copy requires at least the source size.        |

### weka fs replication fetch

Asynchronously fetch a file's lazy-data blocks from the source cluster. The fetch runs in the background; use 'weka fs replication hydration status' to monitor progress. Accepts either a local mount path or --filesystem NAME with an FS-relative path.

```sh
weka fs replication fetch <path> [--filesystem <filesystem>] [--snapshot <snapshot>]
```

| Parameter                    | Description                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------- |
| `path`\*                     | Path to fetch.                                                                  |
| `--filesystem` \<filesystem> | Filesystem name; the positional path is treated as FS-relative.                 |
| `--snapshot` \<snapshot>     | Snapshot name; resolve path within this snapshot view instead of the live root. |

### weka fs replication hydration

Per-file replication hydration commands.

```sh
weka fs replication hydration
```

#### weka fs replication hydration status

Show replication hydration status for a given file path: how much of the file is locally available and how much is still pending on the source cluster (lazy-data blocks not yet prefetched).

```sh
weka fs replication hydration status <path> [--filesystem <filesystem>] [--snapshot <snapshot>]
```

| Parameter                    | Description                                                                     |
| ---------------------------- | ------------------------------------------------------------------------------- |
| `path`\*                     | Path to get replication hydration status for.                                   |
| `--filesystem` \<filesystem> | Filesystem name; the positional path is treated as FS-relative.                 |
| `--snapshot` \<snapshot>     | Snapshot name; resolve path within this snapshot view instead of the live root. |

**Columns:** `path`, `type`, `size`, `local`, `pending`, `progress`, `status`

### weka fs replication pause

Pause an active replication pair.

```sh
weka fs replication pause <id>
```

| Parameter | Description          |
| --------- | -------------------- |
| `id`\*    | Replication pair ID. |

### weka fs replication release

Asynchronously return a file's data blocks to lazy mode. The release runs in the background; use 'weka fs replication hydration status' to monitor progress.

```sh
weka fs replication release
```

### weka fs replication remove

Remove an existing replication pair.

```sh
weka fs replication remove <id> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `id`\*          | Replication pair ID.                                            |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka fs replication resume

Resume a paused replication pair.

```sh
weka fs replication resume <id>
```

| Parameter | Description          |
| --------- | -------------------- |
| `id`\*    | Replication pair ID. |

### weka fs replication update

Update an existing replication pair's configuration.

```sh
weka fs replication update <id> [--access-strategy <access-strategy>] [--add-copy-path <path>…] [--apply-strategy <apply-strategy>] [--copy-path <path>…] [--interval <duration>] [--remove-copy-path <path>…] [--snapshots-to-keep <count>]
```

| Parameter                              | Description                                                                                                                                                                                                                                           |
| -------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `id`\*                                 | Replication pair ID.                                                                                                                                                                                                                                  |
| `--access-strategy` \<access-strategy> | When users see the target filesystem: INSTANT\_ACCESS or COPY\_FIRST.                                                                                                                                                                                 |
| `--add-copy-path` \<path>…             | Add a path to a PARTIAL copy set (repeatable). Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                    |
| `--apply-strategy` \<apply-strategy>   | When the snapshot becomes visible on the target. AUTOMATIC is the only value supported in this release.                                                                                                                                               |
| `--copy-path` \<path>…                 | Replace the entire copy set. Keywords: 'full', 'all' or '/' for full copy; 'none' or 'null' to clear. Mutually exclusive with --add-copy-path/--remove-copy-path. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--interval` \<duration>               | Replication interval (e.g. 5m, 1h). Range: 5 minutes to 30 days.                                                                                                                                                                                      |
| `--remove-copy-path` \<path>…          | Remove a path from a PARTIAL copy set (repeatable). Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                               |
| `--snapshots-to-keep` \<count>         | Number of snapshots to retain. Default: 3. Range: 2 to 25.                                                                                                                                                                                            |

## weka fs reserve

Thin provisioning reserve for tenants.

```sh
weka fs reserve
```

### weka fs reserve reset

Reset the thin provisioning SSD reserve for a tenant.

```sh
weka fs reserve reset [--tenant <string>]
```

| Parameter            | Description                                                 |
| -------------------- | ----------------------------------------------------------- |
| `--tenant` \<string> | Tenant name or ID. If not supplied uses callers own tenant. |

### weka fs reserve set

Set a tenant's thin provisioning SSD reserve.

```sh
weka fs reserve set <ssd-capacity> [--tenant <string>]
```

| Parameter            | Description                                                 |
| -------------------- | ----------------------------------------------------------- |
| `ssd-capacity`\*     | SSD capacity to reserve for tenant.                         |
| `--tenant` \<string> | Tenant name or ID. If not supplied uses callers own tenant. |

### weka fs reserve status

Show thin provisioning reserve for tenants.

```sh
weka fs reserve status [--tenant <string>]
```

| Parameter            | Description                                              |
| -------------------- | -------------------------------------------------------- |
| `--tenant` \<string> | Tenant name or ID. If not supplied, include all tenants. |

**Columns:** `id`, `name`, `ssd_reserve`

## weka fs restore

Restore a filesystem from a snapshot.

```sh
weka fs restore <filesystem> <source-name> [--force] [--preserved-overwritten-snapshot-access-point <string>] [--preserved-overwritten-snapshot-name <string>]
```

| Parameter                                                 | Description                                                       |
| --------------------------------------------------------- | ----------------------------------------------------------------- |
| `filesystem`\*                                            | Filesystem to restore.                                            |
| `source-name`\*                                           | Source snapshot name.                                             |
| `-f`, `--force`                                           | Force action. Perform this action without further confirmation.   |
| `--preserved-overwritten-snapshot-access-point` \<string> | Access point of the preserved overwritten snapshot.               |
| `--preserved-overwritten-snapshot-name` \<string>         | Name of a snapshot to create with old content of the destination. |

**Columns:** `id`, `name`, `access`, `writable`, `created`

## weka fs security

Manage filesystem security policies.

```sh
weka fs security
```

### weka fs security policy

Manage security policies attached to filesystems.

```sh
weka fs security policy
```

#### weka fs security policy attach

Attach security policies to a filesystem, appending to the existing list.

```sh
weka fs security policy attach <name> <policies>…
```

| Parameter     | Description                   |
| ------------- | ----------------------------- |
| `name`\*      | Name of the filesystem.       |
| `policies`\*… | Security policy names or IDs. |

#### weka fs security policy detach

Detach security policies from a filesystem.

```sh
weka fs security policy detach <name> <policies>…
```

| Parameter     | Description                   |
| ------------- | ----------------------------- |
| `name`\*      | Name of the filesystem.       |
| `policies`\*… | Security policy names or IDs. |

#### weka fs security policy list

List security policies attached to a filesystem.

```sh
weka fs security policy list <name>
```

| Parameter | Description             |
| --------- | ----------------------- |
| `name`\*  | Name of the filesystem. |

**Columns:** `position`, `uid`, `id`, `name`

#### weka fs security policy reset

Remove all security policies from a filesystem.

```sh
weka fs security policy reset <name>
```

| Parameter | Description             |
| --------- | ----------------------- |
| `name`\*  | Name of the filesystem. |

#### weka fs security policy set

Set security policies for a filesystem, replacing the existing list.

```sh
weka fs security policy set <name> <policies>…
```

| Parameter     | Description                   |
| ------------- | ----------------------------- |
| `name`\*      | Name of the filesystem.       |
| `policies`\*… | Security policy names or IDs. |

## weka fs set-qos

Set quality of service for a filesystem, limiting how it uses I/O resources within the cluster.

This command is deprecated. Use 'wekactl fs update --max-throughput / --max-iops' instead.

```sh
weka fs set-qos <name> [--max-iops <uint>] [--max-throughput <capacity>]
```

| Parameter                      | Description                                                                                              |
| ------------------------------ | -------------------------------------------------------------------------------------------------------- |
| `name`\*                       | Name of filesystem for this operation.                                                                   |
| `--max-iops` \<uint>           | Limit I/O operations per second. This affects how much CPU is used by the filesystem on cluster servers. |
| `--max-throughput` \<capacity> | Limit throughput per second. This affects how much bandwidth is available to the filesystem.             |

## weka fs snapshot

List filesystem snapshots.

```sh
weka fs snapshot [--filesystem <filesystem>] [--name <string>]
```

| Parameter                    | Description                                 |
| ---------------------------- | ------------------------------------------- |
| `--filesystem` \<filesystem> | Filter results to a specific filesystem.    |
| `--name` \<string>           | Filter results to a specific snapshot name. |

**Columns:** `uid`, `id`, `filesystem`, `name`, `access`, `writable`, `created`, `local_upload`, `remote_upload`, `local_object_status`, `local_object_progress`, `local_object_locator`, `remote_object_status`, `remote_object_progress`, `remote_object_locator`, `removing`, `prefetched`, `reclaimable`, `metadata`, `dependents`

### weka fs snapshot access-point-naming-convention

Manage the default convention for filesystem snapshot access point names.

```sh
weka fs snapshot access-point-naming-convention
```

#### weka fs snapshot access-point-naming-convention status

Show the convention used for naming filesystem snapshot access points.

```sh
weka fs snapshot access-point-naming-convention status
```

**Columns:** `convention`

#### weka fs snapshot access-point-naming-convention update

Update the convention used for naming filesystem snapshot access points.

```sh
weka fs snapshot access-point-naming-convention update <access-point-naming-convention>
```

| Parameter                          | Description                                    |
| ---------------------------------- | ---------------------------------------------- |
| `access-point-naming-convention`\* | Access point naming convention (DATE or NAME). |

### weka fs snapshot add

Create a filesystem snapshot.

```sh
weka fs snapshot add <filesystem> <name> [--access-point <string>] [--source-snapshot <string>] [--writable]
```

| Parameter                     | Description                      |
| ----------------------------- | -------------------------------- |
| `filesystem`\*                | Filesystem name.                 |
| `name`\*                      | Target snapshot name.            |
| `--access-point` \<string>    | Snapshot access point name.      |
| `--source-snapshot` \<string> | Use this snapshot as the source. |
| `--writable`                  | Create the snapshot as writable. |

**Columns:** `id`, `name`, `access`, `writable`, `created`

### weka fs snapshot copy

Copy one filesystem snapshot over another.

```sh
weka fs snapshot copy <filesystem> <source-name> <destination-name> [--preserved-overwritten-snapshot-access-point <string>] [--preserved-overwritten-snapshot-name <string>]
```

| Parameter                                                 | Description                                                   |
| --------------------------------------------------------- | ------------------------------------------------------------- |
| `filesystem`\*                                            | Filesystem name.                                              |
| `source-name`\*                                           | Source snapshot name.                                         |
| `destination-name`\*                                      | Destination snapshot name.                                    |
| `--preserved-overwritten-snapshot-access-point` \<string> | Access point of the preserved overwritten snapshot.           |
| `--preserved-overwritten-snapshot-name` \<string>         | Name of a snapshot to create with old content of destination. |

**Columns:** `id`, `name`, `access`, `writable`, `created`

### weka fs snapshot download

Download a snapshot from object store into an existing filesystem.

```sh
weka fs snapshot download <filesystem> <locator> [--access-point <string>] [--allow-divergence] [--allow-non-chronological] [--name <string>]
```

| Parameter                   | Description                                                                                       |
| --------------------------- | ------------------------------------------------------------------------------------------------- |
| `filesystem`\*              | Filesystem name.                                                                                  |
| `locator`\*                 | Object store locator for the snapshot.                                                            |
| `--access-point` \<string>  | Access point. Defaults to the uploaded access point.                                              |
| `--allow-divergence`        | Allow downloading snapshots that are not descendants of the last downloaded snapshot.             |
| `--allow-non-chronological` | Allow downloading snapshots from remote object store in non-chronological order. Not recommended. |
| `--name` \<string>          | Snapshot name. Defaults to the uploaded name.                                                     |

### weka fs snapshot remove

Remove a filesystem snapshot.

```sh
weka fs snapshot remove <filesystem> <name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `filesystem`\*  | Filesystem name.                                                |
| `name`\*        | Snapshot name.                                                  |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka fs snapshot update

Update filesystem snapshot parameters.

```sh
weka fs snapshot update <filesystem> <name> [--access-point <string>] [--new-name <string>]
```

| Parameter                  | Description                        |
| -------------------------- | ---------------------------------- |
| `filesystem`\*             | Filesystem name.                   |
| `name`\*                   | Snapshot name.                     |
| `--access-point` \<string> | New access point for the snapshot. |
| `--new-name` \<string>     | Rename the snapshot.               |

**Columns:** `id`, `name`, `access`, `writable`, `created`

### weka fs snapshot upload

Upload a filesystem snapshot to object store.

```sh
weka fs snapshot upload <filesystem> <name> [--allow-non-chronological] [--site <obs-site>]
```

| Parameter                   | Description                                                                                   |
| --------------------------- | --------------------------------------------------------------------------------------------- |
| `filesystem`\*              | Filesystem name.                                                                              |
| `name`\*                    | Snapshot name.                                                                                |
| `--allow-non-chronological` | Allow uploading snapshots to remote object store in non-chronological order. Not recommended. |
| `--site` \<obs-site>        | Site of the object store to upload to (LOCAL or REMOTE).                                      |

## weka fs tier

Show object store connectivity for each node in the cluster.

This command is deprecated. Use the weka fs tier s3 command instead.

```sh
weka fs tier
```

**Columns:** `name`, `status_upload`, `status_download`, `status_remove`, `down_count`, `last_errors`

### weka fs tier capacity

List capacities for object store buckets attached to filesystems.

```sh
weka fs tier capacity [--filesystem <string>] [--force-fresh]
```

| Parameter                | Description                                  |
| ------------------------ | -------------------------------------------- |
| `--filesystem` \<string> | Show only the named filesystem.              |
| `--force-fresh`          | Refresh capacities to reflect current state. |

**Columns:** `filesystem`, `id`, `fsUid`, `bucketUid`, `bucket`, `totalConsumed`, `used`, `reclaimablePct`, `reclaimableThreshold`, `reclaimableThresholdLow`, `reclaimableThresholdHigh`

### weka fs tier fetch

Fetch object-stored files to SSD storage.

```sh
weka fs tier fetch <path>… [--non-existing <non-existing>]
```

| Parameter                        | Description                       |
| -------------------------------- | --------------------------------- |
| `path`\*…                        | Path(s) to get information about. |
| `--non-existing` \<non-existing> | Behavior of non-existing files.   |

### weka fs tier location

Show data storage location for a given path.

```sh
weka fs tier location <path>…
```

| Parameter | Description                       |
| --------- | --------------------------------- |
| `path`\*… | Path(s) to get information about. |

**Columns:** `path`, `file_type`, `file_size`, `ssd_write_cache_bytes`, `ssd_read_cache_bytes`, `object_storage_bytes`, `remote_storage_bytes`, `remote_cluster_bytes`

### weka fs tier obs

Manage object stores configured in the cluster.

```sh
weka fs tier obs [--name <string>]
```

| Parameter          | Description                                |
| ------------------ | ------------------------------------------ |
| `--name` \<string> | Show only the object store with this name. |

**Columns:** `uid`, `obs_id`, `name`, `obs_site`, `buckets_count`, `upload_buckets_up`, `download_buckets_up`, `remove_buckets_up`, `protocol`, `hostname`, `port`, `auth_method`, `region`, `access_key_id`, `secret_key`, `download_bandwidth`, `upload_bandwidth`, `remove_bandwidth`, `max_concurrent_downloads`, `max_concurrent_uploads`, `max_concurrent_removals`, `max_extents_in_data_blob`, `max_blocks_in_data_blob`, `enable_upload_tags`, `upload_memory_blocks_limit`, `sts_operation_type`, `sts_role_arn`, `sts_role_session_name`, `sts_session_duration_secs`

#### weka fs tier obs update

Edit an existing object store.

```sh
weka fs tier obs update <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--download-bandwidth <uint>] [--enable-upload-tags] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--new-name <string>] [--obs-type <obs-type>] [--port <uint16>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--upload-memory-limit <capacity>]
```

| Parameter                               | Description                                                                                                 |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `name`\*                                | Name of the object store.                                                                                   |
| `--access-key-id` \<string>             | Access key used for AWS Signature authentications.                                                          |
| `--auth-method` \<s3-auth-method>       | Authentication method.                                                                                      |
| `--bandwidth` \<uint>                   | Bandwidth limitation. Value is per core (Mbps).                                                             |
| `--download-bandwidth` \<uint>          | Download bandwidth limitation. Value is per core (Mbps).                                                    |
| `--enable-upload-tags`                  | Enable tagging of uploaded objects.                                                                         |
| `--hostname` \<string>                  | Hostname or IP address of object store.                                                                     |
| `--max-concurrent-downloads` \<uint8>   | Limits how many downloads we concurrently perform on this object store in a single IO node.                 |
| `--max-concurrent-removals` \<uint8>    | Limits the number of removals we concurrently perform on this object store in a single IO node.             |
| `--max-concurrent-uploads` \<uint8>     | Limits the number of uploads we concurrently perform on this object store in a single IO node.              |
| `--max-data-blob-size` \<capacity>      | Maximum size of a data object to upload to an object store data blob.                                       |
| `--max-extents-in-data-blob` \<uint>    | Limits the number of extents to upload to an object store data blob.                                        |
| `--new-name` \<string>                  | New name for the object store.                                                                              |
| `--obs-type` \<obs-type>                | Object store type.                                                                                          |
| `--port` \<uint16>                      | TCP port to use when connecting to object store (single Accessor or Load Balancer).                         |
| `--protocol` \<obs-http-protocol>       | Transport protocol.                                                                                         |
| `--region` \<string>                    | Name of the region we are assigned to work with (usually empty).                                            |
| `--remove-bandwidth` \<uint>            | Removal bandwidth limitation. Value is per core (Mbps).                                                     |
| `--secret-key` \<string>                | Secret key used for AWS Signature authentications.                                                          |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none.                                                                    |
| `--sts-role-arn` \<string>              | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE. |
| `--sts-role-session-name` \<string>     | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.  |
| `--sts-session-duration` \<duration>    | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600.  |
| `--upload-bandwidth` \<uint>            | Upload bandwidth limitation. Value is per core (Mbps).                                                      |
| `--upload-memory-limit` \<capacity>     | Maximum RAM to allocate for concurrent uploads to this object store (per node).                             |

### weka fs tier ops

List all operations currently running on an object store from all hosts in the cluster.

```sh
weka fs tier ops [<name>]
```

| Parameter | Description                      |
| --------- | -------------------------------- |
| `name`    | Name of the object store bucket. |

**Columns:** `process`, `id`, `key`, `type`, `execTime`, `phase`, `lastExecTime`, `startTime`, `size`, `results`, `curlErrors`, `lastHttpError`, `inode`

### weka fs tier release

Release object-stored files from SSD storage.

```sh
weka fs tier release <path>… [--non-existing <non-existing>]
```

| Parameter                        | Description                                                     |
| -------------------------------- | --------------------------------------------------------------- |
| `path`\*…                        | File path(s) to release from SSD storage.                       |
| `--non-existing` \<non-existing> | Behavior for non-existing files. Default is to report an error. |

### weka fs tier s3

Manage S3 object store bucket connections.

```sh
weka fs tier s3 [--name <string>] [--obs-name <string>]
```

| Parameter              | Description                                       |
| ---------------------- | ------------------------------------------------- |
| `--name` \<string>     | Show only the object store bucket with this name. |
| `--obs-name` \<string> | Show only buckets belonging to this object store. |

**Columns:** `uid`, `obs_id`, `obs_name`, `id`, `name`, `obs_site`, `status_upload`, `status_download`, `status_remove`, `nodes_up_for_upload`, `nodes_up_for_download`, `nodes_up_for_remove`, `nodes_down_for_upload`, `nodes_down_for_download`, `nodes_down_for_remove`, `nodes_unknown_for_upload`, `nodes_unknown_for_download`, `nodes_unknown_for_remove`, `last_errors`, `protocol`, `hostname`, `port`, `bucket`, `auth_method`, `region`, `access_key_id`, `secret_key`, `status`, `up_since`, `download_bandwidth`, `upload_bandwidth`, `remove_bandwidth`, `errors_timeout_sec`, `prefetch_size`, `max_concurrent_downloads`, `max_concurrent_uploads`, `max_concurrent_removals`, `max_extents_in_data_blob`, `max_blocks_in_data_blob`, `enable_upload_tags`, `data_storage_class`, `metadata_storage_class`, `sts_operation_type`, `sts_role_arn`, `sts_role_session_name`, `sts_session_duration_secs`

#### weka fs tier s3 add

Create a new S3 object store bucket connection.

```sh
weka fs tier s3 add <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--bucket <string>] [--data-storage-class <string>] [--download-bandwidth <uint>] [--dry-run] [--enable-upload-tags] [--errors-timeout <duration>] [--gcp-auth-token-file <string>] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--metadata-storage-class <string>] [--obs-name <string>] [--obs-type <obs-type>] [--port <uint16>] [--prefetch-mib <uint16>] [--prefetch-size <capacity>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--site <obs-site>] [--skip-verification] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--verbose-errors]
```

| Parameter                               | Description                                                                                                               |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                                | Name of the object store bucket.                                                                                          |
| `--access-key-id` \<string>             | Access key used for AWS Signature authentications.                                                                        |
| `--auth-method` \<s3-auth-method>       | Authentication method.                                                                                                    |
| `--bandwidth` \<uint>                   | Bandwidth limitation. Value is per core (Mbps).                                                                           |
| `--bucket` \<string>                    | Name of the bucket we are assigned to work with.                                                                          |
| `--data-storage-class` \<string>        | AWS storage class or Azure access tier to use for uploaded data blobs.                                                    |
| `--download-bandwidth` \<uint>          | Download bandwidth limitation. Value is per core (Mbps).                                                                  |
| `--dry-run`                             | Only test the command. Does not affect the system.                                                                        |
| `--enable-upload-tags`                  | Enable tagging of uploaded objects.                                                                                       |
| `--errors-timeout` \<duration>          | If the object store bucket link is down for longer than this, all IOs that need data return with an error.                |
| `--gcp-auth-token-file` \<string>       | File containing a GCP authentication token.                                                                               |
| `--hostname` \<string>                  | Hostname or IP address of object store.                                                                                   |
| `--max-concurrent-downloads` \<uint8>   | Limits how many downloads we concurrently perform on this object store in a single IO node.                               |
| `--max-concurrent-removals` \<uint8>    | Limits the number of removals we concurrently perform on this object store in a single IO node.                           |
| `--max-concurrent-uploads` \<uint8>     | Limits the number of uploads we concurrently perform on this object store in a single IO node.                            |
| `--max-data-blob-size` \<capacity>      | Maximum size of a data object to upload to an object store data blob.                                                     |
| `--max-extents-in-data-blob` \<uint>    | Limits the number of extents to upload to an object store data blob.                                                      |
| `--metadata-storage-class` \<string>    | AWS storage class or Azure access tier to use for uploaded metadata blobs.                                                |
| `--obs-name` \<string>                  | Name of the object store to associate this new bucket with.                                                               |
| `--obs-type` \<obs-type>                | Object store type.                                                                                                        |
| `--port` \<uint16>                      | TCP port to use when connecting to object store (single Accessor or Load Balancer).                                       |
| `--prefetch-mib` \<uint16>              | How many MiB of data to prefetch when reading a whole MiB on object store. Default is 128 MiB.                            |
| `--prefetch-size` \<capacity>           | How much data to prefetch when reading a whole MiB on object store, rounded to nearest MiB. (0-600 MiB, default 128 MiB.) |
| `--protocol` \<obs-http-protocol>       | Transport protocol.                                                                                                       |
| `--region` \<string>                    | Name of the region we are assigned to work with (usually empty).                                                          |
| `--remove-bandwidth` \<uint>            | Removal bandwidth limitation. Value is per core (Mbps).                                                                   |
| `--secret-key` \<string>                | Secret key used for AWS Signature authentications.                                                                        |
| `--site` \<obs-site>                    | Site of the object store. Default is local.                                                                               |
| `--skip-verification`                   | Do not verify the connection to the given storage.                                                                        |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none.                                                                                  |
| `--sts-role-arn` \<string>              | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE.               |
| `--sts-role-session-name` \<string>     | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.                |
| `--sts-session-duration` \<duration>    | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600.                |
| `--upload-bandwidth` \<uint>            | Upload bandwidth limitation. Value is per core (Mbps).                                                                    |
| `--verbose-errors`                      | Dump HTTP info on error.                                                                                                  |

#### weka fs tier s3 attach

Attach a filesystem to an existing object store.

```sh
weka fs tier s3 attach <filesystem> <obs-name> [--mode <obs-attach-mode>]
```

| Parameter                   | Description                                 |
| --------------------------- | ------------------------------------------- |
| `filesystem`\*              | Name of the filesystem.                     |
| `obs-name`\*                | Name of the object store bucket to attach.  |
| `--mode` \<obs-attach-mode> | Operation mode for the object store bucket. |

#### weka fs tier s3 detach

Detach a filesystem from an existing object store.

```sh
weka fs tier s3 detach <filesystem> <obs-name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `filesystem`\*  | Name of the filesystem.                                         |
| `obs-name`\*    | Name of the object store bucket to detach.                      |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

#### weka fs tier s3 remove

Remove an existing S3 object store connection.

```sh
weka fs tier s3 remove <name>
```

| Parameter | Description                      |
| --------- | -------------------------------- |
| `name`\*  | Name of the object store bucket. |

#### weka fs tier s3 snapshot

Obtain information about uploaded snapshots.

```sh
weka fs tier s3 snapshot
```

**weka fs tier s3 snapshot list**

List the uploaded snapshots.

```sh
weka fs tier s3 snapshot list <name> --locator <string>
```

| Parameter               | Description                      |
| ----------------------- | -------------------------------- |
| `name`\*                | Name of the object store bucket. |
| `--locator` \<string>\* | Locator for snapshots.           |

**Columns:** `guid`, `fs_id`, `snap_id`, `orig_fs_id`, `fs_name`, `snap_name`, `access_point`, `total_ssd_metadata_size`, `total_size`, `fs_ssd_capacity`, `fs_total_capacity`, `fs_max_files`, `num_unique_guids`, `compatible_version`

#### weka fs tier s3 update

Edit an existing S3 object store bucket connection.

```sh
weka fs tier s3 update <name> [--access-key-id <string>] [--auth-method <s3-auth-method>] [--bandwidth <uint>] [--bucket <string>] [--data-storage-class <string>] [--download-bandwidth <uint>] [--dry-run] [--enable-upload-tags] [--errors-timeout <duration>] [--gcp-auth-token-file <string>] [--hostname <string>] [--max-concurrent-downloads <uint8>] [--max-concurrent-removals <uint8>] [--max-concurrent-uploads <uint8>] [--max-data-blob-size <capacity>] [--max-extents-in-data-blob <uint>] [--metadata-storage-class <string>] [--new-name <string>] [--new-obs-name <string>] [--port <uint16>] [--prefetch-mib <uint16>] [--prefetch-size <capacity>] [--protocol <obs-http-protocol>] [--region <string>] [--remove-bandwidth <uint>] [--secret-key <string>] [--skip-verification] [--sts-operation-type <sts-operation>] [--sts-role-arn <string>] [--sts-role-session-name <string>] [--sts-session-duration <duration>] [--upload-bandwidth <uint>] [--verbose-errors]
```

| Parameter                               | Description                                                                                                               |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                                | Name of the object store bucket.                                                                                          |
| `--access-key-id` \<string>             | Access key used for AWS Signature authentications.                                                                        |
| `--auth-method` \<s3-auth-method>       | Authentication method.                                                                                                    |
| `--bandwidth` \<uint>                   | Bandwidth limitation. Value is per core (Mbps).                                                                           |
| `--bucket` \<string>                    | Name of the bucket we are assigned to work with.                                                                          |
| `--data-storage-class` \<string>        | AWS storage class or Azure access tier to use for uploaded data blobs.                                                    |
| `--download-bandwidth` \<uint>          | Download bandwidth limitation. Value is per core (Mbps).                                                                  |
| `--dry-run`                             | Only test the command. Does not affect the system.                                                                        |
| `--enable-upload-tags`                  | Enable tagging of uploaded objects.                                                                                       |
| `--errors-timeout` \<duration>          | If the object store bucket link is down for longer than this, all IOs that need data return with an error.                |
| `--gcp-auth-token-file` \<string>       | File containing a GCP authentication token.                                                                               |
| `--hostname` \<string>                  | Hostname or IP address of object store.                                                                                   |
| `--max-concurrent-downloads` \<uint8>   | Limits how many downloads we concurrently perform on this object store in a single IO node.                               |
| `--max-concurrent-removals` \<uint8>    | Limits the number of removals we concurrently perform on this object store in a single IO node.                           |
| `--max-concurrent-uploads` \<uint8>     | Limits the number of uploads we concurrently perform on this object store in a single IO node.                            |
| `--max-data-blob-size` \<capacity>      | Maximum size of a data object to upload to an object store data blob.                                                     |
| `--max-extents-in-data-blob` \<uint>    | Limits the number of extents to upload to an object store data blob.                                                      |
| `--metadata-storage-class` \<string>    | AWS storage class or Azure access tier to use for uploaded metadata blobs.                                                |
| `--new-name` \<string>                  | New name for the object store bucket.                                                                                     |
| `--new-obs-name` \<string>              | New object store name.                                                                                                    |
| `--port` \<uint16>                      | TCP port to use when connecting to object store (single Accessor or Load Balancer).                                       |
| `--prefetch-mib` \<uint16>              | How many MiB of data to prefetch when reading a whole MiB on object store. Default is 128 MiB.                            |
| `--prefetch-size` \<capacity>           | How much data to prefetch when reading a whole MiB on object store, rounded to nearest MiB. (0-600 MiB, default 128 MiB.) |
| `--protocol` \<obs-http-protocol>       | Transport protocol.                                                                                                       |
| `--region` \<string>                    | Name of the region we are assigned to work with (usually empty).                                                          |
| `--remove-bandwidth` \<uint>            | Removal bandwidth limitation. Value is per core (Mbps).                                                                   |
| `--secret-key` \<string>                | Secret key used for AWS Signature authentications.                                                                        |
| `--skip-verification`                   | Do not verify the connection to the given storage.                                                                        |
| `--sts-operation-type` \<sts-operation> | AWS STS operation type. Default is none.                                                                                  |
| `--sts-role-arn` \<string>              | The Amazon Resource Name (ARN) of the role to assume. Mandatory when setting sts-operation to ASSUME\_ROLE.               |
| `--sts-role-session-name` \<string>     | An identifier for the assumed role session. Length constraints: Minimum length of 2, maximum length of 64.                |
| `--sts-session-duration` \<duration>    | Duration of the temporary security credentials in seconds. Must be between 900 and 43200; default is 3600.                |
| `--upload-bandwidth` \<uint>            | Upload bandwidth limitation. Value is per core (Mbps).                                                                    |
| `--verbose-errors`                      | Dump HTTP info on error.                                                                                                  |

**Columns:** `uid`, `obs_id`, `obs_name`, `id`, `name`, `obs_site`, `status_upload`, `status_download`, `status_remove`, `nodes_up_for_upload`, `nodes_up_for_download`, `nodes_up_for_remove`, `nodes_down_for_upload`, `nodes_down_for_download`, `nodes_down_for_remove`, `nodes_unknown_for_upload`, `nodes_unknown_for_download`, `nodes_unknown_for_remove`, `last_errors`, `protocol`, `hostname`, `port`, `bucket`, `auth_method`, `region`, `access_key_id`, `secret_key`, `status`, `up_since`, `download_bandwidth`, `upload_bandwidth`, `remove_bandwidth`, `errors_timeout_sec`, `prefetch_size`, `max_concurrent_downloads`, `max_concurrent_uploads`, `max_concurrent_removals`, `max_extents_in_data_blob`, `max_blocks_in_data_blob`, `enable_upload_tags`, `data_storage_class`, `metadata_storage_class`, `sts_operation_type`, `sts_role_arn`, `sts_role_session_name`, `sts_session_duration_secs`

## weka fs update

Update a filesystem's configuration.

```sh
weka fs update <name> [--access <access>] [--audit-enabled] [--auth-required] [--data-reduction] [--event-log-enabled] [--event-log-max-age-seconds <uint>] [--event-log-max-size-bytes-per-fs-shard <uint>] [--force] [--fs-group <filesystem-group>] [--index-enabled] [--kms-key-identifier <string>] [--kms-namespace <string>] [--kms-role-id <string>] [--kms-secret-id <string>] [--max-iops <uint>] [--max-throughput <capacity>] [--new-name <filesystem>] [--remove-fs-group] [--ssd-capacity <capacity>] [--thin-provision-max-ssd <capacity>] [--thin-provision-min-ssd <capacity>] [--total-capacity <capacity>] [--use-cluster-kms-key-identifier]
```

| Parameter                                         | Description                                                                                                                                                                       |
| ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                                          | Name of filesystem for this operation.                                                                                                                                            |
| `--access` \<access>                              | Set the filesystem access mode: ro (read-only) or rw (read-write). A replication target cannot be set to rw while its pair is active; pause the pair on the source cluster first. |
| `--audit-enabled`                                 | Enable filesystem auditing.                                                                                                                                                       |
| `--auth-required`                                 | Require the mounting user to be authenticated. Effective only in the root organization; non-root users must always authenticate.                                                  |
| `--data-reduction`                                | Enable data reduction.                                                                                                                                                            |
| `--event-log-enabled`                             | Enable the reliable event-change log for the filesystem.                                                                                                                          |
| `--event-log-max-age-seconds` \<uint>             | Set the maximum age in seconds before event-log records are trimmed (0 disables age trim).                                                                                        |
| `--event-log-max-size-bytes-per-fs-shard` \<uint> | Set the maximum on-disk event-log size in bytes per filesystem shard (minimum 1 MiB; smaller values, including 0, are rejected).                                                  |
| `-f`, `--force`                                   | Force action. Perform this action without further confirmation.                                                                                                                   |
| `--fs-group` \<filesystem-group>                  | Move the filesystem into the specified filesystem group.                                                                                                                          |
| `--index-enabled`                                 | Enable catalog indexing for the filesystem.                                                                                                                                       |
| `--kms-key-identifier` \<string>                  | Customize KMS key identifier for this filesystem. Currently only for HashiCorp Vault.                                                                                             |
| `--kms-namespace` \<string>                       | Customize KMS namespace for this filesystem. Currently only for HashiCorp Vault.                                                                                                  |
| `--kms-role-id` \<string>                         | Customize KMS role identifier for this filesystem. Currently only for HashiCorp Vault.                                                                                            |
| `--kms-secret-id` \<string>                       | Customize KMS secret identifier for this filesystem. Currently only for HashiCorp Vault.                                                                                          |
| `--max-iops` \<uint>                              | Limit I/O operations per second. This affects how much CPU is used by the filesystem on cluster servers.                                                                          |
| `--max-throughput` \<capacity>                    | Limit throughput per second. This affects how much bandwidth is available to the filesystem.                                                                                      |
| `--new-name` \<filesystem>                        | Rename the filesystem.                                                                                                                                                            |
| `--remove-fs-group`                               | Reset the filesystem to have no group.                                                                                                                                            |
| `--ssd-capacity` \<capacity>                      | New SSD capacity for the filesystem.                                                                                                                                              |
| `--thin-provision-max-ssd` \<capacity>            | Maximum SSD budget for thin provisioning.                                                                                                                                         |
| `--thin-provision-min-ssd` \<capacity>            | Minimum SSD budget for thin provisioning.                                                                                                                                         |
| `--total-capacity` \<capacity>                    | New total capacity for the filesystem.                                                                                                                                            |
| `--use-cluster-kms-key-identifier`                | Use the cluster KMS configuration for this filesystem, removing any custom KMS configuration.                                                                                     |
