---
description: >-
  Learn how NeuralMesh uses object stores to extend SSD capacity with a
  lower-cost storage tier.
---

# Manage object stores

Object stores are optional external storage media that complement the SSD storage. This split lets you allocate resources by access pattern: the object store holds warm data that is accessed infrequently, and the SSDs hold hot data that is accessed frequently.

NeuralMesh treats an object store as a physical entity, on-premises or in the cloud, that groups multiple object store buckets. Object store buckets can reside in different physical object stores. To keep the Quality of Service (QoS) predictable, each bucket must be mapped to the physical object store that holds it.

## Local and remote object stores

Each object store has a site setting that determines what its buckets can serve:

* **Local**: Used for tiering and snapshots.
* **Remote**: Used for snapshots only.

Add an object store bucket to an object store of the same type. Keep the bucket inaccessible to other applications.

{% hint style="info" %}
Remote object store buckets use a write-once-delete-never approach for snapshot uploads. The bucket only grows over time, even when the snapshots uploaded to it are deleted from the filesystem.
{% endhint %}

## Buckets per filesystem

A single object store bucket can serve different filesystems and multiple NeuralMesh systems. Still, dedicate each bucket to a specific filesystem. For example, when you manage three tiered filesystems, assign a dedicated local object store bucket to each one.

You can attach up to three object store buckets to a filesystem:

* A local object store bucket for tiering and snapshots.
* A second local object store bucket for additional tiering and snapshots. Adding a second local bucket makes the first local bucket read-only.
* A remote object store bucket for snapshots only.

Multiple object store buckets support the following use cases:

* Migrating to a different local object store by detaching the read-only bucket from a filesystem tiered to two local object store buckets.
* Scaling the object store capacity.
* Increasing the total tiering capacity of filesystems.
* Backing up data in a remote site.

## Cloud lifecycle policies

In cloud environments, you can use cloud lifecycle policies to transition storage tiers or classes. For example, in AWS you can move objects from the S3 Standard storage class to the S3 Intelligent-Tiering storage class for long-term retention.

{% hint style="danger" %}
**Do not modify NeuralMesh-managed object store data.**

NeuralMesh manages data in its own internal structures and automatically handles deduplication between live tiered data and filesystem snapshots stored in the object store.

Do not manually manage, delete, or apply lifecycle policies to any data that NeuralMesh uploads to the object store, including policies that delete or age out data objects. Interfering with NeuralMesh-managed data can cause irreversible data loss, including the loss of live filesystem data.
{% endhint %}

**Related topics**

[Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/)

[Manage data lifecycle for tiered systems](../tiering.md)

[Manage object stores using the GUI](managing-object-stores.md)

[Manage object stores using the CLI](managing-object-stores-1.md)
