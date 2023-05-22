---
description: This page describes how to manage the statistics using the CLI.
---

# Manage statistics using the CLI

Using the CLI, you can:

* [List statistics types](statistics-1.md#list-statistics-types)
* [View statistics in real-time](statistics-1.md#view-statistics-in-real-time)
* [View statistics over time](statistics-1.md#view-statistics-over-time)
* [Set statistics retention](statistics-1.md#set-statistics-retention)

## List statistics types

**Command:** `weka stats list-types`

Use the following command line to obtain statistics definition information:\
`weka stats list-types [<name-or-category>] [--show-internal]`

**Parameters**

| Name               | Value                                | Default |
| ------------------ | ------------------------------------ | ------- |
| `name-or-category` | Valid name or category to filter by. |         |
| `show-internal`    | Also displays internal statistics.   | False   |

## View statistics in real-time

**Command:** `weka stats realtime`

Use the following command line to obtain the current performance-related statistics of the processes in a one-second interval:\
`weka stats realtime [<process-ids>] [--raw-units] [--UTC]`

**Parameters**

| Name          | Value                                                                           | Default                                                |
| ------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `process-ids` | Only show real-time stats of the specified processes in a comma-separated list. |                                                        |
| `raw-units`   | Print values in raw units such as bytes and seconds.                            | <p>Readable format.<br>Examples: 1KiB 234MiB 2GiB.</p> |
| `UTC`         | Print times in UTC.                                                             | Server's local time.                                   |

## **View statistics over time**

**Command:** `weka stats`

The collected statistics can help analyze system performance and determine the source of issues that may occur during WEKA system runs. Statistics are divided according to categories. When selecting a category, a list of the possible statistics is displayed, from which you can select the specific statistics.

{% hint style="info" %}
**Note:** WEKA averages all statistics over one-second intervals. Consequently, the total value or other aggregates relate to a specific minute.
{% endhint %}

Use the following command line to manage filters and read statistics:

`weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval interval] [--resolution-secs resolution-secs] [--category category][--stat stat] [--process-ids process-ids] [--param param] [--accumulated] [--per-process] [--no-zeros] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

| Name              | Value                                                                                                                                                                                                                                                                                                                                                   | Default                                                |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `start-time`      | <p>Start time of the reported period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</p> | -1m                                                    |
| `end-time`        | <p>End time of the reported period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</p>   | Current time                                           |
| `interval`\*      | <p>Period of time to be reported.<br>Valid interval in seconds (positive integer number).</p>                                                                                                                                                                                                                                                           |                                                        |
| `resolution-secs` | <p>Length of each interval in the reported period.<br>Must be multiples of 60 seconds</p>                                                                                                                                                                                                                                                               | 60                                                     |
| `category`        | <p>Specific categories for retrieval of appropriate statistics.<br>Valid existing categories: CPU, Object Store, Operations, Operations (NFS), Operations (Driver), SSD.</p>                                                                                                                                                                            | All                                                    |
| `stat`            | Valid statistics names                                                                                                                                                                                                                                                                                                                                  | All                                                    |
| `process-ids`     | Valid process id                                                                                                                                                                                                                                                                                                                                        | All                                                    |
| `param`           | <p>For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'<br>Format: <code>key:val</code></p>                                                                               |                                                        |
| `accumulated`     | Display accumulated statistics, not rate statistics                                                                                                                                                                                                                                                                                                     | False                                                  |
| `per-process`     | Does not aggregate statistics across processes                                                                                                                                                                                                                                                                                                          | False                                                  |
| `no-zeros`        | Filters results where the value is 0                                                                                                                                                                                                                                                                                                                    | False                                                  |
| `show-internal`   | Also displays internal statistics                                                                                                                                                                                                                                                                                                                       | False                                                  |
| `raw-units`       | Print values in raw units such as bytes and seconds.                                                                                                                                                                                                                                                                                                    | <p>Readable format.<br>Examples: 1KiB 234MiB 2GiB.</p> |
| `UTC`             | Print times in UTC                                                                                                                                                                                                                                                                                                                                      | Server's local time.                                   |

## Set statistics retention

**Command:** `weka stats retention set`

Use the following command line to set the statistics retention period.\
`weka stats retention set <--days days> [--dry-run]`

**Parameters**

| Name      | Value                                                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `days`\*  | <p>Number of days to keep the statistics.<br>Ensure sufficient free disk space per server and the specified number of days.</p> |
| `dry-run` | Only tests the required capacity per the retention period.                                                                      |

Use `weka stats retention status` to view the current retention and `weka stats retention restore-default` to restore the default retention settings.
