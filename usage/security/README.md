---
description: >-
  This page describes important security consideration for the Weka cluster
  management.
---

# Manage security

General security considerations are described below.

**Related topics**

* For data security features, such as encryption by KMS, see [KMS Management](../../fs/kms-management/).
* For security topics related to mounting and separation of organizations, see [Organizations](organizations/).
* For the different user roles and AD/LDAP authentication, see [User Management](user-management.md).

## Obtain authentication tokens

The authentication tokens include two types: an access token and a refresh token.

* **Access token:** The access token is a short-live token (five minutes) used for accessing the Weka cluster API and to allow the mounting of secure filesystems.
* **Refresh token:** The refresh token is a long-live token (one year) used for obtaining an additional access token.

**Procedure**

Do one of the following:

*   To obtain the refresh token and access token, **through the CLI**, log in to the cluster using the command: `weka user login`.

    The system creates an authentication token file and saves it in: `~/.weka/auth-token.json`. The token file contains both the access token and refresh token.

![Auth-token file content example](../../.gitbook/assets/wmng\_auth\_token\_example.png)

* To obtain the refresh token and access token, **through the REST API,** use the `POST /login`. The API returns the token in the response body.

![REST API login response example](../../.gitbook/assets/wmng\_auth\_token\_api\_example.png)

### Generate an access token for API usage (for internal users only)

When working with the REST API, internal Weka users may require using a longer-lived access token (a token that doesn't require a refresh every 5 minutes).

You can generate a longer-lived access token using the CLI command:

`weka user generate-token [--access-token-timeout timeout]`

The default timeout is 30 days.

To revoke the access and refresh tokens, use the CLI command: `weka user revoke-tokens`.&#x20;

## TLS

By default, the Weka system deploys a self-signed certificate to access the GUI, CLI, and API through HTTPS.

The Weka system supports TLS 1.2 and higher with at least 128-bit ciphers.

You can deploy your certificates using the CLI command: `weka security tls set`.

The command receives an unencrypted private key.

{% hint style="success" %}
**Example:** This command is similar to the OpenSSL command that Weka uses to generate the self-signed certificate: `openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

### Certificate replacement and rotation

To replace the certificate with a new one, use the CLI command: `weka security tls set`.

Once you issue a certificate, it is used for connecting to the cluster (for the time it is issued), while the revocation is handled by the CA and propagating its revocation lists into the various clients.

## Custom CA certificates

Weka uses well-known CAs to establish trust with external services. For example, when using a KMS.

If a different CA is required for Weka servers to establish trust, install this custom CA certificate on the Weka servers using the CLI command:

`weka security ca-cert set`

## Password management

### Password requirements

* at least 8 characters
* an uppercase letter
* a lowercase letter
* a number or a special character

The [First User ](user-management.md#first-user-cluster-admin)created by default is admin (with `admin` password), and the password is prompt to change on the first login.

### Account lockout

To prevent brute force attacks, if several login attempts fail (default: 5), the user account is locked for several minutes (default: 2 minutes).

You can control the default values by using the CLI commands:

`weka security lockout-config show/set/reset`

## GUI access

You can access the Weka GUI only from the backend servers through port 14000. The GUI session is automatically terminated, and the user is signed out after 30 minutes of inactivity.

### Manage the login banner using the GUI

You can set a login banner containing a security statement or a legal message displayed on the sign-in page. You can also disable, edit, or reset the login banner.

![Sign in page with a banner example](../../.gitbook/assets/wmng\_login\_banner\_sign-in-page.png)

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the Cluster Settings pane, select **Login banner**.

![Login Banner](../../.gitbook/assets/wmng\_login\_banner\_set.png)

3\. Select **Edit Banner**.

![Write the login banner statement](../../.gitbook/assets/wmng\_login\_banner\_edit.png)

4\. In the Edit Login Banner, write your organization statement in the banner text box.

5\. Select **Save**.

6\. To prevent displaying the login banner, select **Disable Login Banner**.

7\. To clear the banner text, select **Reset Banner.**

### Manage the login banner using the CLI

To manage the login banner, use the following CLI command:

`weka security login-banner set|show|reset|enable|disable`

**Command options:**

`set:` Sets the login banner text.

`show`: Displays the login banner text.

`reset`: Clears the login banner text.

`enable`: Displays the login banner when accessing the cluster.

`disable:` Prevents displaying the login banner when accessing the cluster.

