---
description: >-
  Manage access to the S3 API using local WEKA accounts or LDAP-integrated
  identities. Local users require the S3 role and an attached IAM policy.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-users-and-authentication
---

# S3 users and authentication

## S3 credentials

Use an access key and secret key pair to access the S3 API. These credentials are separate from the WEKA account password. WEKA stores each key pair locally.

* **Local accounts:** Managed in WEKA. The key pair belongs to the local account.
* **LDAP accounts:** Managed in LDAP. WEKA issues and stores the key pair locally. Use the dedicated API to create a key pair, refresh the IAM policy and UID/GID mapping from LDAP, or remove the local key pair without changing the LDAP account. For details, see [Configure S3 LDAP authentication](configure-s3-ldap-authentication.md).

### Create credentials for local accounts

Create an S3 access key and secret key for a local user.

Before you begin:

* Ensure the local user exists.
* Ensure the user has the **S3** role.
* Ensure an S3 IAM policy is attached.
* Prepare to copy the secret key when it is shown.

**GUI**

When you create a local S3 user in the GUI, WEKA generates the key pair automatically. The secret key is shown once. Save it immediately.

**CLI**

Generate a key pair for the current user or a specific user.

**Current user**

```bash
weka s3 user keys-generate
```

Generates a new S3 key pair for the currently logged-in user.

**Specific user**

```bash
weka s3 user keys-generate --user <username>
```

Generates a new S3 key pair for the specified user. Only cluster admins and tenant admins can run this command for other users.

The secret key is shown once and cannot be retrieved later. If the key is lost, generate a new key pair. The new pair invalidates the previous one.

## S3 user permissions

Access to the S3 API requires an attached IAM policy. Local users also require the **S3** role. LDAP users do not use WEKA roles.

* **Local users:** A local user needs the **S3** role and an attached S3 IAM policy before using the S3 API.
* **LDAP users:** An LDAP user needs an attached S3 IAM policy before using the S3 API.
* **Policy types:** Attach a predefined policy or a custom policy created with the [AWS Policy Generator](https://awspolicygen.s3.amazonaws.com/policygen.html).
* **Policy size:** IAM policies are limited to 2 KB. Contact the [Customer Success Team](../../../support/getting-support-for-your-weka-system.md) if you need a larger policy.
* **Identity mapping:** Use `--posix-uid` and `--posix-gid` to control the POSIX ownership of objects created by local S3 users.

## Manage S3 credentials

Configure and maintain S3 API credentials to control data access within the WEKA cluster.

#### S3 credential behavior

* **Policy detachment:** Detaching a policy removes S3 data access but does not delete the key pair.
* **Policy re-attachment:** Re-attaching any S3 policy restores access with the same key pair.
* **Tenant routing:** Each S3 access key contains the tenant identifier for correct routing in a multi-tenant cluster.
* **Generation prerequisite:** S3 API credentials can only be generated for users with an S3 policy. If a user has no attached S3 policy, the system rejects credential generation.

#### Manage S3 credentials using the CLI

**Before you begin**

* Ensure administrative privileges on the WEKA cluster.
* Verify the target user exists in the system.

**Procedure**

Run the appropriate command based on the required credential action:

*   Regenerate your own S3 credentials:

    ```bash
    weka s3 user keys-generate
    ```
*   Regenerate credentials for a specific user:

    ```bash
    weka s3 user keys-generate --user <username>
    ```
*   Attach an S3 policy to a user and auto-create credentials:

    ```bash
    weka s3 policy attach <policy> <user>
    ```
*   Detach an S3 policy and preserve credentials:

    ```bash
    weka s3 policy detach <policy> <user>
    ```

## Admin behavior

### TenantAdmin

TenantAdmin has a hardcoded Owner policy within the tenant boundary.

TenantAdmin can:

* Create S3 credentials for users in the tenant.
* Attach or detach IAM policies for users in the tenant.
* Create buckets with the CLI in the tenant.

TenantAdmin does not receive a personal S3 access key and secret key pair. TenantAdmin cannot run S3 data-plane operations directly.

### ClusterAdmin

ClusterAdmin uses cluster-wide hardcoded owner credentials.

ClusterAdmin does not receive a personal S3 access key and secret key pair. ClusterAdmin has full S3 management access across the cluster.

## Temporary credentials and service accounts

Use temporary credentials or service accounts for restricted or automated access patterns.

### IAM temporary credentials

Once a user has an attached IAM policy, the user can call AssumeRole to obtain STS credentials.

* **Components:** The API returns an access key, secret key, and session token.
* **Scope:** Permissions come from the user's primary IAM policy. You can apply a more restrictive policy in the request.
* **Automation:** S3 clients and SDKs can renew STS credentials automatically.
* **Revocation:** Delete the parent S3 user to invalidate active STS credentials and tokens.

### S3 service accounts

Service accounts are permanent child identities of a single S3 user.

* **Inheritance:** A service account inherits the parent IAM policy.
* **Restriction:** You can attach an additional policy to reduce access.
* **Management:** Only an S3 user can manage service accounts. A single user can create up to 100 service accounts.
* **Persistence:** Service accounts do not expire.

### Related topics

[Configure S3 LDAP authentication](configure-s3-ldap-authentication.md)

[Manage S3 users and authentication using the CLI](s3-users-and-authentication.md)

[User roles and permissions](../../../operation-guide/user-management/)

[Supported S3 APIs](../s3-limitations.md)
