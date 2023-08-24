---
description: >-
  This page describes the management of a Key Management System (KMS) within the
  WEKA system.
---

# KMS management

When creating an encrypted filesystem, a KMS must be used to secure the encryption keys properly.

The WEKA system uses the KMS to encrypt filesystem keys. When the WEKA system comes up, it uses the KMS to decrypt the filesystem keys and its in-memory capabilities for data encrypting/decrypting operations.

When a snapshot is taken using the Snap-To-Object feature, the encrypted filesystem key is saved along with the encrypted data. When rehydrating this snapshot to a different filesystem (or when recovering from a disaster to the same filesystem in the WEKA cluster), the KMS decrypts the filesystem key. Consequently, the same KMS data must be present when performing such operations.

For increased security, the WEKA system does not save any information that can reconstruct the KMS encryption keys, performed by the KMS configuration alone. Therefore, the following should be considered:

1. If the KMS configuration is lost, the encrypted data may also be lost. Therefore, a proper DR strategy should be set when deploying the KMS in a production environment.
2. The KMS must be available when the WEKA system comes up when a new filesystem is created and from time to time when key rotations must be performed. Therefore, it is recommended that the KMS be highly available.

The WEKA system supports the following KMS types:

* [KMIP-compliant](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) KMS (protocol version 1.2 and up).
* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) version 1.1.5 up to 1.14.x (not limited to the KMIP-compliant version). For setting up Vault to work with the WEKA system, refer to [Setting Up Vault Configuration](kms-management-1.md#set-up-vault-configuration)&#x20;

## KMS best practices

The KMS is the only source holding the key to decrypt WEKA system filesystem keys. For non-disruptive operations, it is highly recommended to follow these guidelines:

* Set up DR for the KMS (backup/replication) to avoid data loss.
* Ensure that the KMS is highly available. A single URL in the WEKA system represents the KMS.
* Provide access to the KMS from the WEKA backend servers.
* Verify the methods used by the KMS being implemented (each KMS has different methods for securing, unsealing, and reconstructing lost keys, for example, [Vault unsealing methods](https://www.vaultproject.io/docs/concepts/seal.html), which enable the configuration of [auto unsealing using a trusted service](https://learn.hashicorp.com/vault/operations/ops-autounseal-aws-kms)).
* Refer to [Production Hardening](https://learn.hashicorp.com/vault/operations/production-hardening) for additional best practices suggested by HashiCorp when using Vault.

{% hint style="info" %}
Taking a Snap-To-Object ensures that the (encrypted) filesystems keys are backed up to the object store. This is essential if a total corruption of the WEKA system configuration occurs.
{% endhint %}



**Related topics**

[kms-management.md](kms-management.md "mention")

[kms-management-1.md](kms-management-1.md "mention")
