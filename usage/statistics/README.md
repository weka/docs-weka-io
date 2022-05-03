---
description: >-
  This page describes the statistics available in the Weka system and how to
  work with them.
---

# Statistics

## Overview

As the Weka system runs, it collects hundreds of statistics on system performance. These statistics help in analyzing the Weka system performance and determining the source of any problems.

Five different categories of statistics are available for review - Operations (NFS), Operations (Driver), Object Store, SSD and CPU – and when each category is selected, a list of the possible statistics that can be selected is displayed.

By default, the main statistics page displays the last hour of operation, presenting the Weka system operation per second on a time axis.

![Statistics View Screen](<../../.gitbook/assets/Statistics Main Screen.png>)

This Statistics view screen offers a number of options to drill-down into the statistics, according to category. Options include:

* Mousing over the scrollable graph area to view various performance metrics of the Weka cluster.
* Troubleshooting or obtaining a correlation between events and performance (using the top line which provides links to events that occurred).
* Adding more statistics to the view (using the Statistics menu).
*   Displaying different statistics simultaneously and toggling between them. By default, the graph area shows Ops/sec for the last hour. Using the "Hour, Day, Week" buttons

    at the bottom-right enables changing of the time interval.
* Displaying, hiding. deleting, and zooming-in on statistics from defined timelines and dates.
* Bookmarking specific statistics for future reference and sharing with others (using the URL).

{% hint style="info" %}
**Note:** The statistics are only shown for backend/clients that are part of the cluster. Once a host is removed (or a client is not connected to the cluster for more than the `remove_after_secs` period) its statistics will not be shown. The Weka cluster does not hold historical statistics data. Use `weka-mon` for that, as suggested in the [External Monitoring](../../appendix/external-monitoring.md) section.
{% endhint %}

##

## Working with Statistics Using the GUI

### Viewing Statistics

To view the statistics screen using the GUI, click the statistics button on the left bar:

![Statistics View Screen](<../../.gitbook/assets/Screenshot from 2018-07-29 11-47-29.png>)

### Adding Statistics

To select the addition of specific statistics, click the + Add Statistics tab on the right-hand side of the Statistics view screen. The statistics menu will be displayed.

![Add Statistics Tab](<../../.gitbook/assets/Screenshot from 2018-07-29 11-55-54.png>)

![Statistics Menu](<../../.gitbook/assets/Screenshot from 2018-07-29 12-03-48.png>)

Then select the component for which statistics required from the six possible categories. As each component is selected, the list of possible Statistics Names that can be selected changes. It is also possible to searching for a specific statistic by typing the name of the statistic in the Filter field at the top of the menu.

Up to 5 different statistics can be displayed simultaneously. Selecting a metric adds its graph to the Statistics view, together with a selector containing the category and name of the statistics which are displayed according to the appropriate units.

Switching the active unit scale is performed by clicking on one of the inactive units displayed in the left bottom corner of the graph display box.

### Hiding/Deleting Statistics

To hide or delete statistics from a graph, mouse-over the selector and click either the Hide or Delete button appearing under the selector.

![Example of Hide/Delete Buttons ](<../../.gitbook/assets/Screenshot from 2018-07-29 13-13-57.png>)

### Specifying a Time Frame

To define a specific period of time (start and end) for the statistics to be displayed, click the From and To selectors appearing in the left corner of the graph display box. Then select the date of the statistics required from the calendar popup and the hours from the right scroller, or by using the up and down arrows that appear when hovering on the time selectors.

![From/To Time Selectors](<../../.gitbook/assets/Screenshot from 2018-07-29 14-44-31.png>)

![Calendar Popup](<../../.gitbook/assets/Screenshot from 2018-07-29 15-01-39.png>)

{% hint style="info" %}
**Note:** It is also possible to change the time period by dragging the graph left or right.
{% endhint %}

