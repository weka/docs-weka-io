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

| Name            | Value                                                                                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bucket`\*      | Name of the S3 bucket.                                                                                                                                                                                     |
| `expiry-days`\* | <p>The minimum time to wait before expiring an object.<br>In extreme load and scale cases, it might take longer than the set value in  <code>expiry-days</code> to delete an object.<br>Minimum: 1 day</p> |
| `prefix`        | Prefix of objects to apply the rule to.                                                                                                                                                                    |
| `tags`          | <p>Key value pair of object tags to apply the rule to.<br>Pairs of key values: <code>'&#x3C;k1>=&#x3C;v1>&#x26;&#x3C;k2=&#x3C;v2>'</code></p>                                                              |

## View lifecycle rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing lifecycle rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters**

| Name       | Value                      | Default  |
| ---------- | -------------------------- | -------- |
| `bucket`\* | The name of the S3 bucket. | ​Content |

## Remove a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to remove an lifecycle rule of a specified bucket:

`weka s3 bucket lifecycle-rule remove <bucket> <rule>`

**Parameters**

| Name       | Value                         |
| ---------- | ----------------------------- |
| `bucket`\* | The name of the S3 bucket.    |
| `rule`\*   | The ID of the rule to delete. |

## Remove all lifecycle rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to remove all the lifecycle rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters**

| Name       | Value                      |
| ---------- | -------------------------- |
| `bucket`\* | The name of the S3 bucket. |
