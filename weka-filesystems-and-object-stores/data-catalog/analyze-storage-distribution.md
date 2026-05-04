---
description: >-
  Analyze storage distribution with the data catalog. Explore directory
  hierarchies, visualize file statistics, and perform granular metadata
  discovery.
---

# Analyze storage distribution

Explore filesystem metadata to identify usage patterns and discover specific data sets through the Filesystem Analytics dashboard. Powered by the data catalog, these tools provide macro-level insights and granular discovery to eliminate reliance on external capacity monitoring systems.

* **Analyze capacity usage:** Explore the directory hierarchy and identify storage consumption.
* **Visualize file distribution:** Review file statistics by extension, user, or group.
* **Monitor storage distribution and trends:** Observe how files are distributed by size and age, and track capacity growth.
* **Search files with discovery queries:** Build custom queries to locate files based on metadata attributes.
* **Use discovery templates:** Apply pre-defined query patterns for common analysis tasks.
* **Export catalog data:** Save capacity reports and query results as CSV or JSON files.

## Analyze capacity usage

Explore the distribution of storage across different directory levels to identify large data sets and review high-level filesystem metrics.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/catalog_sunburst.png" alt=""><figcaption><p>Capacity usage: Sunburst and File Statistics charts</p></figcaption></figure></div>

**Before you begin**

Verify that the target filesystem is indexed by the data catalog.

**Procedure**

1. Select **Investigate > Filesystem Analytics**.
2. Select the **Capacity Usage** tab.
3. Select the target filesystem from the **Filesystem** dropdown menu.
4. Select a specific point in time from the **Data Collection** dropdown menu.
5. To display the chart from a custom file path, click the pencil icon and enter the desired path.\
   All chart information will relate to this file path.
6. Review the high-level metrics:
   * **Filesystem Capacity:** Displays used and total provisioned space. Hover over the info icon to view the actual block-level occupancy.
   * **File and Directory counts:** Displays the total number of files and directories indexed in the filesystem.
7. Interact with the sunburst chart to navigate the directory hierarchy:
   * Select a sector to zoom into a specific directory.
   * Hover over a sector to view the directory path, total size, and percentage of the total filesystem capacity. Dark purple sectors represent directories, while light purple sectors represent individual files or groups of smaller items.
   * Select the center of the chart to move up one directory level.
8. Use the **File Statistics** chart to view data distribution. Select an option from the dropdown menu:
   * File Count by Extension
   * Usage Statistics by Group
   * Usage Statistics by User

## Monitor storage distribution and trends

Observe how files are distributed by size and age, and track capacity growth over time to forecast future storage needs.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Catalog_fs_analytics.png" alt=""><figcaption><p>File Size Distribution and Capacity by File Age charts</p></figcaption></figure></div>

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/catalog_fs_forecast.png" alt=""><figcaption><p>Filesystem Capacity Over Time and Forecast chart</p></figcaption></figure></div>

**Before you begin**

Access the **Capacity Usage** tab and scroll to the **Filesystem Analytics** section.

Scroll down to view additional distribution metrics.

**Procedure**

1. Review the **File Size Distribution** chart:
   * Identify the number of files within specific size ranges (for example: 1MB-10MB).
   * Hover over a bar to view the exact File Count for that range.
2. Review the **Capacity by File Age** chart:
   * Identify the volume of data based on the time elapsed since the last modification (for example: < 1 week or 5+ years).
   * Hover over a bar to view the Total Size of the files in that age category.
3. Analyze the **Filesystem Capacity Over Time** chart:
   * Observe historical trends for Total Capacity and Used Capacity.
   * Toggle the **Forecast** switch to ON to view projected storage needs. The chart displays Total Forecast and Used Forecast lines based on current data patterns. This requires at least 24 hours of historical snapshot data.
4. Select the **Download** icon in the top right corner of any chart to export the specific chart data as a CSV file.

## Search files with discovery queries

Filter and locate specific files by defining complex metadata conditions such as file size, access time, or owner.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/catalog_discovery.png" alt=""><figcaption><p>Discovery query</p></figcaption></figure></div>

**Before you begin**

Access the **Discovery** tab within the **Filesystem Analytics** view.

**Procedure**

1. Select the **Filesystem** and **Data Collection** date.
2. In the **Show** section, select the columns to display in the results table, for example: File Name, Size, and Created At.
3. In the **Conditions** section, define the search criteria:
   * Select a metadata field (for example: File Size, Access Time, or UID).
   * Select an operator (for example: In, Between, >, or Regular File).
   * Enter or select the value for the condition.
4. Select the **+** icon to add more conditions. Use the Operator dropdown to select AND or OR logic between conditions.
5. In the **Sort** section, select a field and the sort order (ASC or DESC).
6. Set the number of **Rows per Page** to display.
7. Select **Run Query**.

## Apply discovery query templates

Use pre-configured templates to quickly identify common file categories like cold data or recently modified files.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Catalog_query_templates.png" alt=""><figcaption><p>Discovery query templates</p></figcaption></figure></div>

**Before you begin**

Access the **Discovery** tab within the **Filesystem Analytics** view.

**Procedure**

1. Select **Templates** in the **Build a New Query** section.
2. Select a template from the list, for example: Files Not Accessed in Last 90 Days (Cold Data).
3. Review the auto-populated conditions.
4. Modify the values if required, for example: change the date range or the file size threshold.
5. Select **Run Query**.

**Query results handling**

The query results table supports full filesystems exploration through pagination. Navigate across pages to review the complete result set.

The GUI exports up to 10,000 records per query. To retrieve more records, use the REST API. See [#catalog](../../getting-started-with-weka/weka-rest-api-and-equivalent-cli-commands.md#catalog "mention").

## Export catalog data

Save the results of a capacity analysis or a discovery query for external reporting or further processing.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Catalog_download_csv.png" alt=""><figcaption></figcaption></figure></div>

**Before you begin**

Generate a visualization in the **Capacity Usage** tab or run a query in the **Discovery** tab.

**To export capacity data:**

1. Navigate to the **Capacity Usage** tab.
2. Select the **Download CSV** icon located above the sunburst or distribution charts.

The exported CSV reflects the current visualization scope. It includes the top-level directory statistics displayed in the chart. The “**...**” entry represents an aggregated summary of additional directories outside the top view.

**To export discovery results:**

1. Navigate to the **Discovery** tab.
2. Select **Export** above the results table.
3. Select the preferred format and scope:
   * **CSV (current page results)**
   * **JSON (current page results)**
   * **CSV (all results)**
   * **JSON (all results)**

Retrieve the file from the default downloads folder of the browser.
