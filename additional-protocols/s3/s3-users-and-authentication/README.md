---
description: >-
  This page describes how to gain and obtain access permissions to the S3
  protocol.
---

# S3 users and authentication

## S3 user role

A user with S3 user role is required to access the Weka cluster through the S3 protocol, run S3 commands, and S3 APIs. This user can operate within the limits of the S3 IAM policy attached to it.

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

To create a custom policy you can use _AWS Policy Generator_, and select `IAM Policy` as the policy type and `Amazon S3` as the AWS service.&#x20;

{% hint style="info" %}
**Note:** The IAM policy size is limited to 2KB. If a larger policy is required, contact [Weka technical support](../../../support/getting-support-for-your-weka-system.md).
{% endhint %}

****

**Related information**

[AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html)

## IAM temporary credentials (STS)

Once an S3 user is created and an IAM policy is attached, it is possible to gain temporary credentials to access the S3 API. This is done by calling the Assume Role command.

The result of calling the API is an access key, secret key, and session token tuple that can be used to access S3 APIs. The permissions for the temporary credentials are the permissions induced by the user's IAM policy. Furthermore, it is possible to supply a different (with reduced capabilities only) IAM policy for the temporary credentials request.

{% hint style="info" %}
**Note**: Some S3 clients and SDKs (such [boto3](https://boto3.amazonaws.com/v1/documentation/api/latest/index.html)), when provided with an access key and secret key pair, support the AssumeRole API automatically. They automatically generate and use a new temporary credential tuple (access key, secret key, and session token), when the previous one expires.
{% endhint %}

****

**Related topics**

[s3-users-and-authentication.md](s3-users-and-authentication.md "mention")
