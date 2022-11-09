---
description: This page describes how to view and manage filesystems using the GUI.
---

# Manage filesystems using the GUI

Using the GUI, you can perform the following actions:

* [View filesystems](managing-filesystems.md#view-filesystems)
* [Create a filesystem](managing-filesystems.md#add-a-filesystem)
* [Edit a filesystem](managing-filesystems.md#edit-a-filesystem)
* [Delete a filesystem](managing-filesystems.md#delete-a-filesystem)

## View filesystems

The filesystems are displayed on the **Filesystems** page. Each filesystem indicates the status, tiering status, backup status, encryption status, SDD capacity, total capacity, and the filesystem group used.

**Procedure**

1. From the menu, select **Manage > Filesystems**.

The following example shows one filesystem.

![View filesystems](../../.gitbook/assets/wmng\_view\_filesystems.png)

## Create a filesystem

When creating a Weka system on-premises, it does not contain any filesystem. You need to create it and set its properties, such as capacity, group, tiering, thin provisioning, encryption, and required authentication during mount.

When creating a Weka system in AWS using the cloud formation, the Weka system contains a default filesystem, which is provisioned with the maximum capacity. If your deployment requires more filesystems with different settings, first reduce the provisioned capacity of the default filesystem, and then add a filesystem with the properties that meet your specific needs.

**Before you begin**

* Verify that the system has free capacity.
* Verify that a filesystem group is already set.
* If tiering is required, verify that an object store bucket is set.
* If encryption is required, verify that a KMS is configured.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the **+Create** button.

![Create filesystem](../../.gitbook/assets/wmng\_create\_fs\_button.png)

3\. In the **Create Filesystem** dialog, set the following:

* **Name**: Enter a meaningful name for the filesystem.
* **Group**: Select the filesystem group that fits your filesystem.
* **Capacity**: Enter the storage size to provision, or select **Use All** to provision all the free capacity.&#x20;

<figure><img src="../../.gitbook/assets/wmng_4_1_create_fs_animated.gif" alt=""><figcaption><p>Create a filesystem</p></figcaption></figure>

4\. Optional: [**Tiering**](../tiering/advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy).\
&#x20;   If tiering **** is required and an object store bucket is already defined, \
&#x20;   select the toggle button, and set the details of the object store bucket:

* **Object Store Bucket:** Select a predefined object store bucket from the list.
* **Drive Capacity**: Enter the capacity to provision on the SSD, or select **Use All** to use all free capacity.
* **Total Capacity**: Enter the total capacity of the object store bucket, including the drive capacity.

![Tiering](../../.gitbook/assets/wmng\_fs\_tiering.png)

5\. Optional: **Thin Provision**.\
&#x20;   If Thin Provision is required, select the toggle button, and set the minimum \
&#x20;   capacity (guaranteed) and the maximum capacity for the thin provisioned filesystem.\
&#x20;   The minimum capacity must be less or equal to the available SSD capacity.\
&#x20;   You can set any maximum capacity, but the available capacity depends on the actual free space of the SSD capacity.&#x20;

![Thin provisioning](../../.gitbook/assets/wmng\_fs\_thin\_provisioning.png)

6\. Optional: If **Encryption** is required and your Weka system is deployed with a KMS, \
&#x20;   select the toggle button.

7\. Optional: **Required Authentication**.\
&#x20;   When ON, user authentication is required when mounting to the filesystem. This option is \
&#x20;   only relevant to a filesystem created in the root organization.\
&#x20;   To authenticate during mount, the user is required to run the `weka user login` command, or \
&#x20;    use `auth_token_path`.

7\. Select **Save**.

****

**Related topics**

****[managing-filesystem-groups](../managing-filesystem-groups/ "mention")****

****[managing-object-stores](../managing-object-stores/ "mention")****

[kms-management](../../usage/security/kms-management/ "mention")

## Edit a filesystem

You can modify the filesystem parameters according to your demand changes over time. The parameters that you can modify include, filesystem name, capacity, tiering, and thin provisioning (but not encryption).

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to modify, and select **Edit**.

![Filesystem menu](../../.gitbook/assets/wmng\_edit\_fs\_menu.png)

3\. In the **Edit Filesystem** dialog, modify the parameters according to your requirements. (See the parameter descriptions in the [Add a filesystem](managing-filesystems.md#add-a-filesystem) topic.)

![Edit a filesystem](../../.gitbook/assets/wmng\_edit\_fs.png)

4\. Select **Save**.

## Delete a filesystem

You can delete a filesystem if its data is no longer required. Deleting a filesystem does not delete the data in the tiered object store bucket.

{% hint style="info" %}
If you need to delete also the data in the tiered object store bucket, see [delete a filesystem](managing-filesystems-1.md#delete-a-filesystem) in the CLI section.
{% endhint %}

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to delete, and select **Remove**.
3. To confirm the filesystem deletion, enter the filesystem name and select **Confirm**.

![Delete a filesystem](../../.gitbook/assets/wmng\_delete\_fs\_animated.gif)
