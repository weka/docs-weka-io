---
description: >-
  This page describes how to manage information lifecycle (ILM) rules for S3
  buckets using the CLI.
---

# Manage S3 lifecycle rules using the CLI

Using the CLI, you can:

* [Add a lifecycle rule](s3-information-lifecycle-management-1.md#create-an-ilm-rule)
* [View lifecycle rules](s3-information-lifecycle-management-1.md#viewing-ilm-rules)
* [Delete a lifecycle rule](s3-information-lifecycle-management-1.md#delete-an-ilm-rule)
* [Reset the lifecycle rules of a bucket](s3-information-lifecycle-management-1.md#reset-ilm-rules-of-a-bucket)

## Add a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule add`

Use the following command line to add a lifecycle rule:

`weka s3 bucket lifecycle-rule add <bucket> <expiry-days>  [--prefix prefix] [--tags tags]`

**Parameters**

| **Name**      | **Type** | **Value**                                            | **Limitations**                             | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------------------------- | ------------------------------------------- | ------------- | ----------- |
| `bucket`      | String   | The name of the S3 bucket                            |                                             | Yes           |             |
| `expiry-days` | Number   | The number of days to wait before expiring an object | Minimum of 1 day                            | Yes           |             |
| `prefix`      | String   | The prefix of objects to apply the rule to           |                                             | No            |             |
| `tags`        | String   | Key value pair of object tags to apply the rule to   | Pairs of key values: `'<k1>=<v1>&<k2=<v2>'` | No            |             |

{% hint style="info" %}
**Note:** The `expiry-days` is the minimum time to wait before expiring an object. In extreme load and scale cases, it might take longer than `expiry-days` to delete an object.
{% endhint %}

## View lifecycle rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing lifecycle rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters**

| **Name** | **Type** | **Value**                 | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket | ​Content        | Yes           | ​Content    |

## Remove a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to remove an lifecycle rule of a specified bucket:

`weka s3 bucket lifecycle-rule remove <bucket> <rule>`

**Parameters**

| **Name** | **Type** | **Value**                    | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket    |                 | Yes           |             |
| `rule`   | String   | The ID of the rule to delete |                 | Yes           |             |

## Remove all lifecycle rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to remove all the lifecycle rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters**

| **Name** | **Type** | **Value**                 | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------- | --------------- | ------------- | ----------- |
| `bucket` | String   | The name of the S3 bucket |                 | Yes           |             |
