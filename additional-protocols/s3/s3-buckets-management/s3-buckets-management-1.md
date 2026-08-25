---
description: Create, list, configure, and remove S3 buckets using the CLI.
---

# Manage S3 buckets using the CLI

## Add a bucket

Creates an S3 bucket on the cluster. Buckets are backed by a filesystem; name one with `--fs-name`, or let the cluster use the S3 cluster's default filesystem.

**Command:** `weka s3 bucket add`

```sh
weka s3 bucket add <name> [--existing-path <string>] [--force] [--fs-id <fs-id>] [--fs-name <string>] [--hard-quota <capacity>] [--object-locking-on] [--policy <bucket-policy>] [--policy-json <string>]
```

**Parameters**

| Parameter                   | Description                                                                                         |
| --------------------------- | --------------------------------------------------------------------------------------------------- |
| `name`\* | Name of the bucket to create. [Bucket Naming Limitations](../s3-limitations.md#buckets) section |
| `--existing-path` \<string> | Existing path to use for the bucket. |
| `-f`, `--force` | Force when existing path has quota. |
| `--fs-id` \<fs-id> | Filesystem ID for the bucket. |
| `--fs-name` \<string> | Filesystem name for the bucket. |
| `--hard-quota` \<capacity> | Hard limit for the directory. |
| `--object-locking-on` | Enable S3 Object Lock on the bucket (creation-time only; requires cluster-wide versioning support). |
| `--policy` \<bucket-policy> | Existing S3 IAM policy to assign to the bucket. Possible values: `none`, `download`, `upload`, `public`. Default: `none` |
| `--policy-json` \<string> | Path to policy file. File must contain JSON definition of policy. |

{% hint style="info" %}
S3 does not support creating buckets on filesystems with names containing the characters ' ', '`(`', '`)`', or '`&`'. Verify that the filesystem name excludes these characters. Rename the filesystem if needed before creating the S3 bucket.
{% endhint %}

## List buckets

Lists the S3 buckets on the cluster with their quota, usage, and object-lock state.

**Command:** `weka s3 bucket list`

```sh
weka s3 bucket list
```

{% hint style="info" %}
This behavior differs from non-multi-tenant deployments, where all buckets on the cluster were visible to all users. Tenant 0, also called the root tenant, follows the same tenant-scoped visibility model.
{% endhint %}

## Set a bucket quota

Sets a hard capacity limit on a bucket. Writes that would exceed the limit are rejected.

**Command:** `weka s3 bucket quota set`

```sh
weka s3 bucket quota set <name> <hard-quota>
```

**Parameters**

| Parameter      | Description                          |
| -------------- | ------------------------------------ |
| `name`\* | Name of the S3 bucket. |
| `hard-quota`\* | Hard limit for directory disk usage. |

## Reset a bucket quota

Removes the capacity limit from a bucket.

**Command:** `weka s3 bucket quota reset`

```sh
weka s3 bucket quota reset <name>
```

**Parameters**

| Parameter | Description            |
| --------- | ---------------------- |
| `name`\* | Name of the S3 bucket. |

{% hint style="info" %}
If the bucket point to a directory shared with other protocols, changing the quota affects all protocols (changes the associated directory quota).
{% endhint %}

## Remove a bucket

Deletes an S3 bucket.

**Command:** `weka s3 bucket remove`

```sh
weka s3 bucket remove <name> [--force] [--unlink]
```

**Parameters**

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `name`\* | Name of the bucket to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--unlink` | Leave the data directory in place after removal. |

## Manage bucket policies

It is possible to set bucket policies for anonymous access. You can choose a pre-defined policy or add a customized policy.

### Set a pre-defined bucket policy

Applies one of the built-in anonymous-access policies to a bucket.

**Command:** `weka s3 bucket policy set`

```sh
weka s3 bucket policy set <bucket-name> <bucket-policy>
```

**Parameters**

| Parameter         | Description                            |
| ----------------- | -------------------------------------- |
| `bucket-name`\* | Name of the bucket. |
| `bucket-policy`\* | S3 IAM policy to assign to the bucket. Possible values: `none`, `download`, `upload`, `public` |

### Set a custom bucket policy

Applies a bucket policy from a JSON file, for access rules the pre-defined policies do not cover.

**Command:** `weka s3 bucket policy set-custom`

```sh
weka s3 bucket policy set-custom <bucket-name> <policy-file>
```

**Parameters**

| Parameter       | Description                                 |
| --------------- | ------------------------------------------- |
| `bucket-name`\* | Name of the bucket. |
| `policy-file`\* | Path to file containing custom JSON policy. [Supported Policy Actions](../s3-limitations.md#supported-policy-actions) |

### View a bucket policy

Shows the policy applied to a bucket. Use `policy get` for the policy name and `policy get-json` for the full JSON document.

**Command:** `weka s3 bucket policy get`

```sh
weka s3 bucket policy get <bucket-name>
```

**Command:** `weka s3 bucket policy get-json`

```sh
weka s3 bucket policy get-json <bucket-name>
```

**Parameters**

| Parameter       | Description         |
| --------------- | ------------------- |
| `bucket-name`\* | Name of the bucket. |

### Unset a bucket policy

Removes the policy from a bucket, returning it to the default of no anonymous access.

**Command:** `weka s3 bucket policy reset`

```sh
weka s3 bucket policy reset <bucket-name>
```

**Parameters**

| Parameter       | Description         |
| --------------- | ------------------- |
| `bucket-name`\* | Name of the bucket. |
