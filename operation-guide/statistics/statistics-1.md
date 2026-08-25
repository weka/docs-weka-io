---
description: >-
  Read statistics from the command line, look up statistic definitions, and set
  how long the cluster keeps statistics.
---

# Manage statistics using the CLI

## List statistics types

Looks up the definition of a statistic to confirm its identifier, unit, and category.

**Command:** `weka stats types`

```sh
weka stats types [<category_or_name>…] [--show-internal]
```

**Parameters**

| Parameter           | Description                                                        |
| --- | --- |
| `category_or_name`… | Statistic category or name; only show stats matching one of these. |
| `--show-internal` | Show internal statistics. Default: False |

**Output columns**

<table><thead><tr><th width="173.71484375">Column</th><th>Description</th></tr></thead><tbody><tr><td><code>CATEGORY</code></td><td>Category name to pass to <code>weka stats --category</code>, for example <code>api</code>, <code>ops_s3</code>, <code>config</code>.</td></tr><tr><td><code>CATEGORY LABEL</code></td><td>Category name as it appears in the GUI, for example <code>api statistics</code>, <code>Operations (S3)</code>.</td></tr><tr><td><code>IDENTIFIER</code></td><td>Statistic name to pass to <code>weka stats --stat</code>.</td></tr><tr><td><code>DESCRIPTION</code></td><td>What the statistic measures.</td></tr><tr><td><code>LABEL</code></td><td>Chart title in the GUI, including the aggregation in parentheses, for example <code>(total)</code>, <code>(sum)</code>, <code>(per read)</code>.</td></tr><tr><td><code>TYPE</code></td><td>One of <code>Absolute</code>, <code>Accumulated</code>, <code>Rate</code>, <code>Measured</code>, or <code>Histogram</code>.</td></tr><tr><td><code>UNIT</code></td><td>Unit of measurement.</td></tr><tr><td><code>PARAMETERS</code></td><td>For parameterized statistics, the parameter names to filter on with <code>weka stats --param</code>.</td></tr><tr><td><code>CAN ACCUMULATE</code></td><td>Whether <code>weka stats --accumulated</code> applies to the statistic.</td></tr><tr><td><code>HISTOGRAM</code></td><td>Whether the statistic is reported as a histogram.</td></tr><tr><td><code>HISTOGRAM UNIT</code></td><td>Unit of the histogram buckets. Populated only when <code>HISTOGRAM</code> is <code>True</code>.</td></tr></tbody></table>

**Examples**

Filter by category label to list only the statistics in one GUI category. Quote labels that contain spaces.

```bash
$ weka stats types "api statistics"
CATEGORY  CATEGORY LABEL  IDENTIFIER    DESCRIPTION         LABEL                       TYPE      UNIT      PARAMETERS  RELATED RATE PARAMETER  PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM  HISTOGRAM UNIT
api       api statistics  TOTAL_2xx_RQ  Total 2xx requests  Total 2xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_3xx_RQ  Total 3xx requests  Total 3xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_429_RQ  Total 429 requests  Total 429 requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_4xx_RQ  Total 4xx requests  Total 4xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_5xx_RQ  Total 5xx requests  Total 5xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
```

Filter by name to match across categories. The value is matched as a substring, so `api` returns the `api` category and also the `API_*` statistics in `Operations (S3)`.

```bash
$ weka stats types api
CATEGORY  CATEGORY LABEL   IDENTIFIER    DESCRIPTION                 LABEL                     TYPE         UNIT          PARAMETERS  PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM
api       api statistics   TOTAL_2xx_RQ  Total 2xx requests          Total 2xx requests (total) Absolute     Requests                  USER        MANAGEMENT     True            False
...
ops_s3    Operations (S3)  API_FAILURES  Total of failures per API   Failures per API (total)   Accumulated  Ops           api         USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_OPS       Total of Ops per API        Ops per API (total)        Accumulated  Ops           api         USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_TTFB      Time To First Byte per API  TTFB per API (sum)         Accumulated  Milliseconds  api         USER        MANAGEMENT     False           False
ops_s3    Operations (S3)  API_TTLB      Time To Last Byte per API   TTLB per API (sum)         Accumulated  Milliseconds  api         USER        MANAGEMENT     False           False
```

Add `--show-internal` to include the internal statistics of a category. These statistics are intended for the Customer Success team and are not part of the published statistics list.

```bash
weka stats types config --show-internal
```

## View statistics in real-time

Shows a live, continuously updating view of statistics for the selected processes.

**Command:** `weka stats realtime`

