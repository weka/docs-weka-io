---
description: Improve the WEKA support process with Weka Home.
---

# Weka Home - The WEKA support cloud

Weka Home is a central cloud location that collects telemetry data, monitors, and keeps track of WEKA clusters in the field. This information is uploaded from customers' WEKA clusters and clients and is primarily used to improve the support process.

Weka Home is intended for Customer Success Team and is not accessible to customers directly. Weka Home enables the Customer Success Team to provide proactive support when recognizing cluster irregularities, improving incident response time, and streamlining the troubleshooting process.

It is intended to be the first source of information to investigate a critical event or an issue in the field. Also, it provides insights into customer usage and behaviors to improve the WEKA product further.

Only licensed WEKA clusters are monitored through Weka Home, with all telemetry data sent in an encrypted format to ensure security.&#x20;

Weka Home provides the following main features:&#x20;

* Receive and store alerts, events, usage, analytics, statistics, and support diagnostics.
* Query cluster-wide events and statistics.
* Trigger events and alerts for a 24x7 support response.

In the Weka Home portal, the Customer Success Team can view a cluster’s statistics, state of health, consolidated view of events, and diagnostics for various triaging activities. It allows the team to offer a comprehensive 24x7x365 support view of all customer systems sending telemetry data.&#x20;

<figure><img src="../../.gitbook/assets/wekahome_overview.png" alt=""><figcaption><p>WEKA clusters and clients connected to Weka Home</p></figcaption></figure>

## Which information is uploaded to the Weka Home?

The WEKA cluster periodically and on-demand uploads various information types to Cloud Weka Home. The retention period for all the following is 14 days. &#x20;

**Periodic uploads:**

* **Alerts:** Alerts indicate problematic ongoing states that are impacting the cluster. Alerts are uploaded immediately when a cluster container (host) creates an alert.
* **Events:** Events contain relevant information for the WEKA cluster and customer environment. Triggered by a customer or an environmental change, events can be informational, indicate an issue with the cluster, or a previously resolved issue. Events are uploaded immediately when a cluster container creates an event.
* **Statistics:** Statistics help analyze the WEKA system performance and determine the source of any issue. Statistics are uploaded every minute from each container.
* **Usage reports:**  Usage reports provide metrics for interface groups, containers, processes (nodes), drives, status, version, and filesystems. Usage reports are uploaded every minute.
* **Analytics:** Analytics provide metrics for the cluster, drives, filesystems settings, containers, network devices, nodes, protocols, and more. Analytics are uploaded every 30 minutes.

**On-demand uploads:**

* **Diagnostics (support files):** Uploaded on-demand from the container that collected the diagnostics.

## Upload information from the WEKA cluster to the cloud Weka Home

Uploading information to Weka Home from the WEKA cluster backend servers and clients is essential for the Customer Success Team to provide effective assistance. If client connectivity cannot be configured, enabling upload information from the backend servers is still beneficial.

**Procedure**

1. To enable cloud notifications, run the `weka cloud enable` command (during the Weka cluster installation, it is an optional step, which may be already done).
2. To upload diagnostics collected by the cluster, run the `weka diags upload` command.
3. Ensure your network allows HTTPS communication using the following network ports:
   * 443: HTTPS communication from the WEKA cluster to [api.home.weka.io](http://api.home.weka.io/) and [get.weka.io](http://get.weka.io/).
   * 4000, 4001, and 22: Remote access from [api.home.weka.io](http://api.home.weka.io/) for troubleshooting by the Customer Success Team.
4. If the connection to Weka Home is through a proxy, set the proxy by running the command: `weka cloud proxy --set <proxy_url>`.

**Related topics**

[list-of-alerts.md](../../usage/alerts/list-of-alerts.md "mention")

[list-of-events.md](../../usage/events/list-of-events.md "mention")

[list-of-statistics.md](../../usage/statistics/list-of-statistics.md "mention")

[#upload-diagnostics-to-weka-home](../../support/diagnostics-management/diagnostics-utility.md#upload-diagnostics-to-weka-home "mention")
