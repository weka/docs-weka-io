---
description: This page describes how to set up an HTTP webhook for S3  audit purposes.
---

# Audit S3 APIs

## Overview

S3 API calls can generate JSON events that many applications can receive as a stream of events and use them for auditing and analysis purposes. Such applications \(see Splunk example below\) should be configured to accept the events stream and provide it with an authentication token. 

If the application cannot receive the events, they are kept in the cluster until the connection to the application is back, and events are synced. 

{% hint style="info" %}
**Note:** Since we don't want to slow down the applications, events will get thrown if the internal buffer is filled.

The external webhook target application's liveness should be monitored.
{% endhint %}

## Managing S3 Audit in Weka

### Enabling an Audit Webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook enable`

Use the following command line to enable an audit webhook for the S3 cluster:

`weka s3 cluster audit-webhook enable <--endpoint endpoint>  <--auth-token auth-token>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `endpoint` | String | The webhook endpoint | None | Yes |  |
| `auth-token` | Boolean | The authentication token obtained from the webhook service | None | Yes |  |

### Disabling an Audit Webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook disable`

Use this command to disable the audit webhook.

### View the Audit Webhook Configuration

**Command:** `weka s3 cluster audit-webhook show`

Use this command to view the audit webhook configuration.

## Example: How to use Splunk to audit S3

Setting up an HTTP Event Collector \(HEC\)

### Step 1: Configuring the HEC

Follow the steps in [Enable HTTP Event Collector on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Enable_HTTP_Event_Collector_on_Splunk_Enterprise). Since the S3 event stream is provided in JSON  format, choose `_json` as the data source type.

### Step 2: Creating a Token

Follow the steps in [Create an Event Collector token on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Create_an_Event_Collector_token_on_Splunk_Enterprise) to create a token that Weka will use to access the Splunk as HTTP webhook. You can create a new index or use an existing one for easy discovery/monitor/query. 

Make sure to copy the created token for later use.

### Step 3: Testing the Configuration

To make sure the configuration works, send a test event as suggested [here](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#JSON_request_and_response).

```text
curl -k  https://hec.example.com:8088/services/collector/raw -H "Authorization: Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0" -d '{"event": "hello world"}'
{"text": "Success", "code": 0}
```

Now you can search the index you've created in Splunk and see this event.

### Step 4: Configuring the audit-webhook in Weka

As a cluster admin, run the following CLI command to enable the audit webhook:

```text
weka s3 cluster audit-webhook enable --endpoint=https://hec.example.com:8088/services/collector/raw --auth_token="\"Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0\""
```

