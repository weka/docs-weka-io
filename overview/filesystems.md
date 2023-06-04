---
description: >-
  This page describes the three types of entities relevant to data storage in
  the Weka system: filesystems, object stores and filesystem groups.
---

# Filesystems, object stores, and filesystem groups

## About filesystems

A Weka filesystem is similar to a regular on-disk filesystem while distributed across all the hosts in the cluster. Consequently, filesystems are not associated with any physical object in the Weka system and act as root directories with space limitations.

The system supports a total of up to 1024 filesystems. All of which are equally balanced on all SSDs and CPU cores assigned to the system. This means that the allocation of a new filesystem or resizing a filesystem are instant management operations performed without any constraints.

A filesystem has a defined capacity limit and is associated with a predefined filesystem group. A filesystem that belongs to a tiered filesystem group must have a total capacity limit and an SSD capacity cap. All filesystems' available SSD capacity cannot exceed the total SSD net capacity.

### Thin provisioning

Thin provisioning is a method of on-demand SSD capacity allocation based on user requirements. In thin provisioning, the filesystem capacity is defined by a minimum guaranteed capacity and a maximum capacity (virtually can be more than the vailable SSD capacity).

The system allocates more capacity (up to the total available SSD capacity) for users who consume their allocated minimum capacity. Alternatively, when they free up space by deleting files or transferring data, the idle space is reclaimed, repurposed, and used for other workloads that need the SSD capacity.

Thin provisioning is beneficial in various use cases:

* **Tiered filesystems:** On tiered filesystems, available SSD capacity is leveraged for extra performance and released to the object store once needed by other filesystems.
* **Auto-scaling groups:** When using auto-scaling groups, thin provisioning can help to automatically expand and shrink the filesystem's SSD capacity for extra performance.
* **Separation of projects to filesystems:** If it is required to create a separate filesystem for each project, and the administrator doesn't expect all filesystems to be fully utilized simultaneously, creating a thin provisioned filesystem for each project is a good solution. Each filesystem is allocated with a minimum capacity but can consume more when needed based on the actual available SSD capacity.

### Filesystem limits

* **Number of files or directories:** Up to 6.4 trillion (6.4 \* 10^12)
* **Number of files in a single directory:** Up to 6.4 billion (6.4 \* 10^9)
* **Total capacity with object store:** Up to 14 EB&#x20;
* **Total SSD capacity:** Up to 512 PB&#x20;
* **File size:** UP to 4 PB

### Encrypted filesystems

Both data at rest (residing on SSD and object store) and data in transit can be encrypted. This is achieved by enabling the filesystem encryption feature. A decision on whether a filesystem is to be encrypted is made when creating the filesystem.

To create encrypted filesystems, deploy a Key Management System (KMS).

{% hint style="info" %}
**Note:** You can only set the data encryption when creating a filesystem.
{% endhint %}

**Related topics**

[kms-management](../usage/security/kms-management/ "mention")

### Metadata limitations

In addition to the capacity limitation, each filesystem has a limitation on the amount of metadata. The system-wide metadata limit is determined by the SSD capacity allocated to the Weka system and the RAM resources allocated to the Weka system processes.

The Weka system keeps tracking metadata units in the RAM. If it reaches the RAM limit, it pages these metadata tracking units to the SSD and alerts. This leaves enough time for the administrator to increase system resources, as the system keeps serving IOs with a minimal performance impact.

By default, the metadata limit associated with a filesystem is proportional to the filesystem SSD size. It is possible to override this default by defining a filesystem-specific max-files parameter. The filesystem limit is a logical limit to control the specific filesystem usage and can be updated by the administrator when necessary.

The total metadata limits for all the filesystems can exceed the entire system metadata information that can fit in the RAM. For minimal impact, in such a case, the least-recently-used units are paged to disk, as necessary.

#### Metadata units calculation <a href="#metadata-calculations" id="metadata-calculations"></a>

Each metadata unit consumes 4 KB of SSD space (not tiered) and 20 bytes of RAM.

Throughout this documentation, the metadata limitation per filesystem is referred to as the `max-files`parameter, which specifies the number of metadata units (not the number of files). This parameter encapsulates both the file count and the file sizes.

The following table specifies the required number of metadata units according to the file size. These specifications apply to files residing on SSDs or tiered to object stores.

<table><thead><tr><th width="165.70457936628898">File size</th><th width="150">Number of metadata units</th><th>Example</th></tr></thead><tbody><tr><td>&#x3C; 0.5 MB</td><td>1</td><td>A filesystem with 1 billion files of 64 KB each requires 1 billion metadata units.</td></tr><tr><td>0.5 MB - 1 MB</td><td>2</td><td>A filesystem with 1 million files of 750 KB each, requires 2 million metadata units.</td></tr><tr><td>> 1 MB</td><td>2 for the first 1 MB plus<br>1 per MB for the rest MBs</td><td><ul><li>A filesystem with 1 million files of 129 MB each requires 130 million metadata units.<br>2 units for the first 1 MB plus 1 unit per MB for 128 MB.</li><li>A filesystem with 10 million files of 1.5 MB each requires 30 million units.</li><li>A filesystem with 10 million files of 3 MB each requires 40 million units.</li></ul></td></tr></tbody></table>

{% hint style="info" %}
Each directory requires two metadata units instead of one for a small file.
{% endhint %}



**Related topics**

[#memory-resource-planning](../install/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning "mention")

## About object stores

In the Weka system, object stores represent an optional external storage media, ideal for storing warm data. Object stores used in tiered Weka system configurations can be cloud-based, located in the same location (local), or at a remote location.

Weka supports object stores for tiering (tiering and local snapshots) and backup (snapshots only). Both tiering and backup can be used for the same filesystem.

Using object store buckets optimally is achieved when a cost-effective data storage tier is required at a price point that cannot be satisfied by server-based SSDs.

An object store bucket definition contains the object store DNS name, bucket identifier, and access credentials. The bucket must be dedicated to the Weka system and not be accessible by other applications.

Filesystem connectivity to object store buckets can be used in the data lifecycle management and Snap-to-Object features.



**Related topics**

[managing-object-stores](../fs/managing-object-stores/ "mention")

[data-storage.md](data-storage.md "mention")

[snap-to-obj](../fs/snap-to-obj/ "mention")

## **About f**ilesystem groups

In the Weka system, filesystems are grouped into a maximum of eight filesystem groups.

Each filesystem group has tiering control parameters. While tiered filesystems have their object store, the tiering policy is the same for each tiered filesystem under the same filesystem group.



**Related topics**

[managing-filesystem-groups](../fs/managing-filesystem-groups/ "mention")

