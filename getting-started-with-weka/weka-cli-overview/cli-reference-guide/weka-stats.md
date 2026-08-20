# weka stats

Show statistics that conform to the filter criteria. Each statistic and sample is presented in its own row, possibly aggregated.

```sh
weka stats [--accumulated] [--aggregate-by <grouping>] [--category <statistic-categories>…] [--end-time <time>] [--exclude-process-ids <process-ids>…] [--histogram] [--interval <duration>] [--no-units] [--no-zeros] [--param <strings>…] [--per-process] [--per-role] [--process-ids <process-ids>…] [--query-timeout <duration>] [--resolution-secs <duration>] [--role <process-role>] [--show-internal] [--skip-validations] [--start-time <time>] [--stat <statistic-names>…]
```

| Parameter                               | Description                                                                                                                                                                                                                                                                                                                                |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--accumulated`                         | Show accumulated statistics. If not set, show rate statistics.                                                                                                                                                                                                                                                                             |
| `--aggregate-by` \<grouping>            | Aggregate statistics by the specified criteria.                                                                                                                                                                                                                                                                                            |
| `--category` \<statistic-categories>…   | Retrieve only statistics of the specified categories. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                  |
| `--end-time` \<time>                    | Query for statstics up to this time point.                                                                                                                                                                                                                                                                                                 |
| `--exclude-process-ids` \<process-ids>… | Do not include statistics from specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                    |
| `--histogram`                           | Render histograms visually.                                                                                                                                                                                                                                                                                                                |
| `--interval` \<duration>                | Duration (in seconds) of the time report.                                                                                                                                                                                                                                                                                                  |
| `--no-units`                            | Suppress units from table output.                                                                                                                                                                                                                                                                                                          |
| `-Z`, `--no-zeros`                      | Do not retrieve statistics with zero values.                                                                                                                                                                                                                                                                                               |
| `--param` \<strings>…                   | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--per-process`                         | Aggregate statistics by process.                                                                                                                                                                                                                                                                                                           |
| `--per-role`                            | Aggregate stats per process role.                                                                                                                                                                                                                                                                                                          |
| `--process-ids` \<process-ids>…         | Only include the specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                  |
| `--query-timeout` \<duration>           | Per-container timeout (default 5 seconds).                                                                                                                                                                                                                                                                                                 |
| `--resolution-secs` \<duration>         | Length of each interval in the report period.                                                                                                                                                                                                                                                                                              |
| `--role` \<process-role>                | Only include processes with the specified role.                                                                                                                                                                                                                                                                                            |
| `--show-internal`                       | Show internal statistics.                                                                                                                                                                                                                                                                                                                  |
| `--skip-validations`                    | Do not validate statistic or category names.                                                                                                                                                                                                                                                                                               |
| `--start-time` \<time>                  | Query for statistics starting at this time.                                                                                                                                                                                                                                                                                                |
| `--stat` \<statistic-names>…            | Retrieve only these specific statistics. Glob patterns (_, ?, \[]) are supported. For a parameterized statistic, append the parameter value as a suffix, e.g. 'CLIENT\_RPC\_CALLS.writeWithChecksums' for one value or 'CLIENT\_RPC\_CALLS._' for all. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `grouping`, `timestamp`, `category`, `stat`, `unit`, `value`, `containerId`, `containerName`, `hostname`, `roles`, `histogram`

## weka stats categories

Show the statistic categories.

```sh
weka stats categories [--show-internal]
```

| Parameter         | Description               |
| ----------------- | ------------------------- |
| `--show-internal` | Show internal statistics. |

**Columns:** `category`, `clabel`

## weka stats realtime

Get performance related stats which are updated in a one-second interval.

```sh
weka stats realtime [<process>…] [--footer] [--hostnames <strings>…] [--role <process-roles>…]
```

| Parameter                  | Description                                                                                                                         |
| -------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `process`…                 | Only include the specified processes.                                                                                               |
| `--footer`                 | Display a summary at the end of the report showing the totals for the statistics.                                                   |
| `--hostnames` \<strings>…  | Only include processes on these hostnames. Multiple values may be supplied separated by commas, or the option may be repeated.      |
| `--role` \<process-roles>… | Only include processes with the specified role. Multiple values may be supplied separated by commas, or the option may be repeated. |

