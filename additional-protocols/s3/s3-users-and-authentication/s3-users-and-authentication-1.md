---
description: Create, view, and remove S3 service accounts using the CLI.
---

# Manage S3 service accounts using the CLI

## View existing S3 service accounts

Lists the S3 service accounts defined on the cluster.

**Command:** `weka s3 service-account list`

```sh
weka s3 service-account list
```

## Add an S3 service account

Creates an S3 service account, which lets an application authenticate to S3 without a cluster user.

**Command:** `weka s3 service-account add`

```sh
weka s3 service-account add [--policy-file <string>]
```

**Parameters**

| Parameter                 | Description                          |
| --- | --- |
| `--policy-file` \<string> | File containing JSON policy content. |

{% hint style="warning" %}
The secret key is visible **only once** when adding the S3 service account. You must save the secret key in a safe place for later use.
{% endhint %}

## Show an S3 service account details

Shows the details of a single S3 service account.

**Command:** `weka s3 service-account show`

```sh
weka s3 service-account show <access-key>
```

**Parameters**

| Parameter      | Description                                |
| --- | --- |
| `access-key`\* | Access key of the service account to show. |

## Remove S3 service account

Deletes an S3 service account and invalidates its credentials.

**Command:** `weka s3 service-account remove`

```sh
weka s3 service-account remove <access-key>
```

**Parameters**

| Parameter      | Description                                  |
| --- | --- |
| `access-key`\* | Access key of the service account to remove. |

**Related topics**

[#s3-service-accounts](./#s3-service-accounts "mention")
