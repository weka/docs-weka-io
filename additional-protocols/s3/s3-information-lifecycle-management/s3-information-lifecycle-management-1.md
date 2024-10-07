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

<table><thead><tr><th width="189">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>Name of the S3 bucket.</td></tr><tr><td><code>expiry-days</code>*</td><td>The minimum time to wait before expiring an object.<br>In extreme load and scale cases, it might take longer than the set value in  <code>expiry-days</code> to delete an object.<br>Minimum: 1 day</td></tr><tr><td><code>prefix</code></td><td>Prefix of objects to apply the rule to.</td></tr><tr><td><code>tags</code></td><td>Key value pair of object tags to apply the rule to.<br>Pairs of key values: <code>'&#x3C;k1>=&#x3C;v1>&#x26;&#x3C;k2=&#x3C;v2>'</code></td></tr></tbody></table>

## View lifecycle rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing lifecycle rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters**

<table><thead><tr><th width="195">Name</th><th width="327">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The name of the S3 bucket.</td><td>​Content</td></tr></tbody></table>

## Remove a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to remove an lifecycle rule of a specified bucket:

`weka s3 bucket lifecycle-rule remove <bucket> <rule>`

**Parameters**

<table><thead><tr><th width="204">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The name of the S3 bucket.</td></tr><tr><td><code>rule</code>*</td><td>The ID of the rule to delete.</td></tr></tbody></table>

## Remove all lifecycle rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to remove all the lifecycle rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters**

<table><thead><tr><th width="209">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The name of the S3 bucket.</td></tr></tbody></table>
