---
description: >-
  This page describes how to attach or detach object stores buckets to or from
  filesystems.
---

# Attach or detach object store buckets

## Attachment of a local object store bucket to a filesystem

Two local object store buckets can be attached to a filesystem, but only one of the buckets is writable. A local object store bucket is used for both tiering and snapshots. When attaching a new local object store bucket to an already tiered filesystem, the existing local object store bucket becomes read-only, and the new object store bucket is read/write. Multiple local object stores allow a range of use cases, including migration to different object stores, scaling of object store capacity, and increasing the total tiering capacity of filesystems.

When attaching a local object store bucket to a non-tiered filesystem, the filesystem becomes tiered.

## Detachment of a local object store bucket from a filesystem

Detaching a local object-store bucket from a filesystem migrates the filesystem data residing in the object store bucket to the writable object store bucket (if one exists) or to the SSD.

When detaching, the background task of detaching the object-store bucket begins. Detaching can be a long process, depending on the amount of data and the load on the object stores.

{% hint style="warning" %}
Detaching an object store bucket is irreversible. Attaching the same bucket again is considered as re-attaching a new bucket regardless of the data stored in the bucket.
{% endhint %}

### Migration to a different object store

When detaching from a filesystem tiered to two local object store buckets, only the read-only object store bucket can be detached. In such cases, the background task copies the relevant data to the writable object store.

#### Un-tiering a filesystem

Detaching from a filesystem tiered to one object store bucket un-tiers the filesystem and copies the data back to the SSD.

{% hint style="info" %}
The SSD must have sufficient capacity. That is, the allocated SSD capacity must be at least the total capacity used by the filesystem.
{% endhint %}

On completion of detaching, the object-store bucket does not appear under the filesystem when using the `weka fs` command. However, it still appears under the object store and can be removed if it is not used by any other filesystem. The data in the read-only object-store bucket remains in the object-store bucket for backup purposes. If this is unnecessary or the reclamation of object store space is required, it is possible to delete the object-store bucket.

{% hint style="info" %}
Before deleting an object-store bucket, remember to consider data from another filesystem or data not relevant to the WEKA system on the object-store bucket.
{% endhint %}

{% hint style="warning" %}
Once the migration process is completed, while relevant data is migrated, old snapshots (and old locators) reside on the old object-store bucket. To recreate snapshot locators on the new object store bucket, snapshots should be re-uploaded to the (new) bucket.
{% endhint %}

## Migration considerations

When migrating data (using the detach operation), copy only the necessary data (to reduce migration time and capacity). However, you may want to keep snapshots in the old object-store bucket.

**Migration workflow**

The order of the following steps is important.&#x20;

1. Attach a new object store bucket (the old object store bucket becomes read-only).
2. Delete any snapshot that does not need to be migrated. This action keeps the snapshot on the old bucket but does not migrate its data to the new bucket.
3. Detach the old object store bucket.

{% hint style="info" %}
If you perform the workflow steps in a different order, the snapshots can be completely deleted from any of the object store buckets. It is also possible that the snapshots are already in a migration process and cannot be deleted until the migration is completed.
{% endhint %}

### Attach a remote object store bucket

One remote object-store bucket can be attached to a filesystem. A remote object store bucket is used for backup. Only snapshots are uploaded using **Snap-To-Object**. The snapshot uploads are incremental to the previous one.&#x20;

### Detach a remote object store bucket

Detaching a remote object-store bucket from a filesystem keeps the backup data within the bucket intact. It is still possible to use these snapshots for recovery.



**Related topics**

[background-tasks](../../usage/background-tasks/ "mention")

[snap-to-obj](../snap-to-obj/ "mention")

[attaching-detaching-object-stores-to-from-filesystems.md](attaching-detaching-object-stores-to-from-filesystems.md "mention")

[attaching-detaching-object-stores-to-from-filesystems-1.md](attaching-detaching-object-stores-to-from-filesystems-1.md "mention")
