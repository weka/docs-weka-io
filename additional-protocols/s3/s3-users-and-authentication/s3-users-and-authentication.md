---
description: >-
  Manage S3 IAM policies, credentials, and temporary security tokens using the
  CLI.
---

# Manage S3 users and authentication using the CLI

## View existing IAM policies

Lists the IAM policies defined on the cluster.

**Command:** `weka s3 policy list`

```sh
weka s3 policy list
```

{% endtab %}

{% tab title="writeonly" %}
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::*"
      ]
    }
  ]
}
```
{% endtab %}

{% tab title="readwrite" %}
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::*"
      ]
    }
  ]
}
```
{% endtab %}
{% endtabs %}

## Add an IAM policy

Creates an IAM policy from a JSON document that defines the S3 actions and resources it grants.

**Command:** `weka s3 policy add`

```sh
weka s3 policy add <policy-name> <policy-file>
```

**Parameters**

| Parameter       | Description                     |
| --- | --- |
| `policy-name`\* | Name for the new policy. |
| `policy-file`\* | File containing policy content. |

## Delete an IAM policy

Deletes an IAM policy. Detach it from all users and groups first.

**Command:** `weka s3 policy remove`

```sh
weka s3 policy remove <policy-name>
```

**Parameters**

| Parameter       | Description                   |
| --- | --- |
| `policy-name`\* | Name of the policy to remove. |

## Attach a policy to an S3 user

Grants a policy to an S3 user or group.

**Command:** `weka s3 policy attach`

```sh
weka s3 policy attach <policy-name> [<user>] [--group <string>] [--user <string>]
```

**Parameters**

| Parameter           | Description                                                                 |
| --- | --- |
| `policy-name`\* | Name of the policy to attach. |
| `user` | User name to attach the policy to (alternative to --user). |
| `--group` \<string> | Group name to attach the policy to (mutually exclusive with --user). |

If the user does not already have S3 credentials, the system creates them automatically when the policy is attached. The secret key is displayed once and must be saved immediately.

**Example**

```bash
weka s3 policy attach readwrite alice
```

## Detach a policy from an S3 user

Revokes a policy from an S3 user or group.

**Command:** `weka s3 policy detach`

```sh
weka s3 policy detach [<user>] [--group <string>] [--user <string>]
```

**Parameters**

| Parameter           | Description                                                                   |
| --- | --- |
| `user` | User name to detach the policy from (alternative to --user). |
| `--group` \<string> | Group name to detach the policy from (mutually exclusive with --user). |

Detaching a policy removes S3 data access, but keeps the existing S3 access key and secret key. If you later attach any S3 policy again, the same key pair is used.

**Example**

```bash
weka s3 policy detach readwrite alice
```

## Manage S3 credentials

Manage S3 API credentials separately from the WEKA account password.

### Regenerate S3 credentials

Generates a new S3 access key and secret, invalidating the previous pair immediately. Without `--user` it rotates your own credentials; naming another user requires the Tenant Admin or Cluster Admin role.

**Command:** `weka s3 user keys-generate`

```sh
weka s3 user keys-generate [--user <string>]
```

**Parameters**

| Parameter          | Description |
| --- | --- |
| `--user` \<string> | Target S3 username for credential generation/rotation. Requires Tenant Admin or Cluster Admin role. |

## Generate a temporary security token

Issues short-lived S3 credentials through AWS STS AssumeRole, for applications that should not hold permanent keys.

**Command:** `weka s3 sts assume-role`

```sh
weka s3 sts assume-role --access-key <string> --duration <duration> [--policy-file <string>] [--secret-key <string>]
```

**Parameters**

| Parameter                  | Description                                                                             |
| --- | --- |
| `--access-key` \<string>\* | Access key. Essentially an S3 user name. |
| `--duration` \<duration>\* | Duration of the security token. |
| `--policy-file` \<string> | File containing JSON policy content. [Supported Policy Actions](../s3-limitations.md#supported-policy-actions) |
| `--secret-key` \<string> | Secret key for assumed role. Essentially an S3 user password. Prompted if not supplied. |

An example response:

```
Access-Key: JR9O0U6V42KLPFQDO2Z3
Secret-Key: wM0Q.............VPmRsKbH
Session-Token: eyJhbGciOiJI........Pa10YBHseh4DkVA
```
