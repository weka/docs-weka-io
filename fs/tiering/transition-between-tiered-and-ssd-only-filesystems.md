---
description: >-
  This page describes how to transition from an SSD-only to a tiered filesystem,
  and vice versa.
---

# Transition Between Tiered and SSD-Only Filesystems

### Transition from SSD-Only Filesystem to Tiered Filesystem

An SSD-only filesystem can be reconfigured as a tiered filesystem by attaching an object store. In such a situation, the default is to maintain the filesystem size. In order to increase the filesystem size, the total capacity field can be modified, while the existing SSD capacity remains the same.

{% hint style="info" %}
**Note:** Once an SSD-only filesystem has been reconfigured as a tiered filesystem, all existing data will be considered to belong to interval 0 and will be managed according to the 7-interval process. This means that the release process of the data created before the reconfiguration of the filesystem is performed in an arbitrary order and does not depend on the timestamps.
{% endhint %}

### Transition from Tiered Filesystem to SSD-Only Filesystem

A tiered filesystem can be un-tiered \(and only use SSDs\) by detaching its object stores. This will copy the data back to the SSD.

{% hint style="info" %}
**Note:** The SSD must have sufficient capacity, i.e., the allocated SSD capacity should be at least the total capacity used by the filesystem.
{% endhint %}

For more information, refer to [Attaching/Detaching Object Stores Overview](../managing-filesystems/attaching-detaching-object-stores-to-from-filesystems.md#overview).

