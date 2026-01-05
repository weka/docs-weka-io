---
description: Improve the WEKA support process with WEKA Home.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/monitor-the-weka-cluster/the-wekaio-support-cloud
---

# WEKA Home - The WEKA support cloud

WEKA Home is a central cloud location that collects telemetry data, monitors, and keeps track of WEKA clusters in the field. This information is uploaded from customers' WEKA clusters and clients and is primarily used to improve the support process.

WEKA Home is intended for the Customer Success Team and is not accessible to customers directly. WEKA Home enables the Customer Success Team to provide proactive support when recognizing cluster irregularities, improving incident response time, and streamlining the troubleshooting process.

It is intended to be the first source of information to investigate a critical event or an issue in the field. Also, it provides insights into customer usage and behaviors to improve the WEKA product further.

Only licensed WEKA clusters are monitored through WEKA Home, with all telemetry data sent in an encrypted format to ensure security.

WEKA Home provides the following main features:

* Receive and store alerts, events, usage, analytics, statistics, and support diagnostics.
* Query cluster-wide events and statistics.
* Trigger events and alerts for a 24x7 support response.

In the WEKA Home portal, the Customer Success Team can view the cluster’s statistics, state of health, consolidated view of events, and diagnostics for various triaging activities. The team can offer a comprehensive 24x7x365 support view of all customer systems sending telemetry data.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/wekahome_overview.png" alt=""><figcaption><p>WEKA clusters and clients connected to WEKA Home</p></figcaption></figure></div>

## Which information is uploaded to WEKA Home?

The WEKA cluster periodically and on-demand uploads various information types to Cloud WEKA Home. The retention period for all the following is 14 days.

**Periodic uploads:**

* **Alerts:** Alerts indicate problematic ongoing states that are impacting the cluster. Alerts are uploaded immediately when a cluster container (host) creates an alert.
* **Events:** Events contain relevant information for the WEKA cluster and customer environment. Triggered by a customer or an environmental change, events can be informational, indicate an issue with the cluster, or a previously resolved issue. Events are uploaded immediately when a cluster container creates an event.
* **Statistics:** Statistics help analyze the WEKA system performance and determine the source of any issue. The uploaded statistics information includes a subset of the complete list available from the cluster, such as IOPS, throughput, latency, metadata, and block size. Statistics are uploaded every minute from each container.
* **Usage reports:** Usage reports provide metrics for interface groups, containers, processes (nodes), drives, status, version, and filesystems. Usage reports are uploaded every minute.
* **Analytics:** Analytics provide metrics for the cluster configuration, including drives, filesystem settings, containers, network devices, nodes, protocols, and more. Analytics are uploaded every 30 minutes.

**On-demand uploads:**

* **Diagnostics (support files):** These are uploaded on-demand from the container that collected the diagnostics.

{% hint style="info" %}
**WEKA Home data privacy notice:** WEKA Home is committed to safeguarding your data privacy. To ensure the confidentiality and security of your information, the WEKA Home support cloud explicitly excludes the following from upload and collection:

* File and directory names
* File contents
* User passwords
{% endhint %}

## Upload information from the WEKA cluster to the WEKA Home

Uploading information to WEKA Home from the WEKA cluster backend servers and clients is essential for the Customer Success Team to provide practical assistance. If client connectivity cannot be configured, enabling upload information from the backend servers is still beneficial.

**Before you begin**

* Ensure your firewall is configured to allow access to all Cloud WEKA Home destinations. For the complete list of ports and URLs, see [#required-ports](../../planning-and-installation/prerequisites-and-compatibility.md#required-ports "mention").
* If the connection to the Cloud WEKA Home is through a proxy, set the proxy by running the command: `weka cloud proxy --set <proxy_url>`.

**Procedure**

1. To enable cloud notifications, run the `weka cloud enable` command (during the WEKA cluster installation, it is an optional step, which may be already done).
2. To upload diagnostics collected by the cluster, run the `weka diags upload` command.

**Related topics**

[list-of-alerts-and-corrective-actions.md](../../operation-guide/alerts/list-of-alerts-and-corrective-actions.md "mention")

[events-list.md](../../operation-guide/events/events-list.md "mention")

[statistics-list.md](../../operation-guide/statistics/statistics-list.md "mention")

[#upload-diagnostics-data-to-weka-home](../../support/diagnostics-management/diagnostics-utility.md#upload-diagnostics-data-to-weka-home "mention")
