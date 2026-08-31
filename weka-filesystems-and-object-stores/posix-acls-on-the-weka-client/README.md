---
description: >-
  Explore POSIX ACL support for Linux servers mounting WEKA filesystems with the
  native client (wekafs). ACLs grant named users and groups access beyond
  standard UNIX permissions.
---

# POSIX ACLs on the WEKA client

{% hint style="info" %}
POSIX ACLs on the native client apply to wekafs mounts. To enforce ACLs over the NFS protocol, see [Manage the NFS protocol](../../additional-protocols/nfs-support/).
{% endhint %}

## Standard UNIX permissions and POSIX ACLs

Every file and directory carries standard mode bits:

* `user::`: the owner.
* `group::`: the owning group.
* `other::`: everyone else.

For example, `rwxr-x---` represents `0750`.

POSIX ACLs add entries that grant access to named users and groups:

* `user:<user_name>:rw-`
* `group:<group_name>:rw-`

### Default ACLs

Directories can carry default ACLs, that is, entries prefixed with `default:`. New files and subdirectories created under the directory inherit these entries. The POSIX model has no immutable inheritance: the file owner can change default or inherited ACLs later.

### Mask entry

The mask entry sets the maximum permissions that named users and groups can receive through access entries. When an access entry grants a permission above the mask, WEKA reduces the effective permission to the level the mask allows.

## Permission evaluation

Permission evaluation follows standard POSIX behavior and occurs at file open time. When you tighten an ACL, the change applies to subsequent opens. Already-open file handles keep their granted access until they close.

## Performance considerations

Account for the metadata cost before you enable ACL support on a production mount.

Mounting with the `acl` option adds a metadata cost, because WEKA checks for extended attributes (xattrs) on every file open, not only on files that carry ACL entries. This check covers POSIX ACLs together with any other xattr consumer on the server, including SELinux labels, AppArmor labels, and SMB alternate data streams.

WEKA testing measured up to approximately 30% overhead on metadata-heavy operations when ACL support is enabled, compared to the same workload without it. The overhead you see depends on the workload metadata-to-data ratio, the file access pattern, and the working set size. The cost applies even when a file carries no ACL or xattr entries, because every open still queries for xattrs, and a query that finds none still costs a round trip.

### Cache behavior

WEKA compute containers hold an LRU (least recently used) cache of inode blocks, including their extended attribute state, whether present or absent. Repeated access to the same files benefits from this cache and avoids a repeated backend query.

Access to a large or unique working set that exceeds the LRU cache capacity, or a first-time cold file open, pays the full backend round trip for the xattr check. In practice, workloads with a small, frequently reused working set see less impact than workloads that touch many distinct files with low reuse, such as large-scale scans or first-pass ingest jobs.

## Limits and operational considerations

### Extended attribute budget

WEKA stores POSIX ACLs as extended attributes. Each file or directory has a maximum extended attribute size of 1024 bytes. On multi-protocol or SELinux-labeled filesystems, this 1 KB is shared with SMB alternate data streams (ADS) and SELinux labels, which leaves less room for ACL entries. Use caution with lengthy or complex ACLs together with ADS on the same filesystem, given this finite capacity.

### Allow-only model

POSIX ACLs follow an allow-only model. They do not provide the ordered allow and deny semantics that NFSv4 or Windows ACLs provide.

### Inheritance

POSIX ACLs provide directory inheritance only through default ACLs. They do not provide the rich inheritance flags, such as inherit-only or no-propagate, found in the NFSv4 and Windows ACL models.

**Related topics**

[Manage POSIX ACLs on the WEKA client](manage-posix-acls-weka-client.md)

[Mount filesystems](../mounting-filesystems/)

[Manage the NFS protocol](../../additional-protocols/nfs-support/)
