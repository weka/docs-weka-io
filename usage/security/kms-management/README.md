---
description: >-
  This page describes the management of a Key Management System (KMS) within the
  Weka system.
---

# KMS management

When creating an encrypted filesystem, a KMS must be used to properly secure the encryption keys.

The Weka system uses the KMS to encrypt filesystem keys. When the Weka system comes up, it uses the KMS to decrypt the filesystem keys and use its in-memory capabilities for data encrypting/decrypting operations.

When a snapshot is taken using the Snap-To-Object feature, the encrypted filesystem key is saved along with the encrypted data. In the event of rehydrating this snapshot to a different filesystem (or when recovering from a disaster to the same filesystem in the Weka cluster), the KMS is used to decrypt the filesystem key. Consequently, the same KMS data must be present when performing such operations.

For increased security, the Weka system does not save any information that can reconstruct the KMS encryption keys, which is performed by the KMS configuration alone. Therefore, the following should be considered:

1. If the KMS configuration is lost, the encrypted data may also be lost. Therefore, a proper DR strategy should be set when deploying the KMS in a production environment.
2. The KMS must be available when the Weka system comes up when a new filesystem is created, and from time to time when key rotations must be performed. Therefore, it is recommended that the KMS be highly available.

The Weka system supports the following KMS types:

* [KMIP](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) compliant KMS (protocol version 1.2 and up).
* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) version 1.1.5 up to 1.9.x (not limited to the KMIP-compliant version). For setting up Vault to work with the Weka system, refer to [Setting Up Vault Configuration](kms-management-1.md#set-up-vault-configuration)&#x20;

Deploy one of the supported KMS types that best suit your requirements. For additional information on KMS support, contact the Weka Sales or Support Teams.

## KMS best practices

The KMS is the only source holding the key to decrypt Weka system filesystem keys. For non-disruptive operation, it is highly recommended to follow these guidelines:

* Set up DR for the KMS (backup/replication) to avoid any chance of data loss.
* Ensure that the KMS is highly available (note that the KMS is represented by a single URL in the Weka system).
* Provide access to the KMS from the Weka system backend hosts.
* Verify the methods used by the KMS being implemented (each KMS has different methods for securing/unsealing keys and for reconstructing lost keys, e.g., [Vault unsealing methods](https://www.vaultproject.io/docs/concepts/seal.html), which enable the configuration of [auto unsealing using a trusted service](https://learn.hashicorp.com/vault/operations/ops-autounseal-aws-kms)).
* Refer to [Production Hardening](https://learn.hashicorp.com/vault/operations/production-hardening) for additional best practices suggested by HashiCorp when using Vault.

{% hint style="info" %}
**Note:** Taking a Snap-To-Object ensures that the (encrypted) filesystems keys are backed up to the object store, which is important if a total corruption of the Weka system configuration occurs.
{% endhint %}



**Related topics**

[kms-management.md](kms-management.md "mention")

[kms-management-1.md](kms-management-1.md "mention")
