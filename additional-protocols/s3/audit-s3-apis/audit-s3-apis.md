---
description: Configure and view an S3 API audit webhook using the CLI.
---

# Configure audit webhook using the CLI

## Enable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook enable`

Use the following command line to enable an audit webhook for the S3 cluster:

`weka s3 cluster audit-webhook enable <--endpoint endpoint> <--auth-token auth-token>`

**Parameters**

| Name           | Value                                                       |
| -------------- | ----------------------------------------------------------- |
| `endpoint`\*   | The webhook endpoint.                                       |
| `auth-token`\* | The authentication token obtained from the webhook service. |

## Disable an audit webhook for S3 APIs

**Command:** `weka s3 cluster audit-webhook disable`

Use this command to disable the audit webhook.

## View the audit webhook configuration

**Command:** `weka s3 cluster audit-webhook show`

Use this command to view the audit webhook configuration.
