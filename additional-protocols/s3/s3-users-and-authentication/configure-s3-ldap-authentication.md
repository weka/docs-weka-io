---
description: >-
  Integrate S3 service authentication with existing LDAP to automate key
  generation and centralize identity management.
---

# Configure S3 LDAP authentication

#### S3 LDAP Authentication

The S3 LDAP authentication feature facilitates access management by offering an API that interfaces directly with centralized identity providers. This integration reduces the need for maintaining separate S3 credentials, thereby decreasing administrative overhead.

The system manages the entire credential lifecycle using the following mechanisms:

* **Dynamic key generation:** When an authentication request is made for the first time, the API creates a unique and permanent access key and secret key for the S3 service.
* **Policy-driven access control:** User permissions are enforced by aligning LDAP attributes with S3 IAM policies. During authentication, the system strictly validates, if an LDAP user lacks a policy or has malformed UID or GID strings, credential retrieval fails.
* **Consistent identity mapping:** To maintain consistent permissions across protocols, the system retrieves UID and GID values directly from LDAP attributes. Empty fields are automatically set to 0, ensuring structural uniformity.
* **Revocation management:** Administrators can manage revocation by removing an IAM policy linked to an LDAP attribute or by deleting the key pair, ensuring the primary LDAP account remains unaffected.

## Manage the S3 credential lifecycle

Perform these tasks to create, update, or revoke S3 credentials using LDAP authentication.

**Before you begin**

* Ensure the LDAP service is configured and reachable by the S3 service.
* Verify that the LDAP user has the required S3 IAM policy assigned within their LDAP attributes.
* Obtain the cluster management IP or DNS name.

#### Generate S3 credentials

To authenticate an LDAP user and generate a new S3 key pair, execute a POST request.

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

The response returns a randomly generated access key and secret key.

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

The existing access key and secret key remain unchanged.

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
