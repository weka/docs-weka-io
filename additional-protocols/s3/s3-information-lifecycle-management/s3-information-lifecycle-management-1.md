---
description: Create, view, and remove S3 bucket lifecycle rules using the CLI.
---

# Manage S3 lifecycle rules using the CLI

{% hint style="info" %}
In multi-tenant deployments, lifecycle rules are scoped to the tenant in which they are defined. Rules apply only to buckets owned by that tenant. The lifecycle crawler runs cluster-wide across all tenants automatically. No additional configuration is required per tenant.
{% endhint %}

## Add a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule add`

Use the following command line to add a lifecycle rule:

`weka s3 bucket lifecycle-rule add <bucket> <expiry-days> [--prefix prefix] [--tags tags]`

**Parameters**

<table><thead><tr><th width="189">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The S3 bucket name.</td></tr><tr><td><code>expiry-days</code>*</td><td>The minimum number of days before the object is eligible for expiration. ILM processes the object shortly after this period based on its modified timestamp, but processing may be delayed if the queue is long.<br>Minimum: 1 day</td></tr><tr><td><code>prefix</code></td><td><p>The object prefix to which the rule applies.</p><p>Wildcards are not supported.</p></td></tr><tr><td><code>tags</code></td><td>Key value pair of object tags to apply the rule to.<br>Pairs of key values: <code>'&#x3C;k1>=&#x3C;v1>&#x26;&#x3C;k2=&#x3C;v2>'</code></td></tr></tbody></table>

## View lifecycle rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing lifecycle rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters**

| Name       | Value               | Default  |
| ---------- | ------------------- | -------- |
| `bucket`\* | The S3 bucket name. | ​Content |

## Remove a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to remove an lifecycle rule of a specified bucket:

`weka s3 bucket lifecycle-rule remove <bucket> <name>`

**Parameters**

| Name       | Value               |
| ---------- | ------------------- |
| `bucket`\* | The S3 bucket name. |
| `name`\*   | The rule name.      |

## Remove all lifecycle rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to remove all the lifecycle rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters**

| Name       | Value               |
| ---------- | ------------------- |
| `bucket`\* | The S3 bucket name. |
