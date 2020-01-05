---
description: >-
  This page describes the three types of entities relevant to data storage in
  the WekaIO system: filesystems, object stores and filesystem groups.
---

# Filesystems, Object Stores & Filesystem Groups

## About Filesystems

A WekaIO filesystem is similar to a regular on-disk filesystem, with the key difference that it's distributed across all the hosts in the cluster. Consequently, in the WekaIO system, filesystems are not associated with any physical object, and are therefore nothing but a root directory with space limitations. 

A total of up to 1024 filesystems are supported, all of which are equally and perfectly balanced on all SSDs and CPU cores assigned to the WekaIO system. This means that the allocation of a new filesystem, or the resizing a filesystem, are instant management operations that are performed instantly, and without any constraints.

{% hint style="info" %}
**Note:** A filesystem group \(see below\) has to be created before creating a filesystem, and every filesystem must belong to one filesystem group.
{% endhint %}

A filesystem must have a defined capacity limit. A filesystem that belongs to a tiered filesystem group \(see below\) must have a total capacity limit and an SSD capacity limit. The total SSD capacity of all filesystems cannot exceed the total SSD capacity as defined in the total SSD net capacity.

### Encrypted Filesystems

Both data at rest \(residing on SSD and object store\) and data in transit can be encrypted. This is achieved by enabling the filesystem encryption feature. A decision on whether a filesystem is to be encrypted is made when [creating the filesystem](../fs/managing-filesystems/managing-filesystems.md#adding-a-filesystem).

For proper security, a KMS \(Key Management System\) must be used when creating encrypted filesystems. See [KMS Management](../fs/managing-filesystems/kms-management.md) for more information about KMS support in the WekaIO system.

{% hint style="info" %}
**Note:** Setting data encryption \(on/off\) can only be done when creating a filesystem.
{% endhint %}

### Metadata Limitations

In addition to the capacity limitation, each filesystem  also has a limitation on the amount of metadata. The system-wide metadata limit is determined by the SSD capacity allocated to the WekaIO system, as well as the RAM resources allocated to the WekaIO system processes. By default, the metadata limit associated with a filesystem is proportional to the filesystem SSD size. It is possible to override this default by defining a filesystem-specific max-files parameter, although the total of the limits of the metadata for all the filesystems cannot exceed the total system metadata limits.

### Metadata Calculations

Throughout this documentation, the metadata limitation per filesystem is referred to as a parameter named `max-files` , which describes the number of metadata units, and not the number of files. This parameter  encapsulates both the file count and the file sizes, as follows:

* Each file requires two metadata units.
* If a file exceeds 0.5 MB, an additional metadata unit is required.
* For each additional 1 MB over the first MB, an additional metadata unit is required.

The definitions above apply to files residing on SSDs or object stores.

{% hint style="success" %}
**For Example:**

* For a filesystem with potentially 1,000,000,000 files of 64 KB in size,  2,000,000,000 metadata units are required.
* For a filesystem with potentially 1,000,000 files of 128 MB in size, 130,000,000 metadata units are required.
* For a filesystem with 1,000,000 files of 750 KB in size, 3,000,000 metadata units are required.
{% endhint %}

## About Object Stores

In the WekaIO system, object stores represent an optional external storage media, ideal for the storage of warm data. They can be purchased and configured independently by users \(provided they support the S3 protocol\) or supplied by WekaIO as part of the overall data storage solution. Object stores used in tiered WekaIO system configurations can be cloud-based, located in the same location, or at a remote location.

Object stores are optimally used when a cost-effective data storage tier is required at a price point that cannot be satisfied by server-based SSDs. An object store definition contains the object store DNS name, bucket identifier, and access credentials. The bucket must be dedicated to the WekaIO system and must not be accessible by other applications. However, a single object store bucket may serve different filesystems and multiple WekaIO systems.

Filesystem connectivity to object stores can be used in both the [data lifecycle management](data-storage.md) and [Snap to Object](../fs/snap-to-obj.md) features. It is possible to define two object-store buckets for a filesystem, but only one bucket can be writable. In such cases, the WekaIO system will search for relevant data in both the SSD and the readable and writable object stores. This allows a range of use cases, including migration to different object stores, scaling of object store capacity, and increasing the total tiering capacity of filesystems.

The WekaIO system supports up to 2 different object store buckets per filesystem. While object stores can be shared between filesystems, when possible, it is recommended to create and attach a separate object store bucket per filesystem.

## About Filesystem Groups

In the WekaIO system, filesystems are grouped into up to 8 filesystem groups. 

Each filesystem group has tiering control parameters \(see [Guidelines for Data Storage in Tiered WekaIO System Configurations](data-storage.md#guidelines-for-data-storage-in-tiered-weka-system-configurations)\). While tiered filesystems have their own object store, the tiering policy will be the same for each tiered filesystem under the same filesystem group.



For information on managing these entities, refer to [Managing Filesystems, Object Stores and Filesystem Groups](../fs/managing-filesystems/).

