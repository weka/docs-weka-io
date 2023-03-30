---
description: This page describes how to manage S3 buckets.
---

# S3 buckets management

You can manage buckets by either standard S3 API calls or using the WEKA API/CLI.

You determine the bucket permissions by the user's IAM policy for authorized access or by setting bucket policies for anonymous access.&#x20;

Buckets and objects created through the S3 protocol have root POSIX permissions by default. When creating a user with an S3 role, you can set specific POSIX permissions for objects created with this user access/secret keys. Objects created using anonymous access (for buckets with IAM policy allowing that) get the anonymous UID/GID.

By default, all buckets are created within the filesystem specified when creating the S3 cluster configuration. You can create a bucket in a different filesystem by calling the WEKA API/CLI.



**Related topics**

[#s3-user-role](../s3-users-and-authentication/#s3-user-role "mention")

[#naming-limitations](../s3-limitations.md#naming-limitations "mention")

[s3-buckets-management.md](s3-buckets-management.md "mention")

[s3-buckets-management-1.md](s3-buckets-management-1.md "mention")
