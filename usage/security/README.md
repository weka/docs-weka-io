---
description: >-
  This page describes important security consideration for the Weka cluster
  management.
---

# Security

## Overview

General security considerations are described below.

* For data security features, such as encryption via KMS, refer to the [KMS Management](../../fs/managing-filesystems/kms-management.md) section.
* For security around mounting and separation of organizations, refer to the [Organizations](organizations.md) section.
* Different user roles and AD/LDAP authentication is described in the [User Management](user-management.md) section.

## Obtaining an Authentication Token

An authentication token is used to access the Weka cluster API, and allow mounting secure filesystems.

It is first required to log in to obtain an access token. Log in via the CLI \(using the `weka user login` CLI command, a token file is created in `~/.weka/auth-token.json`\) or via the API \(using the `POST /login` API\).

This provides an access token to be used to authenticate the command, as long as a longer-lived refresh-token, to allow re-obtaining additional access-tokens without providing the username/password again.

## TLS

By default, the Weka system deploys a self-signed certificate to access the GUI, CLI, and API via HTTPS.

The Weka system allows using only TLS 1.2 and higher with at least 128-bit ciphers.

You can deploy your certificates using the `weka security tls set` CLI command. The command receives an unencrypted private key.

{% hint style="success" %}
**For example,** this is a similar command to what Weka uses to generate the self-signed certificate using  OpenSSL:`openssl req -x509 -newkey rsa:1024 -keyout key.pem -out cert.pem -days <days> -nodes`
{% endhint %}

### Certificate Replacement/Rotation

To replace the certificate, use the `weka security tls set` CLI command to set a new one. Once a certificate has been issued, it is used for connecting to the cluster \(for the time it has been issued\), while the revocation is handled by the CA and propagating its revocation lists into the various clients.

## Password Management

### Password requirements

* at least 8 characters
* an uppercase letter
* a lowercase letter
* a number or a special character

The [First User ](user-management.md#first-user-cluster-admin)created by default is admin \(with `admin` password\), and the password is prompt to change on the first login.

### Account Lockout

To prevent brute force attacks, if several login attempts fail, the user account will be locked out for several minutes.

The defaults can be controlled using the `weka security lockout-config show/set/reset` CLI commands. 

## GUI

* The Weka GUI is \(only\) accessible from the backend servers via port 14000.
* The GUI session will automatically be terminated, and the user will get logged out after 30 minutes of inactivity.

