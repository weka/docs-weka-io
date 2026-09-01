# weka tenant

List tenants defined in the cluster.

```sh
weka tenant
```

**Columns:** `uid`, `id`, `name`, `allocTotal`, `quotaTotal`, `pctAllocated`, `allocSSD`, `quotaSSD`, `pctAllocatedSSD`, `qos`, `enforceFsAuth`, `enforceNetspace`, `policyNames`, `policyIds`, `maxThroughput`, `maxIops`

## weka tenant add

Create a new tenant in the cluster.

```sh
weka tenant add <name> <username> [<password>] [--enforce-fs-authentication] [--enforce-mount-netspace-access] [--max-iops <uint>] [--max-throughput <capacity>] [--network-spaces <strings>…] [--ssd-quota <capacity>] [--total-quota <capacity>]
```

| Parameter                         | Description                                                                                                                      |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*                          | Name for new tenant.                                                                                                             |
| `username`\*                      | Username of tenant administrator. This user is created with the tenant.                                                          |
| `password`                        | Password of tenant administrator.                                                                                                |
| `--enforce-fs-authentication`     | Require authentication to access every filesystem within this tenant.                                                            |
| `--enforce-mount-netspace-access` | Limit access to every filesystem within this tenant to named network spaces.                                                     |
| `--max-iops` \<uint>              | Limit I/O operations per second across all filesystems in the tenant. Requires cluster-admin role.                               |
| `--max-throughput` \<capacity>    | Limit throughput per second across all filesystems in the tenant. Requires cluster-admin role.                                   |
| `--network-spaces` \<strings>…    | Network space names to assign to the tenant. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--ssd-quota` \<capacity>         | SSD quota to allocate for the tenant.                                                                                            |
| `--total-quota` \<capacity>       | Total quota to allocate for the tenant.                                                                                          |

## weka tenant chown

Manage filesystem ownership and tenancy.

```sh
weka tenant chown
```

### weka tenant chown fs

Move a filesystem from the root tenant to another tenant.

```sh
weka tenant chown fs <filesystem> <target-tenant>
```

| Parameter         | Description                                               |
| ----------------- | --------------------------------------------------------- |
| `filesystem`\*    | Name of the filesystem to move.                           |
| `target-tenant`\* | Name, ID, or UID of the tenant to move the filesystem to. |

## weka tenant network-space

List network spaces assigned to a tenant.

```sh
weka tenant network-space [--tenant <tenant>]
```

| Parameter            | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `--tenant` \<tenant> | Name or ID of tenant. Defaults to the current user's tenant. |

**Columns:** `id`

### weka tenant network-space add

Add network spaces to a tenant.

```sh
weka tenant network-space add <network-spaces>… [--tenant <tenant>]
```

| Parameter            | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `network-spaces`\*…  | Names or IDs of network spaces to add to the tenant.         |
| `--tenant` \<tenant> | Name or ID of tenant. Defaults to the current user's tenant. |

### weka tenant network-space remove

Remove network spaces from a tenant.

```sh
weka tenant network-space remove <network-spaces>… [--tenant <tenant>]
```

| Parameter            | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `network-spaces`\*…  | Names or IDs of network spaces to remove from the tenant.    |
| `--tenant` \<tenant> | Name or ID of tenant. Defaults to the current user's tenant. |

## weka tenant remove

Remove a tenant.

```sh
weka tenant remove <tenant> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `tenant`\*      | Tenant name or ID to remove.                                    |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka tenant rename

Change a tenant name.

```sh
weka tenant rename <tenant> <new-name>
```

| Parameter    | Description                |
| ------------ | -------------------------- |
| `tenant`\*   | Current tenant name or ID. |
| `new-name`\* | New name for the tenant.   |

## weka tenant security

Manage security settings for tenant.

```sh
weka tenant security
```

### weka tenant security policy

Manage tenant security policies.

```sh
weka tenant security policy
```

#### weka tenant security policy attach

Attach security policies to a tenant, appending to the existing list of policies.

```sh
weka tenant security policy attach <tenant> <policies>…
```

| Parameter     | Description                                |
| ------------- | ------------------------------------------ |
| `tenant`\*    | Name or ID of tenant to update.            |
| `policies`\*… | Security policies to attach to the tenant. |

#### weka tenant security policy detach

Detach security policies from a tenant.

```sh
weka tenant security policy detach <tenant> <policies>…
```

| Parameter     | Description                                  |
| ------------- | -------------------------------------------- |
| `tenant`\*    | Name or ID of tenant to update.              |
| `policies`\*… | Security policies to detach from the tenant. |

#### weka tenant security policy list

List tenant security policies.

```sh
weka tenant security policy list <tenant>
```

| Parameter  | Description                      |
| ---------- | -------------------------------- |
| `tenant`\* | Name or ID of tenant to display. |

**Columns:** `position`, `uid`, `id`, `name`

#### weka tenant security policy reset

Reset security policies for a tenant, removing any that exist.

```sh
weka tenant security policy reset <tenant>
```

| Parameter  | Description                     |
| ---------- | ------------------------------- |
| `tenant`\* | Name or ID of tenant to update. |

#### weka tenant security policy set

Set security policies for a tenant, replacing the existing list of policies.

```sh
weka tenant security policy set <tenant> <policies>…
```

