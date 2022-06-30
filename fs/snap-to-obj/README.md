---
description: >-
  This page describes the Snap-To-Object feature, which enables the movement of
  all the data of a specific snapshot to an object store.
---

# Snap-To-Object

The Snap-To-Object feature enables the committing of all the data of a specific snapshot, including file system metadata, every file, and all associated data to an object store. You can use the full snapshot data to restore the data on the Weka cluster or another cluster.

## Snap-To-Object feature use cases

The Snap-To-Object feature is helpful for a range of use cases, as follows:

* **On-premises and cloud use cases**
  * [External backup of data](./#external-backup-of-data)
  * [Archiving data](./#archiving-data)
  * [Asynchronous data replication](./#asynchronous-data-mirroring)
* **Cloud-only use cases**
  * [Cloud pause/restart](./#cloud-pause-restart)
  * [Data protection against cloud availability zone failures](./#aws-migration-of-filesystems-to-another-region)
  * [Migration of filesystems to another region](./#aws-migration-of-filesystems-to-another-region)
* **Hybrid cloud use case**
  * [Cloud bursting](./#cloud-bursting)      &#x20;

### External backup of data

Suppose it is required to recover data stored on a Weka filesystem due to a complete or partial loss of the data within it. You can use a data snapshot saved to an object store to recreate the same data in the snapshot on the same or another Weka cluster.

This use case supports backup in any of the following Weka system deployment modes:

* **Local object store:** The Weka cluster and object store are close to each other and will be highly performant during data recovery operations. The Weka cluster can recover a filesystem from any snapshot on the object store for which it has a reference locator.
* **Remote object store:** The Weka cluster and object store are located in different geographic locations, typically with longer latencies between them. In such a deployment, you can send snapshots to both local and remote object stores.

{% hint style="info" %}
**Note:** This deployment type requires supporting the latency of hundreds of milliseconds. For performance issues on Snap-To-Object tiering cross-interactions/resonance, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md).
{% endhint %}

* **Local object store replicating to a remote object store:** A local object store in one datacenter replicates data to another object store using the object store system features, such as [AWS S3 cross-region replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html).\
  This deployment provides both integrated tiering and Snap-To-Object local high performance between the Weka object store and the additional object store. The object store manages the data replication, enabling data survival in multiple regions.

{% hint style="info" %}
**Note:** This deployment requires ensuring that the object store system perfectly replicates all objects on time to ensure consistency across regions.
{% endhint %}

### Archiving data

The periodic creation of snapshots and uploading of the snapshots to an object store generates an archive, allowing the accessing of past copies of data.

When any compliance or application requirement occurs, it is possible to make the relevant snapshot available on a Weka cluster and view the content of past versions of data.

### Asynchronous data replication

Combining a local cluster with a replicated object store in another data center allows for the following use cases:

* **Disaster recovery:** where you can take the replicated data and make it available to applications in the destination location.
* **Backup:** where you can take multiple snapshots and create point-in-time images of the data that can be mounted and specific files may be restored.

### Cloud pause/restart

In a public cloud, with a Weka cluster running on compute instances with local SSDs, sometimes the data needs to be retained, even though ongoing access to the Weka cluster is unnecessary. In such cases, using Snap-To-Object can save the costs of compute instances running the Weka system.

To pause a cluster, you need to take a snapshot of the data and then use Snap-To-Object to upload the snapshot to an S3 compliant object store. When the upload process is complete, the Weka cluster instances can be stopped, and the data is safe on the object store.

To re-enable access to the data, you need to form a new cluster or use an existing one and download the snapshot from the object store.

### Data protection against cloud availability zone failures

This use case ensures data protection against cloud availability zone failures in the various clouds: AWS Availability Zones, Google Cloud Platform (GCP) Zones, and Oracle Cloud Infrastructure (OCI) Availability Domains.

In AWS, for example, the Weka cluster can run on a single availability zone, providing the best performance and no cross-AZ bandwidth charges. Using Snap-To-Object, you can take and upload snapshots of the cluster to S3 (which is a cross-AZ service). In this way, if an AZ failure occurs, a new Weka cluster can be created on another AZ, and the last snapshot uploaded to S3 can be downloaded to this new cluster.

### Migration of filesystems to another region

Using Weka snapshots uploaded to S3 combined with S3 cross-region replication enables the migration of a filesystem from one region to another.&#x20;

### Cloud bursting

On-premises Weka deployments can often benefit from cloud elasticity to consume large quantities of computation power for short periods.

Cloud bursting requires the following steps:

1. Take a snapshot of an on-premises Weka filesystem.
2. Upload the data snapshot to S3 at AWS using Snap-To-Object.
3. Create a Weka cluster in AWS and make the data uploaded to S3 available to the newly-formed cluster at AWS.
4. Process the data in-cloud using cloud compute resources.

Optionally, you may also rehydrate data back to on-premises by doing the following:

1. Take a snapshot of the Weka filesystem in the cloud on completion of cloud processing.
2. Upload the cloud snapshot to the on-premises Weka cluster.

## Uploading a snapshot to an object store requirements

When uploading a snapshot to an object store, adhere to the following requirements:

* [Upload one snapshot at a time](./#upload-one-snapshot-at-a-time)
* [A writeable snapshot cannot be uploaded as a read-only snapshot](./#a-writeable-snapshot-cannot-be-uploaded-as-a-read-only-snapshot)
* [Upload in chronological order](./#upload-in-chronological-order)
* [No deletion in parallel to snapshot upload](./#no-deletion-in-parallel-to-snapshot-upload)
* [Pause or abort a snapshot upload](./#pause-or-abort-a-snapshot-upload)

### Upload one snapshot at a time

To achieve fast upload and prevent bandwidth competition with other snapshot uploads to the same object store, you can upload only one snapshot at a time to the object store. However, you can upload one snapshot to a local object store and one snapshot to a remote object store in parallel.

### A writeable snapshot cannot be uploaded

A writeable snapshot is a clone of the live filesystem or other snapshots at a specific time, and its data keeps changing. Therefore, its data is tiered according to the tiering policies, but it cannot be uploaded to the object store as a read-only snapshot.

### Upload in chronological order  to the remote object store

For space and bandwidth efficiency, it is highly recommended to upload snapshots in chronological order to the remote object store.

Uploading all snapshots or the same snapshots to a local object store is not required. However, once a snapshot is uploaded to the remote object store (for example, a monthly snapshot), it is inefficient to upload a previous snapshot (for example, the daily snapshot before it) to the remote object store.

### No deletion in parallel to snapshot upload

You cannot delete a snapshot in parallel to a snapshot upload to the same filesystem. Because uploading a snapshot to a remote object store can take a while, it is recommended to delete the required snapshots before uploading to the remote object store.

This requirement is more important in a scenario when uploading snapshots to both the local and remote object stores in parallel. Consider the following:

1. A remote upload is in progress.
2. A snapshot is deleted.
3. Later a snapshot is uploaded to the local object store.

In this scenario, the local snapshot upload waits for the pending deletion of the snapshot, which occurs only once the remote snapshot upload is done.

### Pause or abort a snapshot upload

If required, you can pause or abort a snapshot upload using commands described in the [background tasks](../../usage/background-tasks.md#pause-resume-abort-a-background-task) section.

## Incremental snapshots

Incremental snapshots are point-in-time backups for filesystems. When taken, they consist only of the changes since the last snapshot. When you download and restore an incremental snapshot to a live filesystem, the system reconstructs the filesystem on-the-fly with the changes since the previous snapshot.

This capability for filesystem snapshots potentially makes them more cost-effective because you do not have to update the entire filesystem with each snapshot, you update only the changes since the last snapshot.

Incremental snapshots download and restore are only available through the CLI. It is recommended to download the Incremental snapshots in chronological order. Only snapshots uploaded from a 4.0 version or above can be downloaded as increments.

## Delete snapshots residing on an object store

Deleting a snapshot from a filesystem that uploaded it, removes all of its data from the local object store bucket. It does not remove any data from a remote object store bucket.

{% hint style="danger" %}
If the snapshot has been (or is) downloaded and used by a different filesystem, that filesystem stops functioning correctly, data can be unavailable and errors can occur when accessing the data.

Before deleting the downloaded snapshot, it is recommended to either un-tier or migrate the filesystem to a different object store bucket.
{% endhint %}

## Snap-To-Object and tiering

Snap-To-Object and tiering use SSDs and object stores for the storage of data. To save both storage and performance resources, the Weka system uses the same paradigm for holding SSD and object store data for both Snap-To-Object and tiering.

You can implement this paradigm for each filesystem using one of the following use cases:

* **Data resides on the SSDs only, and the object store is used only for the various Snap-To-Object use cases, such as backup, archiving, and bursting:**\
  ****The allocated SSD capacity must be identical to the filesystem size for each filesystem. The data retention period must be defined as the longest time possible (for example, five years).\
  The Tiering Cue must be defined using the same considerations based on IO patterns. In this case, the applications always work with a high-performance SSD storage system and use the object store only as a backup device.
* **Snap-To-Object on filesystems is used with active tiering between the SSDs and the object store:**\
  ****Objects in the object store are used for tiering all data and for data backup using Snap-To-Object. If possible, the Weka system uses the same object for both purposes, eliminating the unnecessary need to acquire additional storage and copy data.

{% hint style="info" %}
**Note:** When using Snap-To-Object to rehydrate data from an object store, some of the metadata may still be in the object store until it is accessed for the first time.
{% endhint %}



**Related topics**

****[snap-to-obj.md](snap-to-obj.md "mention")****

[snap-to-obj-1.md](snap-to-obj-1.md "mention")
