---
description: >-
  Integrate S3 service authentication with existing LDAP to provision S3
  accounts and centralize identity management.
---

# Configure S3 LDAP authentication

#### S3 LDAP Authentication

The S3 LDAP authentication feature facilitates access management by offering an API that interfaces directly with centralized identity providers. LDAP users get S3 access without an administrator creating a local account for each of them.

The system manages the entire credential lifecycle using the following mechanisms:

* **Account provisioning:** The first import request for an LDAP user creates an S3 account for that user in the cluster. The response returns the account name and password.
* **Separate S3 keys:** The S3 access key and secret key are separate from the account name and password. Generate them with `weka s3 user keys-generate`, either as the user or as an administrator.
* **Policy-driven access control:** User permissions are enforced by aligning LDAP attributes with S3 IAM policies. Creating the account requires an S3 IAM policy in the user's LDAP attributes.
* **Consistent identity mapping:** To maintain consistent permissions across protocols, the system retrieves UID and GID values directly from LDAP attributes. When the `uidNumber` or `gidNumber` attribute is missing, empty, not a number, or 0, objects the user creates keep the S3 service's default ownership.
* **Revocation management:** Administrators can manage revocation by removing an IAM policy linked to an LDAP attribute or by deleting the key pair, ensuring the primary LDAP account remains unaffected.

## Manage the S3 credential lifecycle

Perform these tasks to create, update, or revoke S3 credentials using LDAP authentication.

**Before you begin**

* Ensure the LDAP service is configured and reachable by the S3 service.
* Verify that the LDAP user has the required S3 IAM policy assigned within their LDAP attributes.
* Obtain the cluster management IP or DNS name.

#### Import the LDAP user

To authenticate an LDAP user and create the S3 account, execute a POST request.

Use the tenant-aware URL when you want to import the LDAP user directly into a specific tenant.

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X POST https://<weka_cluster_address>:14000/api/v2/s3/<TenantID>/ldapImportUser -k
```
{% endcode %}

{% hint style="info" %}
`<TenantID>` is optional. If omitted, the request defaults to Tenant 0 for backward compatibility. This applies to all LDAP import requests.
{% endhint %}

Use the backward-compatible URL when you want to target Tenant 0 explicitly by omission:

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X POST https://<weka_cluster_address>:14000/api/v2/s3/ldapImportUser -k
```
{% endcode %}

The response returns the S3 account credentials in the `access_key` and `secret_key` fields. These are the account name and password for logging in to the cluster. S3 clients use a separate key pair, which you generate in the next step. Save the account credentials for that step.

#### Generate the S3 access key and secret key

Generate the key pair that S3 clients use. Either the user or an administrator can generate it.

**As the LDAP user**

1. Log in to the cluster with the account credentials from the import response:

   ```bash
   weka user login <access_key> <secret_key>
   ```

   If you imported the user into a tenant other than Tenant 0, add `--tenant <TenantID>`.
2. Generate the key pair:

   ```bash
   weka s3 user keys-generate
   ```

**As a cluster admin or tenant admin**

Generate the key pair for the account, using the `access_key` value from the import response as the username:

```bash
weka s3 user keys-generate --user <access_key>
```

The command shows the S3 access key and secret key. The secret key is shown once. Store it securely. To replace a lost secret key, run the command again: the new key pair replaces the previous one.

#### Update account attributes

To refresh the IAM policy, UID, or GID for an existing S3 user, execute a PUT request.

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X PUT https://<weka_cluster_address>:14000/api/v2/s3/<TenantID>/ldapImportUser -k
```
{% endcode %}

Backward-compatible Tenant 0 variant:

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X PUT https://<weka_cluster_address>:14000/api/v2/s3/ldapImportUser -k
```
{% endcode %}

The account credentials and the S3 key pair remain unchanged.

#### Revoke S3 access

To permanently delete the S3 account and credentials, execute a DELETE request.

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X DELETE https://<weka_cluster_address>:14000/api/v2/s3/<TenantID>/ldapImportUser -k

```
{% endcode %}

Backward-compatible Tenant 0 variant:

{% code overflow="wrap" %}
```bash
curl -u "ldap_user:ldap_password" -X DELETE https://<weka_cluster_address>:14000/api/v2/s3/ldapImportUser -k
```
{% endcode %}

#### Extended User Attributes

Use these attributes to map S3 IAM policy on the WEKA cluster.

| Parameter      | Description                             |
| -------------- | --------------------------------------- |
| `wekaS3Policy` | The name of the existing S3 IAM policy. |
| `uidNumber`    | The UID number.                         |
| `gidNumber`    | The GID number.                         |

#### S3 LDAP API parameters

Use these parameters to interface with the LDAP authentication endpoint.

<table><thead><tr><th width="215.8182373046875">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>ldap_user</code> *</td><td>The username defined in the LDAP directory.</td></tr><tr><td><code>ldap_password</code> *</td><td>The password associated with the LDAP user.</td></tr><tr><td><code>weka_cluster_address</code> *</td><td>The IP address or FQDN of the cluster management interface.</td></tr><tr><td><code>TenantID</code></td><td>(Optional) The tenant identifier used to specify which LDAP configuration to query. If not provided, defaults to Tenant 0.</td></tr><tr><td><code>-k</code></td><td>Instructs curl to proceed if the SSL certificate is self-signed.</td></tr></tbody></table>
