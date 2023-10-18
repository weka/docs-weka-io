---
description: >-
  This page provides a detailed description of how data storage is managed in
  tiered WEKA system configurations.
---

# Advanced time-based policies for data storage location

This page provides an in-depth explanation for the [Data Lifecycle Management](../../overview/data-storage.md#time-based-policies-for-the-control-of-data-storage-location) overview section.

## Drive retention period policy

The Drive Retention Period policy refers to the amount of time you want to keep a copy of the data on SSD that you previously offloaded/copied to the object storage via the [Tiering Cue Policy](advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy) described further below.

Consider a scenario of a 100 TB filesystem (total capacity), with 100 TB of SSD space (as explained in[ ](../../overview/data-storage.md#the-role-of-ssds-in-tiered-weka-configurations)[The role of SSDs in tiered configurations](../../overview/data-storage.md#the-role-of-ssds-in-tiered-configurations) section). If the data Drive Retention Period policy is defined as 1 month and only 10 TB of data are written per month, it will probably be possible to maintain data from the last 10 months on the SSDs. On the other hand, if 200 TB of data is written per month, it will only be possible to maintain data from half of the month on the SSDs. Additionally, there is no guarantee that the data on the SSDs is the data written in the last 2 weeks of the month, which also depends on the Tiering Cue.

To further help describe this section, let us use an example where the [Tiering Cue Policy](advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy) described below is set to 1 day, and the Drive Retention Period is set to 3 days. After one day, the WEKA system offloads period 0’s data to the object store. Setting the Drive Retention Period to 3 days means leaving a copy of that data in WEKA Cache for three days, and after three days, it is removed from the WEKA Cache. The data is not gone, it is on the object store, and if an application or a user accesses that data, it is pulled back from the object store and placed back on the WEKA SSD tier where it is tagged again with a new Tiering Cue Policy Period.

Consequently, the drive Retention Period policy determines the resolution of the WEKA system release decisions. If it is set to 1 month and the SSD capacity is sufficient for 10 months of writing, then the first month will be kept on the SSDs.

{% hint style="info" %}
If the WEKA system cannot comply with the defined Retention Period, for example, the SSD is full, and data is not released to the object store, a Break-In Policy occurs. In such a situation, an event is received in the WEKA system event log, advising that the system has not complied with the policy and that data has been automatically released from the SSD to the object store before the completion of the defined Retention Period. No data will be lost (since the data has been transferred to the object store), but slower performance may be experienced.
{% endhint %}

{% hint style="info" %}
If the data writing rate is always high and the WEKA system fails to successfully release the data to the object store, an Object Store Bottleneck will occur. If the bottleneck continues, this will also result in a Policy Violation event.
{% endhint %}

## Tiering cue policy

The Tiering Cue policy defines the period of time to wait before the data is copied from the SSD and sent to the object store. It is typically used when it is expected that some of the data being written will be rewritten/modified/deleted in the short term.

The WEKA system integrates a rolling progress control with three rotating periods of 0, 1, and 2.

1. Period 0: All data written is tagged as written in the current period.
2. Period 1: The switch from 0 to 1 is according to the Tiering Cue policy.
3. Period 2: Starts after the period of time defined in the Tiering Cue, triggering the transfer of data written in period 0 from the SSD to the object store.

{% hint style="info" %}
Not all data is transferred to the object store in the order that it was written. If, for example, the Tiering Cue is set to 1 month, there is no priority or order in which the data from the whole month is released to the object store; data written at the end of the month may be released to the object store before data written at the beginning of the month.
{% endhint %}

{% hint style="success" %}
**Example:**

If the Tiering Cue Policy is set to 1 day, all data written within the first day is tagged for Period 0. After one day, and for the next day, the next set of data is tagged for Period 1, and the data written the next day is tagged for Period 2.

As Period 0 rolls around to be next, the data marked for Period 0 is offloaded to the object store, and new data is then tagged for Period 0. When Period 1 rolls around to be next, it is time to offload the data tagged for Period 1 to the object store and so on.
{% endhint %}

One important caveat to mention is that in the above example, if none of the data is touched or modified during the time set for the Tiering Cue Policy, then all the data as described will offload to the object store as planned. But let’s say there is some data in Period 0 that was updated/modified, that data is pulled out of Period 0 and is then tagged with the current Period of data being written at the moment, let’s say that is Period 2. So now, that newly modified data will not get offloaded to the object store until it is Period 2’s time. This is true for any data modified residing in one of the 3 Period cycles. It will be removed from its original Period and placed into the current Period marking the active writes.

## Management of drive retention policies <a href="#management-of-data-retention-policies" id="management-of-data-retention-policies"></a>

Since the WEKA system is a highly scalable data storage system, data storage policies in tiered WEKA configurations cannot be based on cluster-wide FIFO methodology, because clusters can contain billions of files. Instead, drive retention is managed by time-stamping every piece of data, where the timestamp is based on a resolution of intervals that may extend from minutes to weeks. The WEKA system maintains the interval in which each piece of data was created, accessed, or last modified.

Users only specify the Drive Retention Period and based on this, each interval is one-quarter of the Drive Retention Period. Data written, modified, or accessed prior to the last interval is always released, even if SSD space is available.

{% hint style="info" %}
The timestamp is maintained per piece of data in chunks of up to 1 MB, and not per file. Consequently, different parts of big files may have different tiering states.
{% endhint %}

{% hint style="success" %}
**Example:**

In a WEKA system configured with a Drive Retention Period of 20 days, data is split into 7 interval groups, each spanning 5 days in this scenario (5 is 25% of 20, the Drive Retention Period).

If the system starts operating on January 1, data written, accessed, or modified between January 1-5 are classified as belonging to interval 0, data written, accessed, or modified between January 6-10 belongs to interval 1, and so on. In such a case, the 7 intervals will be timestamped and divided as follows:
{% endhint %}

![](<../../.gitbook/assets/Table 1B.jpg>)

In the above scenario, there are seven data intervals on the SSDs (the last one is accumulating new/modified data). In addition, another interval is currently being released to the object-store. Yes, the retention period is almost twice as long as the user specifies, as long as there is sufficient space on the SSD. Why? If possible, it provides better performance and reduces unnecessary release/promotion of data to/from the object-store if data is modified.

## Data release process from SSD to object store <a href="#data-release-process-from-ssd-to-object-store" id="data-release-process-from-ssd-to-object-store"></a>

At any given moment, the WEKA system releases the filesystem data of a single interval, transferring it from the SSD to the object-store. _The release process is based on data aging characteristics_ (as implemented through the intervals system and revolving tags). Consequently, if there is sufficient SSD capacity, only data modified or written before seven intervals will be released. The release process also considers the amount of available SSD capacity through the mechanism of _**Backpressure**_. Backpressure works against two watermarks - 90% and 95%. It kicks in when SSD utilization per file system crosses above 95% and stops when it crosses below 90%. It's also important to understand that _Backpressure_ works in parallel and **independently** of the _Tiering Policy_. If the SSD utilization crosses the 95% watermark, then data will be released from SSD and sent to the object-store sooner than was configured.

{% hint style="success" %}
**Example:**

If 3 TB of data is produced every day, i.e., 15 TB of data in each interval, the division of data will be as follows:
{% endhint %}

![](<../../.gitbook/assets/Table 2.jpg>)

Now consider a situation where the total capacity of the SSD is 100 TB. The situation in the example above will be as follows:

![](<../../.gitbook/assets/Table 3.jpg>)

Since the resolution in the WEKA system is the interval, in the example above the SSD capacity of 100 TB is insufficient for all data written over the defined 35-day Retention Period. Consequently, the oldest, most non-accessed, or modified data, has to be released to the object store. In this example, this release operation will have to be performed in the middle of interval 6 and will involve the release of data from interval 0.

This counting of the age of the data in resolutions of 5 days is performed according to 8 different categories. A constantly rolling calculation, the following will occur in the example above:

* Data from days 1-30 (January 1-30) will all be on the SSD. Some of it may be tiered to the object store, depending on the defined Tiering Cue.
* Data from more than 35 days will be released to the object store.
* Data from days 31-35 (January 31-February 4) will be partially on the SSD and partially tiered to the object store. However, there is no control over the order in which data from days 31-35 is released to the object store.

{% hint style="success" %}
**Example:** If no data has been accessed or modified since creation, then the data from interval 0 will be released and the data from intervals 1-6 will remain on the SSDs. If, on the other hand, 8 TB of data is written every day, meaning that 40 TB of data is written in each interval (as shown below), then the last two intervals, i.e., data written, accessed, or modified in a total of 10 days will be kept on the SSD, while other data will be released to the object-store.
{% endhint %}

![](<../../.gitbook/assets/Table 4.jpg>)

Now consider the following filesystem scenario, where the whole SSD storage capacity of 100 TB is utilized in the first 3 intervals:

![](<../../.gitbook/assets/Table 5.jpg>)

When much more data is written and there is insufficient SSD capacity for storage, the data from interval 0 will be released when the 100 TB capacity is reached. This represents a violation of the Retention Period. In such a situation, it is also possible to either increase the SSD capacity or reduce the Retention Period.

## Tiering cue <a href="#tiering-cue" id="tiering-cue"></a>

The tiering process (the tiering of data from the SSDs to the object stores) is based on when data is created or modified. It is managed similar to the Drive Retention Period, with the data timestamped in intervals. The length of each interval is the size of the user-defined Tiering Cue. The WEKA system maintains 3 such intervals at any given time, and always tiers the data in the third interval. Refer to the example provided in the "Tiering Cue Policy" section above for further clarity.

{% hint style="info" %}
While the data release process is based on timestamps of access, creation, or modification, the tiering process is based only on the timestamps of the creation or modification.
{% endhint %}

{% hint style="info" %}
These timestamps are per 1 MB chunk and not the file timestamp.
{% endhint %}

{% hint style="success" %}
**Example:** If the Tiering Cue is 1 day, then the data will be classified according to the following timeline for a system that starts working on January 1:
{% endhint %}

![](<../../.gitbook/assets/Table 6.jpg>)

Since the tiering process applies to data in the first interval in this example, the data written or modified on January 1 will be tiered to the object store on January 3. Consequently, data will never be tiered before it is at least 1 day old (which is the user-defined Tiering Cue), with the worst case being the tiering of data written at the end of January 1 at the beginning of January 3.

{% hint style="info" %}
The Tiering Cue default is 10 seconds and cannot exceed 1/3 of the Drive Retention period.
{% endhint %}

## Breaks in retention period or tiering cue policies <a href="#breaks-in-retention-period-or-tiering-cue-policies" id="breaks-in-retention-period-or-tiering-cue-policies"></a>

If it is not possible to maintain the defined Retention Period or Tiering Cue policies, a TieredFilesystemBreakingPolicy event will occur, and old data will be released in order to free space on the SSDs. Users are alerted to such a situation through an ObjectStoragePossibleBottleneck event, enabling them to consider either raising the bandwidth or upgrading the object store performance.

## Object store direct-mount option

Regardless of the time-based policies, it is possible to use a special mount option [`obs_direct`](../mounting-filesystems.md#mount-command-options) to bypass the time-based policies. Any creation/writing of files from a mount point with this option will mark it to release as soon as possible, before taking into account other files retention policies. The data extents of the files are still first written to the SSD but get precedence on releasing to the object store.

In addition, any read done through such a mount point will read the extents from the object-store and will not be kept persistently on the SSD (it still goes through the SSD, but is released immediately before any other interval).

{% hint style="warning" %}
In AWS, this mode should only be used for importing data. It should **not** be used for general access to the filesystem as any data read via this mount point would be immediately released from the SSD tier again. This can lead to excessive S3 charges.
{% endhint %}
