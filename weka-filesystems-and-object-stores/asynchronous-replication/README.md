---
description: >-
  Learn how asynchronous replication protects your data by synchronizing
  filesystems directly between two NeuralMesh clusters.
---

# Asynchronous replication

Asynchronous replication is a native, cluster-to-cluster filesystem replication solution that synchronizes data and metadata directly between a source cluster (site A) and a target cluster (site B). Replication transfers incremental snapshot deltas of the source filesystem on a configurable interval, without disrupting client access to the source.

## When to use asynchronous replication

* **Disaster recovery**: Maintain a complete, incrementally updated copy of a filesystem on a secondary site. If the primary site becomes unavailable, you point to the target filesystem manually as read-only filesystem. Because replication is asynchronous, the Recovery Point Objective (RPO) is not zero: writes made after the last replicated snapshot may be lost, and recovery time depends on the manual failover procedure.
* **On-demand caching**: Make a large dataset visible on a remote cluster with limited capacity. The target receives the full filesystem metadata (directories and file hierarchy), and file data is retrieved from the source only when files are accessed. A typical example is a large capacity site that collects data and a smaller GPU cluster that hydrates only the files needed for AI training and inference.
* **Partial copy**: Replicate only selected directories proactively. Specify up to 10 directory paths to copy in full, while the rest of the namespace remains available on demand. Use this when a remote site needs local performance for specific projects only.

## Replication architecture

The following diagram shows the components and data flow for an asynchronous replication pair.

<div data-with-frame="true"><figure><img src="../../.gitbook/assets/Replication_architecture.png" alt=""><figcaption><p>Asynchronous replication architecture</p></figcaption></figure></div>

A replication pair connects a source filesystem on site A with a target filesystem on site B:

* **Trust relationship**: Before you can create a replication pair, the two clusters exchange tokens and establish mutual trust through their APIs.
* **Snapshot deltas**: On each replication interval, the system takes a snapshot of the source filesystem and transfers the incremental delta to the target. The minimum interval is 5 minutes.
* **Transport**: Replication uses the S3 infrastructure of the clusters as a transport layer. Data passes through the object store bucket but is not stored in it. Each cluster requires an S3 cluster, an S3 system user, a thin-provisioned object store tier, and an S3 bucket.
* **Source and target roles**: The source filesystem remains fully readable and writable throughout replication. The target filesystem is write-protected: only the replication process can write to it, while users and applications can read it. The target becomes writable only when you remove the write protection, for example, during a failover.

### Copy options

The replication policy determines how data reaches the target:

* **Full data copy**: All data and metadata are pushed from site A to site B as a one-way incremental copy. Use this for disaster recovery.
* **Metadata-only copy**: Only metadata is pushed from site A to site B. File data is pulled from site A when files are accessed on site B (hydration). Use this for on-demand caching.
* **Partial copy**: Selected directory paths are pushed in full. All other data behaves as metadata-only.

With a metadata-only or partial copy, you can also fetch or release the data of individual files on the target.

### Access strategy

The access strategy determines when users see each replicated snapshot on the target:

* **Instant access** (default): The snapshot is exposed immediately, and its data is visible under the `.snapshot` directory. Data is copied in the background and retrieved on demand when accessed.
* **Copy first**: The snapshot is applied only after its data and metadata are fully copied. Use this when workloads on the target require immediate local data access with full consistency.

## Considerations

{% hint style="warning" %}
The RPO is not zero. Expect a lag of at least the replication interval (minimum 5 minutes). Writes that are not yet replicated at failover time are lost.
{% endhint %}

* Failover is manual. The system does not promote the target automatically.
* Tiered data on the source is not replicated.
* Replication management is available through the CLI only.
* The number of snapshots to keep ranges from 2 to 25. Retaining more snapshots requires more storage.
* The target filesystem is write-protected while the replication pair is active.
* Inode numbers on the target filesystem differ from the source filesystem.
