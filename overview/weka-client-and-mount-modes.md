---
description: >-
  Explore the WEKA client, its mount modes, and how they interact with the Linux
  Page Cache for optimal operation.
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

When mounting in the Read Cache mode, the Linux Page Cache uses a write-through mechanism, acknowledging write operations to the customer application only after securely storing them on resilient storage. This applies to both data and metadata writes.

The default behavior in the WEKA system dictates that data read or written by customer applications resides in a local server read Linux Page Cache. The WEKA system actively monitors whether another server attempts to read or write the same data, invalidating the cache entry if necessary. Such invalidation may occur in two cases:

* If one client is currently writing to a file that another client is reading or writing.
* If one server is currently writing to a file that another server is reading.

This mechanism ensures coherence, allowing full Linux Page Cache usage when either a single server or multiple servers access a file solely for read-only purposes. However, if multiple servers access a file, and at least one performs a write operation, the Linux Page Cache bypasses, and all I/O operations are managed by the backend servers.

Conversely, when either a single server or multiple servers open a file for read-only purposes, the WEKA client fully uses the Linux Page Cache, facilitating read operations directly from memory without accessing the backend servers.

Consider a server as "writing" to a file after the actual first write operation, irrespective of the read/write flags of the open system call.

{% hint style="info" %}
In scenarios involving random reads of small blocks from large files, enabling the read cache, particularly the Linux prefetch mechanism, may not enhance performance and can be counterproductive. Assess the workload to determine if enabling read-ahead for truly random access patterns aligns with performance expectations.
{% endhint %}

## Write cache mount mode (default)

In this mount mode, the Linux operating system operates in a _write-back_ mode rather than a _write-through_. When a write operation occurs, it is promptly acknowledged by the WEKA client and temporarily stored in the kernel memory cache. The actual persistence of this data in resilient storage happens as a background operation at a later time.

This mode enhances performance, especially in reducing write latency, while ensuring data coherency. For instance, if a file is accessed through another server, the local cache is invalidated, and the data is synchronized to maintain a consistent view of the file.

To synchronize the filesystem and commit all changes in the write cache—useful, for example, when ensuring synchronization before taking a snapshot—you can employ the following system calls: `sync`, `syncfs`, and `fsync`.

## Multiple mounts on a single server

The WEKA client allows multiple mount points for the same filesystem on a single server, supporting different mount modes. This is useful in containerized environments where various server processes require distinct read/write access or caching schemes.

Each mount point on the same server is treated independently for cache consistency. For example, two mounts with write cache mode on the same server may have different data simultaneously, accommodating diverse requirements for applications or workflows on that server.

## Metadata management

Unlike file data, file metadata is managed in the Linux operating system through the directory entry (Dentry) cache. While maximizing efficiency in handling directory entries, the Dentry cache is not strongly consistent across WEKA clients. For applications prioritizing metadata consistency, it is possible to configure metadata for strong consistency by mounting without a Dentry cache.

**Related topic**

[#mount-command-options](../fs/mounting-filesystems.md#mount-command-options "mention")
