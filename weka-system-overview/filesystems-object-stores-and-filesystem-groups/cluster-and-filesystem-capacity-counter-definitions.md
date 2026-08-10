---
description: >-
  Understand the key capacity counters for effective storage management,
  including space utilization, availability, and data reduction across SSDs and
  object storage.
---

# Cluster and filesystem capacity counter definitions

## Cluster and filesystem capacity counter definitions

* **SSD capacity counters**:
  * **USED SSD**: Total SSD space currently in use, including both data and metadata.
  * **USED SSD (DATA)**: Space on SSDs occupied by actual file data.
  * **USED SSD (META)**: Space on SSDs used for storing filesystem metadata.
  * **FREE SSD**: Available unused space on SSDs.
  * **AVAILABLE SSD (META)**: Remaining SSD space available for storing filesystem metadata.
  * **AVAILABLE SSD**: Total SSD space provisioned to the filesystem by the user.
* [**Total**](#user-content-fn-1)[^1] **capacity counters**:
  * **USED TOTAL**: Total space used across both SSD and object store for filesystem data and metadata.
  * **USED TOTAL (DATA)**: Total space consumed by file data across the entire filesystem.
  * **FREE TOTAL**: Remaining space available in the filesystem for storing data and metadata.
  * **AVAILABLE TOTAL**: Total allocated space across both SSD and object store tiers.
* **Data reduction counters:**
  * **DATA REDUCTION RATIO (DRR):** Data reduction efficiency, calculated as:\
    USED SSD (DATA) / REDUCED SIZE OF DATA.
  * **USED SSD PENDING DATA REDUCTION:** Amount of data written to SSD that is awaiting data reduction processing.
  * **REDUCED SIZE OF PROCESSED DATA:** Total SSD space occupied post data reduction processing.
  * **REDUCED SIZE OF DATA:** Total SSD space consumed by the filesystem after all data reduction operations are complete.
  * **PROCESSED DATA REDUCTION RATIO:** Storage efficiency that shows actual space savings achieved through data reduction and deduplication. Calculated as:\
    (USED SSD (DATA) - USED SSD PENDING DATA REDUCTION) / REDUCED SIZE OF PROCESSED DATA
* **Other counters**:
  * **THIN PROVISIONED MINIMUM SSD**: Minimum guaranteed space.
  * **THIN PROVISIONED MAXIMUM SSD**: Maximum limit of space that can be dynamically allocated.
  * **USED SSD (WRITECACHE)**: SSD space consumed by modified data, possibly pending tiering to object store.
  * **USED SSD (READCACHE)**: Total SSD space used for caching data that also exists in the object store, based on filesystem group tiering policies.

### Example scenarios

#### Thin provisioned filesystem (no data reduction)

```bash
FILESYSTEM NAME: fs_example1
THIN PROVISIONED: true
THIN PROVISIONED MINIMUM SSD: 100 TB
THIN PROVISIONED MAXIMUM SSD: 500 TB
USED SSD: 150 TB
USED SSD (DATA): 145 TB
USED SSD (META): 5 TB
FREE SSD: 350 TB
```

#### Filesystem with active data reduction

```bash
FILESYSTEM NAME: fs_example2
DATA REDUCTION: Enabled
USED SSD: 200 TB
USED SSD (DATA): 150 TB
PENDING DATA REDUCTION: 50 TB
REDUCED SIZE OF PROCESSED DATA: 40 TB
DATA REDUCTION FACTOR: 3.75
```

**Related topics**

[Filesystems, object stores, and filesystem groups](./)

[Data lifecycle management overview](../data-storage.md)

[Manage filesystems](../../weka-filesystems-and-object-stores/managing-filesystems/)

[^1]: **Total**: Represents the amount used by the filesystem, not across storage tiers. SSD cache usage changes as data moves between SSD and OBS.
