---
description: >-
  This page describes the statistics available in the WekaIO system and how to
  work with them.
---

# Statistics

## Overview

As the WekaIO system runs, it collects hundreds of statistics on system performance. These statistics help in analyzing the WekaIO system performance and determining the source of any problems.

Six different categories of statistics are available for review - CPU, Object Store, Operations, Operations \(NFS\), Operations \(Driver\) and SSD – and when each category is selected, a list of the possible statistics that can be selected is displayed.

By default, the main statistics page displays the last 3 hours of operation, presenting the WekaIO system operation per second on a time axis.

![Statistics View Screen](../.gitbook/assets/statistics-main-screen.png)

This Statistics view screen offers a number of options to drill-down into the statistics, according to category. Options include:

* Viewing the average number of operations per second \(by moving cursor on the time axis\).
* Troubleshooting or obtaining a correlation between events and performance \(using the top line which provides links to events that occurred\).
* Adding more statistics to the view \(using the Statistics menu\).
* Displaying different dimensions simultaneously and toggling between them.
* Displaying, hiding. deleting, and zooming-in on statistics from defined timelines and dates.
* Bookmarking specific statistics for future reference and sharing with others \(using the URL\).

## Working with Statistics Using the GUI

### Viewing Statistics

To view the statistics screen using the GUI, click the statistics button on the left bar:  

![Statistics View Screen](../.gitbook/assets/screenshot-from-2018-07-29-11-47-29.png)

### Adding Statistics

To select the addition of specific statistics, click the + Add Statistics tab on the right-hand side of the Statistics view screen. The statistics menu will be displayed.

![Add Statistics Tab](../.gitbook/assets/screenshot-from-2018-07-29-11-55-54.png)

![Statistics Menu](../.gitbook/assets/screenshot-from-2018-07-29-12-03-48.png)

Then select the component for which statistics required from the six possible categories. As each component is selected, the list of possible Statistics Names that can be selected changes. It is also possible to searching for a specific statistic by typing the name of the statistic in the Filter field at the top of the menu. 

Up to 5 different statistics can be displayed simultaneously. When each statistic is selected, another graph is added to the Statistics view screen, together with a selector containing the category and name of the statistics which are displayed according to the appropriate units. 

Switching the active unit scale is performed by clicking on one of the inactive units displayed in the left bottom corner of the graph display box.

### Hiding/Deleting Statistics

To hide or delete statistics from a graph, hover with the mouse on the selector and click either the Hide or Delete button appearing under the selector.

![Example of Hide/Delete Buttons ](../.gitbook/assets/screenshot-from-2018-07-29-13-13-57.png)

### Defining a Specific Timeline

To define a specific period of time \(start and end\) for the statistics to be displayed, click the From and To selectors appearing in the left corner of the graph display box. Then select the date of the statistics required from the calendar popup and the hours from the right scroller, or by using the up and down arrows that appear when hovering on the time selectors.

![From/To Time Selectors](../.gitbook/assets/screenshot-from-2018-07-29-14-44-31.png)

![Calendar Popup](../.gitbook/assets/screenshot-from-2018-07-29-15-01-39.png)

{% hint style="info" %}
**Note:** It is also possible to change the time period by dragging the graph left or right.
{% endhint %}

The Auto Refresh setting offers another option for defining a specific period of time. Activation of Auto Refresh is performed by clicking on one of the buttons displayed in the right bottom corner of the graph display box, according to the desired period \(hour, day or week\). The selected period of time for the statistics will be automatically updated every minute, until Auto Refresh is deactivated by clicking the 'x' button located at the top right of the Auto Refresh tool tip, or by defining a period of time using the time selector.   

![Auto Refresh Buttons](../.gitbook/assets/screenshot-from-2018-07-29-14-42-22.png)

### Obtaining a Summary of Events

To obtain a summary of events that occurred in a specific time period, click the events bubble displayed above the graph. The Events popup will be displayed.  Expand the popup in order to obtain a detailed list of events. Click on the icon next to each event to link to the selected event in the Events view screen.    

![Events Popup](../.gitbook/assets/screenshot-from-2018-07-29-14-57-57.png)

## Working with Statistics Using the CLI

**Command:** `weka stats`

Use the following command line to obtain statistics definition information:  
`weka stats list-types`

Use the following command line to obtain the current performance status of the hosts:  
`weka stats realtime`

Use the following command line to manage filters and read statistics:  
`weka stats --start-time=<start> [--end-time=<end>] [--category=<category>]... [--stat=<stat>]... [--resolution-secs=<secs>] [--accumulated] [--node-ids=<node>...] [--param=<key:val>]... [--no-zeroes] [--show-internal] [--per-node]`  
or:

`weka stats --interval=<interval> [--category=<category>]... [--stat=<stat>]... [--resolution-secs=<secs>] [--accumulated] [--node-ids=<node>...] [--param=<key:val>]... [--no-zeroes] [--show-internal] [--per-node]`

**Parameters in Command Lines**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `start` | String | Start time of the reported period | Valid date and time\* | Yes |  |
| `end` | String | End time of the reported period | Valid date and time\* | No | Current time |
| `interval**` | String | Period of time to be reported | Valid interval in seconds \(positive integer number\) | Yes |  |
| `category` | String | Specific categories for retrieval of appropirate statistics | Valid existing categories: CPU, Object Store, Operations, Operations \(NFS\), Operations \(Driver\), SSD  | No | All |
| `stat` | String | Statistics names | Valid statistics names | No | All |
| `secs` | String | Length of each interval in the reported period | Must be multiples of 60 seconds | No | 60 seconds |
| `nodes` | String | Node id | Valid node-id | No | All |
| `key:val` | String | A pair of key and value, where `key` is a statistics parameterization type and `val` is a valid parameterization value for that type | Valid parameterization type and value | No |  |

{% hint style="info" %}
**Notes:**

\*Refer to Datetime Switches Syntax section in `weka --help-syntax` for help regarding datetime typed switches.

\*\*Relevant to the second command.
{% endhint %}

**Optional Flags in Command Line**

`[--accumulated]`: Displays accumulated statistics, not rate statistics

`[--no-zeroes]`: Filters results where the value is 0

`[--show-internal]`: Displays internal statistics

`[--per-node]`: Does not aggregate statistics across nodes

