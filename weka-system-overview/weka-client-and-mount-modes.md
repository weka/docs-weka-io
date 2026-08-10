---
description: >-
  Understanding the WEKA system client and possible mount modes of operation in
  relation to the page cache.
---

# WEKA client and mount modes

## The WEKA client

The WEKA client is a standard POSIX-compliant filesystem driver installed on application servers, facilitating file access to WEKA filesystems. Acting as a conventional filesystem driver, it intercepts and executes all filesystem operations, providing applications with local filesystem semantics and performance—distinct from NFS mounts. This approach ensures centrally managed, shareable, and resilient storage for WEKA.

Tightly integrated with the Linux Page Cache, the WEKA client leverages this transparent caching mechanism to store portions of filesystem content in the client's RAM. The Linux operating system maintains a page cache in the unused RAM, allowing rapid access to cached pages and yielding overall performance enhancements.

The Linux Page Cache, implemented in the Linux kernel, operates transparently to applications. Utilizing unused RAM capacity, it incurs minimal performance penalties, often appearing as "free" or "available" memory.

The WEKA client retains control over the Linux Page Cache, enabling cache information management and invalidation when necessary. Consequently, WEKA leverages the Linux Page Cache for high-performance data access, ensuring data consistency across multiple servers.

A filesystem can be mounted in one of two modes with the Linux Page Cache:

* [**Read cache mount mode**](weka-client-and-mount-modes.md#read-cache-mount-mode)**:** Only read operations use Linux Page Cache to sustain RAM-level performance for the frequently accessed data. WEKA ensures that the view of the data is coherent across various applications and clients.
* [**Write cache mount mode (default)**](weka-client-and-mount-modes.md#write-cache-mount-mode-default)**:** Both read and write operations use the Linux Page Cache, maintaining data coherency across servers and providing optimal data performance.

{% hint style="info" %}
Symbolic links are consistently cached in all modes.
{% endhint %}

## **R**ead cache mount mode

In Read Cache mode, the Linux Page Cache operates in _write-through_ mode, meaning that write operations are acknowledged only after being securely stored on resilient storage. This applies to both data and metadata.

By default, data read or written by customer applications is stored in the local server's Linux Page Cache. The WEKA system monitors access to this data and invalidates the cache if another server attempts to read or write the same data. Cache invalidation occurs in the following scenarios:

* When one client writes to a file that another client is reading or writing.
* When one server writes to a file that another server is reading.

This approach ensures data coherence. The Linux Page Cache is fully used when a file is accessed by a single server or multiple servers in read-only mode. However, if multiple servers access a file and at least one server writes to it, the system bypasses the Linux Page Cache, and all I/O operations are handled by the backend servers.

{% hint style="info" %}
A server is considered to be "writing" to a file after the first write operation occurs, regardless of the read/write flags set by the open system call.

For workloads involving random reads of small blocks from large files, enabling the read cache and Linux prefetch mechanisms may not improve performance and could even be counterproductive. Assess whether enabling read-ahead aligns with your performance goals for truly random access patterns.
{% endhint %}

## Write cache mount mode (default)

In Write Cache mode, the Linux Page Cache operates in _write-back_ mode rather than _write-through_. When a write operation occurs, it is immediately acknowledged by the WEKA client and temporarily stored in the kernel memory cache. The data is then written to resilient storage in the background.

This mode improves performance by reducing write latency while maintaining data coherence. If the same file is accessed by another server, the local cache is invalidated, ensuring a consistent view of the data.

To ensure all changes in the write cache are committed to storage, particularly before taking a snapshot, you can use system calls like `sync`, `syncfs`, and `fsync`. These commands force the filesystem to flush the write cache and synchronize data to resilient storage.

## Multiple mounts on a single server

The WEKA client allows multiple mount points for the same filesystem on a single server, supporting different mount modes. This is useful in containerized environments where various server processes require distinct read/write access or caching schemes.

Each mount point on the same server is treated independently for cache consistency. For example, two mounts with write cache mode on the same server may have different data simultaneously, accommodating diverse requirements for applications or workflows on that server.

## Metadata management

Unlike file data, file metadata is managed in the Linux operating system through the directory entry (Dentry) cache. While maximizing efficiency in handling directory entries, the Dentry cache is not strongly consistent across WEKA clients. For applications prioritizing metadata consistency, it is possible to configure metadata for strong consistency by mounting without a Dentry cache.

**Related topic**

[#mount-command-options](../weka-filesystems-and-object-stores/mounting-filesystems/#mount-command-options "mention")
