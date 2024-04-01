---
description: >-
  Explore the principles for data lifecycle management and how data storage is
  managed in SSD-only and tiered WEKA system configurations.
---

# Data lifecycle management

## Media options for data storage in the WEKA system

In the WEKA system, data can be stored on two forms of media:

* On locally-attached SSDs, which are an integral part of the WEKA system configuration.
* On object-store systems external to the WEKA system are third-party solutions, cloud services, or part of the WEKA system.

The WEKA system can be configured as an SSD-only or data management system consisting of SSDs and object stores. By nature, SSDs provide high performance and low latency storage, while object stores compromise performance and latency but are the most cost-effective solution available for storage.

Consequently, users focused on high performance only must consider using an SSD-only WEKA system configuration, while users seeking to balance performance and cost must consider a tiered data management system, with the assurance that the WEKA system features control the allocation of hot data on SSDs and warm data on object stores, thereby optimizing the overall user experience and budget.

{% hint style="info" %}
In SSD-only configurations, the WEKA system sometimes uses an external object store for backup, as explained in [Snap-To-Object Data Lifecycle Management](../fs/snap-to-obj/#snap-to-object-in-data-lifecycle-management).
{% endhint %}

## Guidelines for data storage in tiered WEKA system configurations

In tiered WEKA system configurations, there are various locations for data storage as follows:

* Metadata is stored only on SSDs.
* Writing new files, adding data to existing files, or modifying the content of files is permanently terminated on the SSD, irrespective of whether the file is stored on the SSD or tiered to an object store.
* When reading the content of a file, data can be accessed from either the SSD (if it is available on the SSD) or promoted from the object store (if it is not available on the SSD). &#x20;

This data management approach to data storage on one of two possible media requires system planning to ensure that the most commonly used data (hot data) resides on the SSD to ensure high performance. In contrast, less-used data (warm data) is stored on the object store.

In the WEKA system, this determination of the data storage media is an entirely seamless, automatic, and transparent process, with users and applications unaware of the transfer of data from SSDs to object stores or from object stores to SSDs.

The data is always accessible through the same strongly-consistent POSIX filesystem API, irrespective of where it is stored. The actual storage media affects only latency, throughput, and IOPS.

Furthermore, the WEKA system tiers data into chunks rather than complete files. This enables the intelligent tiering of subsets of a file (and not only complete files) between SSDs and object stores.

The network resources allocated to the object store connections can be [controlled](../fs/managing-object-stores/#editing-an-object-store-using-the-cli). This enables cost control when using cloud-based object storage services since the cost of data stored in the cloud depends on the quantity stored and the number of requests for access made.

## States in the WEKA system data management storage process

Data management represents the media being used for the storage of data. In tiered WEKA system configurations, data can exist in one of three possible states:

* **SSD-only:** When data is created, it exists only on the SSDs.
* **SSD-cached:** A tiered copy of the data exists on both the SSD and the object store.
* **Object store only:** Data resides only on the object store.

{% hint style="info" %}
These states represent the lifecycle of data and not the lifecycle of a file. When a file is modified, each modification creates a separate data lifecycle for the modified data.
{% endhint %}

The data lifecycle flow diagram describes the progression of data through various stages:

1. **Tiering**: This process involves data migration from the SSD to the object store, creating a duplicate copy. The criteria for this transition are governed by a user-specified, temporal policy known as the [Tiering Cue](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy).
2. **Releasing**: This stage entails removing data from the SSD and retaining only the copy in the object store. The need for additional SSD storage space typically triggers this action. The guidelines for this data release are dictated by a user-defined time-based policy referred to as the [Retention Period](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#data-retention-period-policy).
3. **Promoting**: This final stage involves transferring data from the object store to the SSD to facilitate data access.

Accessing data solely on the object store must first be promoted back to the SSD. This ensures that the data is readily accessible for reading.

Within the WEKA system, file modifications are not executed as in-place writes. Instead, they are written to a new area on the SSD, and the corresponding metadata is updated accordingly. As a result, write operations are never linked with operations on the object store. This approach ensures data integrity and efficient use of storage resources.

![Data lifecycle flow](../.gitbook/assets/data\_life\_cycle\_flow.png)

## The role of SSDs in tiered configurations

All writing in the WEKA system is performed on SSDs. The data residing on SSDs is hot (meaning it is currently in use). In tiered WEKA configurations, SSDs have three primary roles in accelerating performance: metadata processing, a staging area for writing, and a cache for reading performance.

### Metadata processing

Since filesystem metadata is, by nature, a large number of update operations, each with a small number of bytes, the embedding of metadata on SSDs accelerates file operations in the WEKA system.

### SSD as a staging area

Since writing directly to an object store demands high latency levels while waiting for approval for the data to be written, with the WEKA system, there is no writing directly to object stores. Much faster writing is performed directly to the SSDs, with very low latency and much better performance. Consequently, in the WEKA system, the SSDs serve as a staging area, providing a buffer that is big enough for writing until the later data tiering to the object store. Upon completion of writing, the WEKA system is responsible for tiering the data to the object store and releasing it from the SSD.

### SSD as a cache

Recently accessed or modified data is stored on SSDs, and most read operations are of such data and served from SSDs. This is based on a single, significant LRU clearing policy for the cache that ensures optimal read performance.

{% hint style="info" %}
On a tiered filesystem, the total capacity determines the maximum capacity that can be used to store data. It could be that all data reside in the object store due to the SSD uses above and the time-based policies below.

For instance, consider a 100 TB filesystem (total capacity) with a 10 TB SSD capacity for this filesystem. All the data reside in the object store; no new writing is allowed. However, the SSD space is only partially used (until files are deleted or the filesystem's total size is increased), leaving the SSD for metadata and cache only.
{% endhint %}

## Time-based policies for the control of data storage location

The WEKA system includes user-defined policies that serve as guidelines to control data storage management. They are derived from several factors:

* The rate at which data is written to the system and the quantity of data.
* The capacity of the SSDs configured to the WEKA system.
* The network speed between the WEKA system and the object store and its performance capabilities, e.g., how much the object store can contain.

Filesystem groups are used to define these policies, while a filesystem is placed in a filesystem group according to the desired policy if the filesystem is tiered.

For tiered filesystems, define the following parameters per filesystem:

* The size of the filesystem.
* The amount of filesystem data to be stored on the SSD.

Define the following parameters per filesystem group:

* The [Drive Retention Period Policy](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#drive-retention-period-policy) is a time-based policy which is the target time for data to be stored on an SSD after creation, modification, or access, and before release from the SSD, even if it is already tiered to the object store, for metadata processing and SSD caching purposes (this is only a target; the actual release schedule depends on the amount of available space).&#x20;
* The [Tiering Cue Policy](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy) is a time-based policy that determines the minimum time that data remains on an SSD before it is considered for release to the object store. As a rule of thumb, this must be configured to a third of the Retention Period, and in most cases, this works well. The Tiering Cue is important because it is pointless to tier a file about to be modified or deleted from the object store.&#x20;

{% hint style="success" %}
**Example**

_When writing log files that are processed every month but retained forever,_ it is recommended to define a Retention Period of one month, a Tiering Cue of one day, and ensure sufficient SSD capacity to hold one month of log files.

_When storing genomic data, which is frequently accessed during the first three months after creation, requires a scratch space for six hours of processing, and requires output to be retained forever,_ it is recommended to define a Retention Period of three months and to allocate an SSD capacity that is sufficient for three months of output data and the scratch space. The Tiering Cue must be defined as one day to avoid a situation where the scratch space data is tiered to an object store and released from the SSD immediately afterward.
{% endhint %}

{% hint style="info" %}
Using the [Snap-To-Object](../fs/snap-to-obj/) feature causes data to be tiered regardless of the tiering policies.
{% endhint %}

### Bypassing the time-based policies

Even when time-based policies are in place, you can override them using a unique mount option called `obs_direct`. When this option is used, any files created or written from the associated mount point are prioritized for release immediately without first considering other file retention policies.

For a more in-depth explanation, refer to [Advanced Data Lifecycle Management](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md).
