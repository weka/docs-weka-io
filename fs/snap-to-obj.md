---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object-store.
---

# Snap-To-Object

## About Snap-To-Object

The Snap-To-Object feature enables the committing of all the data of a specific snapshot, including metadata, to an object-store. Unlike data lifecycle management processes, this feature involves all the snapshot's data, which includes data, metadata, and every file.

The result of using the Snap-To-Object feature is that the object store contains a full copy of the snapshot of the data, which can be used to restore the data on the Weka cluster or on another cluster. Consequently, the Snap-To-Object feature is useful for a range of use cases, as follows:

#### Generic Use Cases (on-premises and cloud)

* [External backup of data](snap-to-obj.md#external-backup-of-data)
* [Archiving of data](snap-to-obj.md#archiving-of-data)
* [Asynchronous mirroring of data](snap-to-obj.md#asynchronous-mirroring-of-data)

#### Cloud-Only Use Cases

* [AWS pause/restart](snap-to-obj.md#aws-pause-restart)
* [AWS protection against single availability zone failure](snap-to-obj.md#protecting-data-against-aws-availability-zone-failures)
* [AWS migration of filesystems to another region](snap-to-obj.md#aws-migration-of-filesystems-to-another-region)

#### Hybrid Cloud Use Case

* [Cloud bursting](snap-to-obj.md#cloud-bursting)       

## Use Cases for the Snap-To-Object Feature

#### External Backup of Data

If a Weka cluster fails beyond recovery due to multiple failures or a structural failure such as fire or flood, snapshot data saved to an object store can be used to recreate the same data on another Weka cluster. This use case supports backup in any of the following Weka system deployment modes:

**Local Object Store:** Weka SSD tier, hosts and object store tiers are located in one data center, but separated in different rooms or buildings. In such a deployment, a total failure obliterating all Weka system hosts will still have another live object store and it is possible to start new filesystems from the last snapshot.

**Remote Object Store:** Weka hosts and object stores are located in different datacenters. In such a deployment, data is perfectly protected even if a complete data center failure occurs.

{% hint style="info" %}
**Note:** This type of deployment requires the ability to support the latency of hundreds of milliseconds. For performance issues on Snap-To-Object tiering cross-interactions/resonance, contact the Weka Support Team.
{% endhint %}

**Local Object Store Replicating to a Remote Object Store:** A local object store in one data center replicates data to another object store using the object store system features, such as [AWS S3 cross-region replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html). This deployment provides both integrated tiering and Snap-To-Object local high performance between the Weka object store and the additional object store, and remote copying of data will enable the survival of data in any data center failure.

{% hint style="info" %}
**Note:** This deployment requires ensuring that the object store system perfectly replicates all objects.
{% endhint %}

#### Archiving of Data

The periodic creation of data snapshots and uploading the snapshots to an object store generates an archive, allowing the accessing of past copies of data. When any compliance or applicative requirement occurs, it is possible to make the relevant snapshot available on a Weka cluster and view the content of past versions of data.

#### Asynchronous Mirroring of Data

Combining a local cluster with a replicated object store on another data center can create a scheme whereby a disaster in the primary site will activate the secondary data center with the content of the last available snapshot.

#### AWS Pause/Restart

Some AWS installations of the Weka system may have a cluster working with local SSDs. Sometimes, the data needs to be retained, even though ongoing access to it is unnecessary. In such cases, the use of Snap-To-Object can save costs of AWS instances running the Weka system and the Weka license.

To pause a cluster, it is necessary to take a snapshot of the data, and then using Snap-To-Object to upload the snapshot to S3 at AWS. When the upload process is complete, the Weka cluster instances be stopped and the data is safe on S3.

To re-enable access to the data, it is necessary to form a new cluster or use an existing one and download the snapshot from S3.

#### Protecting Data Against AWS Availability Zone Failures

This use case ensures the protection of data against AWS availability zone failures. The Weka cluster can be run on a single availability zone ensuring the best performance and no cross--AZ bandwidth costs. Using Snap-To-Object, snapshots of the cluster can be taken and uploaded to S3, which is a cross-AZ service. In this way, if an AZ failure occurs, a new Weka cluster can be created on another AZ and the last snapshot uploaded to S3 can be downloaded to this new cluster.

#### AWS Migration of Filesystems to Another Region

Use of Weka snapshots uploaded to S3 combined with S3 cross-region replication enables the migration of a filesystem from one region to another.

#### Cloud Bursting

On-premises Weka system deployments can often benefit from cloud elasticity to consume large quantities of computation power for short periods of time. This requires the following:

1. Taking a snapshot of the on-premises Weka system data using Snap-To-Object.
2. Uploading the data snapshot to S3 at AWS.
3. Creating a Weka cluster at AWS and making the data uploaded to S3 available to the newly-formed cluster at AWS.
4. Switching control to the cloud and processing the data.
5. Taking a snapshot of the cloud cluster on completion of cloud processing.
6. Uploading the cloud snapshot to the local Weka system cluster.

## Snap-To-Object in Data Lifecycle Management

Snap-To-Object and data lifecycle management both use SSDs and object stores for the storage of data. In order to save both storage and performance resources, the Weka system uses the same paradigm for holding SSD and object store data for both lifecycle management and Snap-To-Object. This can be implemented for each filesystem using one of the following schemes:

1. Data resides on the SSDs only and the object store is used only for the various Snap-To-Object use cases, such as backup, archiving, and bursting. In this case, for each filesystem, the allocated SSD capacity should be identical to the filesystem size, and the data Retention Period should be defined as the longest time possible, i.e., 5 years. The Tiering Cue should be defined using the same considerations as in data lifecycle management, based on IO patterns. In this scheme, the applications work all the time with a high-performance SSD storage system and use the object store only as a backup device.
2. Use of Snap-To-Object on filesystems with active data lifecycle management between the object store and the SSDs. In this case, objects in the object store will be used for both tiering of all data and for backing-up the data using Snap-To-Object, i.e., whenever possible, the Weka system will use the same object for both purposes, thereby eliminating the need to acquire additional storage and to unnecessarily copy data.

{% hint style="info" %}
**Note:** When using Snap-To-Object to rehydrate data from an object store, some of the metadata may still be in the object store until it is accessed for the first time.
{% endhint %}

## Working with Snapshots

### **Snapshot Management**

For information on snapshot viewing, creation, updating, deletion, and restoring a filesystem from a snapshot, refer to [Managing Snapshots](snapshots.md#managing-snapshots).

### Uploading a Snapshot

#### Uploading a Snapshot Using the GUI

To upload a snapshot to the object store configured to its filesystem, in the main snapshot view screen select the filesystem snapshot to be uploaded and click Upload To Object. The Snapshot Upload confirmation window will be displayed.

![Snapshot Upload Confirmation Window](<../.gitbook/assets/Snap upload dialog 3.5.png>)

Click Upload to upload the snapshot to the object-store.

Each snapshot has a unique locator within the object-store. This locator can be used in any of the described use cases. To ensure easy recovery operations in the event of a cluster disaster, it is recommended to save each locator.

To view the object store locator of the uploaded snapshot, click the snapshot in the Snapshots View screen.

![View Object Store Locator of Uploaded Snapshot](<../.gitbook/assets/Snap upload view locator 3.5.png>)

#### Uploading a Snapshot Using the CLI

**Command:** `weka fs snapshot upload`

Use the following command line to upload an existing snapshot:

`weka fs snapshot upload <file-system> <snapshot> [--site site]`

**Parameters in Command Line**

| **Name**      | **Type** | **Value**                         | **Limitations**                                      | **Mandatory**                                          | **Default**                                             |
| ------------- | -------- | --------------------------------- | ---------------------------------------------------- | ------------------------------------------------------ | ------------------------------------------------------- |
| `file-system` | String   | Name of the filesystem            |                                                      | Yes                                                    |                                                         |
| `snapshot`    | String   | Name of the snapshot to upload    | Must be a snapshot of the `<file-system>` filesystem | Yes                                                    |                                                         |
| `site`        | String   | Location for the snapshot  upload | `local` or `remote`                                  | Only if both `local` and `remote` buckets are attached | Auto selected if only one bucket for upload is attached |

{% hint style="info" %}
**Note:** A writeable snapshot is a clone of the live filesystem or other snapshots at a specific time, and its data keeps changing. Therefore, its data is tiered according to the tiering policies, but it cannot be uploaded to the object-store as read-only snapshots.
{% endhint %}

{% hint style="warning" %}
**Note: **A snapshot deletion cannot happen in parallel to a snapshot upload to the same filesystem. Since uploading a snapshot to a remote object-store might take a while, it is advisable to delete the desired snapshots before uploading to the remote object-store. 

Also note, this becomes more important when uploading snapshots to both local and remote object stores. While local and remote uploads can progress in parallel, consider the case of a remote upload in progress, then a snapshot is deleted, and later a snapshot is uploaded to the local object-store. In this scenario, the local snapshot upload will wait for the pending deletion of the snapshot (which will happen only once the remote snapshot upload is done).
{% endhint %}

### Creating a Filesystem from an Uploaded Snapshot

#### Creating a Filesystem from a Snapshot Using the GUI

To create a filesystem from an uploaded snapshot, switch the From Uploaded Snapshot field in the Filesystem Creation dialog box to On. The Create Filesystem dialog box is displayed.

![Create Filesystem from an Uploaded Snapshot Dialog Box](<../.gitbook/assets/Snap create FS from snap 3.5.png>)

Define all the fields and enter the location of the snapshot to be used in the Object Store Locator field.

#### Creating a Filesystem from a Snapshot Using the CLI

**Command:** `weka fs download`

Use the following command line to create a filesystem from an existing snapshot:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <obs-bucket> <locator> [--additional-obs additional-obs]`

**Parameters in Command Line**

| **Name**         | **Type** | **Value**                                                                                                                                                                                                                                                    | **Limitations**                                                                              | **Mandatory** | **Default** |
| ---------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------- | ------------- | ----------- |
| `name`           | String   | Name of the filesystem to be created                                                                                                                                                                                                                         |                                                                                              | Yes           |             |
| `group-name`     | String   | Name of the filesystem group in which the new filesystem will be placed                                                                                                                                                                                      |                                                                                              | Yes           |             |
| `total-capacity` | Capacity | The total capacity of the downloaded filesystem                                                                                                                                                                                                              |                                                                                              | Yes           |             |
| `ssd-capacity`   | Capacity | SSD capacity of the downloaded filesystem                                                                                                                                                                                                                    |                                                                                              | Yes           |             |
| `obs-bucket`     | String   | Object store name for tiering                                                                                                                                                                                                                                |                                                                                              | Yes           |             |
| `locator`        | String   | Object store locator obtained from a previously successful snapshot upload                                                                                                                                                                                   |                                                                                              | Yes           |             |
| `additional-obs` | String   | An additional object-store name. In case the data to recover resides in two object stores (a second object-store attached to the filesystem, and the filesystem has not undergone full migration). This object-store will be attached in a `read-only` mode. | The snapshot locator must reside in the primary object-store supplied in the `obs` parameter | No            |             |

The `locator` is either a locator saved previously for disaster scenarios, or can be obtained using the `weka fs snapshot` command on a system with a live filesystem with snapshots.

{% hint style="info" %}
**Note:** Due to the bandwidth characteristics and potential costs when interacting with remote object-stores it is not allowed to download a filesystem from a remote object-store bucket. If a snapshot on a local object-store bucket exists it is advisable to use that one, otherwise, please create a `local` object-store for this bucket in order to download from it.
{% endhint %}

{% hint style="info" %}
**Note: **For encrypted filesystem, when downloading the same KMS master-key should be used to decrypt the snapshot data. For more information, refer to the [KMS Management Overview](managing-filesystems/kms-management.md#overview) section.
{% endhint %}

### Recovering from a Remote Snapshot

When there is a need to recover from a snapshot residing on a remote object-store, there is a need to define the object-store bucket containing the snapshot as a `local` bucket. This is since normally, a remote object-store has restrictions over the download, as explained in the [Managing Object Stores](managing-filesystems/managing-object-stores.md#overview) section, and we would want to use a different local object-store, due to the QoS reasons explained there. 

To recover from a snapshot residing on a remote object-store, you will need to create a new filesystem from this snapshot by following the below procedure:

1. Add a new local object-store, using `weka fs tier obs add` CLI command
2. Add a local object-store bucket, referring to the bucket with the snapshot to recover, using `weka fs tier s3 add`
3. Download the filesystem, using `weka fs download`
4. If the filesystem should also be tiered, add a local object-store for tiering
5. Detach the initial object-store from the filesystem
6. Assuming you want a remote backup to this filesystem, attach a remote bucket to the filesystem
7. Remove the local object-store bucket and local object-store created for this procedure

### Deleting Snapshots Residing on an Object Store

Deleting a snapshot, from a filesystem that uploaded it, will remove all of its data from the local object-store bucket. It will not remove any data from a remote object-store bucket.

{% hint style="danger" %}
If the snapshot has been (or is) downloaded and used by a different filesystem, that filesystem will stop functioning correctly, data might be unavailable and errors might occur when accessing the data.

It is possible to either un-tier or to migrate the filesystem to a different object store bucket before deleting the snapshot it has downloaded.
{% endhint %}
