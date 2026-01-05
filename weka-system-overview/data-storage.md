---
description: >-
  Explore the principles for data lifecycle management and how data storage is
  managed in SSD-only and tiered WEKA system configurations.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-system-overview/data-storage
---

# Data lifecycle management overview

The WEKA system provides flexible storage architectures that balance performance and cost by managing data across different storage media. Understanding how WEKA handles data placement helps you configure systems that deliver the performance characteristics your workloads require while controlling storage costs.

## Storage media options in WEKA systems

WEKA systems use two types of storage media, each serving distinct purposes based on its performance and cost characteristics:

* **Solid-state drives (SSDs):** Form the foundation of every WEKA system. These locally attached drives provide the high performance and low latency that make WEKA suitable for demanding workloads. SSDs are a required component of any WEKA configuration, and they deliver the exceptional IOPS and throughput that applications depend on for fast data access.
* **Object store systems:** Represent the second storage tier available in WEKA. These systems connect to WEKA externally and can be cloud-based services like AWS S3 or Azure Blob Storage, or on-premises installations using various third-party solutions. Object stores trade some performance and add latency compared to SSDs, but they provide virtually unlimited capacity at significantly lower cost per terabyte than solid-state storage.

### Configuration options: SSD-only vs tiered systems

WEKA supports two fundamental configuration approaches that serve different use cases and priorities:

* SSD-only configurations
* Tiered configurations

#### SSD-only configurations

SSD-only configurations store all data exclusively on solid-state drives. This approach maximizes performance by maintaining all data on the fastest storage media available.

Workloads that demand consistent low latency and high throughput for all data access, regardless of data age or access frequency, benefit from SSD-only configurations. The trade-offs include capacity limitations, where the SSD investment bounds the total storage, and a higher cost per terabyte stored.

In SSD-only configurations, WEKA can optionally use object store for the Snap-To-Object feature. This feature maintains backup copies of snapshots in object store for disaster recovery while keeping all active data on SSDs for performance.

#### Tiered configurations

Tiered configurations combine SSDs and object store into an integrated system where WEKA automatically manages data placement between the two media.

This approach optimizes storage cost and efficiency. Newly created and frequently accessed data stays on SSDs for fast access, while older or rarely accessed data moves to object store. WEKA automatically identifies the appropriate tier for the data and transparently moves it between tiers as access patterns change.

Tiered configurations allow the provisioning of a much larger total filesystem capacity than the SSD investment alone supports. For example, a system can configure 25 TB of SSDs but create a 100 TB filesystem, while WEKA manages which 25 TB resides on SSDs based on access patterns and configured policies.

## Data management in tiered configurations

Understanding data placement in a tiered system clarifies how WEKA balances performance and cost.

#### **Metadata residency**

Metadata resides exclusively on SSDs and never moves to object store. This includes directory structures, file attributes, timestamps, permissions, and internal indexes used to locate data.

Keeping metadata on SSDs ensures that filesystem traversal operations—such as listing directories, checking file existence, and reading attributes—remain fast, regardless of whether the file data resides on SSD or in object store. This design enables navigation of massive filesystems with billions of files at SSD speeds.

#### **Write operations**

Write operations in tiered systems always target SSDs first. Creating new files, appending to existing files, or modifying content occurs at SSD speeds.

WEKA never writes directly to object store to avoid high latency in the write path. Instead, writes complete quickly on SSD, and the system manages the background process of copying data to object store based on configured policies.

#### **Data modifications**

WEKA handles modifications by writing new data to fresh space on SSD rather than overwriting existing data in place. The metadata updates to point to this new location.

Consequently, modifications always occur at SSD speed, even if the original file data was tiered to object store. The old version may remain in object store (supporting snapshot functionality), while the new version resides on SSD.

#### **Read operations and promotion**

Read operations access data from either tier, depending on its location:

* **SSD resident data:** If data resides on SSD (because it has not yet tiered or is cached), the read completes at SSD speed.
* **Object store resident data:** If data exists only in object store, WEKA automatically retrieves it through a process called promotion. The system fetches the data, places it on SSD, and serves it to the application.

Subsequent reads of the promoted data complete at SSD speed. This mechanism ensures transparency. That is, applications access files through standard POSIX operations without tracking data location, while WEKA manages the complexity behind the scenes. The primary observable difference is latency during the first access to object-stored data.

