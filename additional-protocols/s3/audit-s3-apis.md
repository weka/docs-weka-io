---
description: This page describes how to set up an HTTP webhook for S3  audit purposes.
---

# Audit S3 APIs

## Overview

S3 API calls can generate JSON events that many webhook target applications can receive as a stream of events and use them for auditing and analysis purposes. Such applications (see Splunk example below) should be configured to accept the events stream and provide it with an authentication token.&#x20;

Enabling an audit webhook comes instead of the `BucketLogging` S3 APIs and follows a similar best-effort nature. The purpose of these audit logs is to give an idea of the nature of traffic.

{% hint style="info" %}
**Note:** In the event of a disconnection from the webhook application, or if the S3 clusters' internal events buffer fills up, events will get thrown away. It is advised to monitor the external webhook target application's availability.
{% endhint %}

## Managing S3 Audit in Weka

### Enabling an Audit Webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook enable`

Use the following command line to enable an audit webhook for the S3 cluster:

`weka s3 cluster audit-webhook enable <--endpoint endpoint>  <--auth-token auth-token>`

**Parameters in Command Line**

| **Name**     | **Type** | **Value**                                                  | **Limitations** | **Mandatory** | **Default** |
| ------------ | -------- | ---------------------------------------------------------- | --------------- | ------------- | ----------- |
| `endpoint`   | String   | The webhook endpoint                                       | None            | Yes           |             |
| `auth-token` | Boolean  | The authentication token obtained from the webhook service | None            | Yes           |             |

### Disabling an Audit Webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook disable`

Use this command to disable the audit webhook.

### View the Audit Webhook Configuration

**Command:** `weka s3 cluster audit-webhook show`

Use this command to view the audit webhook configuration.

## Example: How to use Splunk to audit S3

Setting up an HTTP Event Collector (HEC)

### Step 1: Configuring the HEC

Follow the steps in [Enable HTTP Event Collector on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Enable\_HTTP\_Event\_Collector\_on\_Splunk\_Enterprise). Since the S3 event stream is provided in JSON  format, choose `_json` as the data source type.

### Step 2: Creating a Token

Follow the steps in [Create an Event Collector token on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Create\_an\_Event\_Collector\_token\_on\_Splunk\_Enterprise) to create a token that Weka will use to access the Splunk as HTTP webhook. You can create a new index or use an existing one for easy discovery/monitor/query.&#x20;

Make sure to copy the created token for later use.

### Step 3: Testing the Configuration

To make sure the configuration works, send a test event as suggested [here](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#JSON\_request\_and\_response).

```
curl -k  https://hec.example.com:8088/services/collector/raw -H "Authorization: Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0" -d '{"event": "hello world"}'
{"text": "Success", "code": 0}
```

Now you can search the index you've created in Splunk and see this event.

### Step 4: Configuring the audit-webhook in Weka

As a cluster admin, run the following CLI command to enable the audit webhook:

```
weka s3 cluster audit-webhook enable --endpoint=https://splunk-server:8088/services/collector/raw --auth-token='\"Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0\"'
```
