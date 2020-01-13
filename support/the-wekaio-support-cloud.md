# The WekaIO Support Cloud

## Weka Home

The WekaIO support cloud \(Weka Home\) collects event information from the WekaIO clusters in order to improve the support process. It is highly recommended to enable the system to upload events to Weka Home. This will enable the provision of proactive support if any irregularities are recognized in system behavior. Additionally, in cases of troubleshooting, this enables the provision of better and quicker response from the WekaIO support team.

To enable the upload of events to the Weka Home, perform the following:

1. Enable [cloud events](../install/bare-metal/using-cli.md#stage-4-enabling-cloud-event-notifications-optional).
2. Make sure that your network allows the system to report events to WekaIO by allowing `https` connections from the WekaIO hosts management IP interfaces to `api.home.weka.io`, `cloud.weka.io`, `*.s3.amazonaws.com` and `*.s3-*.amazonaws.com` . Alternatively, if connecting to the cloud using a proxy, it is possible to set the proxy using the following command:`weka cloud proxy --set <proxy_url>`.
3. [Install a valid commercial or evaluation license](../licensing/overview.md).  It is possible to receive a 30-day evaluation license from get.weka.io. To extend an evaluation license, contact the WekaIO Sales or Support Team.

{% hint style="info" %}
Optimally, both client and backend hosts should be able to upload information to the support cloud. If client connectivity cannot be configured, it is still advantageous to allow the backend hosts to upload events.
{% endhint %}

### Private Instance of Weka Home

For proactive support, it is highly recommended to enable access to the public instance of Weka Home. However, there are situations where there is no connectivity to the public instance of Weka Home \(e.g., when working in dark sites, or private VPCs\). If such a need arises, in order to be able to get proper support, it is important to at least connect to a private instance of Weka Home, which can be installed in the private environment. 

{% hint style="success" %}
**Note:** For installation and maintenance of the private instance of Weka Home If such a need arise, please contact the WekaIO Support Team.
{% endhint %}

#### Requirements for Installation

* CentOS 7.x, Amazon Linux 2 LTS
* 4 GB of RAM
* 20 GB of local storage available \(not including the OS/base install\)

{% hint style="info" %}
**Note:** The private instance of Weka Home requires version 3.6 or later of the WekaIO cluster software.
{% endhint %}

