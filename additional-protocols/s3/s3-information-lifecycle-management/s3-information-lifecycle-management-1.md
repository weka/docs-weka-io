---
description: >-
  This page describes how to manage information lifecycle (ILM) rules for S3
  buckets using the CLI.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-information-lifecycle-management/s3-information-lifecycle-management-1
---

# Manage S3 lifecycle rules using the CLI

Using the CLI, you can:

* [Add a lifecycle rule](s3-information-lifecycle-management-1.md#create-an-ilm-rule)
* [Expire noncurrent object versions](s3-information-lifecycle-management-1.md#expire-noncurrent-object-versions)
* [View lifecycle rules](s3-information-lifecycle-management-1.md#viewing-ilm-rules)
* [Remove a lifecycle rule](s3-information-lifecycle-management-1.md#remove-a-lifecycle-rule)
* [Reset the lifecycle rules of a bucket](s3-information-lifecycle-management-1.md#reset-ilm-rules-of-a-bucket)

{% hint style="info" %}
In multi-tenant deployments, lifecycle rules are scoped to the tenant in which they are defined. Rules apply only to buckets owned by that tenant. The lifecycle crawler runs cluster-wide across all tenants automatically. No additional configuration is required per tenant.
{% endhint %}

## Add a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule add`

Use the following command line to add a lifecycle rule:

`weka s3 bucket lifecycle-rule add <bucket> <expiry-days> [--noncurrent] [--prefix prefix] [--tags tags]`

**Parameters**

<table><thead><tr><th width="189">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The S3 bucket name.</td></tr><tr><td><code>expiry-days</code>*</td><td>The minimum number of days before the object is eligible for expiration. ILM processes the object shortly after this period based on its modified timestamp, but processing may be delayed if the queue is long.<br>Minimum: 1 day</td></tr><tr><td><code>noncurrent</code></td><td>Apply the expiry to noncurrent object versions only, leaving the current version of each object in place.</td></tr><tr><td><code>prefix</code></td><td><p>The object prefix to which the rule applies.</p><p>Wildcards are not supported.</p></td></tr><tr><td><code>tags</code></td><td>Key value pair of object tags to apply the rule to.<br>Pairs of key values: <code>'&#x3C;k1>=&#x3C;v1>&#x26;&#x3C;k2=&#x3C;v2>'</code></td></tr></tbody></table>

## Expire noncurrent object versions

A versioned bucket retains every earlier version of an object. Those versions consume capacity until a lifecycle rule expires them, and no rule expires them by default.

A rule created with `--noncurrent` applies only to earlier versions and leaves the current version of each object in place. A rule created without it applies to current versions.

Two alerts identify a versioned bucket that lacks this cleanup:

<table><thead><tr><th width="330">Alert</th><th>Meaning</th></tr></thead><tbody><tr><td><code>S3VersioningNoNoncurrentExpirationRule</code></td><td>The bucket uses versioning but has no noncurrent version expiration rule.</td></tr><tr><td><code>S3VersioningNoDataservIlm</code></td><td>The bucket uses versioning, but no active Data Services container has lifecycle management configured.</td></tr></tbody></table>

**Example: expire noncurrent versions after 30 days**

1. Enable the S3 lifecycle task manager.

    ```bash
    weka dataservice s3-lifecycle-task enable
    ```
2. Add the rule to the versioned bucket.

    ```bash
    weka s3 bucket lifecycle-rule add bucket1 30 --noncurrent
    ```
3. Confirm the rule. The `Noncurrent` column reads `true`.

    ```bash
    weka s3 bucket lifecycle-rule list bucket1
    ```

## View lifecycle rules <a href="#viewing-ilm-rules" id="viewing-ilm-rules"></a>

**Command:** `weka s3 bucket lifecycle-rule list`‌

Use the following command line to view a bucket's existing lifecycle rules:‌

`weka s3 bucket lifecycle-rule list <bucket>`‌

**Parameters**

<table><thead><tr><th width="195">Name</th><th width="327">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The S3 bucket name.</td><td>​Content</td></tr></tbody></table>

## Remove a lifecycle rule

**Command:** `weka s3 bucket lifecycle-rule remove`

Use the following command line to remove an lifecycle rule of a specified bucket:

`weka s3 bucket lifecycle-rule remove <bucket> <name>`

**Parameters**

<table><thead><tr><th width="204">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The S3 bucket name.</td></tr><tr><td><code>name</code>*</td><td>The rule name.</td></tr></tbody></table>

## Remove all lifecycle rules

**Command:** `weka s3 bucket lifecycle-rule reset`

Use the following command line to remove all the lifecycle rules of a specified bucket:

`weka s3 bucket lifecycle-rule reset <bucket>`

**Parameters**

<table><thead><tr><th width="209">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket</code>*</td><td>The S3 bucket name.</td></tr></tbody></table>
