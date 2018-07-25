# Uploading Events to the WekaIO Support Cloud

The WekaIO support cloud enables the provision of proactive support if any irregularities are identified in system behavior, as well as better and faster WekaIO response to troubleshooting issues.

To enable the upload of events to the WekaIO support cloud, perform the following:

1. Enable [cloud events](../install/bare-metal/untitled.md#stage-4-enabling-cloud-event-notifications-optional).
2. Make sure that your network allows the system to report events to WekaIO by allowing https connections from all Weka nodes \(both clients and backends\) management IP interfaces to `cloud.weka.io`, `*.s3.amazonaws.com` and `*.s3-*.amazonaws.com`
3. [Install a valid commercial or evaluation license](../licensing/overview.md). Contact the Weka sales or support team if an evaluation license is required.

