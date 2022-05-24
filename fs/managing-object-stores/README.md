---
description: This page describes how to view and manage object stores using the GUI.
---

# Manage object stores

Object stores provide optional external storage media in addition to the SSD storage. Object stores are less expensive than SSD storage, therefore object store can be used for storing warm data (data infrequently accessed), while the SSD stores the hot data (data frequently accessed).

You can set object stores on the cloud in the same location as the Weka system (local object store), or at a remote location (remote object store).

A local object store is used for tiering and snapshots (backup). A remote object store is used for snapshots only.

The object store configuration includes:

* Object store DNS name
* Object store bucket identifier
* Access credentials

The object store bucket must be dedicated to the Weka system and must not be accessible by other applications. However, a single object store bucket can serve different filesystems and multiple Weka systems.

You can define up to three object store buckets for a filesystem:

* One object store bucket for tiering, writeable
* Second object store bucket for tiering, read-only
* Third object store bucket for backup only

&#x20;In this setup, the Weka system searches the data in the SSD, and both the tiered object stores, writeable and read-only. This setup enables a range of use cases:

* Migration to different object stores
* Scaling of object store capacity
* Increasing the total tiering capacity of filesystems

## Manage object stores using the GUI

Using the GUI, you can perform the following actions:

* [Edit the default object stores](./#undefined)
* [View object store buckets](./#view-object-store-buckets-using-the-gui)
* [Add an object store bucket](./#add-an-object-store-bucket-using-the-gui)
* [Edit an object store bucket](./#edit-an-object-store-bucket-using-the-gui)
* [Delete an object store bucket](./#delete-an-object-store-bucket)

### Edit the default object stores

Object store buckets can reside in different physical object stores. To achieve good QoS between the buckets, Weka requires to map the buckets to the same physical object store.

You can edit the default local and remote object stores to meet your connection demands. When you add an object store bucket, you apply the relevant default object store on the bucket.

Editing the default object store provides you with the following additional advantages:

* Set restrictions on downloads from a remote object store.\
  For on-premises systems where the remote bucket is in the cloud, to reduce the cost, you set a very low bandwidth for downloading from a remote bucket.
* Ease of adding new buckets.\
  You can set the connection parameters on the object store level and, if not specified differently, automatically use the default settings for the buckets you add.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. On the left, select the pencil icon near the default object store you want to edit.
3. On the **Edit Object Store** dialog, set the following:

* **Type**: Select the type of object store: S3 AWS, HCP, or other.
* **Buckets Default Parameters**: Set the protocol, hostname, port, bucket folder, authentication method, region name, access key, and secret key. (If you have selected **S3 AWS**, the hostname, port, and authentication method are predefined.)

![Edit a default object store](../../.gitbook/assets/wmng\_edit\_default\_obs.gif)

### View object store buckets

The object store buckets are displayed on the **Object Stores** page. Each object store indicates the status, bucket name, protocol (HTTP/HTTPS), port, region, object store location (local or remote), authentication method, and error (if exists).

**Procedure**

1. From the menu, select **Manage > Object Stores**.

The following example shows two object store buckets.

![View object store buckets](../../.gitbook/assets/wmng\_view\_obs\_buckets.png)

### Add an object store bucket

Add object store buckets to be used for tiering or snapshots.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the **+Create** button.

![Create object store bucket](../../.gitbook/assets/wmng\_create\_obs\_button.png)

&#x20;3\. In the **Create Object Store Bucket** dialog, set the following:

* **Name**: Enter a meaningful name for the bucket.
* **Object Store**: Select the location of the object store. For tiering and snapshots, select the local object store. For snapshots only, select the remote object store.
* **Type**: Select the type of object store: S3 AWS, HCP, or other.
* **Buckets Default Parameters**: Set the protocol, hostname, port, bucket folder, authentication method, region name, access key, and secret key. (If you have selected **S3 AWS**, the hostname, port, and authentication method are predefined.)

![Create object store bucket](../../.gitbook/assets/wmng\_create\_obs\_bucket.png)

4\. To validate the connection to the object store bucket, select **Validate**.

5\. Optional. If your deployment requires a specific upload and download configuration, select **Advanced**, and set the parameters.

![Advanced upload and download configuration](../../.gitbook/assets/wmng\_create\_obs\_advanced.png)

6\. Select **Create**.

{% hint style="info" %}
If an error message about the object store bucket configuration appears, to save the configuration, select **Create Anyway**.
{% endhint %}

**Related topics**

[data-management-in-tiered-filesystems.md](../tiering/data-management-in-tiered-filesystems.md "mention")

### Edit an object store bucket

You can modify the object store bucket parameters according to your demand changes over time. The parameters that you can modify include, filesystem name, capacity, tiering, and thin provisioning (but not encryption).

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to modify, and select **Edit**.

![Edit an object store bucket](../../.gitbook/assets/wmng\_edit\_obs\_button.png)

3\. In the Edit Object Store Bucket dialog, modify the details, and select **Update**.

![](../../.gitbook/assets/wmng\_edit\_obs.png)

### Delete an object store bucket

You can delete an object store bucket if it is no longer required.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the three dots on the right of the object store bucket you want to delete, and select **Remove**.
3. To confirm the object store bucket deletion, select **Yes**.

![Delete an object store bucket](../../.gitbook/assets/wmng\_delete\_obs.gif)
