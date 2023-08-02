---
description: This page provides an overview about managing object stores.
---

# Manage object stores

Object stores provide optional external storage media in addition to SSD storage. Object stores are less expensive than SSD storage. Therefore, you can use object stores for storing warm data (data infrequently accessed) while the SSD stores the hot data (data frequently accessed).

Object store buckets can reside in different physical object stores. However, for better QoS, WEKA requires mapping between the bucket and the physical object store.

Object store in WEKA generally represents a physical entity (on-premises or in the cloud) that groups several object store buckets. An object store or object store bucket can be either local (used for tiering+snapshots) or remote (used for snapshots only). An object-store bucket must be added to an object store with the same type.&#x20;

The object store bucket must be dedicated to the WEKA system and not be accessible by other applications. A single object store bucket can serve different filesystems and multiple WEKA systems. However, it is recommended to set one object store bucket per filesystem.

You can define up to three object store buckets for a filesystem:

* One object store bucket writeable for tiering.
* Second object store bucket read-only for tiering.
* Third object store bucket for backup only.

Defining multiple object store buckets for a filesystem allows a range of use cases, such as:

* Migration to different object stores.
* Scaling of object store capacity.
* Increasing the total tiering capacity of filesystems.
* Backing up data in a remote site.

For example, in AWS, you can move objects from S3 standard storage class to S3 intelligent tiering storage class for long-term retention using the AWS lifecycle policy.



**Related topics**

[#about-object-stores](../../overview/filesystems.md#about-object-stores "mention")
