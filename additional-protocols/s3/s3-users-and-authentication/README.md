---
description: >-
  This page describes how to gain and obtain access permissions to the S3
  protocol.
---

# S3 users and authentication

## S3 user role

A user with an S3 user role is required to access the Weka cluster through the S3 protocol and run S3 commands and S3 APIs. The S3 user operates within the limits of the IAM policy attached to it.

When accessing data with S3 and other protocols (such as POSIX), you can control the POSIX UID/GID of the underlying file representation of objects created with a specific S3 user access/secret keys.

Use `--posix-uid` and `--posix-gid` flags for a local user with an S3 user role.

{% hint style="info" %}
**Note:** The S3 user name and password serve as the S3 access key and secret key, respectively.&#x20;
{% endhint %}



**Related topics**

[#create-users](../../../usage/security/user-management.md#create-users "mention")

## IAM policy

Once an S3 user is created, the Cluster Admin must attach an IAM policy to allow this user to operate (within the policy limits). Without an attached IAM policy, the S3 user cannot run any S3 command or API.

The Cluster Admin can attach to an S3 user one of the following:

* A pre-defined policy
* A new custom policy

To create a custom policy, you can use _AWS Policy Generator_ and select `IAM Policy` as the policy type and `Amazon S3` as the AWS service.&#x20;

{% hint style="info" %}
**Note:** The IAM policy size is limited to 2KB. If a larger policy is required, contact the [Customer Success Team](../../../support/getting-support-for-your-weka-system.md).
{% endhint %}

****

**Related information**

[AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html)

## IAM temporary credentials (STS)

Once an S3 user is created and an IAM policy is attached, it is possible to gain temporary credentials to access the S3 API by calling the Assume Role command.

The result of calling the API is an access key, secret key, and session token tuple that can be used to access S3 APIs. The permissions for the temporary credentials are the permissions induced by the user's IAM policy. Furthermore, it is possible to supply a different (with reduced capabilities only) IAM policy for the temporary credentials request.

{% hint style="info" %}
**Note**: Some S3 clients and SDKs (such as [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)), when provided with an access key and secret key pair, support the AssumeRole API automatically. They use STS credentials and automatically regenerate a new STS when the previous one expires.
{% endhint %}

## S3 service accounts

S3 service accounts are child identities of a single parent S3 user. Each service account inherits its privileges based on the IAM policies attached to its parent user. S3 service accounts also support an optionally attached IAM policy that restricts its access to a _subset_ of the actions and resources available to the parent user (S3 APIs and S3-related CLI commands).

S3 service accounts enable the management of specific object store buckets and S3 APIs (as defined by the IAM policy) without relying on the S3 user administrative action.

As opposed to IAM temporary credentials (STS), the S3 service account is not temporary and does not have an expiration date. Therefore, the S3 service account is used for ongoing management of the object store buckets and S3 APIs.

Only an S3 user can manage S3 service accounts (Cluster Admin cannot). An S3 user can create up to 100 S3 service accounts. Managing S3 service accounts is only available through the CLI.

****

**Related topics**

[s3-users-and-authentication.md](s3-users-and-authentication.md "mention")

[s3-users-and-authentication-1.md](s3-users-and-authentication-1.md "mention")

[#supported-s3-apis](../s3-limitations.md#supported-s3-apis "mention")
