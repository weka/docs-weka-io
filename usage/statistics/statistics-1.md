---
description: This page describes how to manage the statistics using the GUI.
---

# Manage statistics using the CLI

Using the GUI, you can:

* [List statistics types](statistics-1.md#list-statistics-types)
* [View statistics in real-time](statistics-1.md#view-realtime-statistics)
* [View statistics over time](statistics-1.md#view-statistics-over-time)
* [Set statistics retention](statistics-1.md#set-statistics-retention)

## List statistics types

**Command:** `weka stats list-types`

Use the following command line to obtain statistics definition information:\
`weka stats list-types [<name-or-category>] [--show-internal]`

**Parameters in command lines**

| **Name**           | **Type** | **Value**                         | **Limitations**        | **Mandatory** | **Default** |
| ------------------ | -------- | --------------------------------- | ---------------------- | ------------- | ----------- |
| `name-or-category` | String   | Name or category fo filter by     | Valid name or category | No            |             |
| `show-internal`    | Boolean  | Also displays internal statistics |                        | No            | False       |

## View statistics in real-time

**Command:** `weka stats realtime`

Use the following command line to obtain the current performance-related statistics of the hosts in a one-second interval:\
`weka stats realtime [<node-ids>] [--raw-units] [--UTC]`

**Parameters in command lines**

| **Name**    | **Type**                | **Value**                                        | **Limitations** | **Mandatory** | **Default**                                 |
| ----------- | ----------------------- | ------------------------------------------------ | --------------- | ------------- | ------------------------------------------- |
| `node-ids`  | Comma-separated strings | Only show realtime stats of these nodes          |                 | No            |                                             |
| `raw-units` | Boolean                 | Print values in raw units (bytes, seconds, etc.) |                 | No            | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC`       | Boolean                 | Print times in UTC                               |                 | No            | Host's local time                           |

## **View statistics over time**

**Command:** `weka stats`

The collected statistics can help analyze system performance and determine the source of issues that may occur during Weka system runs. Statistics are divided according to categories. When selecting a category, a list of the possible statistics is displayed, from which you can select the specific statistics.

{% hint style="info" %}
**Note:** Weka averages all statistics over one-second intervals. Consequently, the total value or other aggregates relate to a specific minute.
{% endhint %}

Use the following command line to manage filters and read statistics:

`weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval interval] [--resolution-secs resolution-secs] [--category category][--stat stat] [--node-ids node-ids] [--param param] [--accumulated] [--per-node] [--no-zeros] [--show-internal] [--raw-units] [--UTC]`

**Parameters in command lines**

| **Name**          | **Type** | **Value**                                                                                                                                                                                                                          | **Limitations**                                                                                                                  | **Mandatory** | **Default**                                 |
| ----------------- | -------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------------------------------------- |
| `start-time`      | String   | Start time of the reported period                                                                                                                                                                                                  | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No            | -1m                                         |
| `end-time`        | String   | End time of the reported period                                                                                                                                                                                                    | Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 9:15Z, 10:00+2:00 | No            | Current time                                |
| `interval`        | String   | Period of time to be reported                                                                                                                                                                                                      | Valid interval in seconds (positive integer number)                                                                              | Yes           |                                             |
| `resolution-secs` | String   | Length of each interval in the reported period                                                                                                                                                                                     | Must be multiples of 60 seconds                                                                                                  | No            | 60                                          |
| `category`        | String   | Specific categories for retrieval of appropriate statistics                                                                                                                                                                        | Valid existing categories: CPU, Object Store, Operations, Operations (NFS), Operations (Driver), SSD                             | No            | All                                         |
| `stat`            | String   | Statistics names                                                                                                                                                                                                                   | Valid statistics names                                                                                                           | No            | All                                         |
| `node-ids`        | String   | Node id                                                                                                                                                                                                                            | Valid node-id                                                                                                                    | No            | All                                         |
| `param`           | String   | For parameterized statistics, retrieve only the instantiations where the specified parameter is of the specified value. Multiple values can be supplied for the same key, e.g. '--param method:putBlocks --param method:initBlock' | Format: `key:val`                                                                                                                | No            |                                             |
| `accumulated`     | Boolean  | Display accumulated statistics, not rate statistics                                                                                                                                                                                |                                                                                                                                  | No            | False                                       |
| `per-node`        | Boolean  | Does not aggregate statistics across nodes                                                                                                                                                                                         |                                                                                                                                  | No            | False                                       |
| `no-zeros`        | Boolean  | Filters results where the value is 0                                                                                                                                                                                               |                                                                                                                                  | No            | False                                       |
| `show-internal`   | Boolean  | Also displays internal statistics                                                                                                                                                                                                  |                                                                                                                                  | No            | False                                       |
| `raw-units`       | Boolean  | Print values in raw units (bytes, seconds, etc.)                                                                                                                                                                                   |                                                                                                                                  | No            | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC`             | Boolean  | Print times in UTC                                                                                                                                                                                                                 |                                                                                                                                  | No            | Host's local time                           |

## Set statistics retention

**Command:** `weka stats retention set`

Use the following command line to set the statistics retention period.\
`weka stats retention set <--days days> [--dry-run]`

**Parameters in command lines**

| **Name**  | **Type** | **Value**                                                | **Limitations**                               | **Mandatory** | **Default** |
| --------- | -------- | -------------------------------------------------------- | --------------------------------------------- | ------------- | ----------- |
| `days`    | Number   | The Number of days to keep the statistics                | Should have enough free disk space per server | Yes           |             |
| `dry-run` | Boolean  | Only test the required capacity per the retention period |                                               | No            |             |

Use `weka stats retention status` to view the current retention and `weka stats retention restore-default` to restore the default retention settings.
