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

<table><thead><tr><th width="237">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>policy-name</code>*</td><td>Name of the IAM policy to add.</td></tr><tr><td><code>policy-file</code>*</td><td>Path to the custom JSON file representing an IAM policy for anonymous access. <br>See  <a data-mention href="../s3-limitations.md#supported-s3-policy-actions">#supported-s3-policy-actions</a>.</td></tr></tbody></table>

## Delete an IAM policy <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy remove`

Use the following command line to delete an S3 IAM policy:‌

`weka s3 policy remove <policy-name>`‌

**Parameters**

<table><thead><tr><th width="241">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>policy-name</code>*</td><td>Name of the IAM policy to  remove.</td></tr></tbody></table>

## Attach a policy to an S3 user <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 policy attach`

Use the following command line to attach an IAM policy to an S3 user:‌

`weka s3 policy attach <policy> <user>`‌

**Parameters**

<table><thead><tr><th width="248">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>policy</code>*</td><td>Name of an existing IAM policy.</td></tr><tr><td><code>user</code>*</td><td>Name of an existing S3 user.</td></tr></tbody></table>

## Detach a policy from an S3 user <a href="#creating-a-new-iam-policies-1" id="creating-a-new-iam-policies-1"></a>

**Command:** `weka s3 policy detach`

Use the following command line to detach an IAM policy from an S3 user:‌‌

`weka s3 policy detach <user>`‌‌

**Parameters**

<table><thead><tr><th width="247">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>user</code>*</td><td>Name of an existing S3 user.</td></tr></tbody></table>

## Generate a temporary security token

**Command:** `weka s3 sts assume-role`

Use the following command line to generate a temporary security token:

`weka s3 sts assume-role <--access-key access-key> [--secret-key secret-key] [--policy-file policy-file] <--duration duration>`

**Parameters**

<table><thead><tr><th width="186">Name</th><th width="349">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>access-key</code>*</td><td>An S3 user access key</td><td></td></tr><tr><td><code>secret-key</code></td><td>An S3 user secret key</td><td>If not supplied, the command prompts to supply the secret-key.</td></tr><tr><td><code>policy-file</code></td><td>Path to a custom JSON file representing an IAM policy for anonymous access.<br>You cannot gain additional capabilities to the IAM policy attached to this S3 user.<br>See <a href="../s3-limitations.md#supported-policy-actions">Supported Policy Actions</a>. </td><td>​</td></tr><tr><td><code>duration</code>*</td><td>Duration for the token validity.<br>Possible values between 15 minutes and 1 week. Format: <code>900s</code>, <code>60m</code>, <code>2d</code>, <code>1w</code></td><td>​</td></tr></tbody></table>

An example response:

```
Access-Key: JR9O0U6V42KLPFQDO2Z3
Secret-Key: wM0QMWuQ04WHlByj2SlEyuNrWoliMaCoVPmRsKbH
Session-Token: eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiJKUjlPMFU2VjQyS0xQRlFETzJaMyIsImV4cCI6NjA0ODAwMDAwMDAwMDAwLCJwb2xpY3kiOiJyZWFkd3JpdGUifQ.-rzf78OHdKv-25NFls1SaUvNKST5SoVSG8iR2hQrTQC1K05ZZlHBFfU-6N3_boF9c5P70y5Pa10YBHseh4DkVA
```
