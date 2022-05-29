---
description: This page provides an overview about managing object stores.
---

# Manage object stores

Object stores provide optional external storage media in addition to the SSD storage. Object stores are less expensive than SSD storage, therefore object store can be used for storing warm data (data infrequently accessed), while the SSD stores the hot data (data frequently accessed).

You can set object stores in one of the following locations:

* Cloud-based.
* The same location as the Weka system. That is a local object store, which is used for tiering and snapshots (backup).
* A remote location. That is a remote object store, which is used for snapshots only.

The object store configuration includes:

* Object store DNS name.
* Object store bucket identifier.
* Access credentials.

The object store bucket must be dedicated to the Weka system and must not be accessible by other applications. A single object store bucket can serve different filesystems and multiple Weka systems. However, it is recommended to set one object store per filesystem.

You can define up to three object store buckets for a filesystem:

* One object store bucket for tiering, writeable.
* Second object store bucket for tiering, read-only.
* Third object store bucket for backup only.

Multiple object stores allow a range of use cases, including migration to different object stores, scaling of object store capacity, and increasing the total tiering capacity of filesystems.

**Related topics**

[#about-object-stores](../../overview/filesystems.md#about-object-stores "mention")
