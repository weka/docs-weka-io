---
description: This page describes an example for using Splunk to audit S3.
---

# Example: How to use Splunk to audit S3

Setting up an HTTP Event Collector (HEC).

#### Step 1: Configure the HEC

Follow the steps in [Enable HTTP Event Collector on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Enable\_HTTP\_Event\_Collector\_on\_Splunk\_Enterprise). Since the S3 event stream is provided in JSON  format, choose `_json` as the data source type.

#### Step 2: Create a token

Follow the steps in [Create an Event Collector token on Splunk](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#Create\_an\_Event\_Collector\_token\_on\_Splunk\_Enterprise) to create a token WEKA will use to access Splunk as an HTTP webhook. You can create a new index or use an existing one for easy discovery/monitor/query.&#x20;

Copy the created token for later use.

#### Step 3: Test the configuration

To validate the configuration, send a test event as suggested in the [JSON request and response](https://docs.splunk.com/Documentation/Splunk/8.0.3/Data/UsetheHTTPEventCollector#JSON\_request\_and\_response) section.

```
curl -k  https://hec.example.com:8088/services/collector/raw -H "Authorization: Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0" -d '{"event": "hello world"}'
{"text": "Success", "code": 0}
```

Once completed, you can search the index you have created in Splunk and see this event.

#### Step 4: Configure the audit webhook in WEKA

As a cluster admin, run the following CLI command to enable the audit webhook:

```
weka s3 cluster audit-webhook enable --endpoint=https://splunk-server:8088/services/collector/raw --auth-token='\"Splunk B5A79AAD-D822-46CC-80D1-819F80D7BFB0\"'
```
