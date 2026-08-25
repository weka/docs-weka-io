---
description: >-
  Configure Key Management System integrations, rewrap filesystem keys, and
  prepare Vault or KMIP using the CLI.
---

# Manage KMS using CLI

## Configure the KMS

Connects the cluster to a key management service for filesystem encryption. The KMS type is a subcommand, and each type takes its own options.

**Command:** `weka security kms set vault`

```sh
weka security kms set vault <address> <key-name> [--auth-path <string>] [--convert-to-cluster-key-on-fs] [--kubernetes-role <string>] [--namespace <string>] [--network-space-id <uint16>] [--role-id <string>] [--secret-id <string>] [--token <string>] [--transit-path <string>]
```

**Command:** `weka security kms set kmip`

```sh
weka security kms set kmip <address> <key-identifier> --client-cert <string> --client-key <string> [--ca-cert <string>] [--convert-to-cluster-key-on-fs] [--network-space-id <uint16>]
```

**Parameters**

| Parameter                        | Description                                                                                 |
| --- | --- |
| `address`\* | Server address, usually a hostname:port or URL. Values: URL for vault hostname:port for kmip |
| `key-name`\* | Key name to secure the filesystems. |
| `--auth-path` \<string> | Custom auth path URL prefix. |
| `--convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the cluster key. |
| `--kubernetes-role` \<string> | Kubernetes role for Vault authentication. |
| `--namespace` \<string> | Namespace in the Vault. |
| `--network-space-id` \<uint16> | Network space ID in which to run the KMS connector. Defaults to the host network namespace. |
| `--role-id` \<string> | Role ID to access the KMS. |
| `--secret-id` \<string> | Secret ID to access the KMS (required with --role-id). |
| `--token` \<string> | API token to access the KMS. |
| `--transit-path` \<string> | Custom transit path URL prefix. |
| `key-identifier`\* | Key UID to secure the filesystems with. |
| `--client-cert` \<string>\* | Path to the client certificate PEM file. |
| `--client-key` \<string>\* | Path to the client key PEM file. |
| `--ca-cert` \<string> | Path to a CA certificate PEM file for the KMIP server. |

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

Shows the configured KMS type, address, and key identifier.

**Command:** `weka security kms`

```sh
weka security kms
```

## Remove the KMS configuration

Disconnects the cluster from its KMS.

**Command:** `weka security kms reset`

```sh
weka security kms reset [--allow-downgrade] [--force]
```

**Parameters**

| Parameter           | Description                                                                                         |
| --- | --- |
| `--allow-downgrade` | Allow downgrading encrypted filesystems to local encryption instead of a KMS. |
| `-f`, `--force` | For tenant KMS deletion, switch filesystems to the cluster-wide KMS. Requires cluster KMS to exist. |

{% hint style="warning" %}
To force remove a KMS even if encrypted filesystems exist, use the `--allow-downgrade` attribute. In such cases, the encrypted filesystem keys are re-encrypted with local encryption and may be compromised.
{% endhint %}

## Rewrap filesystem keys

Re-encrypts filesystem keys with the current KMS master key, after the master key has been rotated.

**Command:** `weka security kms rewrap`

```sh
weka security kms rewrap [--all] [--convert-to-cluster-key-on-fs] [--force] [--new-key-uid <string>]
```

**Parameters**

| Parameter                        | Description                                                                |
| --- | --- |
| `--all` | Rewrap all filesystem keys. |
| `--convert-to-cluster-key-on-fs` | Convert all encrypted filesystems to use the cluster key. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--new-key-uid` \<string> | Unique identifier for the new key to wrap filesystem keys with. KMIP only. |

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
