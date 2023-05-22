---
description: >-
  This page describes how to manage the Key Management System (KMS) using the
  CLI.
---

# Manage KMS using the CLI

Using the CLI, you can:

* [Add or update the KMS](kms-management-1.md#add-or-update-the-kms)
* [View the KMS](kms-management-1.md#view-the-kms)
* [Remove the KMS](kms-management-1.md#remove-the-kms)
* [Set up vault configuration](kms-management-1.md#set-up-vault-configuration)
* [Obtain a certificate for a KMIP-based KMS](kms-management-1.md#obtain-a-certificate-for-a-kmip-based-kms)

## Add or update the KMS

**Command:** `weka security kms set`

Use the following command line to add or update the Vault KMS configuration in the Weka system:

`weka security kms set <type> <address> <key-identifier> [--token token] [--client-cert client-cert] [--client-key client-key] [--ca-cert ca-cert]`

**Parameters**

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
**Example:**

Setting the Weka system with a Vault KMS:

`weka security kms set vault https://vault-dns:8200 weka-key --token s.nRucA9Gtb3yNVmLUK221234`

Setting the Weka system with a KMIP complaint KMS (e.g., SmartKey):

`weka security kms set kmip amer.smartkey.io:5696 b2f81234-c0f6-4d63-b5b3-84a82e231234 --client-cert smartkey_cert.pem --client-key smartkey_key.pem`
{% endhint %}

## View the KMS

**Command:** `weka security kms`

Use this command to show the details of the configured KMS.

## Remove the KMS

**Command:** `weka security kms unset`

Use this command to remove the KMS from the Weka system. It is only possible to remove a KMS configuration if no encrypted filesystems exist.

{% hint style="warning" %}
**Note:** To force remove a KMS even if encrypted filesystems exist, use the `--allow-downgrade` attribute. In such cases, the encrypted filesystem keys are re-encrypted with local encryption and may be compromised.
{% endhint %}

### **Re-wrap filesystem keys**

**Command:** `weka security kms rewrap`

If the KMS key is compromised or requires rotation, the KMS admin can rotate the key in the KMS. In such cases, this command is used to re-encrypt the encrypted filesystem keys with the new KMS master key.

`weka security kms rewrap [--new-key-uid new-key-uid]`

**Parameters**

| Name            | Value                                                                                                                                                                     |
| --------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `new-key-uid`\* | <p>Unique identifier for the new key to be used to wrap filesystem keys.<br>Mandatory for <code>kmip</code> only.<br>Do not specify any value for <code>vault</code>.</p> |

{% hint style="info" %}
**Note:** Existing filesystem keys that are part of the Snap-To-Object feature will not be automatically re-encrypted with the new KMS key.
{% endhint %}

{% hint style="warning" %}
**Note:** Unlike in Vault KMS, re-wrapping a KMIP-based KMS requires generating a new key in the KMS, rather than rotating the same key. Hence, the old key should be preserved in the KMS in order to be able to decrypt old Snap2Obj snapshots.
{% endhint %}

## Set up vault configuration

### Enable 'Transit' secret engine in vault

The Weka system uses [encryption-as-a-service](https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit) capabilities of the KMS to encrypt/decrypt the filesystem keys. This requires the configuration of Vault with the `transit` secret engine.

```
$ vault secrets enable transit
Success! Enabled the transit secrets engine at: transit/
```

For more information, refer to [Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html).

### Set up a master key for the Weka system

Once the `transit` secret engine is set up, a master key for use with the Weka system must be created.

```
$ vault write -f transit/keys/weka-key
Success! Data written to: transit/keys/weka-key
```

{% hint style="info" %}
**Note:** It is possible to either create a different key for each Weka cluster or to share the key between different Weka clusters.
{% endhint %}

For more information, refer to [Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html).

### Create a policy for master key permissions

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

### Obtain an API token from the vault

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

## Obtain a certificate for a KMIP-based KMS

The method for obtaining a client certificate and key and set it via the KMS is different for each KMS. The certificate itself is generated using OpenSSL, with a UID obtained from the KMS.

**Example**:

```
openssl req -x509 -newkey rsa:4096 -keyout client-key.pem -out client-cert.pem -days 365 -nodes -subj '/CN=f283c99b-f173-4371-babc-572961161234'
```

See the specific KMS documentation to create a certificate and link it to the Weka cluster in the  KMS with sufficient privileges (encrypt/decrypt).

For example, for SmartKey KMS, follow similar instructions as suggested [here](https://docs.equinix.com/en-us/Content/Edge-Services/SmartKey/kb/SK-mongodb.htm) to create a client certificate and key, and assign a certificate for Weka within SmartKey.
