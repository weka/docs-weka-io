---
description: This page describes how to set up an HTTP webhook for S3  audit purposes.
---

# Audit S3 APIs

S3 API calls can generate JSON events that webhook target applications can receive as a stream of events and for auditing and analysis purposes. Webhook applications, such as Splunk, must be configured to accept the events stream and provide it with an authentication token.

Enabling an audit webhook comes instead of the `BucketLogging` S3 APIs. The purpose of the audit logs is to indicate the nature of traffic.

{% hint style="info" %}
**Note:** If Weka disconnects from the webhook application or the S3 clusters' internal events buffer fills up, events are thrown away. It is recommended to monitor the external webhook target application's availability.
{% endhint %}



**Related topics**

[audit-s3-apis.md](audit-s3-apis.md "mention")

[audit-s3-apis-1.md](audit-s3-apis-1.md "mention")
