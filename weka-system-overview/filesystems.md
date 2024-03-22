---
description: >-
  This page describes the three entity types relevant to data storage in the
  WEKA system.
---

# Filesystems, object stores, and filesystem groups

## **Introduction to WEKA** filesystems

A WEKA filesystem operates much like a conventional on-disk filesystem but distributes the data across all servers in the cluster. Unlike traditional filesystems, it is not tied to any specific physical object within the WEKA system and serves as a root directory with space limitations.

The WEKA system supports up to 1024 filesystems, distributing them equally across all SSDs and CPU cores assigned to the cluster. This ensures that tasks like allocating new filesystems or resizing existing ones are immediate, without operational constraints.

Each filesystem is linked to a predefined filesystem group, each with a specified capacity limit. For those belonging to tiered filesystem groups, additional constraints, including a total capacity limit and an SSD capacity cap, apply.

The available SSD capacity of individual filesystems cannot exceed the total SSD net capacity allocated to all filesystems. This structured approach ensures effective resource management and optimal performance within the WEKA system.

### Thin provisioning **in WEKA filesystems**

Thin provisioning, a dynamic SSD capacity allocation method, addresses user needs on demand. In this approach, the filesystem's capacity is defined by a minimum guaranteed capacity and a maximum capacity, which can virtually exceed the available SSD capacity.

The system optimally allocates more capacity, up to the total available SSD capacity, for users who use their allocated minimum capacity. Conversely, as users free up space by deleting files or transferring data, the idle space undergoes reclamation, repurposing it for other workloads that require SSD capacity.

Thin provisioning proves beneficial in diverse scenarios:

* **Tiered filesystems:** On tiered filesystems, available SSD capacity is used for enhanced performance and can be released to the object store when needed by other filesystems.
* **Auto-scaling groups:** Thin provisioning facilitates automatic expansion and reduction (shrinking) of the filesystem's SSD capacity when using auto-scaling groups, ensuring optimal performance.
* **Filesystems separation per project:** Creating separate filesystems for each project becomes efficient with thin provisioning, especially when administrators don't anticipate full simultaneous usage of all filesystems. Each filesystem is allocated a minimum capacity but can consume more based on the actual available SSD capacity, offering flexibility and resource optimization.

### WEKA filesystem limits

* **Number of files or directories:** Up to 6.4 trillion (6.4 \* 10^12)
* **Number of files in a single directory:** Up to 6.4 billion (6.4 \* 10^9)
* **Total capacity with object store:** Up to 14 EB&#x20;
* **Total SSD capacity:** Up to 512 PB&#x20;
* **File size:** Up to 4 PB

### Data reduction **in WEKA filesystems**

WEKA introduces a cluster-wide data reduction feature that can be activated for individual filesystems. This capability incorporates block-variable differential compression and advanced de-duplication techniques across all filesystems, significantly reducing the required storage capacity for user data and delivering substantial cost savings.

The effectiveness of the compression ratio hinges on the specific workload, proving particularly efficient for text-based data, large-scale unstructured datasets, log analysis, databases, code repositories, and sensor data.

The data reduction applies exclusively to user data (not metadata) per filesystem. The data reduction can be enabled only on thin-provision, non-tiered, and unencrypted filesystems within a cluster holding a valid Data Efficiency Option (DEO) license.

#### How data reduction operates

Data reduction is a post-process activity. New data written to the cluster is written uncompressed. The data reduction process runs as a background task with lower priority than tasks serving user IO requests. The data reduction starts when enough data is written to the filesystems.

**Data reduction tasks:**

1. **Ingestion:**
   * _Clusterization_**:** Applied on data blocks at the 4K block level. The system identifies similarity across uncompressed data in all filesystems enabled for data reduction.
   * _Compression_: The system reads similar and unique blocks, compressing each type separately. Compressed data is then written to the filesystem.
2. **Defragmentation**:&#x20;
   * Uncompressed data related to successful compression is marked for deletion.
   * The defrag process waits for sufficient blocks to be invalidated and then permanently deletes them.

<figure><img src="../.gitbook/assets/DataReduction.gif" alt=""><figcaption><p>Data reduction process at a glance</p></figcaption></figure>

### Encrypted filesystems in WEKA

WEKA ensures security by offering encryption for data at rest (residing on SSD and object store) and data in transit. This security feature is activated by enabling the filesystem encryption option. The decision on whether a filesystem should be encrypted is crucial during the filesystem creation process.

To create encrypted filesystems, deploying a Key Management System (KMS) is imperative, reinforcing the protection of sensitive data.

{% hint style="info" %}
Data encryption settings can only be configured during the initial creation of a filesystem, emphasizing the importance of making this decision from the beginning.
{% endhint %}

**Related topics**

[kms-management](../operation-guide/security/kms-management/ "mention")

### Metadata limitations **in WEKA filesystems**

In addition to the capacity constraints, each filesystem in WEKA has specific limitations on metadata. The overall system-wide metadata cap depends on the SSD capacity allocated to the WEKA system and the RAM resources allocated to the WEKA system processes.