### Intelligent chunk-level management

WEKA optimizes storage efficiency and performance by managing data at a sub-file granularity. The system uses data chunks to distribute data across different SSDs and organize tiering. It tracks the storage tier and access patterns for each chunk independently.

#### Optimize large file handling

The chunk-level approach enhances large file management. For database files where applications frequently modify specific regions, the system retains active chunks on the SSD for fast access. It tiers unchanged portions to the object store. The application perceives a single consistent file, regardless of the storage tier where specific parts reside.

#### Prevent unnecessary data movement

Chunk-level granularity minimizes data movement. Modifying a specific section of a file, such as 10 MB within a 100 GB file, triggers a rewrite only for the modified chunks. These chunks restart their lifecycle on the SSD. Unchanged chunks maintain their current lifecycle on the SSD or object store. This approach avoids the resource cost of reprocessing the entire file when only a small portion changes.

### Data lifecycle states

In a tiered configuration, data progresses through three distinct states representing its current storage location. These states apply to data chunks rather than entire files, meaning a single file can simultaneously have chunks in different states.

* **SSD-only:** Represents newly created or recently modified data residing exclusively on SSDs. This is the initial state for all data entering the system before it is copied to object store.
* **SSD-cached:** Represents data existing in both the SSD and object store tiers. After the tiering process copies data to object store, the SSD copy serves as a cache to ensure fast access, while the object store copy provides authoritative long-term retention. Data often remains in this state for significant periods to optimize read performance.
* **Object store only:** Represents data released from the SSD after its cache retention period expires. The data resides solely in object store. Accessing this data triggers a promotion process to restore it to the SSD. This state maximizes storage efficiency but incurs higher latency during the initial read.

Identifying these states clarifies system behavior. SSD-cached data ensures low-latency reads. Conversely, accessing data in the object-store-only state requires fetching it from object store, resulting in initial latency before subsequent accesses return to SSD speeds.

### Core data movement processes

Data movement between states relies on three distinct processes: **Tiering, Releasing**, and **Promoting**, that WEKA executes automatically based on configured policies and system conditions.

![Data lifecycle flow](../.gitbook/assets/data_life_cycle_flow.png)

#### **Tiering**

Tiering is the process of copying data from the SSD to object store, creating a duplicate copy that transitions data from the SSD-only to the SSD-cached state.

The Tiering Cue policy controls the timing of this process. It specifies the wait time after data is written before initiating the copy to object store. This waiting period accommodates workflows where data is modified or deleted shortly after creation. By waiting, WEKA avoids the resource overhead of tiering data that may soon change or be deleted. Tiering occurs as a background operation and does not affect data availability or application access.

#### **Releasing**

Releasing is the process of removing data from the SSD after it has been safely tiered to object store. This transitions data from the SSD-cached to the object store only state.

The release process occurs when the system requires SSD space for new data and determines that older cached data can be removed without significantly impacting performance. The Retention Period policy influences the timing, specifying how long tiered data should remain cached on the SSD. However, available SSD capacity strongly influences release timing; if data is written faster than the SSD can accommodate, the system releases data earlier than the Retention Period suggests to prevent the SSD from filling completely.

#### **Promoting**

Promoting is the process of retrieving data from object store and placing it back on the SSD. This is triggered by application access to data in the object store only state.

When a user accesses a file released from the SSD, WEKA automatically fetches the data from object store, places it on the SSD, and serves the read request. The promoted data remains on the SSD with a fresh timestamp, effectively restarting its lifecycle. Subsequent accesses to this data are fast because the promotion restores it to the SSD.

## Role of SSDs in tiered systems

In tiered configurations, SSDs perform three critical functions beyond storage: metadata processing, write staging, and read caching.

#### **Metadata processing**

Filesystem metadata operations, such as creating files, modifying attributes, and updating directory listings, involve frequent, small random read and write operations. SSDs excel at this workload pattern, whereas object store performs poorly.

WEKA stores all metadata on SSDs. This ensures fast filesystem navigation and file operations, regardless of the total data volume or its location.

#### **Write staging**

SSDs act as a low-latency staging area for write operations. Direct writing to object store imposes high latency on applications. To mitigate this, WEKA accepts all writes on SSDs, allowing them to complete at local speeds. The application proceeds immediately while the system handles the background task of copying data to object store. This approach delivers consistent write performance while leveraging cost-effective long-term storage.

