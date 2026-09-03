---
description: >-
  Manage, index, and query filesystem metadata using the data catalog. This
  feature provides macro-level insights and granular data discovery, enabling
  visibility into large filesystems at scale.
---

# Data catalog

## Data catalog overview

The data catalog offers advanced indexing and querying capabilities for filesystem data through a user-friendly graphical dashboard and REST APIs. It provides an indexed perspective on the filesystem, enabling macro-level insights into storage capacity usage and facilitating detailed data exploration.

The data catalog uses a distributed query engine for metadata storage. The engine is embedded directly into catalog services, runs in Data Service containers, and stores filesystem metadata in a dedicated index filesystem.

IT administrators leverage the data catalog to manage, monitor, and query large filesystems metadata at scale without depending on external systems.

### Key benefits

* **Native integration:** Eliminates the need for additional tools to monitor capacity.
* **Visibility at scale:** Use the sunburst chart on the Data Insights dashboard to pinpoint directories contributing most to storage usage, by size or file count. This tool effectively visualizes the hierarchy and capacity across the filesystem, illustrating filesystem trends clearly.
* **Actionable analytics:** Enables the export of panel statistics and chart data as CSV files for reporting purposes.
*   **Enhanced discoverability:**

    With a user-friendly SQL query builder and ready-to-use templates, execute queries straight from the UI. Common tasks include:

    * **Growth analysis:** Identify directories growing by more than 50GB in the past 24 hours.
    * **Capacity forecasting:** Determine which filesystems will reach 90% capacity within the next 14 days.
    * **Cold data identification:** Find all files and directories untouched by any user in the last 90 days.
    * **Export query results:** Download results in JSON format for sharing and analyzing data with other tools.
* **Data forecast:** The data ingestion in the file system, alongside data patterns from the catalog, provides projections for future growth. It offers a visual graphical representation of forecasted numbers.
* **Comparative analysis:** Compare data between two points in time using Comparison Insights. Review a delta summary of added, modified, and deleted files and directories, then identify which directories drove the change.

## Identify storage trends with the Filesystem Analytics dashboard

Monitor storage trends and capacity distribution using the Filesystem Analytics dashboard. This tool, powered by the Data Catalog, provides high-level visualization and granular discovery of filesystem metadata to eliminate the need for external capacity monitoring systems.

#### Dashboard components and behavior

The dashboard features several specialized panels to present filesystem metadata:

* **Sunburst chart:** The centerpiece of the dashboard designed for top-level view of directory hierarchy and capacity consumption.
* **File count by extension:** Shows how files are distributed by extension across the filesystem. Select a bar, then select **Deep Dive** to explore the underlying files.
* **Usage statistics by user or group:** Charts that identify storage consumption attributed to specific accounts or organizational units.
* **Historical trends and forecasting:** The Filesystem Capacity Over Time chart shows historical growth and provides predictable usage based on current patterns if at least 24 hours of data is available.
* **Comparison Insights:** Compares a filesystem between two points in time, summarizing added, modified, and deleted files and directories and ranking directories by storage impact.

#### Sunburst chart characteristics

The chart provides top-level snapshots of the filesystem. It includes the following features:

* **Interactive tooltips:** Hover over a segment to view the directory path, size, and percentage of total capacity.
* **Inner circle distinctions:** Differentiates directory levels at a glance with clear visual boundaries.
* **Other directories (...):** A non-interactive segment represented by an ellipsis **(...)**, grouping smaller directories to enhance UI clarity. Hovering over this section reveals a tooltip summarizing the cumulative folder info: total size, percentage, and capacity of this segment.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/catalog_sunburst_example.png" alt=""><figcaption><p>Sunburst chart example</p></figcaption></figure></div>

### Use case: Optimizing filesystem capacity

Effectively manage storage resources by identifying the root causes of unexpected capacity usage and relocating inactive data.

**Address unexpected capacity challenges**

When filesystem usage unexpectedly approaches 90%, a systematic investigation is essential. Traditional tools like `du -sh` or `du -sb` can take hours to complete on filesystems with billions of files. A data catalog backed by a high-performance indexing database dramatically reduces discovery time, providing immediate insights and intuitive data visualization.

Use the Sunburst view to drill into storage hierarchies and quickly pinpoint the directories or users driving significant disk space consumption.

**Identify and migrate stale data**

Predefined templates in the data catalog allow you to categorize files by access patterns (for example, files inactive for 90 or more days), enabling targeted, cost-saving action:

* **Identify inactive files:** Surface data that is no longer needed by active workloads.
* **Migrate to cost-effective storage:** Move stale data to S3 or low-cost HDD clusters.
* **Optimize premium resources:** Reserve SSD-based cluster capacity for high-priority, frequently accessed data.

{% embed url="https://youtu.be/o_ZnKSCjBQE" fullWidth="true" %}
Demo: NeuralMesh data catalog
{% endembed %}
