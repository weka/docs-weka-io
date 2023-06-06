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

<table><thead><tr><th width="222">Name</th><th width="314">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name-or-category</code></td><td>Valid name or category to filter by.</td><td></td></tr><tr><td><code>show-internal</code></td><td>Also displays internal statistics.</td><td>False</td></tr></tbody></table>

## View statistics in real-time

**Command:** `weka stats realtime`

Use the following command line to obtain the current performance-related statistics of the processes in a one-second interval:\
`weka stats realtime [<process-ids>] [--raw-units] [--UTC]`

**Parameters**

<table><thead><tr><th width="217">Name</th><th width="325">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>process-ids</code></td><td>Only show real-time stats of the specified processes in a comma-separated list.</td><td></td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units such as bytes and seconds.</td><td>Readable format.<br>Examples: 1KiB 234MiB 2GiB.</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC.</td><td>Server's local time.</td></tr></tbody></table>

## **View statistics over time**

**Command:** `weka stats`

The collected statistics can help analyze system performance and determine the source of issues that may occur during WEKA system runs. Statistics are divided according to categories. When selecting a category, a list of the possible statistics is displayed, from which you can select the specific statistics.

{% hint style="info" %}
WEKA averages all statistics over one-second intervals. Consequently, the total value or other aggregates relate to a specific minute.
{% endhint %}

Use the following command line to manage filters and read statistics:

`weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval interval] [--resolution-secs resolution-secs] [--category category][--stat stat] [--process-ids process-ids] [--param param] [--accumulated] [--per-process] [--no-zeros] [--show-internal] [--raw-units] [--UTC]`

**Parameters**

<table><thead><tr><th width="202">Name</th><th width="369">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>start-time</code></td><td>Start time of the reported period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>-1m</td></tr><tr><td><code>end-time</code></td><td>End time of the reported period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>9:15Z</code>, <code>10:00+2:00</code>.</td><td>Current time</td></tr><tr><td><code>interval</code>*</td><td>Period of time to be reported.<br>Valid interval in seconds (positive integer number).</td><td></td></tr><tr><td><code>resolution-secs</code></td><td>Length of each interval in the reported period.<br>Must be multiples of 60 seconds</td><td>60</td></tr><tr><td><code>category</code></td><td>Specific categories for retrieval of appropriate statistics.<br>Valid existing categories: CPU, Object Store, Operations, Operations (NFS), Operations (Driver), SSD.</td><td>All</td></tr><tr><td><code>stat</code></td><td>Valid statistics names</td><td>All</td></tr><tr><td><code>process-ids</code></td><td>Valid process id</td><td>All</td></tr><tr><td><code>param</code></td><td>For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock'<br>Format: <code>key:val</code></td><td></td></tr><tr><td><code>accumulated</code></td><td>Display accumulated statistics, not rate statistics</td><td>False</td></tr><tr><td><code>per-process</code></td><td>Does not aggregate statistics across processes</td><td>False</td></tr><tr><td><code>no-zeros</code></td><td>Filters results where the value is 0</td><td>False</td></tr><tr><td><code>show-internal</code></td><td>Also displays internal statistics</td><td>False</td></tr><tr><td><code>raw-units</code></td><td>Print values in raw units such as bytes and seconds.</td><td>Readable format.<br>Examples: 1KiB 234MiB 2GiB.</td></tr><tr><td><code>UTC</code></td><td>Print times in UTC</td><td>Server's local time.</td></tr></tbody></table>

## Set statistics retention

**Command:** `weka stats retention set`

Use the following command line to set the statistics retention period.\
`weka stats retention set <--days days> [--dry-run]`

**Parameters**

<table><thead><tr><th width="207">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>days</code>*</td><td>Number of days to keep the statistics.<br>Ensure sufficient free disk space per server and the specified number of days.</td></tr><tr><td><code>dry-run</code></td><td>Only tests the required capacity per the retention period.</td></tr></tbody></table>

Use `weka stats retention status` to view the current retention and `weka stats retention restore-default` to restore the default retention settings.