**Columns:** `process`, `hostname`, `roles`, `mode`, `writeps`, `writebps`, `wlatency`, `readps`, `readbps`, `rlatency`, `ops`, `cpu`, `l6recv`, `l6send`, `upload`, `download`, `rdmarecv`, `rdmasend`

## weka stats retention

Configure retention for statistics. Longer retention periods consume more storage.

```sh
weka stats retention
```

### weka stats retention reset

Reset statistics retention to the default.

```sh
weka stats retention reset [--dry-run]
```

| Parameter   | Description                                        |
| ----------- | -------------------------------------------------- |
| `--dry-run` | Only test the command. Does not affect the system. |

### weka stats retention set

Choose for how long to keep statistics. Longer retention periods consume more storage.

```sh
weka stats retention set --days <uint> [--dry-run]
```

| Parameter          | Description                                                                                                                  |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| `--days` \<uint>\* | Number of days to keep the statistics (1-30).                                                                                |
| `--dry-run`        | Only test the command. Does not affect the system. This is primarily useful to verify sufficient space exists for retention. |

### weka stats retention status

Show configured statistics retention, including estimated storage requirements.

```sh
weka stats retention status
```

## weka stats show

This is an alias for weka stats table.

This command is deprecated. Use weka stats table instead.

```sh
weka stats show [--accumulated] [--aggregate-by <grouping>] [--category <statistic-categories>…] [--end-time <time>] [--exclude-process-ids <process-ids>…] [--histogram] [--interval <duration>] [--no-units] [--no-zeros] [--param <strings>…] [--per-process] [--process-ids <process-ids>…] [--query-timeout <duration>] [--resolution-secs <duration>] [--role <process-role>] [--show-internal] [--skip-validations] [--start-time <time>] [--stat <statistic-names>…]
```

| Parameter                               | Description                                                                                                                                                                                                                                                                                                                                |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--accumulated`                         | Show accumulated statistics. If not set, show rate statistics.                                                                                                                                                                                                                                                                             |
| `--aggregate-by` \<grouping>            | Aggregate statistics by the specified criteria.                                                                                                                                                                                                                                                                                            |
| `--category` \<statistic-categories>…   | Retrieve only statistics of the specified categories. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                  |
| `--end-time` \<time>                    | Query for statstics up to this time point.                                                                                                                                                                                                                                                                                                 |
| `--exclude-process-ids` \<process-ids>… | Do not include statistics from specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                    |
| `--histogram`                           | Render histograms visually.                                                                                                                                                                                                                                                                                                                |
| `--interval` \<duration>                | Duration (in seconds) of the time report.                                                                                                                                                                                                                                                                                                  |
| `--no-units`                            | Suppress units from table output.                                                                                                                                                                                                                                                                                                          |
| `-Z`, `--no-zeros`                      | Do not retrieve statistics with zero values.                                                                                                                                                                                                                                                                                               |
| `--param` \<strings>…                   | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--per-process`                         | Aggregate statistics by process.                                                                                                                                                                                                                                                                                                           |
| `--process-ids` \<process-ids>…         | Only include the specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                  |
| `--query-timeout` \<duration>           | Per-container timeout (default 5 seconds).                                                                                                                                                                                                                                                                                                 |
| `--resolution-secs` \<duration>         | Length of each interval in the report period.                                                                                                                                                                                                                                                                                              |
| `--role` \<process-role>                | Only include processes with the specified role.                                                                                                                                                                                                                                                                                            |
| `--show-internal`                       | Show internal statistics.                                                                                                                                                                                                                                                                                                                  |
| `--skip-validations`                    | Do not validate statistic or category names.                                                                                                                                                                                                                                                                                               |
| `--start-time` \<time>                  | Query for statistics starting at this time.                                                                                                                                                                                                                                                                                                |
| `--stat` \<statistic-names>…            | Retrieve only these specific statistics. Glob patterns (_, ?, \[]) are supported. For a parameterized statistic, append the parameter value as a suffix, e.g. 'CLIENT\_RPC\_CALLS.writeWithChecksums' for one value or 'CLIENT\_RPC\_CALLS._' for all. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka stats table