The Auto Refresh setting offers another option for defining a specific period of time. Activation of Auto Refresh is performed by clicking on one of the buttons displayed in the right bottom corner of the graph display box, according to the desired period (hour, day or week). The selected period of time for the statistics will be automatically updated every minute, until Auto Refresh is deactivated by clicking the 'x' button located at the top right of the Auto Refresh tool tip, or by defining a period of time using the time selector.

![Auto Refresh Buttons](<../../.gitbook/assets/Screenshot from 2018-07-29 14-42-22.png>)

### Obtaining a Summary of Events

To obtain a summary of events that occurred in a specific time period, click the events bubble displayed above the graph. The Events popup will be displayed. Expand the popup in order to obtain a detailed list of events. Click on the icon next to each event to link to the selected event in the Events view screen.

![Events Popup](<../../.gitbook/assets/Screenshot from 2018-07-29 14-57-57.png>)

## Working with Statistics Using the CLI

### **Listing Statistics Types**

**Command:** `weka stats list-types`

Use the following command line to obtain statistics definition information:\
`weka stats list-types [<name-or-category>] [--show-internal]`

**Parameters in Command Lines**

| **Name**           | **Type** | **Value**                         | **Limitations**        | **Mandatory** | **Default** |
| ------------------ | -------- | --------------------------------- | ---------------------- | ------------- | ----------- |
| `name-or-category` | String   | Name or category fo filter by     | Valid name or category | No            |             |
| `show-internal`    | Boolean  | Also displays internal statistics |                        | No            | False       |

### **Viewing Statistics**

**Command:** `weka stats realtime`

Use the following command line to obtain the current performance-related statistics of the hosts, in a one-second interval:\
`weka stats realtime [<node-ids>] [--raw-units] [--UTC]`

**Parameters in Command Lines**

| **Name**    | **Type**                | **Value**                                        | **Limitations** | **Mandatory** | **Default**                                 |
| ----------- | ----------------------- | ------------------------------------------------ | --------------- | ------------- | ------------------------------------------- |
| `node-ids`  | Comma-separated strings | Only show realtime stats of these nodes          |                 | No            |                                             |
| `raw-units` | Boolean                 | Print values in raw units (bytes, seconds, etc.) |                 | No            | Human-readable format, e.g 1KiB 234MiB 2GiB |
| `UTC`       | Boolean                 | Print times in UTC                               |                 | No            | Host's local time                           |

**Command:** `weka stats`

The collected statistics are helpful to analyze system performance and determine the source of any problems as the Weka system runs, according to several categories. When each category is selected, a list of the possible statistics that can be selected is displayed.

{% hint style="info" %}
**Note:** All statistics are averaged over one-second intervals. Consequently, "total" or other aggregates relate to a specific minute.
{% endhint %}

Use the following command line to manage filters and read statistics:

`weka stats [--start-time <start-time>] [--end-time <end-time>] [--interval interval] [--resolution-secs resolution-secs] [--category category][--stat stat] [--node-ids node-ids] [--param param] [--accumulated] [--per-node] [--no-zeros] [--show-internal] [--raw-units] [--UTC]`

**Parameters in Command Lines**

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

{% content-ref url="broken-reference" %}
[Broken link](broken-reference)
{% endcontent-ref %}

### Setting statistics Retention

**Command:** `weka stats retention set`

Use the following command line to set the statistics retention period\
`weka stats retention set <--days days> [--dry-run]`

**Parameters in Command Lines**

| **Name**  | **Type** | **Value**                                                | **Limitations**                               | **Mandatory** | **Default** |
| --------- | -------- | -------------------------------------------------------- | --------------------------------------------- | ------------- | ----------- |
| `days`    | Number   | The Number of days to keep the statistics                | Should have enough free disk space per server | Yes           |             |
| `dry-run` | Boolean  | Only test the required capacity per the retention period |                                               | No            |             |

Use `weka stats retention status` to view the current retention and `weka stats retention restore-default` to restore the default retention settings.
