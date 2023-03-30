---
description: >-
  This page describes the statistics available in the WEKA system and how to
  work with them.
---

# Statistics

As the WEKA system runs, it collects hundreds of statistics on system performance. These statistics help analyze the WEKA system performance and determine the source of any issue.

The statistics categories of the basic charts include:

* CPU
* Object Store
* Operations
* Operations (Driver)
* Operations (NFS)
* Operations (NFSw)
* SSD

When you select each category, a list of the possible statistics related to the category is displayed, from which you can select a specific chart.

The system also provides advanced statistic charts aimed to be used by the Customer Success Team.

The default statistics page displays charts of the last hour of operation, presenting the system operation average value per second in one minute range.

![Statistics page](../../.gitbook/assets/wmng\_statistics\_overview.gif)

## **Drill-down options**

This Statistics page provides several options to drill down into the charts according to the selected category.

The options include:

* Move the mouse over the scrollable chart area to view the performance metrics of the WEKA cluster.
* Troubleshoot or obtain a correlation between events and performance using links to events that occurred.
* Add charts to the Statistics page, or remove charts.
* Display different charts of up to five on the statistics page. The default statistics page shows OPS (total), Throughput (total), and read/write latency for the last hour. You can change the interval by selecting the Hour, Day, or Week buttons or specifying a timeframe.
* Display and zoom in on statistics from defined timelines and dates.
* Bookmark specific statistics for future reference and share them with others (using the URL).

{% hint style="info" %}
**Note:** The page shows only the statistics of the backend servers and clients in the cluster. The page does not show statistics in the following cases:

* A backend server is removed.
* A client is not connected to the cluster for more than the [retention period](statistics-1.md#set-statistics-retention).

The WEKA cluster does not hold historical statistics data. For historical statistics data, use `weka-mon` (see [Monitor using external tools](../../appendix/external-monitoring.md)).
{% endhint %}

****

**Related topics**

[statistics.md](statistics.md "mention")

[statistics-1.md](statistics-1.md "mention")
