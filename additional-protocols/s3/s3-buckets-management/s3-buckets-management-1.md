---
description: This page describes how to manage S3 buckets using the CLI.
---

# Manage S3 buckets using the CLI

Using the CLI, you can:

* [Create a bucket](s3-buckets-management-1.md#add-a-bucket)
* [List buckets](s3-buckets-management-1.md#list-buckets)
* [Set a bucket quota](s3-buckets-management-1.md#set-a-bucket-quota)
* [Unset a bucket quota](s3-buckets-management-1.md#unset-a-bucket-quota)
* [Delete a bucket](s3-buckets-management-1.md#delete-a-bucket)
* [Manage bucket policies](s3-buckets-management-1.md#manage-bucket-policies)

## Create a bucket

**Command:** `weka s3 bucket create`

Use the following command line to create an S3 bucket:

`weka s3 bucket create <name> [--policy policy] [--policy-json policy-json] [--hard-quota hard-quota] [--fs-name fs-name] [--fs-id fs-id] [--existing-path existing-path]` &#x20;

**Parameters**

<table><thead><tr><th>Name</th><th width="329">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The name for the  S3 bucket to add.<br>Refer to the <a href="../s3-limitations.md#buckets">Bucket Naming Limitations</a> section.</td><td></td></tr><tr><td><code>policy</code></td><td>The name of a pre-defined bucket policy for anonymous access. <br>Possible values: <code>none</code>, <code>download</code>, <code>upload</code>, <code>public</code>.</td><td><code>none</code></td></tr><tr><td><code>policy-json</code></td><td>A path to a custom policy JSON file representing an S3 bucket policy for anonymous access.</td><td></td></tr><tr><td><code>hard-quota</code></td><td>Hard quota for the S3 bucket.<br>You can only set on a new bucket without existing data. You cannot set it when using <code>existing-path</code> to an existing directory with data.</td><td></td></tr><tr><td><code>fs-name</code></td><td>Existing filesystem name to create the bucket within.<br>Possible values: <code>fs-name</code>, <code>fs-id</code>.</td><td>The default filesystem specified when creating the S3 cluster.</td></tr><tr><td><code>fs-id</code></td><td>Existing filesystem ID to create the bucket within.<br>Possible values: <code>fs-name</code>, <code>fs-id</code>.</td><td>The default filesystem specified when creating the S3 cluster.</td></tr><tr><td><code>existing-path</code></td><td>Existing directory path relative to the filesystem root to expose a bucket from.</td><td></td></tr></tbody></table>

## List buckets

**Command:** `weka s3 bucket list`

Use this command to list existing buckets.

## Set a bucket quota

**Command:** `weka s3 bucket quota set`

Use the following command line to set an S3 bucket quota:

`weka s3 bucket quota set <bucket-name> <hard-quota>`

**Parameters**

<table><thead><tr><th width="215">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket-name</code>*</td><td>The name of an existing S3 bucket.</td></tr><tr><td><code>hard-quota</code>*</td><td>Hard quota for the S3 bucket.<br>You can only set it initially on an empty bucket. Calling this command on a bucket that already has a quota changes the quota limitation.</td></tr></tbody></table>

## Unset a bucket quota

**Command:** `weka s3 bucket quota unset <bucket-name>`

Use this command to unset an existing bucket quota.

{% hint style="info" %}
**Note:** If the bucket point to a directory shared with other protocols, changing the quota affects all protocols (changes the associated directory quota).
{% endhint %}

## Delete a bucket

**Command:** `weka s3 bucket destroy`

Use this command to delete an existing bucket.

{% hint style="info" %}
**Note:** You can only delete a bucket if it is empty (all its objects are deleted).
{% endhint %}

## Manage bucket policies

It is possible to set bucket policies for anonymous access. You can choose a pre-defined policy or add a customized policy.

### Set a pre-defined bucket policy

A bucket is automatically created without any anonymous access permissions. You can use one of the pre-defined policies: `download`, `upload`, or `public`.

Example: For a bucket named `mybucket`, the following are the pre-defined policy values:

{% tabs %}
{% tab title="download" %}
```json
{
  "Statement": [
    {
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket"
      ]
    },
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket/*"
      ]
    }
  ],
  "Version": "2012-10-17"
} 
```
{% endtab %}

{% tab title="upload" %}
```json
{
  "Statement": [
    {
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket"
      ]
    },
    {
      "Action": [
        "s3:DeleteObject",
        "s3:ListMultipartUploadParts",
        "s3:PutObject",
        "s3:AbortMultipartUpload"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
```
{% endtab %}

{% tab title="public" %}
```json
{
  "Statement": [
    {
      "Action": [
        "s3:GetBucketLocation",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket"
      ]
    },
    {
      "Action": [
        "s3:ListMultipartUploadParts",
        "s3:PutObject",
        "s3:AbortMultipartUpload",
        "s3:DeleteObject",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "*"
        ]
      },
      "Resource": [
        "arn:aws:s3:::mybucket/*"
      ]
    }
  ],
  "Version": "2012-10-17"
}
```
{% endtab %}
{% endtabs %}

**Command:** `weka s3 bucket policy set`

Use the following command line to set a pre-defined bucket policy:

`weka s3 bucket policy set <bucket-policy> <bucket-name>`

**Parameters**

<table data-header-hidden><thead><tr><th width="249">Name</th><th>Value</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td></tr><tr><td><code>bucket-policy</code>*</td><td>Name of a pre-defined bucket policy for anonymous access.<br>Possible values: <code>none</code>, <code>download</code>, <code>upload</code>, <code>public</code>.</td></tr><tr><td><code>bucket-name</code>*</td><td>Name of an existing S3 bucket.</td></tr></tbody></table>

### Set a custom bucket policy

To create a custom policy, you can use [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html) and select `S3 Bucket Policy` type. With a custom policy, it is possible to limit anonymous access only to specific prefixes.

For example, to set a custom policy for `mybucket` to allow read-only access for objects with a `public/` prefix, the custom policy, as generated with the calculator, is:

```
{
  "Id": "Policy1624778813411",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1624778790840",
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mybucket",
      "Condition": {
        "StringEquals": {
          "s3:prefix": "public/"
        }
      },
      "Principal": "*"
    },
    {
      "Sid": "Stmt1624778812360",
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::mybucket/public/*",
      "Principal": "*"
    }
  ]
}
```

**Command:** `weka s3 bucket policy set-custom`

Use the following command line to set a custom bucket policy:

`weka s3 bucket policy set-custom <policy-file> <bucket-name>`

**Parameters**

<table data-header-hidden><thead><tr><th width="256">Name</th><th>Value</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td></tr><tr><td><code>policy-file</code>*</td><td>A path to a custom JSON file representing an S3 bucket policy for anonymous access.<br>Wildcards (such as <code>s3:*</code>) are not allowed as an <code>Action</code> in the custom policy file.<br>See <a href="../s3-limitations.md#supported-policy-actions">Supported Policy Actions</a>.</td></tr><tr><td><code>bucket-name</code>*</td><td>Name of an existing S3 bucket.</td></tr></tbody></table>

### View a bucket policy

**Command:** `weka s3 bucket policy get / weka s3 bucket policy get-json`

Use the following command line to view an S3 bucket policy name/JSON:

`weka s3 bucket policy get <bucket-name> / weka s3 bucket policy get-json <bucket-name>`

**Parameters**

<table><thead><tr><th width="256">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>bucket-name</code>*</td><td>Name of an existing S3 bucket.</td></tr></tbody></table>

### Unset a bucket policy

**Command:** `weka s3 bucket policy unset`

Use the following command line to unset an S3 bucket policy:

`weka s3 bucket policy unset <bucket-name>`

**Parameters**

<table data-header-hidden><thead><tr><th width="317">Name</th><th>Value</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Value</strong></td></tr><tr><td><code>bucket-name</code>*</td><td>Name of an existing S3 bucket.</td></tr></tbody></table>

