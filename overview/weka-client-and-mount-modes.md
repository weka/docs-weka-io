---
description: >-
  Understanding the WEKA system client and possible mount modes of operation in
  relation to the page cache.
---

# WEKA client and mount modes

## The WEKA system client

The WEKA system client is a standard, POSIX-compliant filesystem driver installed on application servers that enables file access to WEKA filesystems. Like any other filesystem driver, the WEKA system client intercepts and executes all filesystem operations. This enables the WEKA system to provide applications with local filesystem semantics and performance (as opposed to NFS mounts) while providing a centrally managed, sharable, and resilient storage.

The WEKA system client is tightly integrated with the Linux operating system page cache, a transparent caching mechanism that stores parts of the filesystem content in the client RAM. The operating system maintains a page cache in the unused RAM capacity of the application server, delivering quick access to the contents of the cached pages and overall performance improvements.

The page cache is implemented in the Linux kernel and is fully transparent to applications. All physical memory not directly allocated to applications is used by the operating system for the page cache. Since the memory would otherwise be idle and is easily reclaimed when requested by applications, there is usually no associated performance penalty, and the operating system might even report such memory as "free" or "available". Click [here](https://manybutfinite.com/post/page-cache-the-affair-between-memory-and-files/) for a more detailed description of the page cache.

The WEKA client can control the information stored in the page cache and invalidate it if necessary. Consequently, the WEKA system can use the page cache for cached high-performance data access while maintaining data consistency across multiple servers.

Each filesystem can be mounted in one of two modes of operation in relation to the page cache:

* [**Read Cache**](weka-client-and-mount-modes.md#read-cache-mount-mode)**,** where only read operations are using the page cache, file data is coherent across servers and resilient to client failures
* [**Write Cache (default)**](weka-client-and-mount-modes.md#write-cache-mount-mode-default)**,** where both read and write operations use the page cache while keeping data coherency across servers and which provides the highest data performance

{% hint style="info" %}
Symbolic links are always cached in all cached modes.
{% endhint %}

{% hint style="info" %}
Unlike actual file data, the file metadata is managed in the Linux operating system by the Dentry (directory entry) cache, which maximizes efficiency in the handling of directory entries and is not strongly consistent across WEKA clients. At the cost of some performance compromises, metadata can be configured to be strongly consistent by mounting without Dentry cache (using`dentry_max_age_positive=0, dentry_max_age_negative=0` mount options) if metadata consistency is critical for the application, as described in [Mount Command Options](../fs/mounting-filesystems/#mount-command-options).&#x20;
{% endhint %}

## **R**ead cache mount mode

When mounting in this mode, the page cache uses a write cache in the write-through mode, so any write is acknowledged to the customer application only after being safely stored on resilient storage. This applies to both data and metadata writes. Consequently, only read operations are accelerated by the page cache.

In the WEKA system, by default, any data read or written by customer applications is stored on a local server read page cache. As a sharable filesystem, the WEKA system monitors whether another server tries to read or write the same data and, if necessary, invalidates the cache entry. Such invalidation may occur in two cases:

* If a file that is being written by one client is currently being read or written by another client.
* If a file that is being read by one server is currently being written by another server.

This mechanism ensures coherence, providing the WEKA system with full page cache utilization whenever only a single server or multiple servers access a file for read-only purposes. If multiple servers access a file and at least one of them is writing to the file, the page cache is not used, and any IO operation is handled by the backends. Conversely, when either a single server or multiple servers open a file for read-only purposes, the page cache is fully utilized by the WEKA client, enabling read operations from memory without accessing the backend servers.

{% hint style="info" %}
A server is defined as writing to a file on the actual first write operation and not based on the read/write flags of the open system call.
{% endhint %}

{% hint style="info" %}
In some scenarios, particularly random reads of small blocks of data from large files, a read cache enablement can amplify reads due to the Linux operating system's prefetch mechanism. If necessary, this mechanism can be tuned as explained [here](https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-class-bdi).
{% endhint %}

## Write cache mount mode (default)

In this mount mode, the Linux operating system is used as write-back, rather than write-through, i.e., the write operation is acknowledged immediately by the WEKA client and is stored in resilient storage as a background operation.

This mode can provide significantly more performance, particularly in relation to write latency, all that while keeping data coherency, i.e., if a file is accessed via another server it invalidates the local cache and sync the data to get a coherent view of the file.

To sync the filesystem and commit all changes in the write cache (e.g., if there is a need to ensure it has been synced before taking a snapshot), it is possible to use the following system calls: `sync`, `syncfs`, and `fsync`.

## Multiple mounts on a single server

The WEKA client supports multiple mount points of the same file system on the same server, even with different mount modes. This can be effective in environments such as containers where different processes in the server need to have different definitions of read/write access or caching schemes.

{% hint style="info" %}
Two mounts on the same servers are treated as two different servers with respect to the consistency of the cache, as described above. For example, two mounts on the same server, mounted with write cache mode, might have different data simultaneously.
{% endhint %}
