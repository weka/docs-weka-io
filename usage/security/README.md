---
description: >-
  This page describes important security consideration for the Weka cluster
  management.
---

# Security management

The Weka system is a secured environment. It deploys a combination of security controls to ensure secured communication and secured user data.

The security controls include the following:

* **HTTPS access:** To access the Weka GUI, you connect only to one of the system servers using HTTPS through port 14000.
* **Authentication tokens:** The **** authentication tokens are used **** for accessing the Weka system API and to allow the mounting of secure filesystems.
* **KMS:** When creating an encrypted filesystem, a KMS must be used to properly secure the encryption keys. The KMS encrypts and decrypts filesystem keys.
* **TLS certificates:** By default, the system deploys a self-signed certificate to access the GUI, CLI, and API through HTTPS.  You can deploy your certificate by providing an unencrypted private key and certificate PEM files.
* **CA certificates:** The system uses well-known CA certificates to establish trust with external services. For example, when using a KMS.
* **Account lockout:** To prevent brute force attacks, if several login attempts fail (default: 5), the user account is locked for several minutes (default: 2 minutes).
* **Login banner:** The login banner provides a security statement or a legal message displayed on the sign-in page.
* **GUI session automatic termination:** The user is signed out after 30 minutes of inactivity.

****

**Related topics**

[obtain-authentication-tokens.md](obtain-authentication-tokens.md "mention")

[kms-management](kms-management/ "mention")****

[tls-certificate-management](tls-certificate-management/ "mention")****

[ca-certificate-management](ca-certificate-management/ "mention")****

[account-lockout-threshold-policy-management](account-lockout-threshold-policy-management/ "mention")

[organizations](../organizations/ "mention")\
&#x20;   (security topics related to mounting and separation of organizations)

[user-management](../user-management/ "mention")\
&#x20;   (authentication of different user roles and AD/LDAP)
