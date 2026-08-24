---
description: Create, list, configure, and remove S3 buckets using the CLI.
---

# Manage S3 buckets using the CLI

## Add a bucket

**Command:** `weka s3 bucket add`

Use the following command line to add an S3 bucket:

`weka s3 bucket add <name> [--policy policy] [--policy-json policy-json] [--hard-quota hard-quota] [--fs-name fs-name] [--fs-id fs-id] [--existing-path existing-path]`

{% hint style="info" %}
S3 does not support creating buckets on filesystems with names containing the characters ' ', '`(`', '`)`', or '`&`'. Verify that the filesystem name excludes these characters. Rename the filesystem if needed before creating the S3 bucket.
{% endhint %}

Bucket names must be unique across the entire cluster. If the name is already in use, the command returns a message to choose another name.

**Parameters**

| Name            | Value                                                                                                                                                                                                                                                      |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `name`\*        | The name for the S3 bucket to add.Refer to the [Bucket Naming Limitations](../s3-limitations.md#buckets) section.                                                                                                                                          |
| `policy`        | The name of a pre-defined bucket policy for anonymous access.Possible values: `none`, `download`, `upload`, `public`.Default: `none`                                                                                                                       |
| `policy-json`   | A path to a custom policy JSON file representing an S3 bucket policy for anonymous access.                                                                                                                                                                 |
| `hard-quota`    | Hard quota for the S3 bucket.You can only set on a new bucket without existing data. You cannot set it when using `existing-path` to an existing directory with data.                                                                                      |
| `fs-name`       | Existing filesystem name to create the bucket within.If omitted, the system uses the tenant default filesystem first and then the cluster default filesystem. If neither default is configured, the command fails unless you specify `fs-name` or `fs-id`. |
| `fs-id`         | Existing filesystem ID to create the bucket within.If omitted, the system uses the tenant default filesystem first and then the cluster default filesystem. If neither default is configured, the command fails unless you specify `fs-name` or `fs-id`.   |
| `existing-path` | Existing directory path relative to the filesystem root to expose a bucket from.                                                                                                                                                                           |

## List buckets

**Command:** `weka s3 bucket list`

Use this command to list existing buckets.

In multi-tenant deployments, this command lists only buckets in the current tenant. Buckets from other tenants are hidden, regardless of admin role.

{% hint style="info" %}
This behavior differs from non-multi-tenant deployments, where all buckets on the cluster were visible to all users. Tenant 0, also called the root tenant, follows the same tenant-scoped visibility model.
{% endhint %}

## Set a bucket quota

**Command:** `weka s3 bucket quota set`

Use the following command line to set an S3 bucket quota:

`weka s3 bucket quota set <bucket-name> <hard-quota>`

**Parameters**

| Name            | Value                                                                                                                                                                  |
| --------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bucket-name`\* | The name of an existing S3 bucket.                                                                                                                                     |
| `hard-quota`\*  | Hard quota for the S3 bucket.You can only set it initially on an empty bucket. Calling this command on a bucket that already has a quota changes the quota limitation. |

## Reset a bucket quota

**Command:** `weka s3 bucket quota reset <bucket-name>`

Use this command to reset an existing bucket quota.

{% hint style="info" %}
If the bucket point to a directory shared with other protocols, changing the quota affects all protocols (changes the associated directory quota).
{% endhint %}

## Remove a bucket

**Command:** `weka s3 bucket remove`

Use this command to remove an existing bucket from the filesystem only if the bucket is empty. If the bucket is not empty, you can keep the data on the filesystem and remove the bucket from the S3 configuration.

`weka s3 bucket remove <name> [--unlink]`

**Parameters**

<table><thead><tr><th width="184">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>The name of an existing S3 bucket.</td></tr><tr><td><code>unlink</code></td><td><p>Detaches the bucket from the S3 configuration and keeps the data and metadata in place. Consequently, you can recreate the bucket while preserving the data and metadata (see <code>weka s3 bucket add</code> using the <code>existing-path</code> option).</p><p>Note: If the intent is to keep the data files for use outside of the S3 configuration and delete only the S3 metadata, contact the Customer Success Team for assistance.</p></td></tr></tbody></table>

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

`weka s3 bucket policy set <bucket-name> <bucket-policy>`

**Parameters**

| Name              | Value                                                                                                             |
| ----------------- | ----------------------------------------------------------------------------------------------------------------- |
| `bucket-name`\*   | Name of an existing S3 bucket.                                                                                    |
| `bucket-policy`\* | Name of a pre-defined bucket policy for anonymous access.Possible values: `none`, `download`, `upload`, `public`. |

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

`weka s3 bucket policy set-custom <bucket-name> <policy-file>`

**Parameters**

| Name            | Value                                                                                                                                                                                                                                                 |
| --------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `bucket-name`\* | Name of an existing S3 bucket.                                                                                                                                                                                                                        |
| `policy-file`\* | A path to a custom JSON file representing an S3 bucket policy for anonymous access.Wildcards (such as `s3:*`) are not allowed as an `Action` in the custom policy file.See [Supported Policy Actions](../s3-limitations.md#supported-policy-actions). |

### View a bucket policy

**Command:** `weka s3 bucket policy get / weka s3 bucket policy get-json`

Use the following command line to view an S3 bucket policy name/JSON:

`weka s3 bucket policy get <bucket-name> / weka s3 bucket policy get-json <bucket-name>`

**Parameters**

| Name            | Value                          |
| --------------- | ------------------------------ |
| `bucket-name`\* | Name of an existing S3 bucket. |

### Unset a bucket policy

**Command:** `weka s3 bucket policy reset`

Use the following command line to unset an S3 bucket policy:

`weka s3 bucket policy reset <bucket-name>`

**Parameters**

| Name            | Value                          |
| --------------- | ------------------------------ |
| `bucket-name`\* | Name of an existing S3 bucket. |
