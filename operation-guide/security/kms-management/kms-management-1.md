---
description: >-
  Explore commands for managing Key Management System (KMS) integration with the
  WEKA system using the CLI.
---

# Manage KMS using the CLI

Using the CLI, you can:

* [Configure the KMS](kms-management-1.md#configure-the-kms)
* [View the KMS configuration](kms-management-1.md#view-the-kms-configuration)
* [Remove the KMS configuration](kms-management-1.md#remove-the-kms-configuration)
* [Set up vault configuration](kms-management-1.md#set-up-vault-configuration)
* [Obtain a certificate for a KMIP-based KMS](kms-management-1.md#obtain-a-certificate-for-a-kmip-based-kms)

## Configure the KMS

**Command:** `weka security kms set`

To integrate the Key Management Service (KMS) with the WEKA system, use the provided command line for adding or updating the KMS configuration. Ensure that the KMS is preconfigured, and both the key and a valid token are readily available.

Run the following command to establish a connection between the WEKA system and the configured Vault KMS.

`weka security kms set <type> <address> <key-identifier> [--token token] [--namespace namespace] [--client-cert client-cert] [--client-key client-key] [--ca-cert ca-cert]`&#x20;

**Parameters**

| Name               | Value                                               | Limitations                                                                                                                                                                                                                                                                                                                                                                                                             |
| ------------------ | --------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `type`\*           | Type of the KMS.                                    | Possible values:  `vault` or `kmip`                                                                                                                                                                                                                                                                                                                                                                                     |
| `address`\*        | KMS server address.                                 | <p><code>URL</code> for <code>vault</code></p><p><code>hostname:port</code> for <code>kmip</code></p>                                                                                                                                                                                                                                                                                                                   |
| `key-identifier`\* | Key to secure the filesystem keys.                  | <p>Key name for <code>vault</code></p><p>Key UID for <code>kmip</code></p>                                                                                                                                                                                                                                                                                                                                              |
| `token`            | API token to access Vault KMS.                      | <p>Mandatory for  <code>vault</code>.</p><p>Prohibited for <code>kmip</code>.</p><p>Must have:</p><ul><li>read permissions to <code>transit/keys/&#x3C;master-key-name></code></li><li>write permissions to <code>transit/encrypt/&#x3C;master-key-name></code> and <code>transit/decrypt/&#x3C;masterkeyname></code> </li><li>permissions to <code>/transit/rewrap</code> and <code>auth/token/lookup</code></li></ul> |
| `namespace`        | The vault's namespace name.                         | Namespace names must not end with "/", avoid spaces, and refrain from using reserved names like `root`, `sys`, `audit`, `auth`, `cubbyhole`, and `identity`.                                                                                                                                                                                                                                                            |
| `client-cert`      | <p>Path to the client certificate PEM file.<br></p> | <p>Must permit <code>encrypt</code> and <code>decrypt</code> permissions.<br>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p>                                                                                                                                                                                                                                                             |
| `client-key`       | Path to the client key PEM file.                    | <p>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p>                                                                                                                                                                                                                                                                                                                                       |
| `ca-cert`          | <p>Path to the CA certificate PEM file.<br></p>     | <p>Optional for <code>kmip</code>.</p><p>Prohibited for <code>vault</code>.</p>                                                                                                                                                                                                                                                                                                                                         |

{% hint style="success" %}
**Example:**

Setting the WEKA system with a Vault KMS:

`weka security kms set vault https://vault-dns:8200 weka-key --token s.nRucA9Gtb3yNVmLUK221234`

Setting the WEKA system with a KMIP complaint KMS (SmartKey example):

`weka security kms set kmip amer.smartkey.io:5696 b2f81234-c0f6-4d63-b5b3-84a82e231234 --client-cert smartkey_cert.pem --client-key smartkey_key.pem`
{% endhint %}

## View the KMS configuration

**Command:** `weka security kms`

Use this command to show the details of the configured KMS.

## Remove the KMS configuration

**Command:** `weka security kms unset`

Use this command to remove the KMS from the Weka system. It is only possible to remove a KMS configuration if no encrypted filesystems exist.

{% hint style="warning" %}
To force remove a KMS even if encrypted filesystems exist, use the `--allow-downgrade` attribute. In such cases, the encrypted filesystem keys are re-encrypted with local encryption and may be compromised.
{% endhint %}

### **Re-wrap filesystem keys**

**Command:** `weka security kms rewrap`

If the KMS key is compromised or requires rotation, the KMS admin can rotate the key in the KMS. In such cases, this command is used to re-encrypt the encrypted filesystem keys with the new KMS master key.

`weka security kms rewrap [--new-key-uid new-key-uid]`

**Parameters**

<table><thead><tr><th width="175">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>new-key-uid</code>*</td><td>Unique identifier for the new key to be used to wrap filesystem keys.<br>Mandatory for <code>kmip</code> only.<br>Do not specify any value for <code>vault</code>.</td></tr></tbody></table>

{% hint style="info" %}
WEKA does not automatically re-encrypt existing filesystem keys with the new KMS key for the existing snapshots already uploaded with the old encrypted keys.
{% endhint %}

{% hint style="warning" %}
In contrast to Vault KMS, the process of re-wrapping a KMIP-based KMS involves generating a new key within the KMS, rather than rotating the existing key. Therefore, it is essential to retain the old key within the KMS to ensure the ability to decrypt older Snap-to-Object snapshots.
{% endhint %}

## Set up vault configuration

### Enable 'Transit' secret engine in vault

The WEKA system uses [encryption-as-a-service](https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit) capabilities of the KMS to encrypt/decrypt the filesystem keys. This requires the configuration of Vault with the `transit` secret engine.

```bash
$ vault secrets enable transit
Success! Enabled the transit secrets engine at: transit/
```

### Set up a master key for the WEKA system

Once the `transit` secret engine is set up, a master key for use with the WEKA system must be created.

```bash
$ vault write -f transit/keys/weka-key
Success! Data written to: transit/keys/weka-key
```

{% hint style="info" %}
It is possible to either create a different key for each WEKA cluster or to share the key between different WEKA clusters.
{% endhint %}

**Related information:**

[Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html)&#x20;

### Create a policy for master key permissions

* Create a `weka_policy.hcl` file with the following content:

```bash
path "transit/+/weka-key" {
  capabilities = ["read", "create", "update"]
}
path "transit/keys/weka-key" {
  capabilities = ["read"]
}
```

This limits the capabilities so there is no permission to destroy the key, using this policy. This protection is important when creating an API token.

* Create the policy using the following command:

```bash
$ vault policy write weka weka_policy.hcl
```

### Obtain an API token from the vault

Authentication from the WEKA system to Vault relies on an API token. Since the WEKA system must always be able to communicate with the KMS, a [periodic service token](https://www.vaultproject.io/docs/concepts/tokens.html#periodic-tokens) must be used.

* Verify that the`token` authentication method in Vault is enabled. This can be performed using the following command:

```bash
$ vault auth list

Path         Type        Description
----         ----        -----------
token/       token       token based credentials
```

* To enable the token authentication method use the following command:

```
$ vault auth enable token
```

* Log into the KMS system using any of the identity methods Vault supports. The identity should have permission to use the previously set master key.&#x20;
* Create a token role for the identity using the following command:

{% code overflow="wrap" %}
```bash
$ vault write auth/token/roles/weka allowed_policies="weka" period="768h"
```
{% endcode %}

{% hint style="info" %}
The `period` is the designated timeframe for a renewal request. If a renewal is not requested within this period, the token is revoked, necessitating the retrieval of a new token from the Vault and its configuration in the WEKA system.
{% endhint %}

* Generate a token for the logged-in identity using the following command:

```bash
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
The WEKA system does not automatically renew the API token lease. It can be renewed using the [Vault CLI/API](https://learn.hashicorp.com/vault/security/tokens#step-3-renew-service-tokens). It is also possible to define a higher maximum token value (`max_lease_ttl)`by changing the [Vault Configuration file](https://www.vaultproject.io/docs/configuration/index.html#max\_lease\_ttl).
{% endhint %}

## Obtain a certificate for a KMIP-based KMS

Each KMS employs a unique process for obtaining a client certificate and key and configuring it through the KMS. The certificate is generated using OpenSSL and utilizes a UID obtained from the KMS.

**Example**:

{% code overflow="wrap" %}
```bash
openssl req -x509 -newkey rsa:4096 -keyout client-key.pem -out client-cert.pem -days 365 -nodes -subj '/CN=f283c99b-f173-4371-babc-572961161234'
```
{% endcode %}

Refer to the specific KMS documentation to create a certificate and associate it with the WEKA cluster within the KMS, ensuring it has the necessary privileges for encryption and decryption.
