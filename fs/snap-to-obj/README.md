---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object store.
---

# Snap-To-Object

The Snap-To-Object feature enables the committing of all the data of a specific snapshot, including metadata, to an object store. Unlike data lifecycle management processes, this feature involves the full snapshot data (data, metadata, and every file).

Using the Snap-To-Object feature results in the object store containing a copy of the full snapshot data. You can use the full snapshot data to restore the data on the Weka cluster or another cluster.

The Snap-To-Object feature is useful for a range of use cases, as follows:

* **Generic use cases (on-premises and cloud)**
  * [External backup of data](./#external-backup-of-data)
  * [Archiving of data](./#archiving-of-data)
  * [Asynchronous mirroring of data](./#asynchronous-mirroring-of-data)
* **Cloud-only use cases**
  * [AWS pause/restart](./#aws-pause-restart)
  * [AWS protection against single availability zone failure](./#protecting-data-against-aws-availability-zone-failures)
  * [AWS migration of filesystems to another region](./#aws-migration-of-filesystems-to-another-region)
* **Hybrid cloud use case**
  * [Cloud bursting](./#cloud-bursting)      &#x20;

## Use cases for the Snap-To-Object feature

#### External backup of data

If a Weka cluster fails beyond recovery due to multiple failures or a structural failure such as a fire or flood, snapshot data saved to an object store can be used to recreate the same data on another Weka cluster. This use case supports backup in any of the following Weka system deployment modes:

**Local object store:** Weka SSD tier, hosts, and object store tiers are located in one data center, but separated in different rooms or buildings. In such a deployment, a total failure obliterating all Weka system hosts will still have another live object store and it is possible to start new filesystems from the last snapshot.

**Remote object store:** Weka hosts and object stores are located in different datacenters. In such a deployment, data is perfectly protected even if a complete data center failure occurs.

{% hint style="info" %}
**Note:** This type of deployment requires the ability to support the latency of hundreds of milliseconds. For performance issues on Snap-To-Object tiering cross-interactions/resonance, contact the Weka Support Team.
{% endhint %}

**Local object store replicating to a remote object store:** A local object store in one datacenter replicates data to another object store using the object store system features, such as [AWS S3 cross-region replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html). This deployment provides both integrated tiering and Snap-To-Object local high performance between the Weka object store and the additional object store, and remote copying of data enables the survival of data in any data center failure.

{% hint style="info" %}
**Note:** This deployment requires ensuring that the object store system perfectly replicates all objects.
{% endhint %}

#### Archiving data

The periodic creation of data snapshots and uploading the snapshots to an object store generates an archive, allowing the accessing of past copies of data. When any compliance or applicative requirement occurs, it is possible to make the relevant snapshot available on a Weka cluster and view the content of past versions of data.

#### Asynchronous data mirroring

Combining a local cluster with a replicated object store in another data center can create a scheme whereby a disaster in the primary site will activate the secondary data center with the content of the last available snapshot.

#### AWS pause/restart

Some AWS installations of the Weka system may have a cluster working with local SSDs. Sometimes, the data needs to be retained, even though ongoing access is unnecessary. In such cases, the use of Snap-To-Object can save costs of AWS instances running the Weka system and the Weka license.

To pause a cluster, you need to take a snapshot of the data and then use Snap-To-Object to upload the snapshot to S3. When the upload process is complete, the Weka cluster instances are stopped, and the data is safe on S3.

To re-enable access to the data, you need to form a new cluster or use an existing one and download the snapshot from S3.

#### Protecting data against AWS availability zone failures

This use case ensures the protection of data against AWS availability zone failures. The Weka cluster can be run on a single availability zone, providing the best performance and no cross-AZ bandwidth costs.

Using Snap-To-Object, you can take and upload snapshots of the cluster to S3 (which is a cross-AZ service). In this way, if an AZ failure occurs, a new Weka cluster can be created on another AZ, and the last snapshot uploaded to S3 can be downloaded to this new cluster.

#### AWS migration of filesystems to another region

Use of Weka snapshots uploaded to S3 combined with S3 cross-region replication enables the migration of a filesystem from one region to another.

#### Cloud Bursting

On-premises Weka system deployments can often benefit from cloud elasticity to consume large quantities of computation power for short periods.

Cloud bursting requires the following steps:

1. Take a snapshot of the on-premises Weka system data using Snap-To-Object.
2. Upload the data snapshot to S3 at AWS.
3. Create a Weka cluster at AWS and make the data uploaded to S3 available to the newly-formed cluster at AWS.
4. Switch control to the cloud and process the data.
5. Take a snapshot of the cloud cluster on completion of cloud processing.
6. Upload the cloud snapshot to the local Weka system cluster.

## Snapshots upload guidelines

When uploading a snapshot, follow these guidelines:

* **Upload one snapshot at a time**: To achieve fast upload and prevent bandwidth competition with other snapshot uploads to the same physical object store, you can upload only one snapshot to each object store. However, you can upload one snapshot to the local object store and one snapshot to the remote object store in parallel.
* **A writeable snapshot cannot be uploaded as a read-only snapshot:** A writeable snapshot is a clone of the live filesystem or other snapshots at a specific time, and its data keeps changing. Therefore, its data is tiered according to the tiering policies, but it cannot be uploaded to the object store as a read-only snapshot.
* **Upload in chronological order:** For space and bandwidth efficiency, it is highly recommended to upload snapshots in chronological order to the remote object store. Uploading all snapshots or the same snapshots to a local object store is not required. However, once a snapshot is uploaded to the remote object store (for example, a monthly snapshot), it is inefficient to upload a previous snapshot (for example, the daily snapshot before it) to the remote object store.
* **No deletion in parallel to snapshot upload**: You cannot delete a snapshot in parallel to a snapshot upload to the same filesystem. Because uploading a snapshot to a remote object store can take a while, it is recommended to delete the required snapshots before uploading to the remote object store.\
  It is more important in a scenario when uploading snapshots to both local and remote object stores. While local and remote uploads can progress in parallel, consider the case of a remote upload is in progress. A snapshot is deleted, and later a snapshot is uploaded to the local object store. In this scenario, the local snapshot upload waits for the pending deletion of the snapshot (which occurs only once the remote snapshot upload is done).
* **Pause or abort a snapshot upload:** If required, you can pause or abort a snapshot upload using commands described in the [background tasks](../../usage/background-tasks.md#pause-resume-abort-a-background-task) section.

## Recover from a remote snapshot

When recovering from a snapshot residing on a remote object store, it is required to define the object store bucket containing the snapshot as a local bucket. Because a remote object store has restrictions over the download, and we want to use a different local object store due to the QoS reasons explained in [Manage object stores](../managing-object-stores/#overview).

To recover from a snapshot residing on a remote object store, create a new filesystem from this snapshot as follows:

1. Add a new local object-store, using `weka fs tier obs add` CLI command.
2. Add a local object-store bucket, referring to the bucket with the snapshot to recover, using `weka fs tier s3 add.`
3. Download the filesystem, using `weka fs download.`
4. If the filesystem should also be tiered, add a local object store bucket for tiering.
5. Detach the initial object store bucket from the filesystem.
6. Assuming you want a remote backup to this filesystem, attach a remote bucket to the filesystem.
7. Remove the local object store bucket and local object store created for this procedure.

## Incremental snapshots

Incremental snapshots are point-in-time backups for filesystems. When taken, consist only of the changes since the last snapshot. When you download and restore an incremental snapshot to a live filesystem, the system reconstructs the filesystem with the changes since the previous snapshot.

This capability for filesystem snapshots potentially makes them more cost-effective because you do not have to download the entire filesystem with each snapshot, you download only the changes since the last snapshot. For example, incremental snapshots are essential when deploying a secondary Weka system for disaster recovery (DR).

Among the components of a DR plan are two key parameters that define how long your business can afford to be offline and how much data loss it can tolerate. These are the Recovery Time Objective (RTO) and Recovery Point Objective (RPO).

* RTO is the organization's goal for the maximum time it should take to restore normal operations following an outage or data loss.
* RPO is the goal for the maximum amount of data the organization can tolerate losing. This parameter is measured in time: from the moment a failure occurs to your last valid incremental snapshot. For example, if you experience a failure now and your last incremental snapshot was one hour ago, the RPO is one hour.&#x20;

Incremental snapshots enable lowering these two key parameters. It prepares you for getting back online fast, so you can minimize damage to your business.

Incremental snapshots download and restore are only available through the CLI. It is recommended to download the Incremental snapshots in chronological order. Only snapshots uploaded from a 4.0 version or above can be downloaded as increments.

## Delete snapshots residing on an object store

Deleting a snapshot, from a filesystem that uploaded it, removes all of its data from the local object-store bucket. It does not remove any data from a remote object store bucket.

{% hint style="danger" %}
If the snapshot has been (or is) downloaded and used by a different filesystem, that filesystem stops functioning correctly, data can be unavailable and errors can occur when accessing the data.

It is possible to either un-tier or migrate the filesystem to a different object store bucket before deleting the snapshot that has been downloaded.
{% endhint %}

## Snap-To-Object in data lifecycle management

Snap-To-Object and data lifecycle management both use SSDs and object stores for the storage of data. In order to save both storage and performance resources, the Weka system uses the same paradigm for holding SSD and object store data for both lifecycle management and Snap-To-Object. This can be implemented for each filesystem using one of the following schemes:

1. Data resides on the SSDs only and the object store is used only for the various Snap-To-Object use cases, such as backup, archiving, and bursting. In this case, for each filesystem, the allocated SSD capacity should be identical to the filesystem size, and the data Retention Period should be defined as the longest time possible, i.e., 5 years. The Tiering Cue should be defined using the same considerations as in data lifecycle management, based on IO patterns. In this scheme, the applications work all the time with a high-performance SSD storage system and use the object store only as a backup device.
2. Use of Snap-To-Object on filesystems with active data lifecycle management between the object store and the SSDs. In this case, objects in the object store will be used for both tiering of all data and for backing up the data using Snap-To-Object, i.e., whenever possible, the Weka system will use the same object for both purposes, thereby eliminating the need to acquire additional storage and to unnecessarily copying data.

{% hint style="info" %}
**Note:** When using Snap-To-Object to rehydrate data from an object store, some of the metadata may still be in the object store until it is accessed for the first time.
{% endhint %}



**Related topics**

****[snap-to-obj.md](snap-to-obj.md "mention")****

[snap-to-obj-1.md](snap-to-obj-1.md "mention")
