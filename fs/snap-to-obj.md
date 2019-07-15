---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object store.
---

# Snap-To-Object

## About Snap-To-Object

 The Snap-To-Object feature enables the committing of all the data of a specific snapshot, including metadata, to an object store. Unlike data lifecycle management processes, this feature involves all the snapshot, which includes data, metadata and every file.

The result of using the Snap-To-Object feature is that the object store contains a full copy of the snapshot of the data, which can be used to restore the data on the WekaIO cluster or on another cluster. Consequently, the Snap-To-Object feature is useful for a range of use cases, as follows:

#### Generic Use Cases \(on-premises and cloud\)

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

If a WekaIO cluster fails beyond recovery due to multiple failures or a structural failure such as fire or flood, snapshot data saved to an object store can be used to recreate the same data on another WekaIO cluster. This use case supports backup in any of the following WekaIO system deployment modes:

**Local Object Store:** WekaIO SSD tier, hosts and object store tiers are located in one data center, but separated in different rooms or buildings. In such a deployment, a total failure obliterating all WekaIO system hosts will still have another live object store and it is possible to start new filesystems from the last snapshot.

**Remote Object Store:** WekaIO hosts and object stores are located in different data centers. In such a deployment, data is perfectly protected even if a complete data center failure occurs.

{% hint style="info" %}
**Note:** This type of deployment requires the ability to support a latency of hundreds of milliseconds. For performance issues on Snap-To-Object tiering cross-interactions/resonance, contact the WekaIO Support Team.
{% endhint %}

