---
description: This page describes how to add and control S3 service accounts using the CLI.
---

# Manage S3 service accounts using the CLI

With the CLI, as an S3 user, you can:

* View S3 service accounts
* Add an S3 service account
* Show S3 service account details
* Remove an S3 service account

**Related topics**

[#s3-service-accounts](./#s3-service-accounts "mention")

## View existing S3 service accounts

**Command:** `weka s3 service-account list`

Use this command to list the existing S3 service accounts.

The command lists only the access keys of the S3 service accounts added by the S3 user.

## Add an S3 service account

**Command:** `weka s3 service-account add`

Use the following command line to add an S3 user account:

`weka s3 service-account add <policy-file>`

The system returns an access key and a secret key. If you do not specify a `policy-file`, the S3 service account inherits the IAM policy from the parent S3 user.

{% hint style="warning" %}
The secret key is visible **only once** when adding the S3 service account. You must save the secret key in a safe place for later use.
{% endhint %}

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th>Type</th><th width="168">Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>policy-file</code></td><td>String</td><td>The IAM policy file to attach to the S3 service account</td><td></td><td></td><td>Inherits the IAM policy from the parent S3 user</td></tr></tbody></table>



## Show an S3 service account details

**Command:** `weka s3 service-account show`

Use the following command line to display the policy details attached to the specified S3 service account:

`weka s3 service-account show <access-key>`

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th>Type</th><th width="168">Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>access-key</code></td><td>String</td><td>The access key of the S3 service account</td><td></td><td>Yes</td><td></td></tr></tbody></table>

## Remove S3 service account <a href="#creating-a-new-iam-policies" id="creating-a-new-iam-policies"></a>

**Command:** `weka s3 service-account remove`

Use the following command line to remove an S3 service account:‌

`weka s3 service-account remove <access-key>`‌

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th>Type</th><th width="168">Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>access-key</code></td><td>String</td><td>The access key of the S3 service account to remove</td><td></td><td>Yes</td><td></td></tr></tbody></table>
