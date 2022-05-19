---
description: >-
  This page describes the management of a Key Management System (KMS) within the
  Weka system.
---

# KMS Management

## Overview

When creating an encrypted filesystem, a KMS must be used to properly secure the encryption keys.

The Weka system uses the KMS to encrypt filesystem keys. When the Weka system comes up, it uses the KMS to decrypt the filesystem keys and use its in-memory capabilities for data encrypting/decrypting operations.

When a snapshot is taken using the Snap-To-Object feature, the encrypted filesystem key is saved along with the encrypted data. In the event of rehydrating this snapshot to a different filesystem (or when recovering from a disaster to the same filesystem in the Weka cluster), the KMS is used to decrypt the filesystem key. Consequently, the same KMS data must be present when performing such operations.

For increased security, the Weka system does not save any information that can reconstruct the KMS encryption keys, which is performed by the KMS configuration alone. Therefore, the following should be considered:

1. If the KMS configuration is lost, the encrypted data may also be lost. Therefore, a proper DR strategy should be set when deploying the KMS in a production environment.
2. The KMS should be available when the Weka system comes up when a new filesystem is created, and from time to time when key rotations must be performed. Therefore, it is recommended that the KMS be highly available.

For more information, refer to [KMS Best Practices](kms-management.md#kms-best-practices).

The Weka system supports the following KMS types:

1. [HashiCorp Vault](https://www.hashicorp.com/products/vault/) (version 1.1.5 and up). For setting up Vault to work with the Weka system, refer to [Setting Up Vault Configuration](kms-management.md#setting-up-vault-configuration).
2. [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) compliant KMS (protocol version 1.2 and up)

For additional information on KMS support, contact the Weka Sales or Support Teams.

## Managing KMS Using the GUI

### Adding a KMS

To add a KMS to the Weka system, go to the KMS Configuration screen on the left sidebar and click Configure KMS.

![](<../../.gitbook/assets/KMS not set main screen 3.5.png>)

The Configure KMS dialog box will be displayed.

![Configure KMS Dialog Box](<../../.gitbook/assets/KMS configure empty 3.5.png>)

Enter the URL, key name, and API token, and click Update to configure the KMS.

### Viewing the KMS

To view the configured KMS, go to the main KMS configuration screen.

![KMS Configuration Screen](<../../.gitbook/assets/KMS View 3.5.png>)

### Updating the KMS Configuration

To update the KMS configuration, click Update KMS. The Configure KMS dialog box will be displayed.

![Configure KMS Dialog Box](<../../.gitbook/assets/KMS configure 3.5.png>)

Update the URL, master key or API token, and click Update.

### Removing the KMS

To remove a KMS configuration (an operation that is only possible if no encrypted filesystems exist), click the Reset KMS button on the main KMS Configuration screen. The KMS Reset dialog box will be displayed.

![KMS Reset Dialog Box](<../../.gitbook/assets/KMS remove 3.5.png>)

Click Yes to remove the KMS configuration.

## Managing KMS using the CLI

### Adding/Updating a KMS

**Command:** `weka security kms set`

Use the following command line to add or update the Vault KMS configuration in the Weka system:

`weka security kms set <type> <address> <key-identifier> [--token token] [--client-cert client-cert] [--client-key client-key] [--ca-cert ca-cert]`

**Parameters in Command Line**

| **Name**         | **Type** | **Value**                                              | **Limitations**                                                                                                                                                                                                                                                                                                                        | **Mandatory**                                                     | **Default** |
| ---------------- | -------- | ------------------------------------------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ----------- |
| `type`           | String   | Type of the KMS                                        | Either `vault` or `kmip`                                                                                                                                                                                                                                                                                                               | Yes                                                               |             |
| `address`        | String   | KMS server address                                     | `URL` for Vault, `hostname:port` for KMIP                                                                                                                                                                                                                                                                                              | Yes                                                               |             |
| `key-identifier` | String   | Key  to be used for encryption-as-a-service in the KMS | Key name (for Vault) or a key UID (for KMIP)                                                                                                                                                                                                                                                                                           | Yes                                                               |             |
| `token`          | String   | API token to access Vault KMS                          | <p>Must have:</p><ul><li>read permissions to <code>transit/keys/&#x3C;master-key-name></code></li><li>write permissions to <code>transit/encrypt/&#x3C;master-key-name></code> and <code>transit/decrypt/&#x3C;masterkeyname></code> </li><li>permissions to <code>/transit/rewrap</code> and <code>auth/token/lookup</code></li></ul> | Must be supplied for `vault` and must not be supplied for `kmip`  |             |
| `client-cert`    | String   | Path to the client certificate PEM file                | Must permit `encrypt` and `decrypt` permissions                                                                                                                                                                                                                                                                                        | Must be supplied for `kmip` and must not be supplied for `vault`  |             |
| `client-key`     | String   | Path to the client key PEM file                        |                                                                                                                                                                                                                                                                                                                                        | Must be supplied for `kmip` and must not be supplied for `vault`  |             |
| `ca-cert`        | String   | Path to the CA certificate PEM file                    |                                                                                                                                                                                                                                                                                                                                        | Optional for `kmip` and must not be supplied for `vault`          |             |

{% hint style="info" %}
**Note:** For the add/update command to succeed, the KMS should be preconfigured and available with the key and a valid token.
{% endhint %}

{% hint style="success" %}
**For Example:**

Setting the Weka system with a Vault KMS:

`weka security kms set vault https://vault-dns:8200 weka-key --token s.nRucA9Gtb3yNVmLUK221234`

Setting the Weka system with a KMIP complaint KMS (e.g., SmartKey):

`weka security kms set kmip amer.smartkey.io:5696 b2f81234-c0f6-4d63-b5b3-84a82e231234 --client-cert smartkey_cert.pem --client-key smartkey_key.pem`
{% endhint %}

### Viewing the KMS

**Command:** `weka security kms`

Use this command to show the details of the configured KMS.

### Removing the KMS

**Command:** `weka security kms unset`

Use this command to remove the KMS from the Weka system. It is only possible to remove a KMS configuration if no encrypted filesystems exist.

{% hint style="warning" %}
**Note:** To force remove a KMS even if encrypted filesystems exist, use the `--allow-downgrade` attribute. In such cases, the encrypted filesystem keys are re-encrypted with local encryption and may be compromised.
{% endhint %}

### **Re-wrapping Filesystem Keys**

**Command:** `weka security kms rewrap`

If the KMS key is compromised or requires rotation, the KMS admin can rotate the key in the KMS. In such cases, this command is used to re-encrypt the encrypted filesystem keys with the new KMS master key.

`weka security kms rewrap [--new-key-uid new-key-uid]`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                                                            | **Limitations** | **Mandatory**                                                    | **Default** |
| ------------- | -------- | -------------------------------------------------------------------- | --------------- | ---------------------------------------------------------------- | ----------- |
| `new-key-uid` | String   | Unique identifier for the new key to be used to wrap filesystem keys |                 | Must be supplied for `kmip` and must not be supplied for `vault` |             |

{% hint style="info" %}
**Note:** Existing filesystem keys that are part of the Snap-To-Object feature will not be automatically re-encrypted with the new KMS key.
{% endhint %}

{% hint style="warning" %}
**Note:** Unlike in Vault KMS, re-wrapping a KMIP based KMS requires generating a new key in the KMS, rather than rotating the same key. Hence, the old key should be preserved in the KMS in order to be able to decrypt old Snap2Obj snapshots.
{% endhint %}

## KMS Best Practices

The KMS is the only source holding the key to decrypt Weka system filesystem keys. For non-disruptive operation, it is highly recommended to follow these guidelines:

* Set-up DR for the KMS (backup/replication) to avoid any chance of data loss.
* Ensure that the KMS is highly available (note that the KMS is represented by a single URL in the Weka system).
* Provide access to the KMS from the Weka system backend hosts.
* Verify the methods used by the KMS being implemented (each KMS has different methods for securing/unsealing keys and for reconstructing lost keys, e.g., [Vault unsealing methods](https://www.vaultproject.io/docs/concepts/seal.html), which enable the configuration of [auto unsealing using a trusted service](https://learn.hashicorp.com/vault/operations/ops-autounseal-aws-kms)).
* Refer to [Production Hardening](https://learn.hashicorp.com/vault/operations/production-hardening) for additional best practices suggested by HashiCorp when using Vault.

{% hint style="info" %}
**Note:** Taking a Snap-To-Object ensures that the (encrypted) filesystems keys are backed up to the object store, which is important if a total corruption of the Weka system configuration occurs.
{% endhint %}

## Setting-Up Vault Configuration

### Enabling 'Transit' Secret Engine in Vault

As described above, the Weka system uses [encryption-as-a-service](https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit) capabilities of the KMS to encrypt/decrypt the filesystem keys. This requires the configuration of Vault with the `transit` secret engine.

```
$ vault secrets enable transit
Success! Enabled the transit secrets engine at: transit/
```

For more information, refer to [Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html).

### Setting-Up a Master Key for the Weka System

Once the `transit` secret engine is set up, a master key for use with the Weka system must be created.

```
$ vault write -f transit/keys/weka-key
Success! Data written to: transit/keys/weka-key
```

{% hint style="info" %}
**Note:** It is possible to either create a different key for each Weka cluster or to share the key between different Weka clusters.
{% endhint %}

For more information, refer to [Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html).

### Creating a Policy for Master Key Permissions

* Create a `weka_policy.hcl` file with the following content:

```
path "transit/+/weka-key" {
  capabilities = ["read", "create", "update"]
}
path "transit/keys/weka-key" {
  capabilities = ["read"]
}
```

This limits the capabilities so there is no permission to destroy the key, using this policy. This protection is important when creating an API token.

* Create the policy using the following command:

```
$ vault policy write weka weka_policy.hcl
```

### Obtaining an API Token from Vault

Authentication from the Weka system to Vault relies on an API token. Since the Weka system must always be able to communicate with the KMS, a [periodic service token](https://www.vaultproject.io/docs/concepts/tokens.html#periodic-tokens) must be used.

* Verify that the`token` authentication method in Vault is enabled. This can be performed using the following command:

```
$ vault auth list

Path         Type        Description
----         ----        -----------
token/       token       token based credentials
```

* To enable the token authentication method use the following command:

```
$ vault auth enable token
```

* Log into the KMS system using any of the identity methods supported by Vault. The identity should have permission to use the previously-set master key.&#x20;
* Create a token role for the identity using the following command:

```
$ vault write auth/token/roles/weka allowed_policies="weka" period="768h"
```

{% hint style="info" %}
**Note:** The `period` is the time set for a renewal request. If no renewal is requested during this time period, the token will be revoked and a new token must be retrieved from Vault and set in the Weka system.
{% endhint %}

* Generate a token for the logged-in identity using the following command:

```
$ vault token create -role=weka

Key                  Value
---                  -----
token                s.nRucA9Gtb3yNVmLUK221234
token_accessor       4Nm9BvIVS4HWCgLATc3r1234
token_duration       768h
token_renewable      true
token_policies       ["default"]
identity_policies    []
policies             ["default"]
```

For more information on obtaining an API token, refer to [Vault Tokens documentation](https://learn.hashicorp.com/vault/security/tokens).

{% hint style="warning" %}
**Note:** The Weka system does not automatically renew the API token lease. It can be renewed using the [Vault CLI/API](https://learn.hashicorp.com/vault/security/tokens#step-3-renew-service-tokens). It is also possible to define a higher maximum token value (`max_lease_ttl)`by changing the [Vault Configuration file](https://www.vaultproject.io/docs/configuration/index.html#max\_lease\_ttl).
{% endhint %}

## Obtaining a Certificate for a KMIP based KMS

The method for obtaining a client certificate and key and set it via the KMS is different for each KMS. The certificate itself will be generated using OpenSSL, with some UID obtained from the KMS, e.g.:

```
openssl req -x509 -newkey rsa:4096 -keyout client-key.pem -out client-cert.pem -days 365 -nodes -subj '/CN=f283c99b-f173-4371-babc-572961161234'
```

Please consult the specific KMS documentation to create a certificate and link it to the Weka cluster in the  KMS with sufficient privileges (encrypt/decrypt).

For example, for SmartKey KMS, follow similar instruction as suggested [here](https://docs.equinix.com/en-us/Content/Edge-Services/SmartKey/kb/SK-mongodb.htm) to create a client certificate and key, and to assign a certificate for Weka within SmartKey.
