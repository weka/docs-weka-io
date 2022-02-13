---
description: >-
  This page provides a detailed description of how data storage is managed in
  tiered Weka system configurations.
---

# Advanced Time-based Policies for Data Storage Location

## Data Retention Period Policy

Consider a scenario of a 100 TB filesystem (total capacity), with 100 TB of SSD space (as explained in [The Role of SSDs in Tiered Weka Configurations](../../overview/data-storage.md#the-role-of-ssds-in-tiered-weka-configurations) section). If the data Retention Period policy is defined as 1 month and only 10 TB of data are written per month, it will probably be possible to maintain data from the last 10 months on the SSDs. On the other hand, if 200 TB of data is written per month, it will only be possible to maintain data from half of the month on the SSDs. Additionally, there is no guarantee that the data on the SSDs is the data written in the last 2 weeks of the month, which also depends on the Tiering Cue.

Consequently, the data Retention Period policy determines the resolution of the Weka system release decisions. If it is set to 1 month and the SSD capacity is sufficient for 10 months of writing, then the first month will be kept on the SSDs.

{% hint style="info" %}
**Note:** If the Weka system cannot comply with the defined Retention Period, e.g., the SSD is full and data has not been released from the SSD to the object store, a Break-In Policy will occur. In such a situation, an event is received in the Weka system event log, advising that the system has not succeeded in complying with the policy and that data has been automatically released from the SSD to the object store, before completion of the defined Retention Period. No data will be lost (since the data has been transferred to the object store), but slower performance may be experienced.
{% endhint %}

{% hint style="info" %}
**Note:** If the data writing rate is always high and the Weka system fails to successfully release the data to the object store, an Object Store Bottleneck will occur. If the bottleneck continues, this will also result in a Policy Violation event.
{% endhint %}

## Tiering Cue Policy

The Tiering Cue policy defines the period of time to wait before the release of data from the SSD to the object-store. It is typically used when it is expected that some of the data being written will be rewritten/modified/deleted in the short term.

The Weka system integrates a rolling progress control with three rotating periods of 0, 1, and 2.

1. Period 0: All data written is tagged as written in the current period.
2. Period 1: The switch from 0 to 1 is according to the Tiering Cue policy.
3. Period 2: Starts after the period of time defined in the Tiering Cue, triggering the transfer of data written in period 0 from the SSD to the object-store.

{% hint style="info" %}
**Note:** Not all data is transferred to the object store in the order that it was written. If, for example, the Tiering Cue is set to 1 month, there is no priority or order in which the data from the whole month is released to the object store; data written at the end of the month may be released to the object store before data written at the beginning of the month.
{% endhint %}

## Management of Data Retention Policies <a href="#management-of-data-retention-policies" id="management-of-data-retention-policies"></a>

Since the Weka system is a highly scalable data storage system, data storage policies in tiered Weka configurations cannot be based on cluster-wide FIFO methodology, because clusters can contain billions of files. Instead, data retention is managed by time-stamping every piece of data, where the timestamp is based on a resolution of intervals which may extend from minutes to weeks. The Weka system maintains the interval in which each piece of data was created, accessed, or last modified.

Users only specify the data Retention Period and based on this, each interval is one-quarter of the Data Retention Period. Data written, modified, or accessed prior to the last interval is always released, even if SSD space is available.

{% hint style="info" %}
**Note:** The timestamp is maintained per piece of data in chunks of up to 1 MB, and not per file. Consequently, different parts of big files may have different tiering states.
{% endhint %}

{% hint style="success" %}
**For Example:** In a Weka system that is configured with a Data Retention Period of 20 days, data is split into 7 interval groups, with each group spanning a total of 5 days (5 is 25% of 20, the data Retention Period). If the system starts operating on January 1, then data written, accessed, or modified between January 1-5 is classified as belonging to interval 0, data written, accessed, or modified between January 6-10 belongs to interval 1, and so on. In such a case, the 7 intervals will be timestamped and divided as follows:
{% endhint %}

![](<../../.gitbook/assets/Table 1B.jpg>)

## Data Release Process from SSD to Object Store <a href="#data-release-process-from-ssd-to-object-store" id="data-release-process-from-ssd-to-object-store"></a>

At any given moment, the Weka system releases the filesystem data of a single interval, transferring it from the SSD to the object-store. This release process is based on the available SSD capacity. Consequently, if there is sufficient SSD capacity, only data which was modified or written before 7 intervals will be released.

{% hint style="success" %}
**For Example:** If 3 TB of data is produced every day, i.e., 15 TB of data in each interval, the division of data will be as follows:
{% endhint %}

![](<../../.gitbook/assets/Table 2.jpg>)

Now consider a situation where the total capacity of the SSD is 100 TB. The situation in the example above will be as follows:

![](<../../.gitbook/assets/Table 3.jpg>)

Since the resolution in the Weka system is the interval, in the example above the SSD capacity of 100 TB is insufficient for all data written over the defined 35-day Retention Period. Consequently, the oldest, most non-accessed, or modified data, has to be released to the object-store. In this example, this release operation will have to be performed in the middle of interval 6 and will involve the release of data from interval 0.

This counting of the age of the data in resolutions of 5 days is performed according to 8 different categories. A constantly rolling calculation, the following will occur in the example above:

* Data from days 1-30 (January 1-30) will all be on the SSD. Some of it may be tiered to the object store, depending on the defined Tiering Cue.
* Data from more than 35 days will be released to the object-store.
* Data from days 31-35 (January 31-February 4) will be partially on the SSD and partially tiered to the object-store. However, there is no control over the order in which data from days 31-35 is released to the object-store.

{% hint style="success" %}
**For Example:** If no data has been accessed or modified since creation, then the data from interval 0 will be released and the data from intervals 1-6 will remain on the SSDs. If, on the other hand, 8 TB of data is written every day, meaning that 40 TB of data is written in each interval (as shown below), then the first two intervals, i.e., data written, accessed or modified in a total of 10 days will be kept on the SSD, while other data will be released to the object-store.
{% endhint %}

![](<../../.gitbook/assets/Table 4.jpg>)

Now consider the following filesystem scenario, where the whole SSD storage capacity of 100 TB is utilized in the first 3 intervals:

![](<../../.gitbook/assets/Table 5.jpg>)

When much more data is written and there is insufficient SSD capacity for storage, the data from interval 0 will be released when the 100 TB capacity is reached. This represents a violation of the Retention Period. In such a situation, it is also possible to either increase the SSD capacity or reduce the Retention Period.

## Tiering Cue <a href="#tiering-cue" id="tiering-cue"></a>

The tiering process (the tiering of data from the SSDs to the object stores) is based on when data is created or modified. It is managed similar to the Retention Period, with the data timestamped in intervals. The length of each interval is the size of the user-defined Tiering Cue. The Weka system maintains 3 such intervals at any given time, and always tiers the data in the third interval.

{% hint style="info" %}
**Note:** While the data release process is based on timestamps of access, creation, or modification, the tiering process is based only on the timestamps of the creation or modification.
{% endhint %}

{% hint style="info" %}
**Note:** These timestamps are per 1 MB chunk and not the file timestamp.
{% endhint %}

{% hint style="success" %}
**For Example:** If the Tiering Cue is 1 day, then the data will be classified according to the following timeline for a system that starts working on January 1:
{% endhint %}

![](<../../.gitbook/assets/Table 6.jpg>)

Since the tiering process applies to data in the first interval in this example, the data written or modified on January 1 will be tiered to the object store on January 3. Consequently, data will never be tiered before it is at least 1 day old (which is the user-defined Tiering Cue), with the worst case being the tiering of data written at the end of January 1 at the beginning of January 3.

{% hint style="info" %}
**Note:** The Tiering Cue default is 10 seconds and cannot exceed 1/3 of the Data Retention period.
{% endhint %}

## Breaks in Retention Period or Tiering Cue Policies <a href="#breaks-in-retention-period-or-tiering-cue-policies" id="breaks-in-retention-period-or-tiering-cue-policies"></a>

If it is not possible to maintain the defined Retention Period or Tiering Cue policies, a TieredFilesystemBreakingPolicy event will occur, and old data will be released in order to free space on the SSDs. Users are alerted to such a situation through an ObjectStoragePossibleBottleneck event, enabling them to consider either raising the bandwidth or upgrading the object store performance.

## Object-store Direct Mount Option

Regardless of the time-based policies, it is possible to use a special mount option [`obs_direct`](../mounting-filesystems.md#mount-command-options) to bypass the time-base policies. Any creation/writing of files from a mount point with this option will mark it to release as soon as possible, before taking into account other files retention policy. The data extents of the files are still first written to the SSD but get precedence on releasing to the object-store.

In addition, any read done through such a mount point will read the extents from the object-store and will not promote and store them in the SSD.
