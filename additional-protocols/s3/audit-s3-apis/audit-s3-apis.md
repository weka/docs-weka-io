---
description: Configure and view an S3 API audit webhook using the CLI.
---

# Configure audit webhook using the CLI

## Enable an audit webhook for S3 APIs

Starts forwarding S3 API audit events to an external webhook endpoint.

**Command:** `weka s3 cluster audit-webhook enable`

```sh
weka s3 cluster audit-webhook enable --auth-token <string> --endpoint <string>
```

**Parameters**

| Parameter                  | Description                   |
| -------------------------- | ----------------------------- |
| `--auth-token` \<string>\* | Webhook authentication token. |
| `--endpoint` \<string>\* | Webhook endpoint URL. |

## Disable an audit webhook for S3 APIs

Stops forwarding S3 API audit events.

**Command:** `weka s3 cluster audit-webhook disable`

```sh
weka s3 cluster audit-webhook disable
```

## View the audit webhook configuration

Shows the current S3 audit webhook endpoint and its state.

**Command:** `weka s3 cluster audit-webhook show`

```sh
weka s3 cluster audit-webhook show
```
