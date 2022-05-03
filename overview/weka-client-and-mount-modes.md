---
description: >-
  Understanding the Weka system client and possible mount modes of operation in
  relation to the page cache.
---

# Weka Client & Mount Modes

## The Weka System Client

The Weka system client is a standard, POSIX-compliant filesystem driver installed on application servers, that enables file access to Weka filesystems. Similar to any other filesystem driver, the Weka system client intercepts and executes all filesystem operations. This enables the Weka system to provide applications with local filesystem semantics and performance (as opposed to NFS mounts) while providing a centrally managed, sharable, and resilient storage.

The Weka system client is tightly integrated with the Linux operating system page cache, which is a transparent caching mechanism that stores parts of the filesystem content in the client host RAM. The operating system maintains a page cache in unused RAM capacity of the application server, delivering quick access to the contents of the cached pages and overall performance improvements.

The page cache is implemented in the Linux kernel and is fully transparent to applications. All physical memory not directly allocated to applications is used by the operating system for the page cache. Since the memory would otherwise be idle and is easily reclaimed when requested by applications, there is usually no associated performance penalty and the operating system might even report such memory as "free" or "available". Click [here](https://manybutfinite.com/post/page-cache-the-affair-between-memory-and-files/) for a more detailed description of the page cache.

The Weka client can control the information stored in the page cache and also invalidate it, if necessary. Consequently, the Weka system can utilize the page cache for cached high-performance data access while maintaining data consistency across multiple hosts.

Each filesystem can be mounted in one of two modes of operation in relation to the page cache:

* [**Read Cache**](weka-client-and-mount-modes.md#read-cache-mount-mode)**,** where only read operations are using the page cache, file data is coherent across hosts and resilient to client failures
* ****[**Write Cache (default)**](weka-client-and-mount-modes.md#write-cache-mount-mode-default)**,** where both read and write operations are using the page cache while keeping data coherency across hosts and which provides the highest data performance

{% hint style="info" %}
**Note:** Symbolic links are always cached in all cached modes.
{% endhint %}

{% hint style="info" %}
**Note:** Unlike actual file data, the file metadata is managed in the Linux operating system by the Dentry (directory entry) cache, which maximizes efficiency in the handling of directory entries, and is not strongly consistent across Weka client hosts. At the cost of some performance compromises, metadata **** can be configured to be strongly consistent by mounting without Dentry cache (using`dentry_max_age_positive=0, dentry_max_age_negative=0` mount options) if metadata consistency is critical for the application, as described in [Mount Command Options](../fs/mounting-filesystems.md#mount-command-options).&#x20;
{% endhint %}

## **R**ead Cache Mount Mode

When mounting in this mode, the page cache uses write cache in the write-through mode, so any write is acknowledged to the customer application only after being safely stored on resilient storage. This applies to both data and metadata writes. Consequently, only read operations are accelerated by the page cache.

In the Weka system, by default, any data read or written by customer applications is stored on a local host read page cache. As a sharable filesystem, the Weka system monitors whether another host tries to read or write the same data and if necessary, invalidates the cache entry. Such invalidation may occur in two cases:

* If a file that is being written by one client host is currently being read or written by another client host.
* If a file that is being read by one host is currently being written by another host.

This mechanism ensures coherence, providing the Weka system with full page cache utilization whenever only a single host or multiple hosts access a file for read-only purposes. If multiple hosts access a file and at least one of them is writing to the file, the page cache is not used and any IO operation is handled by the backends. Conversely, when either a single host or multiple hosts open a file for read-only purposes, the page cache is fully utilized by the Weka client, enabling read operations from memory without accessing the backend hosts.

{% hint style="info" %}
**Note:** A host is defined as writing to a file on the actual first write operation, and not based on the read/write flags of the open system call.
{% endhint %}

{% hint style="info" %}
**Note:** In some scenarios, particularly random reads of small blocks of data from large files, a read cache enablement can create an amplification of reads, due to the Linux operating system's prefetch mechanism. If necessary, this mechanism can be tuned as explained [here](https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-bdi).
{% endhint %}

## Write Cache Mount Mode (Default)

In this mount mode, the Linux operating system is used as write-back, rather than write-through, i.e., the write operation is acknowledged immediately by the Weka client and is stored in resilient storage as a background operation.

This mode can provide significantly more performance, particularly in relation to write latency, all that while keeping data coherency, i.e., if a file is accessed via another host it invalidates the local cache and sync the data to get a coherent view of the file.

To sync the filesystem and commit all changes in the write cache (e.g., if there is a need to ensure it has been synced before taking a snapshot), it is possible to use the following system calls: `sync`, `syncfs`, and `fsync`.

## Multiple Mounts on a Single Host

The Weka client supports multiple mount points of the same file system on the same host, even with different mount modes. This can be effective in environments such as containers where different processes in the host need to have different definitions of read/write access or caching schemes.

{% hint style="info" %}
Note that two mounts on the same hosts are treated as two different hosts with respect to the consistency of the cache as described above. For example, two mounts on the same host, mounted with write cache mode might have different data at the same point in time.
{% endhint %}
