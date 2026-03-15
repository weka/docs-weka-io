---
description: >-
  Manage access to the S3 API using WEKA local or centralized LDAP integrated
  credentials. Every entity interacting with WEKA S3 API must have an assigned
  S3 role and an attached IAM policy.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-users-and-authentication
---

# S3 users and authentication

## S3 authentication methods

The system supports two methods for authenticating S3 requests:

* **Local S3 authentication:** Create and manage S3 credentials directly within the cluster. For local entities, the username acts as the Access Key and the password acts as the Secret Key.
* **S3 LDAP authentication:** Integrate an existing LDAP directory to manage access centrally. Users authenticate with LDAP credentials through a dedicated API to retrieve dynamically generated S3 key pairs.

## S3 user permissions

Access to the S3 API requires an S3 user role. The system enforces the following permission structure:

* **IAM policy requirement:** A Cluster Admin must attach an S3 IAM policy to any account that needs S3 access. Without an active policy, the user cannot run S3 commands or API calls.
* **Policy types:** Admins may attach pre-defined policies or create custom ones using the [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html).
* **Policy size:** IAM policies are limited to 2KB. Contact the [Customer Success Team](../../../support/getting-support-for-your-weka-system.md) if a larger policy is required.
* **Identity mapping:** To maintain consistency across protocols, use the `--posix-uid` and `--posix-gid` flags for local users. This controls the POSIX attributes of the underlying file representation for objects created by that user.

## Temporary credentials and service accounts

For specific workflows requiring restricted or automated access, use one of the following identity types:

**IAM temporary credentials (STS)**

Once a user has an attached IAM policy, they can use the AssumeRole API to obtain Security Token Service (STS) credentials.

* **Components:** The API returns an access key, secret key, and session token.
* **Scope:** Permissions are derived from the user's primary IAM policy. You can provide a more restrictive policy during the request to further limit access.
* **Automation:** Many S3 clients and SDKs natively support the AssumeRole API. When provided with a key pair, they automatically request and regenerate a new STS token before the previous one expires.
* **Revocation:** If STS credentials become compromised, delete the parent S3 user. This action permanently invalidates all active STS credentials and session tokens linked to that account.

**S3 service accounts**

Service accounts are permanent child identities of a single parent S3 user.

* **Inheritance:** Each service account inherits privileges from the parent user's IAM policy.
* **Restriction:** You can attach an optional IAM policy to a service account to restrict it to a subset of the parent's actions.
* **Management:** Only an S3 user can manage service accounts. A single user can create up to 100 service accounts. This management is performed exclusively through the CLI.
* **Persistence:** Unlike STS, service accounts do not expire.

**Related topics**

[configure-s3-ldap-authentication.md](configure-s3-ldap-authentication.md "mention")

[#creating-a-new-iam-policies-1](s3-users-and-authentication.md#creating-a-new-iam-policies-1 "mention")

&#x20;[user-management](../../../operation-guide/user-management/ "mention")

[#supported-s3-apis](../s3-limitations.md#supported-s3-apis "mention")
