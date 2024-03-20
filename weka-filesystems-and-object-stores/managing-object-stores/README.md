---
description: This page provides an overview about managing object stores.
---

# Manage object stores

Object stores in WEKA serve as optional external storage media, complementing SSD storage with a more cost-effective solution. This allows for the strategic allocation of resources, with object stores accommodating warm data (infrequently accessed) and SSDs handling hot data (frequently accessed).

In WEKA, object store buckets can be distributed across different physical object stores. However, to ensure optimal Quality of Service (QoS), a crucial mapping between the bucket and the physical object store is required.

WEKA treats object stores as physical entities, either on-premises or in the cloud, grouping multiple object store buckets. These buckets can be categorized as either local (used for tiering and snapshots) or remote (exclusively for snapshots). An object-store bucket must be added to an object store with the same type and remain inaccessible to other applications.

While a single object store bucket can potentially serve different filesystems and multiple WEKA systems, it is advisable to dedicate each bucket to a specific filesystem. For instance, if managing three tiered file systems, assigning a dedicated local object storage bucket to each file system is recommended.

For each filesystem, users can attach up to three object store buckets:

* A local object store bucket for tiering and snapshots.
* A second local object store bucket for additional tiering and snapshots. Note that adding a second local bucket renders the first local bucket read-only.
* A remote object store bucket exclusively for snapshots.

Multiple object store buckets offer flexibility for various use cases, including:

* Migrating to different local object stores when detaching a read-only bucket from a filesystem tiered to two local object store buckets.
* Scaling object store capacity.
* Increasing total tiering capacity for filesystems.
* Backing up data in a remote site.

In cloud environments, users can employ cloud lifecycle policies to transition storage tiers or classes. For example, in AWS, users can move objects from the S3 standard storage class to the S3 intelligent tiering storage class for long-term retention using the AWS lifecycle policy.

**Related topics**

[#about-object-stores](../../weka-system-overview/filesystems.md#about-object-stores "mention")
