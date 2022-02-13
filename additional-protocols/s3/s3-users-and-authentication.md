---
description: >-
  This page describes how to gain and obtain access permissions to the S3
  protocol.
---

# S3 Users and Authentication

## Overview

### S3 User Role

To access the Weka cluster through the S3 protocol, a user with an S3 user role must be created (see [Managing Users](../../usage/security/user-management.md#managing-users) for details on creating users in Weka). &#x20;

{% hint style="info" %}
**Note:** The S3 user name and password will serve as the S3 access key and secret key, respectively.&#x20;
{% endhint %}

### IAM Policy

Once an S3 user has been created, it cannot run any S3 command or API. The Cluster Admin must attach an IAM policy to allow this user to operate (within the policy limits).

A set of pre-defined policies can be attached to an S3 user, or new custom policies can be created and attached to an S3 user. To create a custom policy you can use [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html), and select `IAM Policy` as the policy type and `Amazon S3` as the AWS service.&#x20;

{% hint style="info" %}
**Note:** The IAM policy size is limited to 2KB. In case a larger policy is required, please contact the Weka Support Team.
{% endhint %}

### IAM Temporary Credentials (STS) - Assume Role

Once an S3 user is created and an IAM policy is attached, it is possible to gain temporary credentials to access the S3 API. This is done by calling the Assume Role command.

The result of calling the API is an access key, secret key, and session token tuple that can be used to access S3 APIs. The permissions for the temporary credentials will be the permissions induced by the user's IAM policy. Furthermore, it is possible to supply a different (with reduced capabilities only) IAM policy for the temporary credentials request.

{% hint style="info" %}
**Note:** some S3 clients and SDKs (e.g., [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)) support using the AssumeRole API automatically when provided with an access key and secret key pair. They will automatically generate and use new temporary credentials tuple when the previous one expires.
{% endhint %}

## Manage Users and Authentication

### Viewing Existing IAM Policies

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

### Creating an IAM Policy

**Command:** `weka s3 policy create`

Use the following command line to create an S3 IAM policy:

`weka s3 policy create <policy-name> <policy-file>`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                                  | **Limitations**                                                                                                                                                                      | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------- |
| `policy-name` | String   | The name of the new IAM policy                             |                                                                                                                                                                                      | Yes           |             |
| `policy-file` | String   | A path to a custom policy JSON file for anonymous access.  | <p>A JSON file representing an IAM policy. </p><p>For supported actions, refer to the <a href="s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section.</p> | Yes           |             |

### Deleting an IAM Policy <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy remove`

Use the following command line to delete an S3 IAM policy:‌

`weka s3 policy remove <policy-name>`‌

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                             | **Limitations** | **Mandatory** | **Default** |
| ------------- | -------- | ------------------------------------- | --------------- | ------------- | ----------- |
| `policy-name` | String   | The name of the IAM policy to  remove | ​               | Yes           | ​           |

### Attaching a Policy to an S3 User <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy attach`

Use the following command line to attach an IAM policy to an S3 user:‌

`weka s3 policy attach <policy> <user>`‌

**Parameters in Command Line**

| **Name** | **Type** | **Value**                          | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ---------------------------------- | --------------- | ------------- | ----------- |
| `policy` | String   | The name of an existing IAM policy | ​               | Yes           | ​           |
| `user`   | String   | The name of an existing S3 user    |                 | Yes           | ​           |

### Detaching a Policy to an S3 User <a href="#creating-a-new-iam-policies-1" id="creating-a-new-iam-policies-1"></a>

**Command:** `weka s3 policy detach`

Use the following command line to detach an IAM policy from an S3 user:‌‌

`weka s3 policy detach <user>`‌‌

**Parameters in Command Line**

| **Name** | **Type** | **Value**                       | **Limitations** | **Mandatory** | **Default** |
| -------- | -------- | ------------------------------- | --------------- | ------------- | ----------- |
| `user`   | String   | The name of an existing S3 user | ​               | Yes           | ​           |

### Generating a Temporary Security Token

**Command:** `weka s3 sts assume-role`

Use the following command line to generate a temporary security token:

`weka s3 sts assume-role <--access-key access-key> [--secret-key secret-key] [--policy-file policy-file] <--duration duration>`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                                  | **Limitations**                                                                                                                                                                                                                                                          | **Mandatory** | **Default**                                                       |
| ------------- | -------- | ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- | ----------------------------------------------------------------- |
| `access-key`  | String   | An S3 user access key                                      |                                                                                                                                                                                                                                                                          | Yes           |                                                                   |
| `secret-key`  | String   | An S3 user secret key                                      |                                                                                                                                                                                                                                                                          | No            | If not supplied, the command will prompt to supply the secret-key |
| `policy-file` | String   | A path to a custom policy JSON file for anonymous access.  | <p>A JSON file representing an IAM policy. </p><p>For supported actions, refer to the <a href="s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section. You cannot gain additional capabilities to the IAM policy attached to this S3 user.</p> | No            | ​                                                                 |
| `duration`    | String   | Duration for the token validity                            | Between 15 minutes and 1 week. Format: `900s`, `60m`, `2d`, `1w`                                                                                                                                                                                                         | Yes           | ​                                                                 |

An example response:

```
Access-Key: JR9O0U6V42KLPFQDO2Z3
Secret-Key: wM0QMWuQ04WHlByj2SlEyuNrWoliMaCoVPmRsKbH
Session-Token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiJKUjlPMFU2VjQyS0xQRlFETzJaMyIsImV4cCI6NjA0ODAwMDAwMDAwMDAwLCJwb2xpY3kiOiJyZWFkd3JpdGUifQ.-rzf78OHdKv-25NFls1SaUvNKST5SoVSG8iR2hQrTQC1K05ZZlHBFfU-6N3_boF9c5P70y5Pa10YBHseh4DkVA
```