**Local Object Store Replicating to a Remote Object Store:** A local object store in one data center replicates data to another object store using the object store system features, such as [AWS S3 cross-region replication](https://docs.aws.amazon.com/AmazonS3/latest/dev/crr.html). This deployment provides both integrated tiering and Snap-To-Object local high performance between the WekaIO object store and the additional object store, and remote copying of data will enable the survival of data in any data center failure.

{% hint style="info" %}
**Note:** This deployment requires ensuring that the object store system perfectly replicates all objects.
{% endhint %}

#### Archiving of Data

The periodic creation of data snapshots and uploading the snapshots to an object store generates an archive, allowing the accessing of past copies of data. When any compliance or applicative requirement occurs, it is possible to make the relevant snapshot available on a WekaIO cluster and view the content of past versions of data.

#### Asynchronous Mirroring of Data

Combining a local cluster with a replicated object store on another data center can create a scheme whereby a disaster in the primary site will activate the secondary data center with the content of the last available snapshot.

#### AWS Pause/Restart

Some AWS installations of the WekaIO system may have a cluster working with local SSDs. Sometimes, the data needs to be retained, even though ongoing access to it is unnecessary. In such cases, the use of Snap-To-Object can save costs of AWS instances running the WekaIO system and the WekaIO license.

To pause a cluster, it is necessary to take a snapshot of the data, and then using Snap-To-Object to upload the snapshot to S3 at AWS. When the upload process is complete, the WekaIO cluster instances be stopped and the data is safe on S3.

To re-enable access to the data, it is necessary to form a new cluster or use an existing one, and download the snapshot from S3.

#### Protecting Data Against AWS Availability Zone Failures

This use case ensures the protection of data against AWS availability zone failures. The WekaIO cluster can be run on a single availability zone ensuring best performance and no cross--AZ bandwidth costs. Using Snap-To-Object, snapshots of the cluster can be taken and uploaded to S3, which is a cross-AZ service. In this way, if an AZ failure occurs, a new WekaIO cluster can be created on another AZ and the last snapshot uploaded to S3 can be downloaded to this new cluster.

#### AWS Migration of Filesystems to Another Region

Use of WekaIO snapshots uploaded to S3 combined with S3 cross-region replication enables the migration of a filesystem from one region to another.

#### Cloud Bursting

On-premises WekaIO system deployments can often benefit from cloud elasticity to consume large quantities of computation power for short periods of time. This requires the following:

1. Taking a snapshot of the on-premises WekaIO system data using Snap-To-Object.
2. Uploading the data snapshot to S3 at AWS.
3. Creating a WekaIO cluster at AWS and making the data uploaded to S3 available to the newly-formed cluster at AWS.
4. Switching control to the cloud and processing the data.
5. Taking a snapshot of the cloud cluster on completion of cloud processing.
6. Uploading the cloud snapshot to the local WekaIO system cluster.

## Snap-To-Object in Data Lifecycle Management

Snap-To-Object and data lifecycle management both use SSDs and object stores for the storage of data. In order to save both storage and performance resources, the WekaIO system uses the same paradigm for holding SSD and object store data for both lifecycle management and Snap-To-Object. This can be implemented for each filesystem using one of the following schemes:

1. Data resides on the SSDs only and the object store is used only for the various Snap-To-Object use cases, such as backup, archiving and bursting. In this case, for each filesystem, the allocated SSD capacity should be identical to the filesystem size and the data Retention Period should be defined as the longest time possible, i.e., 5 years. The Tiering Cue should be defined using the same considerations as in data lifecycle management, based on IO patterns. In this scheme, the applications work all the time with a high-performance SSD storage system and use the object store only as a backup device.
2. Use of Snap-To-Object on filesystems with active data lifecycle management between the object store and the SSDs. In this case, objects in the object store will be used for both tiering of all data and for backing-up the data using Snap-To-Object, i.e., whenever possible, the WekaIO system will use the same object for both purposes, thereby eliminating the need to acquire additional storage and to unnecessarily copy data.

## Working with Snapshots

### **Snapshot Management**

For information on snapshot viewing, creation, updating, deletion and restoring a filesystem from a snapshot, refer to [Managing Snapshots](snapshots.md#managing-snapshots).

### Uploading a Snapshot

#### Uploading a Snapshot Using the GUI

To upload a snapshot to its filesystem's configured object store, in the main snapshot view screen, select the filesystem snapshot to be uploaded and click Upload To Object. The Snapshot Upload confirmation window will be displayed.

![Snapshot Upload Confirmation Window](../.gitbook/assets/snapshot-upload-confirmation-window.jpg)

Click Upload to upload the snapshot to the object store.

#### Uploading a Snapshot Using the CLI

**Command: `snapshot upload`**

Use the following command line to update an existing snapshot:

`weka fs snapshot upload <file-system> <snapshot>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `<fs>` | String | Name of the filesystem |  | Yes |  |
| `<snapshot>` | String | Name of snapshot to upload | Has to be a snapshot of the &lt;fs&gt; filesystem | Yes |  |

### Creating a Filesystem from an Uploaded Snapshot

#### Creating a Filesystem from a Snapshot Using the GUI

To create a filesystem from an uploaded snapshot, switch the From Uploaded Snapshot field in the Filesystem Creation dialog box to On. The Create Filesystem dialog box is displayed.

![Create Filesystem from an Uploaded Snapshot Dialog Box](../.gitbook/assets/create-fs-from-snapshot-dialog-box.jpg)

Define all the fields and enter the location of the snapshot to be used in the Object Store Locator field.

#### Creating a Filesystem from a Snapshot Using the CLI

**Command: `filesystem download`**

Use the following command line to update an existing snapshot:

`weka fs download <name> <group-name> <total-capacity> <ssd-capacity> <locator>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `<fs>` | String | Name of filesystem to create |  | Yes |  |
| `<group>` | String | Name of filesystem-group to place the new filesystem in |  | Yes |  |
| `<ssd-capacity>` | Capacity | SSD capacity of the downloaded filesystem |  | Yes |  |
| `<total-capacity>` | Capacity | Total capacity of the downloaded filesystem |  | Yes |  |
| `<locator>` | String | The object-store locator obtained from a previously successful snapshot upload |  | Yes |  |





