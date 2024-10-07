---
description: >-
  This page describes how to set up an HTTP webhook for S3  audit purposes using
  the CLI.
---

# Configure audit webhook using the CLI

Using the CLI, you can:

* [Enable an audit webhook for S3 APIs](audit-s3-apis.md#enable-an-audit-webhook-for-s3-apis)
* [Disable an audit webhook for S3 APIs](audit-s3-apis.md#disable-an-audit-webhook-for-s3-apis)
* [View the audit webhook configuration](audit-s3-apis.md#view-the-audit-webhook-configuration)

## Enable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook enable`

Use the following command line to enable an audit webhook for the S3 cluster:

`weka s3 cluster audit-webhook enable <--endpoint endpoint>  <--auth-token auth-token>`

**Parameters**

<table><thead><tr><th width="239">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>endpoint</code>*</td><td>The webhook endpoint.</td></tr><tr><td><code>auth-token</code>*</td><td>The authentication token obtained from the webhook service.</td></tr></tbody></table>

## Disable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook disable`

Use this command to disable the audit webhook.

## View the audit webhook configuration

**Command:** `weka s3 cluster audit-webhook show`

Use this command to view the audit webhook configuration.
