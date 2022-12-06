---
description: This page describes how to view and manage object stores using the GUI.
---

# Manage object stores using the GUI

Using the GUI, you can perform the following actions:

* [Edit the default object stores](managing-object-stores.md#edit-the-default-object-stores)
* [View object store buckets](managing-object-stores.md#view-object-store-buckets)
* [Add an object store bucket](managing-object-stores.md#add-an-object-store-bucket)
* [Edit an object store bucket](managing-object-stores.md#edit-an-object-store-bucket)
* [Show recent operations of an object store bucket](managing-object-stores.md#show-recent-operations-of-an-object-store-bucket)
* [Delete an object store bucket](managing-object-stores.md#delete-an-object-store-bucket)

## Edit the default object stores <a href="#edit-the-default-object-stores" id="edit-the-default-object-stores"></a>

Object store buckets can reside in different physical object stores. To achieve good QoS between the buckets, Weka requires to map the buckets to the physical object store.

You can edit the default local and remote object stores to meet your connection demands. When you add an object store bucket, you apply the relevant object store on the bucket.

Editing the default object store provides you with the following additional advantages:

* Set restrictions on downloads from a remote object store.\
  For on-premises systems where the remote bucket is in the cloud, to reduce the cost, you set a very low bandwidth for downloading from a remote bucket.
* Ease of adding new buckets.\
  You can set the connection parameters on the object store level and, if not specified differently, automatically use the default settings for the buckets you add.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. On the left, select the pencil icon near the default object store you want to edit.
3. On the **Edit Object Store** dialog, set the following:

* **Type**: Select the type of object store.
* **Buckets Default Parameters**: Set the protocol, hostname, port, bucket folder, authentication method, region name, access key, and secret key.

{% hint style="info" %}
If using the AWS object store type and access from the Weka EC2 instances to the object store is granted by the IAM roles, it is not mandatory to set the access and secret keys in the Edit Object Store dialog.
{% endhint %}

![Edit the default-remote object store ](../../.gitbook/assets/wmng\_4\_1\_edit\_default\_obs.gif)

## View object store buckets <a href="#view-object-store-buckets" id="view-object-store-buckets"></a>

The object store buckets are displayed on the **Object Stores** page. Each object store indicates the status, bucket name, protocol (HTTP/HTTPS), port, region, object store location (local or remote), authentication method, and error information (if exists).

**Procedure**

1. From the menu, select **Manage > Object Stores**.

The following example shows two object store buckets.

![View object store buckets](../../.gitbook/assets/wmng\_view\_obs\_buckets.png)

## Add an object store bucket <a href="#add-an-object-store-bucket" id="add-an-object-store-bucket"></a>

Add object store buckets to be used for tiering or snapshots.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the **+Create** button.

![Create object store bucket](../../.gitbook/assets/wmng\_4\_1\_create\_obs\_button.png)

&#x20;3\. In the **Create Object Store Bucket** dialog, set the following:

* **Name**: Enter a meaningful name for the bucket.
* **Object Store**: Select the location of the object store. For tiering and snapshots, select the local object store. For snapshots only, select the remote object store.
* **Type**: Select the type of object store.
* **Buckets Default Parameters**: Set the protocol, hostname, port, bucket folder, authentication method, region name, access key, and secret key.

![Create object store bucket](../../.gitbook/assets/wmng\_create\_obs\_bucket.png)

4\. To validate the connection to the object store bucket, select **Validate**.

5\. Optional**:** If your deployment requires a specific upload and download configuration, select **Advanced**, and set the parameters:

* **Download Bandwidth**: Object store download bandwidth limitation per core (Mbps).
* **Upload Bandwidth**: Object store upload bandwidth limitation per core (Mbps).
* **Max concurrent Downloads**: Maximum number of downloads concurrently performed on this object store in a single IO node.
* **Max concurrent Uploads**: Maximum number of uploads concurrently performed on this object store in a single IO node.
* **Max concurrent Removals**: Maximum number of removals concurrently performed on this object store in a single IO node,
* **Enable Upload Tags**: Whether to enable [object-tagging](../tiering/data-management-in-tiered-filesystems.md#object-tagging) or not.

![Advanced upload and download configuration](../../.gitbook/assets/wmng\_create\_obs\_advanced.png)

6\. Select **Create**.

{% hint style="info" %}
If an error message about the object store bucket configuration appears, to save the configuration, select **Create Anyway**.
{% endhint %}

## Edit an object store bucket <a href="#edit-an-object-store-bucket" id="edit-an-object-store-bucket"></a>

You can modify the object store bucket parameters according to your demand changes over time.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the three dots on the right of the object store you want to modify, and select **Edit**.

![Edit an object store bucket](../../.gitbook/assets/wmng\_edit\_obs\_button.png)

3\. In the Edit Object Store Bucket dialog, modify the details, and select **Update**.

![Edit an object store bucket](../../.gitbook/assets/wmng\_edit\_obs.png)

## Show recent operations of an object store bucket

For active object store buckets connected to filesystems, the system tracks this activity and provides details about each activity on the Bucket Operations page.

The details include the operation type (download or upload), start time, execution time, previous attempts results, cURL errors, and more.&#x20;

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the three dots on the right of the object store bucket you want to show its recent operation, and select **Show Recent Operations**.

<figure><img src="../../.gitbook/assets/wmng_obs_show_recent_operations_menu.png" alt=""><figcaption><p>Show recent operations of an object store bucket</p></figcaption></figure>

The recent operations page for the selected object store bucket appears. To focus on specific operations, you can sort the columns and use the filters that appear on the top of the columns.

<figure><img src="../../.gitbook/assets/wmng_obs_show_recent_ops_example.png" alt=""><figcaption><p>Bucket Operations page</p></figcaption></figure>

## Delete an object store bucket

You can delete an object store bucket if it is no longer required. The data in the object store remains intact.

**Procedure**

1. From the menu, select **Manage > Object Stores**.
2. Select the three dots on the right of the object store bucket you want to delete, and select **Remove**.
3. To confirm the object store bucket deletion, select **Yes**.

![Delete an object store bucket](../../.gitbook/assets/wmng\_delete\_obs.gif)
