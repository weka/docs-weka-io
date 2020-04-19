---
description: >-
  This page covers the principles for data lifecycle management and how data
  storage is managed in SSD-only and tiered WEKA system configurations.
---

# Data Lifecycle Management

## Media Options for Data Storage in the WEKA System

In the WEKA system, data can be stored on two forms of media:

1. On locally-attached SSDs, which are an integral part of the WEKA system configuration.
2. On object store systems external to the WEKA system, which are either third party solutions, cloud services or part of the WEKA system.

The WEKA system can be configured either as an SSD-only system, or as a data management system consisting of both SSDs and object stores. By nature, SSDs provide high performance and low latency storage, while object stores compromise performance and latency but are the most cost-effective solution available for storage. Consequently, users focused on high performance only should consider using an SSD-only WEKA system configuration, while users seeking to balance between performance and cost should consider a tiered data management system, with the assurance that the WEKA system features will control the allocation of hot data on SSDs and warm data on object stores, thereby optimizing the overall user experience and budget.

{% hint style="info" %}
**Note:** In SSD-only configurations, the WEKA system will sometimes use an external object store for backup, as explained in [Snap-To-Object Data Lifecycle Management](../fs/snap-to-obj.md#snap-to-object-in-data-lifecycle-management).
{% endhint %}

## Guidelines for Data Storage in Tiered WEKA System Configurations

In tiered WEKA system configurations, there are various locations for data storage as follows:

1. Metadata is stored only on the SSDs.
2. Writing of new files, adding data to existing files or modifying the content of files is always terminated on the SSD, irrespective of whether the file is currently stored on the SSD or tiered to an object store.
3. When reading the content of a file, data can be accessed from either the SSD \(if it is available on the SSD\) or rehydrated from the object store \(if it is not available on the SSD\).  

This data management approach to data storage on one of two possible media requires system planning to ensure that most commonly-used data \(hot data\) resides on the SSD to ensure high performance, while less-used data \(warm data\) is stored on the object store. In the WEKA system, this determination of the data storage media is a completely seamless, automatic and transparent process, with users and applications unaware of the transfer of data from SSDs to object stores, or from object stores to SSDs. The data is accessible at all times through the same strongly-consistent POSIX filesystem API, irrespective of where it is stored. Only latency, throughput and IOPS are affected by the actual storage media.

Furthermore, the WEKA system tiers data in chunks, rather than in complete files. This enables the smart tiering of subsets of a file \(and not only complete files\) between SSDs and object stores.

The network resources allocated to the object store connections can be [controlled](../fs/managing-filesystems/managing-object-stores.md#editing-an-object-store-using-the-cli). This enables cost control when using cloud-based object storage services, since the cost of data stored in the cloud depends on the quantity stored and the number of requests for access made.

## States in the WEKA System Data Management Storage Process

Data management represents the media being used for the storage of data. In tiered WEKA system configurations, data can exist in one of three possible states:

1. **SSD-only:** When data is created, it exists only on the SSDs.
2. **SSD-cached:** A tiered copy of the data exists on both the SSD and the object store.
3. **Object Store only:** Data resides only on the object store.

{% hint style="info" %}
**Note:** These states represent the lifecycle of data, and not the lifecycle of a file. When a file is modified, each modification creates a separate data lifecycle for the modified data.
{% endhint %}

![](../.gitbook/assets/diagram-2a-121676.jpg)

In order to read data residing only on an object store, the data must first be rehydrated back to the SSD.

In the WEKA system, file modification is never implemented as in-place write, but rather as a write to a new area located on the SSD, and the relevant modification of the meta-data. Consequently, write operations are never associated with object store operations.

## The Role of SSDs in Tiered WEKA Configurations

All writing in the WEKA system is performed to SSDs. The data residing on SSDs is hot data, i.e., data that is currently in use. In tiered WEKA configurations, SSDs have three primary roles in accelerating performance: metadata processing, a staging area for writing and as a cache for read performance.

### Metadata Processing

Since filesystem metadata is by nature a large number of update operations each with a small number of bytes, the embedding of metadata on SSDs serves to accelerate file operations in the WEKA system.

### SSD as a Staging Area

Since writing directly to an object store demands high latency levels while waiting for approval that the data has been written, with the WEKA system there is no writing directly to object stores. Much faster writing is performed directly to the SSDs, with very low latency and therefore much better performance. Consequently, in the WEKA system, the SSDs serve as a staging area, providing a buffer that is big enough for writing until later tiering of data to the object store. On completion of writing, the WEKA system is responsible for tiering the data to the object store and for releasing it from the SSD.

### SSD as a Cache

Recently accessed or modified data is stored on SSDs, and most read operations will be of such data and served from SSDs. This is based on a single, large LRU clearing policy for the cache that ensures optimal read performance.

{% hint style="info" %}
**Note:** On a tiered filesystem, the total capacity determines the maximum capacity that will be used to store data. It could be that it will all reside on the object store due to the SSD uses above and the below time-based policies.

E.g., consider a 100 TB filesystem \(total capacity\) with a 10TB SSD capacity for this filesystem. It could be that all the data will reside on the object-store, and no new writes will be allowed, although the SSD space is not completely used \(until deleting files or increasing filesystem total size\), leaving the SSD for metadata and cache only.
{% endhint %}

## Time-based Policies for the Control of Data Storage Location

The WEKA system includes user-defined policies which serve as guidelines to control the data storage management. They are derived from a number of factors:

1. The rate at which data is written to the system and the quantity of data.
2. The capacity of the SSDs configured to the WEKA system.
3. The speed of the network between the WEKA system and the object store, and the performance capabilities of the object store itself, e.g., how much the object store can actually contain.

Filesystem groups are used to define these policies, while a filesystem is placed in a filesystem group according to the desired policy if the filesystem is tiered.

For tiered filesystems, the following parameters should be defined per filesystem:

1. The size of the filesystem.
2. The amount of filesystem data to be stored on the SSD.

The following parameters should be defined per filesystem group:

1. The [Data Retention Period Policy](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#data-retention-period-policy), a time-based policy which is the target time for data to be stored on an SSD after creation, modification or access, and before release from the SSD, even if it is already tiered to the object store, for metadata processing and SSD caching purposes \(this is only a target; the actual release schedule depends on the amount of available space\). 
2. The [Tiering Cue Policy](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy), a time-based policy which determines the minimum amount of time that data will remain on an SSD before it is considered for release to the object store. As a rule of thumb, this should be configured to a third of the Retention Period, and in most cases, this will work well. The Tiering Cue is important because it is pointless to tier a file which is about to be modified or deleted from the object store. 

{% hint style="success" %}
**For Example:**

_When writing log files which are processed every month but retained forever:_ It is recommended to define a Retention Period of 1 month, a Tiering Cue of 1 day, and ensure that there is sufficient SSD capacity to hold 1 month of log files.

_When storing genomic data which is frequently accessed during the first 3 months after creation, requires a scratch space for 6 hours of processing, and requires output to be retained forever:_ It is recommended to define a Retention Period of 3 months and to allocate an SSD capacity that will be sufficient for 3 months of output data and the scratch space. The Tiering Cue should be defined as 1 day, in order to avoid a situation where the scratch space data is tiered to an object store and released from the SSD immediately afterwards.
{% endhint %}

{% hint style="info" %}
**Note:** Using the [Snap-To-Object](../fs/snap-to-obj.md) feature causes data to be tiered regardless of the tiering policies.
{% endhint %}

For a more in-depth explanation, refer to [Advanced Data Lifecycle Management](../fs/tiering/advanced-time-based-policies-for-data-storage-location.md).

