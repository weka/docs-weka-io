# The WekaIO Support Cloud

The WekaIO support cloud collects event information from the WekaIO clusters in order to improve the support process. It is highly recommended to enable the system to upload events to the WekaIO support cloud. This will enable the provision of proactive support if any irregularities are recognized in system behavior. Additionally, in cases of troubleshooting, this enables the provision of better and quicker response from WekaIO.

To enable the upload of events to the WekaIO support cloud, perform the following:

1. Enable [cloud events](../install/bare-metal/using-cli.md#stage-4-enabling-cloud-event-notifications-optional).
2. Make sure that your network allows the system to report events to WekaIO by allowing `https` connections from the WekaIO hosts management IP interfaces to `cloud.weka.io`, `*.s3.amazonaws.com` and `*.s3-*.amazonaws.com` . Alternatively, if connecting to the cloud using a proxy, it is possible to set the proxy using the following command:`weka cloud proxy --set <proxy_url>`.
3. [Install a valid commercial or evaluation license](../licensing/overview.md).  It is possible to receive a 30-day evaluation license from get.weka.io. To extend an evaluation license, contact the WekaIO Sales or Support Team.

{% hint style="info" %}
Optimally, both client and backend hosts should be able to upload information to the support cloud. If client connectivity cannot be configured, it is still advantageous to allow the backend hosts to upload events.
{% endhint %}