```sh
weka stats realtime [<process>…] [--footer] [--hostnames <strings>…] [--role <process-roles>…]
```

**Parameters**

| Parameter                  | Description                                                                                                                         |
| --- | --- |
| `process`… | Only include the specified processes. |
| `--footer` | Display a summary at the end of the report showing the totals for the statistics. |
| `--hostnames` \<strings>… | Only include processes on these hostnames. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--role` \<process-roles>… | Only include processes with the specified role. Multiple values may be supplied separated by commas, or the option may be repeated. |

## View statistics over time

Reports statistics for a past time range, aggregated by the interval you choose.

**Command:** `weka stats`

```sh
weka stats [--accumulated] [--aggregate-by <grouping>] [--category <statistic-categories>…] [--end-time <time>] [--exclude-process-ids <process-ids>…] [--histogram] [--interval <duration>] [--no-units] [--no-zeros] [--param <strings>…] [--per-process] [--per-role] [--process-ids <process-ids>…] [--query-timeout <duration>] [--resolution-secs <duration>] [--role <process-role>] [--show-internal] [--skip-validations] [--start-time <time>] [--stat <statistic-names>…]
```

**Parameters**

| Parameter                               | Description                                                                                                                                                                                                                                                                                                                                |
| --- | --- |
| `--accumulated` | Show accumulated statistics. If not set, show rate statistics. |
| `--aggregate-by` \<grouping> | Aggregate statistics by the specified criteria. |
| `--category` \<statistic-categories>… | Retrieve only statistics of the specified categories. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--end-time` \<time> | Query for statstics up to this time point. |
| `--exclude-process-ids` \<process-ids>… | Do not include statistics from specified processes. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--histogram` | Render histograms visually. |
| `--interval` \<duration> | Duration (in seconds) of the time report. |
| `--no-units` | Suppress units from table output. |
| `-Z`, `--no-zeros` | Do not retrieve statistics with zero values. |
| `--param` \<strings>… | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--per-process` | Aggregate statistics by process. |
| `--per-role` | Aggregate stats per process role. |
| `--process-ids` \<process-ids>… | Only include the specified processes. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--query-timeout` \<duration> | Per-container timeout (default 5 seconds). |
| `--resolution-secs` \<duration> | Length of each interval in the report period. |
| `--role` \<process-role> | Only include processes with the specified role. |
| `--show-internal` | Show internal statistics. |
| `--skip-validations` | Do not validate statistic or category names. |
| `--start-time` \<time> | Query for statistics starting at this time. |
| `--stat` \<statistic-names>… | Retrieve only these specific statistics. Glob patterns (_, ?, \[]) are supported. For a parameterized statistic, append the parameter value as a suffix, e.g. 'CLIENT\_RPC\_CALLS.writeWithChecksums' for one value or 'CLIENT\_RPC\_CALLS._' for all. Multiple values may be supplied separated by commas, or the option may be repeated. |

Statistics are averaged over one-minute intervals, so a total or any other aggregate relates to a specific minute. Raising `resolution-secs` widens each interval and reduces the number of rows returned.

**Examples**

Report one category over the last hour at five-minute resolution, omitting statistics that stayed at zero:

```bash
weka stats --category api --start-time -1h --resolution-secs 300 --no-zeros
```

Report one statistic per process over the last day:

```bash
weka stats --stat TOTAL_4xx_RQ --start-time -1d --per-process
```

## Set statistics retention

Sets how long the cluster keeps collected statistics before discarding them.

**Command:** `weka stats retention set`

```sh
weka stats retention set --days <uint> [--dry-run]
```

**Parameters**

| Parameter          | Description                                                                                                                  |
| --- | --- |
| `--days` \<uint>\* | Number of days to keep the statistics (1-30). |
| `--dry-run` | Only test the command. Does not affect the system. This is primarily useful to verify sufficient space exists for retention. |

**Example**

Test the capacity required for a 30-day retention period, and then apply it:

bash

```bash
weka stats retention set --days 30 --dry-run
weka stats retention set --days 30
```

{% hint style="warning" %}
Shortening the retention period deletes statistics older than the new period. The deleted statistics cannot be recovered.
{% endhint %}

### View the current retention period

Shows the configured statistics retention period.

**Command:** `weka stats retention status`

```sh
weka stats retention status
```

### Restore the default retention period

Returns the statistics retention period to its default.

**Command:** `weka stats retention reset`

```sh
weka stats retention reset [--dry-run]
```

**Parameters**

| Parameter   | Description                                        |
| --- | --- |
| `--dry-run` | Only test the command. Does not affect the system. |
