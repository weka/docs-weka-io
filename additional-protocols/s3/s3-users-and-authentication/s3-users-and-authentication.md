---
description: >-
  Manage S3 IAM policies, credentials, and temporary security tokens using the
  CLI.
---

# Manage S3 users and authentication using the CLI

## View existing IAM policies

**Command:** `weka s3 policy list`

Use this command to list the existing IAM policies.

The command lists the pre-defined and custom policies the Cluster Admin has added.

**Command:** `weka s3 policy show <policy-name>`

Use this command to see the JSON definition of the selected IAM policy.

The pre-defined policy values are:

{% tabs %}
{% tab title="readonly" %}
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListAllMyBuckets",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:ListMultipartUploadParts",
        "s3:GetBucketLocation",
        "s3:GetBucketPolicy",
        "s3:GetBucketTagging",
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::*"
      ]
    }
  ]
}
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

**Command:** `weka s3 policy add`

Use the following command line to add an S3 IAM policy:

`weka s3 policy add <policy-name> <policy-file>`

**Parameters**

| Name            | Value                                                                                                          |
| --------------- | -------------------------------------------------------------------------------------------------------------- |
| `policy-name`\* | Name of the IAM policy to add.                                                                                 |
| `policy-file`\* | Path to the custom JSON file representing an IAM policy for anonymous access.See #supported-s3-policy-actions. |

## Delete an IAM policy <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy remove`

Use the following command line to delete an S3 IAM policy:‌

`weka s3 policy remove <policy-name>`‌

**Parameters**

| Name            | Value                             |
| --------------- | --------------------------------- |
| `policy-name`\* | Name of the IAM policy to remove. |

## Attach a policy to an S3 user <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy attach`

Use the following command line to attach an IAM policy to an S3 user:‌

`weka s3 policy attach <policy> <user>`‌

**Parameters**

| Name       | Value                           |
| ---------- | ------------------------------- |
| `policy`\* | Name of an existing IAM policy. |
| `user`\*   | Name of a local WEKA S3 user.   |

If the user does not already have S3 credentials, the system creates them automatically when the policy is attached. The secret key is displayed once and must be saved immediately.

**Example**

```bash
weka s3 policy attach readwrite alice
```

## Detach a policy from an S3 user <a href="#creating-a-new-iam-policies-1" id="creating-a-new-iam-policies-1"></a>

**Command:** `weka s3 policy detach`

Use the following command line to detach an IAM policy from an S3 user:‌‌

`weka s3 policy detach <policy> <user>`‌‌

**Parameters**

| Name       | Description                       |
| ---------- | --------------------------------- |
| `policy`\* | Name of the IAM policy to detach. |
| `user`\*   | Name of a local WEKA S3 user.     |

Detaching a policy removes S3 data access, but keeps the existing S3 access key and secret key. If you later attach any S3 policy again, the same key pair is used.

**Example**

```bash
weka s3 policy detach readwrite alice
```

## Manage S3 credentials

Manage S3 API credentials separately from the WEKA account password.

### Regenerate your own S3 credentials

**Command:** `weka s3 user keys-generate`

Use this command to regenerate your own S3 access key and secret key.

```bash
weka s3 user keys-generate
```

### Regenerate S3 credentials for another user

**Command:** `weka s3 user keys-generate --user <username>`

Use this command as an administrator to regenerate credentials for a specific user.

```bash
weka s3 user keys-generate --user alice
```

Behavioral notes:

* Attaching an S3 policy grants S3 access and auto-creates credentials if needed.
* Detaching an S3 policy removes S3 access, but preserves the credentials.
* Each S3 access key includes the tenant identifier for correct multi-tenant routing.

If the user has no attached S3 policy, the command fails:

```
error: S3 API credentials can only be generated for users with an S3 policy attached.
```

## Generate a temporary security token

**Command:** `weka s3 sts assume-role`

Use the following command line to generate a temporary security token:

`weka s3 sts assume-role <--access-key access-key> [--secret-key secret-key] [--policy-file policy-file] <--duration duration>`

**Parameters**

| Name           | Description                                                                                                                                                                                                                                  | Default                                                        |
| -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------- |
| `access-key`\* | A local WEKA S3 user access key                                                                                                                                                                                                              |                                                                |
| `secret-key`   | A local WEKA S3 user secret key                                                                                                                                                                                                              | If not supplied, the command prompts to supply the secret-key. |
| `policy-file`  | Path to a custom JSON file representing an IAM policy for anonymous access.You cannot gain additional capabilities to the IAM policy attached to this S3 user.See [Supported Policy Actions](../s3-limitations.md#supported-policy-actions). | ​                                                              |
| `duration`\*   | Duration for the token validity.Possible values between 15 minutes and 1 week. Format: `900s`, `60m`, `2d`, `1w`                                                                                                                             | ​                                                              |

An example response:

```
Access-Key: JR9O0U6V42KLPFQDO2Z3
Secret-Key: wM0Q.............VPmRsKbH
Session-Token: eyJhbGciOiJI........Pa10YBHseh4DkVA
```
