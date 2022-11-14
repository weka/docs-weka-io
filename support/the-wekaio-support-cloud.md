---
description: >-
  This page describes the Weka support cloud which is provided to improve the
  Weka support process.
---

# The Weka support cloud

## Weka Home

The Weka support cloud (Weka Home) collects events and statistics information from the Weka clusters in order to improve the support process. Consequently, it is highly recommended to enable the system to upload events and statistics to Weka Home, since this will enable the provision of proactive support if any irregularities are recognized in system behavior. Additionally, when troubleshooting, this enables the provision of better and quicker responses from the [Customer Success Team](getting-support-for-your-weka-system.md#contact-customer-success-team).

To enable the uploading of data to Weka Home, perform the following:

1. To enable [c](../install/bare-metal/using-cli.md#stage-4-enabling-cloud-event-notifications-optional)loud events and diagnostics information use `weka cloud enable` CLI command.
2. Make sure that your network allows the system to report events to Weka by allowing `https` connections from the Weka servers management IP interfaces to `api.home.weka.io` and `get.weka.io` . Alternatively, if connecting to the cloud using a proxy, it is possible to set the proxy using the following command:`weka cloud proxy --set <proxy_url>`.
3. [Install a valid commercial or evaluation license](../licensing/overview.md).  It is possible to receive a 30-day evaluation license from get.weka.io. To extend an evaluation license, contact Weka Sales or the [Customer Success Team](getting-support-for-your-weka-system.md#contact-customer-success-team).

{% hint style="info" %}
Optimally, both client and backend servers should be able to upload information to the Weka support cloud. If client connectivity cannot be configured, it is still advantageous to allow the backend servers to upload information.
{% endhint %}

## Weka Home private instance&#x20;

For proactive support, it is highly recommended to enable access to the public instance of Weka Home. However, in some situations - such as when working in dark sites or private VPCs - there is no connectivity to the public instance of Weka Home. In such cases, receipt of proper support requires at least a connection to a private instance of Weka Home, which can be installed in a private environment.

For installation and maintenance of a private instance of Weka Home, contact the the [Customer Success Team](getting-support-for-your-weka-system.md#contact-customer-success-team).

### Installation requirements

* CentOS 7.x, Amazon Linux 2 LTS
* 4 GB of RAM
* 20 GB of local storage available (not including the OS/base install)
* Version 3.6 or later of the Weka cluster software
* Open port 8000 from the Weka cluster to the private Weka Home instance
* Root access on the instance for the [Customer Success Team ](getting-support-for-your-weka-system.md#contact-customer-success-team)to install, run and manage the private Weka Home instance
