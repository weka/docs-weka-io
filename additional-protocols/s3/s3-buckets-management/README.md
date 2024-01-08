---
description: Explore how to manage to manage S3 buckets.
---

# S3 buckets management

Manage your buckets using WEKA, either through standard S3 API calls or the WEKA GUI/API/CLI. Determine bucket permissions by using IAM policies for authorized users or setting bucket policies for anonymous access.

Buckets and objects created through the S3 protocol come with default root POSIX permissions. For more precise control, create a user with an S3 role and set specific POSIX permissions for objects generated with their access/secret keys.

Objects created through anonymous access (enabled by IAM policy) are assigned the anonymous UID/GID. By default, all buckets are created within the specified filesystem during S3 cluster configuration. To place a bucket in a different filesystem, use a straightforward call to the WEKA GUI/API/CLI.

**Related topics**

[#s3-user-role](../s3-users-and-authentication/#s3-user-role "mention")

[#naming-limitations](../s3-limitations.md#naming-limitations "mention")

[s3-buckets-management.md](s3-buckets-management.md "mention")

[s3-buckets-management-1.md](s3-buckets-management-1.md "mention")
