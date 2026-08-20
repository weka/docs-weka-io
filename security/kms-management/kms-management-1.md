---
description: >-
  Configure Key Management System integrations, rewrap filesystem keys, and
  prepare Vault or KMIP using the CLI.
---

# Manage KMS using CLI

## Configure the KMS

**Command:** `weka security kms set`

Use this command to add or update the KMS configuration. For HashiCorp Vault, you can configure a single cluster-wide encryption key or enable per-filesystem encryption keys.

Per-filesystem encryption requires using Vault's [AppRole](https://developer.hashicorp.com/vault/docs/auth/approle) authentication method, which you configure using the `--role-id` and `--secret-id` parameters.

Run the following command to establish a connection between the WEKA system and the configured Vault KMS.

`weka security kms set <type> <address> <key-identifier> [--token token] [--role-id role-id] [--secret-id secret-id] [--kubernetes-role kubernetes-role] [--namespace namespace]`\
`[--client-cert client-cert] [--client-key client-key] [--ca-cert ca-cert] [--transit-path transit-path] [--auth-path auth-path] [--convert-to-cluster-key-on-fs]`

**Parameters**

<table><thead><tr><th width="209">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>type</code>*</td><td>Type of the KMS.<br>Values: <code>vault</code> or <code>kmip</code></td></tr><tr><td><code>address</code>*</td><td><p>KMS server address.<br>Values:<br><code>URL</code> for <code>vault</code></p><p><code>hostname:port</code> for <code>kmip</code></p></td></tr><tr><td><code>key-identifier</code>*</td><td><p>Key name for <code>vault</code></p><p>UID for <code>kmip</code> to secure filesystem keys.</p></td></tr><tr><td><code>token</code></td><td><p>The API token for authenticating with a HashiCorp Vault KMS.</p><p>This parameter applies only to <strong>Vault</strong> and is used for <strong>cluster-wide encryption</strong>. It cannot be used with the <code>role-id</code> or <code>secret-id</code> parameters, which are used for AppRole authentication.</p><p>The access token must have the following permissions in Vault:</p><ul><li><p>Read access to</p><p><code>transit/keys/&#x3C;master-key-name></code></p></li><li><p>Write access to</p><p><code>transit/encrypt/&#x3C;master-key-name></code> and <code>transit/decrypt/&#x3C;master-key-name></code></p></li><li><p>Permissions for</p><p><code>/transit/rewrap</code> and <code>auth/token/lookup</code></p></li></ul></td></tr><tr><td><code>role-id</code></td><td>Role ID for HashiCorp Vault's AppRole authentication method, which is provided by the Vault administrator. This parameter must be used with <code>secret-id</code> and cannot be used with <code>token</code>.</td></tr><tr><td><code>secret-id</code></td><td><p>Secret ID for HashiCorp Vault's AppRole authentication, which is provided by the Vault administrator. This parameter must be used with <code>role-id</code>. Alternatively, you can set this value using the</p><p><code>WEKA_KMS_SECRET_ID</code> environment variable.</p></td></tr><tr><td><code>kubernetes-role</code></td><td>The Kubernetes role used for authentication with HashiCorp Vault.</td></tr><tr><td><code>namespace</code></td><td>The namespace name in HashiCorp Vault.<br>Namespace names must not end with "/", avoid spaces, and refrain from using reserved names like <code>root</code>, <code>sys</code>, <code>audit</code>, <code>auth</code>, <code>cubbyhole</code>, and <code>identity</code>.</td></tr><tr><td><code>client-cert</code></td><td><p>Path to the client certificate PEM file.<br>Must permit <code>encrypt</code> and <code>decrypt</code> permissions.<br>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>client-key</code></td><td><p>Path to the client key PEM file.<br>Mandatory for <code>kmip</code> .</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>ca-cert</code></td><td><p>Path to the CA certificate PEM file.<br>Optional for <code>kmip</code>.</p><p>Prohibited for <code>vault</code>.</p></td></tr><tr><td><code>transit-path</code></td><td>The custom path where the HashiCorp Vault transit secrets engine is enabled.</td></tr><tr><td><code>auth-path</code></td><td>The custom path where the HashiCorp Vault authentication method is enabled.</td></tr><tr><td><code>convert-to-cluster-key-on-fs</code></td><td>Convert all encrypted filesystems to use cluster key.</td></tr></tbody></table>

### Obtain `role-id` and `secret-id` from HashiCorp Vault

Use this procedure when configuring HashiCorp Vault with AppRole authentication. This method is required for per-filesystem encryption and is an option for cluster-wide encryption. The Vault administrator provides the `role-id` and `secret-id` needed for access.

#### **Recommendation: use batch tokens for per-filesystem encryption**

For per-filesystem encryption, it is recommended to configure the AppRole with **batch tokens** to ensure optimal performance and scalability in your HashiCorp Vault environment.

Unlike standard service tokens, which generate a new lease for each authentication request, batch tokens are designed for high-volume, automated workflows. They do not create new leases upon use, which is critical for maintaining efficiency in environments with many filesystems.

While batch tokens can be used multiple times, their lifetime is limited by a Time-to-Live (TTL). It is recommended to set a short TTL (for example, 20 minutes) to align with security best practices.

Batch tokens are not single-use but are limited by their TTL, and they do not create new leases upon use, which prevents this scalability problem. To implement this, create your AppRole with the `token_type` set to `batch`.

For more information, refer to the official HashiCorp Vault documentation.

{% hint style="warning" %}
**Disclaimer**: The following example is provided as a courtesy to illustrate possible integration with **HashiCorp Vault** and is not part of our product.
{% endhint %}

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

| Name                           | Value                                                                                                                                                                                                                                         |
| ------------------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `new-key-uid`\*                | Unique identifier for the new key to be used to wrap filesystem keys.Mandatory for `kmip` only.Do not specify any value for `vault`.                                                                                                          |
| `all`                          | Rewrap all the filesystem encryption keys. Applicable when using HashiCorp Vault for per-filesystem encryption keys.Without the `--all` option, the command re-encrypts only the keys of filesystems that use the cluster key for encryption. |
| `convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the KMS cluster key.                                                                                                                                                                                 |

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

[Vault transit secret-engine documentation](https://www.vaultproject.io/docs/secrets/transit/index.html)

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

* Log into the KMS system using any of the identity methods Vault supports. The identity must have permission to use the previously set master key.
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