| Parameter     | Description                          |
| ------------- | ------------------------------------ |
| `tenant`\*    | Name or ID of tenant to update.      |
| `policies`\*… | Security policies to set for tenant. |

### weka tenant security revoke-tokens

Revoke all API tokens issued for this tenant, forcing users to reauthenticate.

```sh
weka tenant security revoke-tokens [<tenant>] [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `tenant`        | Tenant name or ID to revoke tokens for.                         |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

## weka tenant set-qos

Set quality of service for the tenant, limiting how it uses I/O resources within the cluster.

This command is deprecated. Use 'weka tenant update --max-throughput / --max-iops' instead.

```sh
weka tenant set-qos <tenant> [--max-iops <uint>] [--max-throughput <capacity>]
```

| Parameter                      | Description                                                                                          |
| ------------------------------ | ---------------------------------------------------------------------------------------------------- |
| `tenant`\*                     | Name or ID of tenant to update.                                                                      |
| `--max-iops` \<uint>           | Limit I/O operations per second. This affects how much CPU is used by the tenant on cluster servers. |
| `--max-throughput` \<capacity> | Limit throughput per second. This affects how much bandwidth is available to the tenant.             |

## weka tenant set-quota

Set a tenant's storage capacity quotas. This limits how much capacity a tenant can utilize.

This command is deprecated. Use 'weka tenant update --ssd-quota / --total-quota' instead.

```sh
weka tenant set-quota <tenant> [--ssd-quota <capacity>] [--total-quota <capacity>]
```

| Parameter                   | Description                                               |
| --------------------------- | --------------------------------------------------------- |
| `tenant`\*                  | Name or ID of tenant to update.                           |
| `--ssd-quota` \<capacity>   | Limit the SSD capacity that is available to the tenant.   |
| `--total-quota` \<capacity> | Limit the total capacity that is available to the tenant. |

## weka tenant stats

Show I/O statistics per tenant (equivalent to 'weka stats' --category=tenant_stats --param tenant:*). Use --tenant to filter to a specific tenant.

```sh
weka tenant stats [--accumulated] [--aggregate-by <grouping>] [--end-time <time>] [--interval <duration>] [--no-zeros] [--param <strings>…] [--per-process] [--per-role] [--process-ids <process-ids>…] [--query-timeout <duration>] [--resolution-secs <duration>] [--show-internal] [--start-time <time>] [--stat <statistic-names>…] [--tenant <tenant>]
```

| Parameter                       | Description                                                                                                                                                                                               |
| ------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--accumulated`                 | Show accumulated statistics. If not set, show rate statistics.                                                                                                                                            |
| `--aggregate-by` \<grouping>    | Aggregate statistics by the specified criteria. Valid values: process, role, container, server.                                                                                                           |
| `--end-time` \<time>            | Query for statistics up to this time point.                                                                                                                                                               |
| `--interval` \<duration>        | Duration (in seconds) of the time report.                                                                                                                                                                 |
| `-Z`, `--no-zeros`              | Do not retrieve statistics with zero values.                                                                                                                                                              |
| `--param` \<strings>…           | For parameterized statistics, filter by additional key:value pairs. --tenant is shorthand for --param tenant:\<name>. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--per-process`                 | Do not aggregate statistics across processes.                                                                                                                                                             |
| `--per-role`                    | Aggregate statistics by role.                                                                                                                                                                             |
| `--process-ids` \<process-ids>… | Limit the report to the specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                          |
| `--query-timeout` \<duration>   | Per-container timeout (default 5 seconds).                                                                                                                                                                |
| `--resolution-secs` \<duration> | Length of each interval in the report period.                                                                                                                                                             |
| `--show-internal`               | Show internal statistics.                                                                                                                                                                                 |
| `--start-time` \<time>          | Query for statistics starting at this time.                                                                                                                                                               |
| `--stat` \<statistic-names>…    | Retrieve only the specified statistics. Glob patterns (\*, ?, []) are supported. Multiple values may be supplied separated by commas, or the option may be repeated.                                      |
| `--tenant` \<tenant>            | Filter by tenant name or ID.                                                                                                                                                                              |

**Columns:** `timestamp`, `stat`, `value`

## weka tenant update

Update options for a tenant: authentication enforcement, QoS limits, quota, and name.

```sh
weka tenant update <tenant> [--enforce-fs-authentication] [--enforce-mount-netspace-access] [--max-iops <uint>] [--max-throughput <capacity>] [--new-name <string>] [--ssd-quota <capacity>] [--total-quota <capacity>]
```

| Parameter                         | Description                                                                                        |
| --------------------------------- | -------------------------------------------------------------------------------------------------- |
| `tenant`\*                        | Name or ID of tenant to update.                                                                    |
| `--enforce-fs-authentication`     | Require authentication to access every filesystem within this tenant.                              |
| `--enforce-mount-netspace-access` | Limit access to every filesystem within this tenant to named network spaces.                       |
| `--max-iops` \<uint>              | Limit I/O operations per second across all filesystems in the tenant. Requires cluster-admin role. |
| `--max-throughput` \<capacity>    | Limit throughput per second across all filesystems in the tenant. Requires cluster-admin role.     |
| `--new-name` \<string>            | Rename the tenant. Requires cluster-admin role.                                                    |
| `--ssd-quota` \<capacity>         | Set the SSD capacity quota for the tenant.                                                         |
| `--total-quota` \<capacity>       | Set the total capacity quota for the tenant.                                                       |
