---
description: >-
  This page describes how to gain and obtain access permissions to the S3
  protocol using the CLI.
---

# Manage S3 users and authentication using the CLI

With the CLI, you can:

* [View existing IAM policies](s3-users-and-authentication.md#view-existing-iam-policies)
* [Add an IAM policy](s3-users-and-authentication.md#create-an-iam-policy)
* [Delete an IAM policy](s3-users-and-authentication.md#creating-a-new-iam-policies)
* [Attach a policy to an S3 user](s3-users-and-authentication.md#creating-a-new-iam-policies-1)
* [Detach a policy from an S3 user](s3-users-and-authentication.md#creating-a-new-iam-policies-1-1)
* [Generate a temporary security token](s3-users-and-authentication.md#generate-a-temporary-security-token)

## View existing IAM policies

**Command:** `weka s3 policy list`

Use this command to list the existing IAM policies.

The command lists both the pre-defined policies and custom policies that the Cluster Admin has added.

**Command:** `weka s3 policy show <policy-name>`

Use this command to see the JSON definition of the selected IAM policy.

The pre-defined policies value are:

{% tabs %}
{% tab title="readonly" %}
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetBucketLocation",
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
```
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
```
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

| **Name**      | **Type** | **Value**                                                    | **Limitations**                                                                                                                                                                         | **Mandatory** | **Default** |
| ------------- | -------- | ------------------------------------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `policy-name` | String   | The name of the IAM policy to add                            |                                                                                                                                                                                         | Yes           |             |
| `policy-file` | String   | A path to the custom policy JSON file for anonymous access.  | <p>A JSON file representing an IAM policy. </p><p>For supported actions, refer to the <a href="../s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section.</p> | Yes           |             |

## Delete an IAM policy <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy remove`

Use the following command line to delete an S3 IAM policy:‌

`weka s3 policy remove <policy-name>`‌

**Parameters**

| **Name**      | **Type** | **Value**                             | **Limitations** | **Mandatory** | **Default** |
| ------------- | -------- | ------------------------------------- | --------------- | ------------- | ----------- |
| `policy-name` | String   | The name of the IAM policy to  remove | ​               | Yes           | ​           |

## Attach a policy to an S3 user <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy attach`

Use the following command line to attach an IAM policy to an S3 user:‌

`weka s3 policy attach <policy> <user>`‌

**Parameters**

| **Name** | **Type** | **Value**                          | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------------------------------- | --------------- | ------------- | ----------- |
| `policy` | String   | The name of an existing IAM policy | ​               | Yes           | ​           |
| `user`   | String   | The name of an existing S3 user    |                 | Yes           | ​           |

## Detach a policy from an S3 user <a href="#creating-a-new-iam-policies-1" id="creating-a-new-iam-policies-1"></a>

**Command:** `weka s3 policy detach`

Use the following command line to detach an IAM policy from an S3 user:‌‌

`weka s3 policy detach <user>`‌‌

**Parameters**

| **Name** | **Type** | **Value**                       | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------------- | --------------- | ------------- | ----------- |
| `user`   | String   | The name of an existing S3 user | ​               | Yes           | ​           |

## Generate a temporary security token

**Command:** `weka s3 sts assume-role`

Use the following command line to generate a temporary security token:

`weka s3 sts assume-role <--access-key access-key> [--secret-key secret-key] [--policy-file policy-file] <--duration duration>`

**Parameters**

| **Name**      | **Type** | **Value**                                                  | **Limitations**                                                                                                                                                                                                                                                             | **Mandatory** | **Default**                                                       |
| ------------- | -------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------------------------------------------------------------- |
| `access-key`  | String   | An S3 user access key                                      |                                                                                                                                                                                                                                                                             | Yes           |                                                                   |
| `secret-key`  | String   | An S3 user secret key                                      |                                                                                                                                                                                                                                                                             | No            | If not supplied, the command will prompt to supply the secret-key |
| `policy-file` | String   | A path to a custom policy JSON file for anonymous access.  | <p>A JSON file representing an IAM policy. </p><p>For supported actions, refer to the <a href="../s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section. You cannot gain additional capabilities to the IAM policy attached to this S3 user.</p> | No            | ​                                                                 |
| `duration`    | String   | Duration for the token validity                            | Between 15 minutes and 1 week. Format: `900s`, `60m`, `2d`, `1w`                                                                                                                                                                                                            | Yes           | ​                                                                 |

An example response:

```
Access-Key: JR9O0U6V42KLPFQDO2Z3
Secret-Key: wM0QMWuQ04WHlByj2SlEyuNrWoliMaCoVPmRsKbH
Session-Token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiJKUjlPMFU2VjQyS0xQRlFETzJaMyIsImV4cCI6NjA0ODAwMDAwMDAwMDAwLCJwb2xpY3kiOiJyZWFkd3JpdGUifQ.-rzf78OHdKv-25NFls1SaUvNKST5SoVSG8iR2hQrTQC1K05ZZlHBFfU-6N3_boF9c5P70y5Pa10YBHseh4DkVA
```
