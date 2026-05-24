---
description: >-
  Explore managing your buckets in WEKA using S3 API, GUI, CLI, or API, with
  flexible permissions through IAM or bucket policies for anonymous access.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-buckets-management
---

# S3 buckets management

Manage your buckets using WEKA, either through standard S3 API calls or the WEKA GUI/API/CLI. Determine bucket permissions by using IAM policies for authorized users or setting bucket policies for anonymous access.

Buckets and objects created through the S3 protocol come with default root POSIX permissions. For more precise control, create a user with an S3 role and set specific POSIX permissions for objects generated with their access/secret keys.

Objects created through anonymous access are assigned the anonymous UID and GID configured for the tenant. If the tenant does not define these values, the system uses the cluster-level defaults.

S3 bucket creation does not support a filesystem parameter. The system creates the bucket in the tenant default filesystem. If no tenant default filesystem is configured, bucket creation fails.

Bucket names must be unique across the entire cluster. If a bucket name is already in use, the system returns an error to choose another name.

In multi-tenant deployments, bucket visibility is tenant-scoped. `ListBuckets` and `weka s3 bucket list` return only buckets in the calling user's tenant. Buckets from other tenants are not visible, regardless of admin role.

{% hint style="info" %}
This behavior differs from non-multi-tenant deployments, where all buckets on the cluster were visible to all users. Tenant 0, also called the root tenant, follows the same tenant-scoped visibility model.
{% endhint %}

**Related topics**

* [S3 users and authentication](../s3-users-and-authentication/)
* [Naming limitations](../s3-limitations.md)
* [Manage S3 buckets using the GUI](s3-buckets-management.md)
* [Manage S3 buckets using the CLI](s3-buckets-management-1.md)
