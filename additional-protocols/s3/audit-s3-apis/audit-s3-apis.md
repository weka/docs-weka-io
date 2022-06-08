---
description: >-
  This page describes how to set up an HTTP webhook for S3  audit purposes using
  the CLI.
---

# Manage S3 audit in Weka using the CLI

Using the CLI, you can:

* [Enable an audit webhook for S3 APIs](audit-s3-apis.md#enable-an-audit-webhook-for-s3-apis)
* [Disable an audit webhook for S3 APIs](audit-s3-apis.md#disable-an-audit-webhook-for-s3-apis)
* [View the audit webhook configuration](audit-s3-apis.md#view-the-audit-webhook-configuration)

## Enable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook enable`

Use the following command line to enable an audit webhook for the S3 cluster:

`weka s3 cluster audit-webhook enable <--endpoint endpoint>  <--auth-token auth-token>`

**Parameters**

| **Name**     | **Type** | **Value**                                                  | **Limitations** | **Mandatory** | **Default** |
| ------------ | -------- | ---------------------------------------------------------- | --------------- | ------------- | ----------- |
| `endpoint`   | String   | The webhook endpoint                                       | None            | Yes           |             |
| `auth-token` | Boolean  | The authentication token obtained from the webhook service | None            | Yes           |             |

## Disable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook disable`

Use this command to disable the audit webhook.

## View the audit webhook configuration

**Command:** `weka s3 cluster audit-webhook show`

Use this command to view the audit webhook configuration.