List statistics that conform to the filter criteria. Each sample period is a row, with different statistics each in their own column. This may facilitate analysis involving multiple statistics at the same time.

```sh
weka stats table [--accumulated] [--aggregate-by <grouping>] [--category <statistic-categories>…] [--end-time <time>] [--exclude-process-ids <process-ids>…] [--histogram] [--interval <duration>] [--no-units] [--no-zeros] [--param <strings>…] [--per-process] [--process-ids <process-ids>…] [--query-timeout <duration>] [--resolution-secs <duration>] [--role <process-role>] [--show-internal] [--skip-validations] [--start-time <time>] [--stat <statistic-names>…]
```

| Parameter                               | Description                                                                                                                                                                                                                                                                                                                                |
| --------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `--accumulated`                         | Show accumulated statistics. If not set, show rate statistics.                                                                                                                                                                                                                                                                             |
| `--aggregate-by` \<grouping>            | Aggregate statistics by the specified criteria.                                                                                                                                                                                                                                                                                            |
| `--category` \<statistic-categories>…   | Retrieve only statistics of the specified categories. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                  |
| `--end-time` \<time>                    | Query for statstics up to this time point.                                                                                                                                                                                                                                                                                                 |
| `--exclude-process-ids` \<process-ids>… | Do not include statistics from specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                    |
| `--histogram`                           | Render histograms visually.                                                                                                                                                                                                                                                                                                                |
| `--interval` \<duration>                | Duration (in seconds) of the time report.                                                                                                                                                                                                                                                                                                  |
| `--no-units`                            | Suppress units from table output.                                                                                                                                                                                                                                                                                                          |
| `-Z`, `--no-zeros`                      | Do not retrieve statistics with zero values.                                                                                                                                                                                                                                                                                               |
| `--param` \<strings>…                   | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'. Multiple values may be supplied separated by commas, or the option may be repeated.                    |
| `--per-process`                         | Aggregate statistics by process.                                                                                                                                                                                                                                                                                                           |
| `--process-ids` \<process-ids>…         | Only include the specified processes. Multiple values may be supplied separated by commas, or the option may be repeated.                                                                                                                                                                                                                  |
| `--query-timeout` \<duration>           | Per-container timeout (default 5 seconds).                                                                                                                                                                                                                                                                                                 |
| `--resolution-secs` \<duration>         | Length of each interval in the report period.                                                                                                                                                                                                                                                                                              |
| `--role` \<process-role>                | Only include processes with the specified role.                                                                                                                                                                                                                                                                                            |
| `--show-internal`                       | Show internal statistics.                                                                                                                                                                                                                                                                                                                  |
| `--skip-validations`                    | Do not validate statistic or category names.                                                                                                                                                                                                                                                                                               |
| `--start-time` \<time>                  | Query for statistics starting at this time.                                                                                                                                                                                                                                                                                                |
| `--stat` \<statistic-names>…            | Retrieve only these specific statistics. Glob patterns (_, ?, \[]) are supported. For a parameterized statistic, append the parameter value as a suffix, e.g. 'CLIENT\_RPC\_CALLS.writeWithChecksums' for one value or 'CLIENT\_RPC\_CALLS._' for all. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka stats types

List statistics types that conform to the filter criteria.

```sh
weka stats types [<category_or_name>…] [--show-internal]
```

| Parameter           | Description                                                        |
| ------------------- | ------------------------------------------------------------------ |
| `category_or_name`… | Statistic category or name; only show stats matching one of these. |
| `--show-internal`   | Show internal statistics.                                          |

**Columns:** `category`, `clabel`, `identifier`, `description`, `label`, `type`, `unit`, `params`, `related`, `permission`, `ptype`, `accumulate`, `histogram`, `histogramUnit`
