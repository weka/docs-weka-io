---
description: Create, view, and remove S3 bucket lifecycle rules using the CLI.
---

# Manage S3 lifecycle rules using the CLI

{% hint style="info" %}
In multi-tenant deployments, lifecycle rules are scoped to the tenant in which they are defined. Rules apply only to buckets owned by that tenant. The lifecycle crawler runs cluster-wide across all tenants automatically. No additional configuration is required per tenant.
{% endhint %}

## Add a lifecycle rule

Adds a rule that expires objects in a bucket after a set number of days. Limit the rule to a subset of objects with `--prefix` or `--tags`.

**Command:** `weka s3 bucket lifecycle-rule add`

```sh
weka s3 bucket lifecycle-rule add <name> <expiry-days> [--noncurrent] [--prefix <string>] [--tags <string>]
```

**Parameters**

| Parameter            | Description                                                             |
| --- | --- |
| `name`\* | Name of the S3 bucket. |
| `expiry-days`\* | Number of days after which objects expire. |
| `--noncurrent` | Apply expiry to noncurrent object versions only (not current versions). |
| `--prefix` \<string> | Object key prefix to which the rule applies. |
| `--tags` \<string> | Object tags to which the rule applies. values: '<k1>=<v1>&#x26;<k2=<v2>' |

## Expire noncurrent object versions

A versioned bucket retains every earlier version of an object. Those versions consume capacity until a lifecycle rule expires them, and no rule expires them by default.

A rule created with `--noncurrent` applies only to earlier versions and leaves the current version of each object in place. A rule created without it applies to current versions.

Two alerts identify a versioned bucket that lacks this cleanup:

| Alert | Meaning |
| --- | --- |
| `S3VersioningNoNoncurrentExpirationRule` | The bucket uses versioning but has no noncurrent version expiration rule. |
| `S3VersioningNoDataservIlm` | The bucket uses versioning, but no active Data Services container has lifecycle management configured. |

**Example: expire noncurrent versions after 30 days**

1. Enable the S3 lifecycle task manager.

    ```bash
    weka dataservice s3-lifecycle-task enable
    ```
2. Add the rule to the versioned bucket.

    ```bash
    weka s3 bucket lifecycle-rule add bucket1 30 --noncurrent
    ```
3. Confirm the rule. The `Noncurrent` column reads `true`.

    ```bash
    weka s3 bucket lifecycle-rule list bucket1
    ```

## View lifecycle rules

Lists the lifecycle rules defined on a bucket.

**Command:** `weka s3 bucket lifecycle-rule list`

```sh
weka s3 bucket lifecycle-rule list <name>
```

**Parameters**

| Parameter | Description            |
| --- | --- |
| `name`\* | Name of the S3 bucket. |

## Remove a lifecycle rule

Removes a single lifecycle rule from a bucket.

**Command:** `weka s3 bucket lifecycle-rule remove`

```sh
weka s3 bucket lifecycle-rule remove <name> <rule>
```

**Parameters**

| Parameter | Description            |
| --- | --- |
| `name`\* | Name of the S3 bucket. |
| `rule`\* | Rule ID to remove. |

## Remove all lifecycle rules

Removes every lifecycle rule from a bucket.

**Command:** `weka s3 bucket lifecycle-rule reset`

```sh
weka s3 bucket lifecycle-rule reset <name> [--force]
```

**Parameters**

| Parameter       | Description                                                     |
| --- | --- |
| `name`\* | Name of the S3 bucket. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
