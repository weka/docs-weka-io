---
description: >-
  Protect S3 objects from deletion or modification with WORM enforcement,
  meeting regulatory requirements, such as SEC 17a-4 and FINRA 4511, and
  guarding data against accidental and intentional changes.
---

# S3 Object Lock

## Overview

S3 Object Lock applies Write Once Read Many (WORM) protection to object versions stored in a versioned bucket. After you lock an object version, WEKA prevents any user from deleting or overwriting that version until its protection is released.

S3 Object Lock provides two independent protection methods that you can combine:

* **Retention modes:** Set a retention period during which an object version cannot be deleted or overwritten. Two modes control who can change the protection.
* **Legal hold:** Protect an individual object version indefinitely, without a defined retention period.

Object Lock helps meet regulatory and legal requirements while preserving data integrity. You can apply retention and legal hold policies to individual object versions. You can also remove legal holds as requirements change.

### Retention modes

Retention modes define the level of protection applied to an object version for a fixed period.

* **Governance mode:** Prevents deletion and modification of an object version during the retention period. Users who hold the `s3:BypassGovernanceRetention` permission can override the retention and delete or shorten the protection.
* **Compliance mode:** Prevents deletion and modification of an object version during the retention period for all users, including the cluster administrator. No user can shorten the retention period or delete the object version until the period expires.

You can extend a retention period at any time. In Governance mode, shortening or removing a retention period requires the `s3:BypassGovernanceRetention` permission. In Compliance mode, a retention period can only be extended, never shortened or removed.

### Legal hold

Legal hold protects an individual object version from deletion or modification for an unlimited time. A legal hold applies to a single object and remains active until an authorized user removes it. Legal hold works independently of retention modes, so you can apply it on top of Governance or Compliance protection.

While an object version is under a legal hold, the following rules apply:

* The object version cannot be deleted. This applies to direct deletions, deletions triggered by Information Lifecycle Management (ILM) rules, and deletions attempted after the retention period expires.
* An ILM rule that targets a noncurrent version does not delete an object version under legal hold. The version remains until you lift the hold.
* An ILM rule that targets the current version of an object under legal hold creates a delete marker only. The protected version is preserved.
* Copying an object does not copy its legal hold settings. The copy starts with no legal hold.

### Object Lock and bucket versioning

S3 Object Lock depends on bucket versioning:

* A bucket must be versioned to use Object Lock. Enabling Object Lock automatically turns on versioning for the bucket.
* You enable Object Lock when you create a bucket. You cannot enable Object Lock on an existing bucket.
* You cannot disable Object Lock after you enable it on a bucket.

## Configure S3 Object Lock

Configure S3 Object Lock to protect object versions. Enable Object Lock, set retention periods, and apply legal holds.

**Before you begin**

Confirm the following before you configure S3 Object Lock:

* The cluster has S3 versioning with the extended-attribute metadata scheme enabled. If it is not enabled, WEKA rejects the creation of a versioning- or Object-Lock-enabled bucket.
* You have the S3 permissions required for each action. See [Grant access control permissions for Object Lock](s3-object-lock.md#grant-access-control-permissions-for-object-lock).
* You use the WEKA CLI to enable Object Lock on a bucket, and the S3 API to set retention or legal hold on individual objects.

### Grant access control permissions for Object Lock

Grant the following S3 permissions to control access to Object Lock, legal hold, and retention operations.

| Permission | Description |
| --- | --- |
| `s3:GetBucketObjectLockConfiguration` | Get the Object Lock configuration of a bucket. |
| `s3:PutBucketObjectLockConfiguration` | Set the Object Lock configuration of a bucket. |
| `s3:GetObjectLegalHold` | Get the legal hold status of an object with a GET or HEAD request. |
| `s3:PutObjectLegalHold` | Turn the legal hold of an object on or off. |
| `s3:BypassGovernanceRetention` | Bypass the retention period of an object in Governance mode. |
| `s3:GetObjectRetention` | Get the retention period of an object. |
| `s3:PutObjectRetention` | Set the retention mode and retention date of an object. |

### Enable Object Lock on a bucket

Enable Object Lock on a new bucket by way of the WEKA CLI. Enabling Object Lock turns on bucket versioning automatically.

To enable Object Lock when you create a bucket, run:

```bash
weka s3 bucket create <name> --object-locking-on
```

To confirm the Object Lock status of your buckets, run:

```bash
weka s3 bucket list -v
```

### Set a retention period on an object

Set the retention mode and retention date on an object version by way of the S3 API.

**Before you begin**

* Confirm that Object Lock is enabled on the bucket.
* Confirm that you hold the `s3:PutObjectRetention` permission.

**Procedure**

1. Call the `PutObjectRetention` operation on the object.
2. Set the retention mode to `GOVERNANCE` or `COMPLIANCE`.
3. Set the retention date to a point in time in the future when protection expires.
4. To confirm the setting, call `GetObjectRetention`.

### Apply a legal hold on an object

Apply a legal hold to an individual object version by way of the S3 API. A legal hold stays active until you remove it.

**Before you begin**

* Confirm that Object Lock is enabled on the bucket.
* Confirm that you hold the `s3:PutObjectLegalHold` permission.

**Procedure**

1. To apply a legal hold, call `PutObjectLegalHold` and set the status to `ON`.
2. To remove a legal hold, call `PutObjectLegalHold` and set the status to `OFF`.
3. To check the current legal hold status, call `GetObjectLegalHold`.

**Related topic**

Object Lock APIs in [Supported S3 APIs](s3-limitations.md#supported-s3-apis)
