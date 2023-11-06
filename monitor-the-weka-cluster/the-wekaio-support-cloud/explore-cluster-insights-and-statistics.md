# Explore cluster insights and statistics

## Clusters

### View clusters list

Local WEKA Home provides monitoring and reporting capabilities for multiple clusters within your organization. When you access the Local WEKA Home interface, the initial screen displays a list of all the WEKA clusters in your environment that have been configured to send telemetry data to your Local WEKA Home instance.

To view the cluster overview, select it from the list, or select the 3-dot icon on the right and select **Open in new tab**.

<figure><img src="../../.gitbook/assets/clusters-page (1).png" alt=""><figcaption><p>Clusters page</p></figcaption></figure>

### Filter clusters list

You can filter and sort the clusters based on a range of criteria, including their last seen status, licensed or unlicensed status, and whether the clusters have silenced alerts.

For more advanced filtering options, select the **Advanced filters** icon.

<figure><img src="../../.gitbook/assets/clusters-advanced-filters.png" alt=""><figcaption><p>Clusters page: Advance filters</p></figcaption></figure>

### Download clusters report

To download a report of all your clusters, select the **Download** icon.

<figure><img src="../../.gitbook/assets/clusters-download-report.png" alt="" width="563"><figcaption><p>Download clusters report</p></figcaption></figure>

## Overview

The Overview displays multiple panels summarizing key cluster-wide information, including health, configuration, alerts, events, performance, and more.

You can access the other view pages, such as events and filesystems, by either selecting them from the left menu or selecting the corresponding panel titles.

<figure><img src="../../.gitbook/assets/cluster-overview-page.png" alt=""><figcaption><p>Cluster overview</p></figcaption></figure>

## Events

The Events page displays the offline event data for the cluster and associated detail with each event. You can use filters to refine your search according the event severity, category, process ID, and more.

<figure><img src="../../.gitbook/assets/cluster-event-view.png" alt=""><figcaption><p>Events page</p></figcaption></figure>

## Filesystems

The Filesystems page provides comprehensive information about the configured filesystems in the cluster.

You have the flexibility to reorganize the display by selecting any column in the tables, and you can use filters to refine your search. For more in-depth information in JSON format, select a specific row.

<figure><img src="../../.gitbook/assets/cluster-filesystems-view.png" alt=""><figcaption><p>Filesystems view with in-depth information in JSON format</p></figcaption></figure>

## Topology

The Topology page presents an array of cluster configurations categorized into sections: Servers, Containers, Processes, Drives, and Network Devices.

You have the flexibility to reorganize the display by selecting on any column in the tables, and you can use filters to refine your search. For more in-depth information in JSON format, select a specific row.

Select each tab to explore the topology screens.

{% tabs %}
{% tab title="Servers" %}
<figure><img src="../../.gitbook/assets/cluster-topology-servers-view.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Containers" %}
<figure><img src="../../.gitbook/assets/cluster-topology-containers.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Processes" %}
<figure><img src="../../.gitbook/assets/cluster-topology-processes.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Drives" %}
<figure><img src="../../.gitbook/assets/cluster-topology-drives.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="Network Devices" %}
<figure><img src="../../.gitbook/assets/cluster-topology-net-devices.png" alt=""><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

## Protocols

The Protocols page provides comprehensive information about the configured protocols in the cluster. Each tab corresponds to a specific protocol, including NFS, S3, and SMB.

You can customize the display order of information in the tables by selecting the column title.

Select each tab to explore the protocol screens.

{% tabs %}
{% tab title="NFS" %}
<figure><img src="../../.gitbook/assets/cluster-protocols-nfs.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="S3" %}
<figure><img src="../../.gitbook/assets/cluster-protocols-s3.png" alt=""><figcaption></figcaption></figure>
{% endtab %}

{% tab title="SMB" %}
<figure><img src="../../.gitbook/assets/cluster-protocols-smb.png" alt=""><figcaption></figcaption></figure>
{% endtab %}
{% endtabs %}

## Settings

The Settings page displays a variety of panels containing information such as traces, container uptimes, process uptimes, overrides, and more.

<figure><img src="../../.gitbook/assets/cluster-settings.png" alt=""><figcaption><p>Setting page</p></figcaption></figure>

## Diagnostics&#x20;

The Diagnostics page displays the content of all diagnostic files uploaded from the cluster. Diagnostics are neatly organized in a file system tree structure for convenient navigation.

To access the file content, select the respective file.

Additionally, you have the option to directly upload a diagnostics tar file. You can effortlessly locate specific information by using the search feature and its additional options.

<figure><img src="../../.gitbook/assets/cluster-diagnostics.png" alt=""><figcaption><p>Diagnostics view</p></figcaption></figure>

## Admin

See [enforce-security-and-compliance.md](enforce-security-and-compliance.md "mention").

## Analytics

The Analytics page displays the cluster configuration (similar to the Topology view) in JSON format. To locate specific information, use the search feature and its options. If you need to copy the content, click the copy icon located next to the first row.

<figure><img src="../../.gitbook/assets/cluster-analytics.png" alt=""><figcaption><p>Analytics view</p></figcaption></figure>

## Tasks

The Tasks page presents a list of background tasks with various statuses that are currently active in your cluster.

You can further refine your task list and customize the display order of information in the tables by selecting the column title.

To access detailed information about a specific task, select its row to view it in JSON format.

<figure><img src="../../.gitbook/assets/cluster-tasks.png" alt=""><figcaption><p>Tasks view</p></figcaption></figure>

## Download Usage Report and Analytics

Local Weka Home allows you to download JSON-formatted reports to your local workstation for viewing and forwarding to the Customer Success Team for case resolution. You can also add these reports to Cloud Weka Home for offline monitoring.

If your data includes sensitive values that you want to protect, you can choose to download anonymized reports. In anonymized reports, sensitive values are handled as follows: The cluster name is replaced with `weka-[first part of cluster GUID]` and other sensitive values are removed.

<details>

<summary>Usage Report default anonymized data</summary>

The following properties are affected by anonymization:

* name
* alerts
* status/name
* status/cloud

</details>

<details>

<summary>Analytics default anonymized data</summary>

The following properties are affected by anonymization:

* cluster/name
* For all hosts:
  * host/hosts/ips
  * host/hosts/host\_ip
  * host/hosts/hostname
  * host/hosts/instance\_region
  * host/hosts/aws\_instance\_region
* misc/kms/type
* misc/cloud/url
* nfs/interface\_groups/name
* nfs/interface\_groups/gateway
* nfs/interface\_groups/subnet\_mask
* s3/domain
* s3/filesystem
* smb/smb\_trusted\_domains

</details>

{% hint style="info" %}
The anonymization option is supported with WEKA clusters of version 3.14.2 and above.
{% endhint %}

<figure><img src="../../.gitbook/assets/download_usage_analytics_reports (3).png" alt=""><figcaption><p>Download Usage Report and Analytics</p></figcaption></figure>

## Performance Statistics

You can open the Grafana application to view some of the various performance visualizations directly from the Local WEKA Home.

From the **Cluster Configuration** menu, select **Performance Statistics**.

<figure><img src="../../.gitbook/assets/lwh_cluster_stats1.png" alt=""><figcaption><p>Cluster Summary in Grafana</p></figcaption></figure>

<figure><img src="../../.gitbook/assets/lwh_cluster_stats2.png" alt=""><figcaption><p>WEKA Home Health Dashboard in Grafana</p></figcaption></figure>