#### **Read caching**

SSDs function as a read cache for object-stored data. When the system tiers data to the object store, it retains a cached copy on the SSD. To manage this cache, the system applies a Least Recently Used (LRU) policy. This ensures that the most recently accessed data remains on the high-performance SSD, while the system clears the least active data to free up space. This strategy supports a working set significantly larger than the physical SSD capacity.

## Capacity considerations in tiered filesystems

In tiered systems, distinguishing between total filesystem capacity and SSD capacity is essential for proper configuration and interpretation of system behavior. These two metrics serve different purposes.

**Capacity definitions**

* **Total filesystem capacity:** Represents the maximum amount of data the filesystem can hold across both tiers (SSD and object store). For example, a 100 TB filesystem can store up to 100 TB of data, distributed between the tiers based on policies and access patterns.
* **SSD capacity:** Represents the working space allocated for recently written or frequently accessed data, metadata, and caching. This is typically significantly smaller than the total filesystem capacity. For example, a system might allocate 25 TB of SSD capacity within a 100 TB filesystem, relying on object store for the remaining 75 TB.

**Filesystem capacity limits vs. SSD utilization**

A filesystem can report as full even when the SSD tier retains available space.

Consider a 100 TB filesystem with 25 TB of allocated SSD capacity. If the system stores 100 TB of data, most of which has tiered to object store, the SSD might only contain 20 TB of cached data. Despite the available SSD space, the system prevents further writes because the total filesystem capacity limit has been reached.

**Role of reserved SSD capacity**

SSD space remains reserved for essential functions, even when not fully utilized for data storage. This reservation ensures resources are available for:

* **Metadata processing:** Storing directory structures and file attributes.
* **Write staging:** Accepting new writes at high speed before tiering.
* **Read caching:** Accommodating data promoted from object store upon access.

To write additional data when the total capacity limit is reached, either delete existing files to free space or increase the total filesystem capacity allocation. Increasing the total capacity allows more data storage, with the additional volume residing in object store.

## Data lifecycle management policies

WEKA provides time-based policies to control data movement between tiers. These policies enable tuning the system for specific workload patterns and balancing performance against storage costs.

#### Drive retention period

The drive retention period specifies the duration data remains cached on the SSD after the system tiers it to the object store. This setting controls the depth of the SSD cache relative to data history.

* **Longer retention:** Keeps more data accessible at SSD speeds but requires more SSD capacity.
* **Shorter retention:** Reduces SSD requirements but increases the likelihood of fetching data from the object store upon access.

This setting serves as a target. If data is written faster than the SSD capacity can accommodate within the configured retention period, the system releases data earlier to prevent SSD exhaustion.

#### Tiering cue

The tiering cue determines the wait time before the system begins copying data from the SSD to the object store. This buffer accommodates data modification patterns. For workflows involving file edits over several hours or days, setting a tiering cue that spans the editing window prevents the repeated tiering of changing data.

The minimum tiering cue is one-third of the retention period.

#### **Policy configuration strategy**

Configure lifecycle policies at the filesystem group level to align with specific workload characteristics. Effective configuration requires analyzing data generation rates, access patterns, and available SSD capacity.

**Workload strategies**

* **Active processing:** Assign a long retention period to maintain working data on the SSD for high-performance access.
* **Archival storage:** Assign a short retention period for rarely accessed data to optimize SSD usage.

**Configuration examples**

* **Log files:** For log files processed within a month but retained permanently, set a one-month retention period. Verify that the SSD capacity is sufficient to cache one month of data.
* **Research data:** For research data analyzed for three months before archiving, set a three-month retention period. This keeps active data on the SSD for fast access while moving completed projects to the object store.

### Bypassing standard lifecycle policies

While time-based policies manage data lifecycle for most workflows, WEKA provides mechanisms for immediate action when needed:

* **Snap-To-Object**: Forces data to tier immediately to object store, bypassing standard tiering policies. Useful for backup workflows requiring immediate object store writes.
* **Object-store direct mount** (`obs_direct`): Bypasses SSD cache for specific mount points. Writes are released immediately to object store. Reads access object store directly. Ideal for bulk imports that bypass SSD cache.

**Related topics**

[tiering.md](../weka-filesystems-and-object-stores/tiering.md "mention")

[snap-to-obj](../weka-filesystems-and-object-stores/snap-to-obj/ "mention")
