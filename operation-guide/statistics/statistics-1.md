---
description: >-
  Read statistics from the command line, look up statistic definitions, and set
  how long the cluster keeps statistics.
---

# Manage statistics using the CLI

## List statistics types

Look up the definition of a statistic before you chart it or query it, to confirm its identifier, unit, and category.

**Command:** `weka stats list-types`

{% code overflow="wrap" %}
```bash
weka stats list-types [<name-or-category>] [--show-internal]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="220.75">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name-or-category</code></td><td>Limit the output to a specific statistic name, category, or category label (in parentheses).</td></tr><tr><td><code>show-internal</code></td><td>Include internal statistics in the output.<br>Default: False</td></tr></tbody></table>

**Output columns**

<table><thead><tr><th width="173.71484375">Column</th><th>Description</th></tr></thead><tbody><tr><td><code>CATEGORY</code></td><td>Category name to pass to <code>weka stats --category</code>, for example <code>api</code>, <code>ops_s3</code>, <code>config</code>.</td></tr><tr><td><code>CATEGORY LABEL</code></td><td>Category name as it appears in the GUI, for example <code>api statistics</code>, <code>Operations (S3)</code>.</td></tr><tr><td><code>IDENTIFIER</code></td><td>Statistic name to pass to <code>weka stats --stat</code>.</td></tr><tr><td><code>DESCRIPTION</code></td><td>What the statistic measures.</td></tr><tr><td><code>LABEL</code></td><td>Chart title in the GUI, including the aggregation in parentheses, for example <code>(total)</code>, <code>(sum)</code>, <code>(per read)</code>.</td></tr><tr><td><code>TYPE</code></td><td>One of <code>Absolute</code>, <code>Accumulated</code>, <code>Rate</code>, <code>Measured</code>, or <code>Histogram</code>.</td></tr><tr><td><code>UNIT</code></td><td>Unit of measurement.</td></tr><tr><td><code>PARAMETERS</code></td><td>For parameterized statistics, the parameter names to filter on with <code>weka stats --param</code>.</td></tr><tr><td><code>CAN ACCUMULATE</code></td><td>Whether <code>weka stats --accumulated</code> applies to the statistic.</td></tr><tr><td><code>HISTOGRAM</code></td><td>Whether the statistic is reported as a histogram.</td></tr><tr><td><code>HISTOGRAM UNIT</code></td><td>Unit of the histogram buckets. Populated only when <code>HISTOGRAM</code> is <code>True</code>.</td></tr></tbody></table>

**Examples**

Filter by category label to list only the statistics in one GUI category. Quote labels that contain spaces.

```bash
$ weka stats list-types "api statistics"
CATEGORY  CATEGORY LABEL  IDENTIFIER    DESCRIPTION         LABEL                       TYPE      UNIT      PARAMETERS  RELATED RATE PARAMETER  PERMISSION  FOR NODE TYPE  CAN ACCUMULATE  HISTOGRAM  HISTOGRAM UNIT
api       api statistics  TOTAL_2xx_RQ  Total 2xx requests  Total 2xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_3xx_RQ  Total 3xx requests  Total 3xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_429_RQ  Total 429 requests  Total 429 requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_4xx_RQ  Total 4xx requests  Total 4xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
api       api statistics  TOTAL_5xx_RQ  Total 5xx requests  Total 5xx requests (total)  Absolute  Requests                                      USER        MANAGEMENT     True            False
```

Filter by name to match across categories. The value is matched as a substring, so `api` returns the `api` category and also the `API_*` statistics in `Operations (S3)`.

```bash
$ weka stats list-types api
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
weka stats list-types config --show-internal
```

## View statistics in real-time

Sample the current performance statistics of the processes at a one-second interval. Real-time statistics are the only statistics that are not averaged over one minute.

**Command:** `weka stats realtime`

{% code overflow="wrap" %}
```bash
weka stats realtime [<process-ids>] [--raw-units] [--UTC]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="159.77734375">Name</th><th width="346.12109375">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>process-ids</code></td><td>Only show real-time stats of the specified processes in a comma-separated list.</td><td>All</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units such as bytes and seconds.</td><td>Readable format.Examples: 1KiB 234MiB 2GiB.</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

## **View statistics over time**

Query the retained statistics for a period, filtered by category, statistic, process, or parameter.

**Command:** `weka stats`

{% code overflow="wrap" %}
```bash
weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval <interval>]
[--resolution-secs <resolution-secs>] [--category <category>] [--stat <stat>]
[--process-ids <process-ids>] [--param <param>] [--accumulated] [--per-process]
[--no-zeros] [--show-internal] [--raw-units] [--UTC]
```
{% endcode %}

**Parameters**

<table><thead><tr><th>Name</th><th width="393.86328125">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>start-time</code></td><td>Start time of the reported period. Format examples: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td><code>-1m</code></td></tr><tr><td><code>end-time</code></td><td>End time of the reported period. Uses the same formats as <code>start-time</code>.</td><td>Current time</td></tr><tr><td><code>interval</code>*</td><td>Period of time to report, in seconds. Must be a positive integer.</td><td></td></tr><tr><td><code>resolution-secs</code></td><td>Length of each interval in the reported period. Must be a multiple of 60 seconds.</td><td>60</td></tr><tr><td><code>category</code></td><td>Retrieve statistics from one category only. Run <code>weka stats list-types</code> to see the available categories.</td><td>All</td></tr><tr><td><code>stat</code></td><td>Statistic names to retrieve, as listed in the <code>IDENTIFIER</code> column of <code>weka stats list-types</code>.</td><td>All</td></tr><tr><td><code>process-ids</code></td><td>Retrieve statistics only for the specified process IDs.</td><td>All</td></tr><tr><td><code>param</code></td><td>For parameterized statistics, retrieve only the instantiations where the parameter has the specified value. Format: <code>key:val</code>. Repeat the parameter for multiple values, for example <code>--param method:putBlocks --param method:initBlock</code>.</td><td></td></tr><tr><td><code>accumulated</code></td><td>Display accumulated statistics instead of rate statistics.</td><td>False</td></tr><tr><td><code>per-process</code></td><td>Do not aggregate statistics across processes.</td><td>False</td></tr><tr><td><code>no-zeros</code></td><td>Filter out results whose value is 0.</td><td>False</td></tr><tr><td><code>show-internal</code></td><td>Display internal statistics.</td><td>False</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units, such as bytes and seconds.</td><td>Readable format.(for example: <code>1KiB</code> <code>234MiB</code> , <code>2GiB</code>)</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

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

Set how many days the cluster keeps statistics. A longer retention period consumes more disk space on every server.

**Command:** `weka stats retention set`

{% code overflow="wrap" %}
```bash
weka stats retention set <--days <days>> [--dry-run]
```
{% endcode %}

**Parameters**

<table><thead><tr><th width="168.06640625">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>days</code>*</td><td>Number of days to keep the statistics.</td></tr><tr><td><code>dry-run</code></td><td>Test the capacity required for the retention period without applying it.</td></tr></tbody></table>

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

**Command:** `weka stats retention status`

```bash
weka stats retention status
```

### Restore the default retention period

**Command:** `weka stats retention restore-default`

```bash
weka stats retention restore-default
```





