---
description: >-
  Efficiently manage and safeguard WEKA system keys through strategic KMS
  configurations and best practices. Optimize security and operational
  resilience.
---

# KMS management

When establishing an encrypted filesystem within the WEKA system, the usage of a Key Management System (KMS) is imperative to ensure the secure management of encryption keys. The WEKA system relies on the KMS for encrypting filesystem keys, and during system startup, it employs the KMS to decrypt these keys, leveraging its in-memory capabilities for data encryption and decryption operations.

The Snap-To-Object feature, employed for taking snapshots, includes the storage of the encrypted filesystem key along with the encrypted data. Subsequently, when promoting such a snapshot to a different filesystem or recovering from a disaster within the WEKA cluster, the KMS decrypts the filesystem key. Therefore, the presence of the same KMS data is crucial for these operations.\
\
To enhance security, the WEKA system refrains from saving any information that could reconstruct KMS encryption keys, relying solely on the KMS configuration. This necessitates careful consideration of the following:

* **Disaster recovery strategy:** Loss of the KMS configuration may result in the loss of encrypted data. It is imperative to establish a robust Disaster Recovery (DR) strategy when deploying the KMS in a production environment.
* **High availability:** The KMS must be available during system startup, when creating a new filesystem, and periodically during key rotations. Therefore, maintaining high availability for the KMS is strongly recommended.

The WEKA system supports the following KMS types:

* [KMIP-compliant](http://docs.oasis-open.org/kmip/spec/v1.2/os/kmip-spec-v1.2-os.html) KMS (protocol version 1.2 and up).
* [HashiCorp Vault](https://www.hashicorp.com/products/vault/) version 1.1.5 up to 1.14.x (not limited to the KMIP-compliant version). For setup instructions, see [Set up vault configuration](kms-management-1.md#set-up-vault-configuration).

## **KMS integration best practices**

The KMS is the sole entity holding the key to decrypt WEKA system filesystem keys. Adhering to the following best practices is crucial for non-disruptive operations:

* **DR setup for KMS:** Implement backup/replication for the KMS to mitigate data loss risks.
* **High availability for KMS:** Maintain high availability for the KMS, represented by a single address in the WEKA system.
* **Access to KMS:** Provide access to the KMS from the WEKA backend servers.
* **Verification of KMS methods:** Verify and understand the methods employed by the KMS for securing, unsealing, and reconstructing lost keys. Different KMS solutions have distinct methods; for instance, [Vault unsealing methods](https://www.vaultproject.io/docs/concepts/seal.html) can enable [auto unsealing using a trusted service](https://learn.hashicorp.com/vault/operations/ops-autounseal-aws-kms).

For additional best practices recommended by HashiCorp when using Vault, refer to the [Production Hardening](https://learn.hashicorp.com/vault/operations/production-hardening) documentation.

{% hint style="info" %}
**Snapshot considerations:** Taking a Snap-To-Object ensures that the (encrypted) filesystem keys are backed up to the object store, serving as a crucial safeguard in the event of total corruption of the WEKA system configuration.
{% endhint %}



**Related topics**

[kms-management.md](kms-management.md "mention")

[kms-management-1.md](kms-management-1.md "mention")
