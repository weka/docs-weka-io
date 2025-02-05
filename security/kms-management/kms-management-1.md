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
* [Rewrap filesystem keys](kms-management-1.md#rewrap-filesystem-keys)
* [Set up vault configuration](kms-management-1.md#set-up-vault-configuration)
* [Obtain a certificate for a KMIP-based KMS](kms-management-1.md#obtain-a-certificate-for-a-kmip-based-kms)

## Configure the KMS

**Command:** `weka security kms set`

To integrate the Key Management Service (KMS) with the WEKA system, use the provided command line for adding or updating the KMS configuration. Ensure that the KMS is preconfigured, and both the key and a valid token are readily available.

Run the following command to establish a connection between the WEKA system and the configured Vault KMS.

`weka security kms set <type> <address> <key-identifier> [--token token] [--namespace namespace] [--client-cert client-cert] [--client-key client-key] [--ca-cert ca-cert] [--role-id role-id] [--secret-id secret-id] [--convert-to-cluster-key-on-fs]`

**Parameters**

<table><thead><tr><th width="209">Name</th><th width="284">Value</th><th>Considerations</th></tr></thead><tbody><tr><td><code>type</code>*</td><td>Type of the KMS.</td><td>Possible values:<br><code>vault</code> or <code>kmip</code></td></tr><tr><td><code>address</code>*</td><td>KMS server address. </td><td><p><code>URL</code> for <code>vault</code></p><p><code>hostname:port</code> for <code>kmip</code></p></td></tr><tr><td><code>key-identifier</code>*</td><td>Key name for <code>vault</code> or UID for <code>kmip</code> to secure filesystem keys.</td><td></td></tr><tr><td><code>token</code></td><td>API token to access HashiCorp Vault KMS.</td><td><p>This applies only to <code>vault</code>.<br>Prohibited for <code>kmip</code>.</p><ul><li>For cluster-wide encryption, specify the <code>token</code>.</li><li>For per-filesystem encryption, specify the <code>role-id</code> and <code>secret-id</code> parameters below instead of the <code>token</code>.</li></ul><p>The access token must have:</p><ul><li>Read permissions to <code>transit/keys/&#x3C;master-key-name></code></li><li>Write permissions to <code>transit/encrypt/&#x3C;master-key-name></code> and <code>transit/decrypt/&#x3C;masterkeyname></code> </li><li>Permissions to <code>/transit/rewrap</code> and <code>auth/token/lookup</code></li></ul></td></tr><tr><td><code>namespace</code></td><td>The namespace name in HashiCorp Vault.</td><td>Namespace names must not end with "/", avoid spaces, and refrain from using reserved names like <code>root</code>, <code>sys</code>, <code>audit</code>, <code>auth</code>, <code>cubbyhole</code>, and <code>identity</code>.</td></tr><tr><td><code>client-cert</code></td><td>Path to the client certificate PEM file.<br></td><td><p>Must permit <code>encrypt</code> and <code>decrypt</code> permissions.<br>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>client-key</code></td><td>Path to the client key PEM file.</td><td><p>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>ca-cert</code></td><td>Path to the CA certificate PEM file.<br></td><td><p>Optional for <code>kmip</code>.</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>role-id</code></td><td>Role ID for KMS access with per-filesystem encryption.<br>To obtain the <code>role-id</code> and <code>secret-id</code>, see the section below.</td><td>Mandatory if KMS Namespace is defined.</td></tr><tr><td><code>secret-id</code></td><td>Secret ID for KMS access with per-filesystem encryption.</td><td><p>Mandatory if KMS Namespace is defined.</p><p>You can also specify the secret ID using the environment variable <code>WEKA_KMS_SECRET_ID</code>.</p></td></tr><tr><td><code>convert-to-cluster-key-on-fs</code></td><td>Convert all encrypted filesystems to use cluster key.</td><td></td></tr></tbody></table>

### Obtain `role-id` and `secret-id` from HashiCorp Vault

In environments using **HashiCorp Vault** for secure credential management, the Vault administrator would provide the `role-id` and `secret-id` needed for access.

**Disclaimer**: The following example is provided as a courtesy to illustrate possible integration with **HashiCorp Vault** and is not part of our product.

#### Set up roles for cluster access

Enable AppRole authentication:

```
$ vault auth enable approle
```

Role for cluster:

```shell
$ vault write -f auth/approle/role/weka-role-cluster
Success! Data written to: auth/approle/role/weka-role-cluster

$ vault write -f auth/approle/role/weka-role-cluster token_policies="weka_cluster_role_key_policy"
Success! Data written to: auth/approle/role/weka-role-cluster
```

Retrieve the **role-id**:

```shell
$ vault read auth/approle/role/weka-role-cluster/role-id
```

Role for **Key1**:

```shell
$ vault write -f auth/approle/role/weka-role-1
Success! Data written to: auth/approle/role/weka-role-1

$ vault write -f auth/approle/role/weka-role-1 token_policies="weka_fs_role_key1_policy"
Success! Data written to: auth/approle/role/weka-role-1
```

Retrieve the **role-id** and generate a **secret-id**:

```
$ vault read auth/approle/role/weka-role-1/role-id
Key        Value
---        -----
role_id    5a574437-72b8-17b0-dbce-f36731d77663

$ vault write -f auth/approle/role/weka-role-1/secret-id
Key                   Value
---                   -----
secret_id             69c26538-27cb-bcce-1ac2-27d4de590d5b
secret_id_accessor    a3b885ff-ba25-560d-cc56-58df99962b2d
secret_id_num_uses    0
secret_id_ttl         0s 
```

### **Examples**

**Setting the WEKA system with a HashiCorp Vault KMS for cluster-wide encryption:**

{% code overflow="wrap" %}
```
weka security kms set vault https://vault-dns:8200 weka_cluster_key --token s.nRucA9Gtb3yNVmLUK221234
```
{% endcode %}

**Setting the WEKA system with a HashiCorp Vault KMS for per-filesystem encryption:**

{% code overflow="wrap" %}
```
weka security kms set  vault  https://vault-dns:8200 weka_cluster_key --role-id 26e2576f-cb9d-b48a-057d-e37d8956b00c --secret-id 44797329-e729-6j80-m9d4-b1825037cha6
```
{% endcode %}

**Setting the WEKA system with a KMIP complaint KMS (SmartKey example):**

{% code overflow="wrap" %}
```
weka security kms set kmip amer.smartkey.io:5996 b2f81634-c0f6-4y63-b5b3-84a82e231634 --client-cert smartkey_cert.pem --client-key smartkey_key.pem
```
{% endcode %}

## View the KMS configuration

**Command:** `weka security kms`

Use this command to show the details of the configured KMS.

## Remove the KMS configuration

**Command:** `weka security kms unset`

Use this command to remove the KMS from the WEKA system. It is only possible to remove a KMS configuration if no encrypted filesystems exist.

{% hint style="warning" %}
To force remove a KMS even if encrypted filesystems exist, use the `--allow-downgrade` attribute. In such cases, the encrypted filesystem keys are re-encrypted with local encryption and may be compromised.
{% endhint %}

## **Rewrap filesystem keys**

**Command:** `weka security kms rewrap`

If the KMS key is compromised or requires rotation, the KMS administrator can rotate the key in the KMS. In such cases, this command is used to re-encrypt the encrypted filesystem keys with the new KMS cluster key.

`weka security kms rewrap [--new-key-uid new-key-uid] [--all] [--convert-to-cluster-key-on-fs]`

**Parameters**

<table><thead><tr><th width="335">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>new-key-uid</code>*</td><td>Unique identifier for the new key to be used to wrap filesystem keys.<br>Mandatory for <code>kmip</code> only.<br>Do not specify any value for <code>vault</code>.</td></tr><tr><td><code>all</code></td><td>Rewrap all the filesystem encryption keys. Applicable when using HashiCorp Vault for per-filesystem encryption keys.<br>Without the <code>--all</code> option, the command re-encrypts only the keys of filesystems that use the cluster key for encryption.</td></tr><tr><td><code>convert-to-cluster-key-on-fs</code></td><td>Convert all encrypted filesystems to use the KMS cluster key.</td></tr></tbody></table>

{% hint style="info" %}
WEKA does not automatically re-encrypt existing filesystem keys with the new KMS key for snapshots that were previously uploaded with the old encrypted keys.
{% endhint %}

{% hint style="warning" %}
Unlike HashiCorp Vault KMS, re-wrapping a KMIP-based KMS necessitates generating a new key within the KMS rather than rotating the existing one. Therefore, it is essential to retain the old key in the KMS to ensure the decryption of older Snap-to-Object snapshots.
{% endhint %}

## Set up vault configuration

### Enable 'Transit' secret engine in vault

The WEKA system uses [encryption-as-a-service](https://learn.hashicorp.com/vault/encryption-as-a-service/eaas-transit) capabilities of the KMS to encrypt/decrypt the filesystem keys. This requires the configuration of Vault with the `transit` secret engine with this command:

```
vault secrets enable transit
```

The expected output is:

<pre class="language-bash"><code class="lang-bash"><strong>Success! Enabled the transit secrets engine at: transit/
</strong></code></pre>

### Set up a master key for the WEKA system

Once the `transit` secret engine is set up, a master key for use with the WEKA system must be created with this command:

```
vault write -f transit/keys/weka-key
```

The expected output is:

```bash
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
vault policy write weka weka_policy.hcl
```

### Obtain an API token from the vault

Authentication from the WEKA system to Vault relies on an API token. Since the WEKA system must always be able to communicate with the KMS, a [periodic service token](https://www.vaultproject.io/docs/concepts/tokens.html#periodic-tokens) must be used.

* Verify that the`token` authentication method in Vault is enabled. This can be performed using the following command:

```
vault auth list
```

The expected output is:

```bash
vault auth list

Path         Type        Description
----         ----        -----------
token/       token       token based credentials
```

* To enable the token authentication method use the following command:

```
vault auth enable token
```

* Log into the KMS system using any of the identity methods Vault supports. The identity must have permission to use the previously set master key.&#x20;
* Create a token role for the identity using the following command:

{% code overflow="wrap" %}
```bash
vault write auth/token/roles/weka allowed_policies="weka" period="768h"
```
{% endcode %}

{% hint style="info" %}
The `period` is the designated timeframe for a renewal request. If a renewal is not requested within this period, the token is revoked, necessitating the retrieval of a new token from the Vault and its configuration in the WEKA system.
{% endhint %}

* Generate a token for the logged-in identity using the following command:

```
vault token create -role=weka
```

The expected output is:

```bash
vault token create -role=weka

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
The WEKA system does not automatically renew the API token lease. It can be renewed using the [Vault CLI/API](https://learn.hashicorp.com/vault/security/tokens#step-3-renew-service-tokens). It is also possible to define a higher maximum token value (`max_lease_ttl)`by changing the [Vault Configuration file](https://www.vaultproject.io/docs/configuration/index.html#max_lease_ttl).
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
