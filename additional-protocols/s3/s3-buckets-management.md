---
description: This page describes how to manage S3 buckets.
---

# S3 Buckets Management

## Overview

Buckets can be managed by either standard [S3 API](./#supported-s3-apis) calls or by using the Weka API/CLI.

Buckets permissions are determined by the user's IAM policy for authorized access or by setting bucket policies for anonymous access. 

Currently, buckets and objects created through the S3 protocol will have root POSIX permissions. In addition, all buckets are created within the filesystem specified in the S3 cluster creation. Directories \(adhering to the [naming limitations](s3-limitations.md#buckets)\) within this filesystem are exposed as buckets without anonymous permissions.

## Managing Buckets using the CLI

### Creating a New Bucket

**Command:** `weka s3 bucket create`

Use the following command line to create an S3 bucket:

`weka s3 bucket create <name> [--policy policy] [--policy-json policy-json]` 

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>name</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The name for the new S3 bucket</td>
      <td style="text-align:left">
        <p></p>
        <p>Refer to the <a href="s3-limitations.md#buckets">Bucket Naming Limitations</a> section.</p>
      </td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>policy</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The name of a pre-defined bucket policy for anonymous access.</td>
      <td
      style="text-align:left">One of: <code>none</code>, <code>download</code>, <code>upload</code>, <code>public</code>
        </td>
        <td style="text-align:left">No</td>
        <td style="text-align:left"><code>none</code>
        </td>
    </tr>
    <tr>
      <td style="text-align:left"><code>policy-json</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">A path to a custom policy JSON file for anonymous access.</td>
      <td style="text-align:left">A JSON file representing an S3 bucket policy.</td>
      <td style="text-align:left">No</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

### Listing Buckets

**Command:** `weka s3 bucket list`

Use this command to list existing buckets.

### Deleting a Bucket

**Command:** `weka s3 bucket destroy`

Use this command to delete an existing bucket.

{% hint style="info" %}
**Note:** A bucket can only be deleted if it is empty \(all its objects have been deleted\).
{% endhint %}

## Managing Bucket Policies

It is possible to set bucket policies for anonymous access. You can choose one of the pre-defined policies or add your own customized policies.

### Setting a Pre-Defined Bucket Policy

A bucket is automatically created without any anonymous access permissions. You can use one of the pre-defined policies: `download`, `upload`, or `public`.

For example, for a bucket named `mybucket`, these will be the pre-defined policies values:

{% tabs %}
{% tab title="download" %}
```text
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
```text
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
```text
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

**Command:** `weka s3 bucket set-policy`

Use the following command line to set a pre-defined bucket policy:

`weka s3 bucket set-policy <bucket-policy> <bucket-name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `bucket-policy` | String | The name of a pre-defined bucket policy for anonymous access.  | One of: `none`, `download`, `upload`, `public` | Yes |  |
| `bucket-name` | String | The name of an existing S3 bucket |  | Yes |  |

### Setting a Custom Bucket Policy

To create a custom policy, you can use [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html) and select `S3 Bucket Policy` as the policy type. With a custom policy, it is possible to limit anonymous access only to specific prefixes.

For example, to set a custom policy for `mybucket` to allow read-only access for objects with a `public/` prefix, the custom policy, as generated with the calculator, is:

```text
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

**Command:** `weka s3 bucket set-custom-policy`

Use the following command line to set a custom bucket policy:

`weka s3 bucket set-custom-policy <policy-file> <bucket-name>`

**Parameters in Command Line**

<table>
  <thead>
    <tr>
      <th style="text-align:left"><b>Name</b>
      </th>
      <th style="text-align:left"><b>Type</b>
      </th>
      <th style="text-align:left"><b>Value</b>
      </th>
      <th style="text-align:left"><b>Limitations</b>
      </th>
      <th style="text-align:left"><b>Mandatory</b>
      </th>
      <th style="text-align:left"><b>Default</b>
      </th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td style="text-align:left"><code>policy-file</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">A path to a custom policy JSON file for anonymous access.</td>
      <td style="text-align:left">
        <p>A JSON file representing an S3 bucket policy.</p>
        <p>Wildcards (e.g., <code>s3:*</code>) are not allowed as an <code>Action</code> in
          the custom policy file. For supported actions, refer to the <a href="s3-limitations.md#supported-policy-actions">Supported Policy Actions</a> section.</p>
      </td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
    <tr>
      <td style="text-align:left"><code>bucket-name</code>
      </td>
      <td style="text-align:left">String</td>
      <td style="text-align:left">The name of an existing S3 bucket.</td>
      <td style="text-align:left"></td>
      <td style="text-align:left">Yes</td>
      <td style="text-align:left"></td>
    </tr>
  </tbody>
</table>

### Viewing a Bucket Policy

**Command:** `weka s3 bucket get-policy / weka s3 bucket get-policy-json`

Use the following command line to view an S3 bucket policy name/JSON:

`weka s3 bucket get-policy <bucket-name> / weka s3 bucket get-policy-json <bucket-name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `bucket-name` | String | The name of an existing S3 bucket. |  | Yes |  |

