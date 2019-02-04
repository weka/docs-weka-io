---
description: >-
  Understanding the WekaIO system client and possible mount modes of operation
  in relation to the page cache.
---

# WekaIO Client & Mount Modes

## The WekaIO System Client

The WekaIO system client is a standard, POSIX-compliant filesystem driver installed on application servers that enable file access to the WekaIO filesystems. Similar to any other filesystem driver, the WekaIO system client intercepts and executes all filesystem operations. This enables the WekaIO system to provide applications with a local filesystem semantics and performance \(as opposed to NFS mounts\) while providing a centrally managed, sharable resilient storage.

The WekaIO system client is tightly integrated with the Linux operating system page cache, which is a transparent caching mechanism that stores parts of the filesystem content in the client host RAM. The operating system maintains a page cache in unused RAM capacity of the application server, delivering quicker access to the contents of the cached pages and overall performance improvements. 

The page cache is implemented in the Linux kernel and is fully transparent to applications. All physical memory not directly allocated to applications is used by the operating system for the page cache. Since the memory would otherwise be idle and is easily reclaimed when requested by applications, there is usually no associated performance penalty and the operating system might even report such memory as "free" or "available". Click [here](https://manybutfinite.com/post/page-cache-the-affair-between-memory-and-files/) for a more detailed description of the page cache.

The WekaIO client can control the information stored in the page cache and also invalidate it, if necessary. Consequently, the WekaIO system can utilize the page cache for cached high-performance data access while maintaining data consistency across multiple hosts.

Each filesystem can be mounted in one of three modes of operation in relation to the page cache:

* **Read Cache \(default\),** where file data is consistent across hosts, but there may be some metadata inconsistency in extreme cases.
* **Coherent,** where both data and metadata are guaranteed to be strongly consistent, at the cost of some performance compromise. Note that file content is still cached locally in the system page cache.
* **Write Cache,** which does not ensure data consistency or data reliability but provides the highest performance.  

{% hint style="info" %}
**Note:** Symbolic links are always cached in all cached modes.
{% endhint %}

##  <a id="page-cache"></a>

## Read Cache Mount Mode \(Default\)

When mounting in read cache mode, the page cache uses write cache in the write through mode, so any write is acknowledged to the customer application only after being safely stored on resilient storage. This applies to both data and metadata writes. Consequently, only read operations are accelerated by the page cache. 

In the WekaIO system, by default, any data read or written by customer applications is stored on a local host read page cache. As a sharable filesystem, the WekaIO system monitors whether another host tries to read or write the same data and if necessary, invalidates the cache entry. Such invalidation may occur in two cases:

* If a file which is being written by one client host is currently being read or written by another client host.
* If a file which is being read by one host is currently being written from another host.

This mechanism ensures coherence, providing the WekaIO system with full page cache utilization whenever only a single host or multiple hosts access a file for read-only purposes. If multiple hosts access a file and at least one of them is writing to the file, the page cache is not used and any IO operation is handled by the backends. Conversely, when either a single host or multiple hosts open a file for read-only purpose, the page cache is fully utilized by the WekaIO client, enabling read operations from memory without accessing the backend hosts.

{% hint style="info" %}
**Note:** A host is defined as writing to a file on the actual first write operation, and not based on the read/write flags of the open system call.
{% endhint %}

{% hint style="info" %}
**Note:** Unlike actual file data, the file metadata is managed in the Linux operation system by the Dentry \(directory entry\) cache, which maximizes efficiency in the handling of directory entries. Since the Dentry cache is not strongly consistent across WekaIO client hosts in the read cache mount mode, consideration should be given to using the coherent mount mode if metadata consistency is critical for the application.
{% endhint %}

{% hint style="info" %}
**Note:** In some scenarios, particularly random reads of small blocks of data from large files, a read cache enablement can create an amplification of reads, due to the Linux operating system prefetch mechanism. If necessary, this mechanism can be tuned as explained [here](https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-bdi).
{% endhint %}

## Coherent Mount Mode

When mounting in the coherent mode, the page cache uses write cache in the write through mode, so any write is acknowledged to the customer application only after being safely stored on resilient storage. This applies to both data and metadata writes. Consequently, only read operations are accelerated by the page cache.

This mode ensures the strong consistency of data and metadata. Any data or metadata change will always be acknowledged to the application only after being safely stored on resilient storage. This enables sharing of data and metadata between hosts concurrently accessing the same filesystem.

In the coherent mode, file data access still uses the performance enhancements of the local system page cache, as in the[ read cache mode](weka-client-and-mount-modes.md#read-cache-mount-mode-default). Only the handling of metadata is different between the coherent mount mode and the read cache mount mode.

## Write Cache Mount Mode

{% hint style="info" %}
**Note:** Check the latest release notes to determine whether the write cache mount mode is enabled as a production feature or a technology preview.
{% endhint %}

In the write cache mount mode, the Linux operating system is used as write-back, rather than write-through, i.e., the write operation is acknowledged immediately by the WekaIO client and is stored in a resilient storage as a background operation.

This mode can provide significantly more performance, particularly in relation to write latency, with the following caveats:

1. The filesystem is not coherent, i.e., another host trying to read the same data may receive the wrong version of the data.
2. The filesystem is not resilient, i.e., if a client host failure occurs, data not yet committed to the WekaIO system may be lost, even though the write was acknowledged to the host.

The write cache mount mode should only be used if:

1. No concurrent data access between hosts is required.
2. On a client host failure, it is not necessary to use the data written by the client host.

It is possible to use the following system calls: sync, syncfs, fsync, where sync is for files and syncfs is to create consistent checkpoints of the write cache data. Similarly, the sync command can be used to sync the filesystem and commit all changes in the write cache.

## Multiple Mounts on a Single Host

The Weka client supports multiple mount points of the same file system on the same host, even with different mount modes. This can be effective in environments such as containers where different processes in the host need to have different definitions of read/write access or caching schemes.

{% hint style="info" %}
Note that two mounts on the same hosts are treated as two different hosts with respect to the consistency of the cache as described above. So for example, two mounts on the same host, mounted with write cache mode might have different data in the same point in time.
{% endhint %}