WEKA carefully tracks metadata units in RAM. If the metadata units approach the RAM limit, they are intelligently paged to the SSD, triggering alerts. This proactive measure allows administrators sufficient time to increase system resources while sustaining IO operations with minimal performance impact.

By default, the metadata limit linked to a filesystem correlates with the filesystem's SSD size. However, users have the flexibility to override this default by defining a filesystem-specific `max-files` parameter. This logical limit empowers administrators to regulate filesystem usage, providing the flexibility to update it as needed.

The cumulative metadata limits across all filesystems can surpass the system's entire metadata information that fits in RAM. In potential impact scenarios, the system optimizes by paging the least recently used units to disk, ensuring operational continuity with minimal disruption.

#### Metadata units calculation <a href="#metadata-calculations" id="metadata-calculations"></a>

Every metadata unit within the WEKA system demands 4 KB of SSD space (excluding tiered storage) and occupies 20 bytes of RAM.

Throughout this documentation, the restriction on metadata per filesystem is denoted as the `max-files` parameter. This parameter includes the files' count and respective sizes.

The following table outlines the requisite metadata units based on file size. These specifications apply to files stored on SSDs or tiered to object stores.

<table><thead><tr><th width="152.34501597463696">File size</th><th width="237">Number of metadata units</th><th>Example</th></tr></thead><tbody><tr><td>&#x3C; 0.5 MB</td><td>1</td><td>A filesystem containing 1 billion files, each sized at 64 KB, requires 1 billion metadata units.</td></tr><tr><td>0.5 MB - 1 MB</td><td>2</td><td>A filesystem containing 1 billion files, each sized at 750 KB, requires 2 billion metadata units.</td></tr><tr><td>> 1 MB</td><td>2 for the first 1 MB plus<br>1 per MB for the rest MBs</td><td><ul><li>A filesystem containing 1 million files, each sized at 129 MB, requires 130 million metadata units. This calculation includes 2 units for the first 1 MB and an additional unit per MB for the subsequent 128 MB.</li><li>A filesystem containing 10 million files, each sized at 1.5 MB, requires 30 million metadata units.</li><li>A filesystem containing 10 million files, each sized at 3 MB, requires 40 million metadata units.</li></ul></td></tr></tbody></table>

{% hint style="info" %}
Each directory requires two metadata units instead of one for a small file.
{% endhint %}

**Related topics**

[#memory-resource-planning](../planning-and-installation/bare-metal/planning-a-weka-system-installation.md#memory-resource-planning "mention")

### Filesystem Extended Attributes considerations

The maximum size for extended attributes (xattr) of a file or directory is 1024 bytes. This attribute space is used by Access Control Lists (ACLs) and Alternate Data Streams (ADS) within an SMB cluster and when configuring SELinux. When using Windows clients, named streams in smb-w are saved in the file’s xattr.

Given its finite capacity, exercise caution when using lengthy or complex ACLs and ADS on a WEKA filesystem.

When encountering a message indicating the file size exceeds the limit allowed and cannot be saved, carefully decide which data to retain. Strategic planning and selective use of ACLs and ADS contribute to optimizing performance and stability.

## **Introduction to** object stores

Within the WEKA system, object stores are an optional external storage medium strategically designed to store warm data. These object stores, employed in tiered WEKA system configurations, can be cloud-based, located in the same location as the WEKA cluster, or at a remote location.

WEKA extends support for object stores, leveraging their capabilities for tiering (both tiering and local snapshots) and backup (snapshots only). Both tiering and backup functionalities can be concurrently used for the same filesystem, enhancing flexibility.

The optimal usage of object store buckets comes into play when a cost-effective data storage tier is imperative and traditional server-based SSDs prove insufficient in meeting the required price point.

An object store bucket definition comprises crucial components: the object store DNS name, bucket identifier, and access credentials. The bucket must remain dedicated to the WEKA system, ensuring exclusivity and security by prohibiting access from other applications.

Moreover, the connectivity between filesystems and object store buckets extends beyond essential storage. This connection proves invaluable in data lifecycle management and facilitates the innovative Snap-to-Object features, offering a holistic approach to efficient data handling within the WEKA system.

**Related topics**

[managing-object-stores](../weka-filesystems-and-object-stores/managing-object-stores/ "mention")

[data-storage.md](data-storage.md "mention")

[snap-to-obj](../weka-filesystems-and-object-stores/snap-to-obj/ "mention")

## **Introduction to f**ilesystem groups

Within the WEKA system, the organization of filesystems takes place through the creation of filesystem groups, with a maximum limit set at eight groups.

Each of these filesystem groups comes equipped with tiering control parameters. When filesystems are tiered and have associated object stores, the tiering policy remains consistent for all tiered filesystems residing within the same filesystem group. This unification ensures streamlined management and unified control over tiering strategies within the WEKA system.

**Related topics**

[managing-filesystem-groups](../weka-filesystems-and-object-stores/managing-filesystem-groups/ "mention")
