---
description: This page describes how to define information lifecycle rules for S3 buckets.
---

# S3 Information Lifecycle Management

## Overview

For S3 buckets, it is possible to set information lifecycle rules to apply to the objects within the bucket. The ILM rules apply to the data within the bucket, no matter by which protocol it has been created.

### Rules Evaluation

Weka currently only supports rules for expiring objects and allows you to set different expirations per object prefix and tags. Up to 1000 rules per bucket are supported. If multiple rules are overlapping, the rule with the earliest expiration that applies for an object deletes this object from the bucket.

## Managing Rules

### Creating an ILM Rule

**Command:** `weka s3 bucket lifecycle-rule add`

Use the following command line to create an ILM rule:

`weka s3 bucket lifecycle-rule add <bucket> <expiry-days>  [--prefix prefix] [--tags tags]`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                            | **Limitations**                             | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------------------------- | ------------------------------------------- | ------------- | ----------- |
| `bucket`      | String   | The name of the S3 bucket                            |                                             | Yes           |             |
| `expiry-days` | Number   | The number of days to wait before expiring an object | Minimum of 1 day                            | Yes           |             |
| `prefix`      | String   | The prefix of objects to apply the rule to           |                                             | No            |             |
| `tags`        | String   | Key value pair of object tags to apply the rule to   | Pairs of key values: `'<k1>=<v1>&<k2=<v2>'` | No            |             |

{% hint style="info" %}
**Note:** The `expiry-days` is the minimum time to wait before expiring an object. In extreme load and scale cases, it might take longer than the `expiry-days` to delete an object.
{% endhint %}

### Viewing ILM Rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing ILM rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters in Command Line**

| **Name** | **Type** | **Value**                 | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket | ​Content        | Yes           | ​Content    |

### Deleting an ILM Rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to delete an ILM rule:

`weka s3 bucket lifecycle-rule remove <bucket> <rule>`

**Parameters in Command Line**

| **Name** | **Type** | **Value**                    | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket    |                 | Yes           |             |
| `rule`   | String   | The ID of the rule to delete |                 | Yes           |             |

### Resetting a Bucket's ILM Rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to delete all the ILM rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters in Command Line**

| **Name** | **Type** | **Value**                 | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket |                 | Yes           |             |
