---
description: >-
  This page describes important security consideration for the Weka cluster
  management.
---

# Manage security

## Overview

General security considerations are described below.

* For data security features, such as encryption via KMS, refer to the [KMS Management](../../fs/kms-management.md) section.
* For security around mounting and separation of organizations, refer to the [Organizations](organizations.md) section.
* Different user roles and AD/LDAP authentication is described in the [User Management](user-management.md) section.

## Obtaining an authentication token

An authentication token is used to access the Weka cluster API, and allow the mounting of secure filesystems.

It is first required to log in to obtain an access token. Log in via the CLI (using the `weka user login` CLI command, a token file is created in `~/.weka/auth-token.json`) or via the API (using the `POST /login` API).

This provides an access token to be used to authenticate the command, as long as a longer-lived refresh-token, to allow re-obtaining additional access-tokens without providing the username/password again.

#### Access token for API usage

When working with REST API, it is sometimes desired to use a longer-lived token (one that doesn't require a refresh every 5 minutes). It is possible to generate such a token for internal Weka users using the `weka user generate-token [--access-token-timeout timeout]` CLI command (default to  30 days).

Access-tokens are revoked when calling the `weka user revoke-tokens` CLI command.&#x20;

## TLS

By default, the Weka system deploys a self-signed certificate to access the GUI, CLI, and API via HTTPS.

The Weka system allows using only TLS 1.2 and higher with at least 128-bit ciphers.

You can deploy your certificates using the `weka security tls set` CLI command. The command receives an unencrypted private key.

{% hint style="success" %}
**Example:** This is a similar command to what Weka uses to generate the self-signed certificate using  OpenSSL:`openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

### Certificate replacement and rotation

To replace the certificate, use the `weka security tls set` CLI command to set a new one. Once a certificate has been issued, it is used for connecting to the cluster (for the time it has been issued), while the revocation is handled by the CA and propagating its revocation lists into the various clients.

## Custom CA certificates

Weka uses well-known CAs to establish trust with external services, e.g., when using a KMS. If a different CA is required for Weka servers to establish trust, use `weka security ca-cert set` CLI command to install this custom CA certificate on the Weka servers.

## Password management

### Password requirements

* at least 8 characters
* an uppercase letter
* a lowercase letter
* a number or a special character

The [First User ](user-management.md#first-user-cluster-admin)created by default is admin (with `admin` password), and the password is prompt to change on the first login.

### Account lockout

To prevent brute force attacks, if several login attempts fail (5 by default), the user account will be locked out for several minutes (2 by default).

The defaults can be controlled using the `weka security lockout-config show/set/reset` CLI commands.&#x20;

## GUI

* The Weka GUI is (only) accessible from the backend servers via port 14000.
* The GUI session will automatically be terminated, and the user will get logged out after 30 minutes of inactivity.

### Security login statement

It is possible to set a security/legal login statement that will add a banner with that statement on the GUI login page.

To set the statement, use the `weka security login-banner set|show|reset|enable|disable` CLI command or the GUI `Login Banner` menu.&#x20;
