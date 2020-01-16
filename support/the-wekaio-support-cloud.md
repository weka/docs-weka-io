---
description: >-
  This page describes the WekaIO support cloud which is provided to improve the
  WekaIO support process.
---

# The WekaIO Support Cloud

## Weka Home

The WekaIO support cloud \(Weka Home\) collects event information from the WekaIO clusters in order to improve the support process. Consequently, it is highly recommended to enable the system to upload events to Weka Home, since this will enable the provision of proactive support if any irregularities are recognized in system behavior. Additionally, when troubleshooting, this enables the provision of better and quicker response from the WekaIO Support Team.

To enable the uploading of events to Weka Home, perform the following:

1. Enable [cloud events](../install/bare-metal/using-cli.md#stage-4-enabling-cloud-event-notifications-optional).
2. Make sure that your network allows the system to report events to WekaIO by allowing `https` connections from the WekaIO hosts management IP interfaces to `api.home.weka.io`, `cloud.weka.io`, `*.s3.amazonaws.com` and `*.s3-*.amazonaws.com` . Alternatively, if connecting to the cloud using a proxy, it is possible to set the proxy using the following command:`weka cloud proxy --set <proxy_url>`.
3. [Install a valid commercial or evaluation license](../licensing/overview.md).  It is possible to receive a 30-day evaluation license from get.weka.io. To extend an evaluation license, contact the WekaIO Sales or Support Team.

{% hint style="info" %}
Optimally, both client and backend hosts should be able to upload information to the support cloud. If client connectivity cannot be configured, it is still advantageous to allow the backend hosts to upload events.
{% endhint %}

## Private Instance of Weka Home

For proactive support, it is highly recommended to enable access to the public instance of Weka Home. However, in some situations - such as when working in dark sites or private VPCs - there is no connectivity to the public instance of Weka Home. In such cases, receipt of proper support requires at least connection to a private instance of Weka Home, which can be installed in the private environment. 

For installation and maintenance of a private instance of Weka Home, contact the WekaIO Support Team.

### Requirements for Installation

* CentOS 7.x, Amazon Linux 2 LTS
* 4 GB of RAM
* 20 GB of local storage available \(not including the OS/base install\)
* Version 3.6 or later of the WekaIO cluster software
* Open port 8000 from the WekaIO cluster to the private Weka Home instance
* Root access on the instance for WekaIO Support Team to install, run and manage the private Weka Home instance



