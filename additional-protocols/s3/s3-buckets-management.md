---
description: This page describes how to manage S3 buckets.
---

# S3 Buckets Management

## Overview

Buckets can be managed by either standard [S3 API](./#supported-s3-apis) calls or by using the Weka API/CLI.

Buckets permissions are determined by the user's IAM policy for authorized access or by setting bucket policies for anonymous access.&#x20;

By default, buckets and objects created through the S3 protocol will have root POSIX permissions. When creating a user with an [S3 role](s3-users-and-authentication.md#s3-user-role), specific POSIX permissions can be set for objects created with this user access/secret keys. Objects created using anonymous access (for buckets with IAM policy allowing that) will get the anonymous UID/GID.

By default, all buckets are created within the filesystem specified in the S3 cluster creation. It is possible to create a bucket in a different filesystem, by calling the Weka API/CLI.

Directories (adhering to the [naming limitations](s3-limitations.md#buckets)) within this filesystem are exposed as buckets without anonymous permissions.

## Managing Buckets using the CLI

### Creating a New Bucket

**Command:** `weka s3 bucket create`

Use the following command line to create an S3 bucket:

`weka s3 bucket create <name> [--policy policy] [--policy-json policy-json] [--hard-quota hard-quota] [--fs-name fs-name] [--fs-id fs-id] [--existing-path existing-path]` &#x20;

**Parameters in Command Line**

<table data-header-hidden><thead><tr><th width="150">Name</th><th width="150">Type</th><th width="184">Value</th><th>Limitations</th><th width="150">Mandatory</th><th width="150">Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code></td><td>String</td><td>The name for the new S3 bucket</td><td><p></p><p>Refer to the <a href="s3-limitations.md#buckets">Bucket Naming Limitations</a> section. </p></td><td>Yes</td><td></td></tr><tr><td><code>policy</code></td><td>String</td><td>The name of a pre-defined bucket policy for anonymous access. </td><td>One of: <code>none</code>, <code>download</code>, <code>upload</code>, <code>public</code></td><td>No</td><td><code>none</code></td></tr><tr><td><code>policy-json</code></td><td>String</td><td>A path to a custom policy JSON file for anonymous access.</td><td>A JSON file representing an S3 bucket policy.</td><td>No</td><td></td></tr><tr><td><code>hard-quota</code></td><td>Number</td><td>Hard quota for the S3 bucket</td><td>Can only be set on a new bucket without existing data (cannot be set when using <code>existing-path</code> to an existing directory with data)</td><td>No</td><td></td></tr><tr><td><code>fs-name</code></td><td>String</td><td>Filesystem name to create the new bucket within</td><td>An existing filesystem name</td><td>No. When specified, use only <code>fs-name</code> or <code>fs-id</code>.</td><td>The default filesystem specified when creating the S3 cluster</td></tr><tr><td><code>fs-id</code></td><td>Number</td><td>Filesystem ID to create the new bucket within</td><td>An existing filesystem ID</td><td>No. When specified, use only <code>fs-name</code> or <code>fs-id</code>.</td><td>The default filesystem specified when creating the S3 cluster</td></tr><tr><td><code>existing-path</code></td><td>String</td><td>Existing directory path (relative to the filesystem root) to expose a bucket from</td><td>An existing path within the filesystem</td><td>No</td><td></td></tr></tbody></table>

### Listing Buckets

**Command:** `weka s3 bucket list`

Use this command to list existing buckets.

### Setting a Bucket Quota

**Command:** `weka s3 bucket quota set`

Use the following command line to create an S3 bucket:

`weka s3 bucket quota set <bucket-name> <hard-quota>`

**Parameters in Command Line**

<table data-header-hidden><thead><tr><th width="150">Name</th><th width="150">Type</th><th width="184">Value</th><th>Limitations</th><th width="150">Mandatory</th><th width="150">Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>bucket-name</code></td><td>String</td><td>The name of an existing S3 bucket</td><td><p></p><p></p></td><td>Yes</td><td></td></tr><tr><td><code>hard-quota</code></td><td>Number</td><td>Hard quota for the S3 bucket</td><td>Can only be initially set on an empty bucket. Calling this command on a bucket that already has a quota will change the quota limitation.</td><td>Yes</td><td></td></tr></tbody></table>

### Unsetting a Bucket Quota

**Command:** `weka s3 bucket quota unset <bucket-name>`

Use this command to unset an existing bucket quota.

{% hint style="info" %}
**Note:** If the bucket point to a directory shared with other protocols, changing the quota affects all protocols (changes the associated directory quota).
{% endhint %}

### Deleting a Bucket

**Command:** `weka s3 bucket destroy`

Use this command to delete an existing bucket.

{% hint style="info" %}
**Note:** A bucket can only be deleted if it is empty (all its objects have been deleted).
{% endhint %}

## Managing Bucket Policies

It is possible to set bucket policies for anonymous access. You can choose one of the pre-defined policies or add your own customized policies.

### Setting a Pre-Defined Bucket Policy

A bucket is automatically created without any anonymous access permissions. You can use one of the pre-defined policies: `download`, `upload`, or `public`.

For example, for a bucket named `mybucket`, these will be the pre-defined policies values:

{% tabs %}
{% tab title="download" %}
```
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
```
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
```
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

**Parameters in Command Line**

| **Name**        | **Type** | **Value**                                                      | **Limitations**                                | **Mandatory** | **Default** |
| --------------- | -------- | -------------------------------------------------------------- | ---------------------------------------------- | ------------- | ----------- |
| `bucket-policy` | String   | The name of a pre-defined bucket policy for anonymous access.  | One of: `none`, `download`, `upload`, `public` | Yes           |             |
| `bucket-name`   | String   | The name of an existing S3 bucket                              |                                                | Yes           |             |

### Setting a Custom Bucket Policy

To create a custom policy, you can use [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html) and select `S3 Bucket Policy` as the policy type. With a custom policy, it is possible to limit anonymous access only to specific prefixes.

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

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                                  | **Limitations**                                                                                                                                                                                                                                                                                      | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `policy-file` | String   | A path to a custom policy JSON file for anonymous access.  | <p>A JSON file representing an S3 bucket policy. </p><p>Wildcards  (e.g., <code>s3:*</code>) are not allowed as an <code>Action</code> in the custom policy file. For supported actions, refer to the <a href="s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section.</p> | Yes           |             |
| `bucket-name` | String   | The name of an existing S3 bucket.                         |                                                                                                                                                                                                                                                                                                      | Yes           |             |

### Viewing a Bucket Policy

**Command:** `weka s3 bucket policy get / weka s3 bucket policy get-json`

Use the following command line to view an S3 bucket policy name/JSON:

`weka s3 bucket policy get <bucket-name> / weka s3 bucket policy get-json <bucket-name>`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                          | **Limitations** | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------- | --------------- | ------------- | ----------- |
| `bucket-name` | String   | The name of an existing S3 bucket. |                 | Yes           |             |

### Unsetting a Bucket Policy

**Command:** `weka s3 bucket policy unset`

Use the following command line to unset an S3 bucket policy:

`weka s3 bucket policy unset <bucket-name>`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                          | **Limitations** | **Mandatory** | **Default** |
| ------------- | -------- | ---------------------------------- | --------------- | ------------- | ----------- |
| `bucket-name` | String   | The name of an existing S3 bucket. |                 | Yes           |             |

