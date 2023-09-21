---
description: This page provides an overview about managing object stores.
---

# Manage object stores

Object stores provide optional external storage media in addition to SSD storage. Object stores are less expensive than SSD storage. Therefore, you can use object stores for storing warm data (data infrequently accessed) while the SSD stores the hot data (data frequently accessed).

Object store buckets can reside in different physical object stores. However, for better QoS, WEKA requires mapping between the bucket and the physical object store.

Object store in WEKA generally represents a physical entity (on-premises or in the cloud) that groups several object store buckets. An object store or object store bucket can be either local (used for tiering+snapshots) or remote (used for snapshots only). An object-store bucket must be added to an object store with the same type.&#x20;

The object store bucket must be dedicated to the WEKA system and not be accessible by other applications. A single object store bucket can serve different filesystems and multiple WEKA systems but this is not recommended.  Instead, always dedicate an object store bucket to a single  filesystem, so for instance if you have three tiered file systems, then assign a dedicated local object storage bucket to each file system.

You can attach up to three object store buckets to each filesystem:

* A local object store bucket for tiering and snapshots.
* A second local object store bucket for tiering and snapshots.  However when you add the second local bucket, the first local bucket becomes read-only. &#x20;
* A remote object store bucket for snapshots only.

Defining multiple object store buckets for a filesystem allows a range of use cases, such as:

* Migration to different local object stores (this occurs when you detach the read-only bucket, see [https://docs.weka.io/fs/attaching-detaching-object-stores-to-from-filesystems#migration-to-a-different-object-store](https://docs.weka.io/fs/attaching-detaching-object-stores-to-from-filesystems#migration-to-a-different-object-store))
* Scaling of object store capacity.
* Increasing the total tiering capacity of filesystems.
* Backing up data in a remote site.

In Cloud you can also use cloud lifecycle policies to change the storage tier or class. For example in AWS you can move objects from S3 standard storage class to S3 intelligent tiering storage class for long-term retention using the AWS lifecycle policy.



**Related topics**

[#about-object-stores](../../overview/filesystems.md#about-object-stores "mention")
