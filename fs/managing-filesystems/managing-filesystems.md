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

The filesystems are displayed on the **Filesystems** page. Each filesystem indicates the status, tiering, remote backup, encryption, SDD capacity, total capacity, filesystem group, and data reduction details.

**Procedure**

1. From the menu, select **Manage > Filesystems**.

![View filesystems example](../../.gitbook/assets/wmng\_view\_filesystems.png)

## Create a filesystem

When creating a WEKA system on-premises, it does not contain any filesystem. You must create it and set its properties, such as capacity, group, tiering, thin provisioning, encryption, and required authentication during mount.

When creating a WEKA system in AWS using the cloud formation, the WEKA system contains a default filesystem, which is provisioned with the maximum capacity. If your deployment requires more filesystems with different settings, reduce the default filesystem's provisioned capacity and then add a filesystem with the properties that meet your specific needs.

**Before you begin**

* Verify that the system has free capacity.
* Verify that a filesystem group is already set.
* If tiering is required, verify that an object store bucket is set.
* If encryption is required, verify that a KMS is configured.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the **+Create** button.

![Create filesystem](../../.gitbook/assets/wmng\_create\_fs\_button.png)

3. In the **Create Filesystem** dialog, set the following:
   * **Name**: Enter a descriptive label for the filesystem, limited to 32 characters and excluding slashes (`/`) or backslashes (`\`).
   * **Group**: Select the filesystem group that fits your filesystem.
   * **Capacity**: Enter the storage size to provision, or select **Use All** to provision all the free capacity.

<figure><img src="../../.gitbook/assets/wmng_create_fs.png" alt=""><figcaption><p>Create filesystem</p></figcaption></figure>

4.  Optional: [**Tiering**](../tiering/advanced-time-based-policies-for-data-storage-location.md#tiering-cue-policy).\
    If tiering is required, an object store bucket is already defined, and data reduction is not enabled, select the toggle button and set the details of the object store bucket:

    * **Object Store Bucket:** Select a predefined object store bucket from the list.
    * **Drive Capacity**: Enter the capacity to provision on the SSD, or select **Use All** to use all free capacity.
    * **Total Capacity**: Enter the total capacity of the object store bucket, including the drive capacity.

    When you set tiering, you can create the filesystem from an uploaded snapshot. See the related topics below.

![Tiering](../../.gitbook/assets/wmng\_fs\_tiering.png)

5. Optional: **Thin Provision**.\
   If Thin Provision is required, select the toggle button, and set the minimum (guaranteed) and the maximum capacity for the thin provisioned filesystem.\
   The minimum capacity must be less or equal to the available SSD capacity.\
   You can set any maximum capacity, but the available capacity depends on the actual free space of the SSD capacity.\
   Thin provisioning is mandatory when enabling data reduction.

![Thin provisioning](../../.gitbook/assets/wmng\_fs\_thin\_provisioning.png)

6. Optional: **Data Reduction**.\
   Data reduction can be enabled only on thin provision, non-tiered, and unencrypted filesystems on a cluster with a valid data reduction license (you can verify the data reduction license in the cluster settings). For more details, see the related topics below. \
   To enable the Data Reduction, select the toggle button.

<figure><img src="../../.gitbook/assets/wmng_fs_data_reduction.png" alt=""><figcaption><p>Data reduction</p></figcaption></figure>

7. Optional: If **Encryption** is required and your WEKA system is deployed with a KMS, select the toggle button.
8. Optional: **Required Authentication**.\
   When ON, user authentication is required when mounting to the filesystem. This option is only relevant to a filesystem created in the root organization.\
   Enabling authentication is not allowed for a filesystem hosting NFS client permissions or SMB shares.\
   To authenticate during mount, the user must run the `weka user login` command or use the `auth_token_path` parameter.
9. Select **Save**.



**Related topics**

[managing-filesystem-groups](../managing-filesystem-groups/ "mention")

[managing-object-stores](../managing-object-stores/ "mention")

[kms-management](../../usage/security/kms-management/ "mention")

[overview.md](../../licensing/overview.md "mention")

[#data-reduction](../../overview/filesystems.md#data-reduction "mention")

[#create-a-filesystem-from-an-uploaded-snapshot](../snap-to-obj/snap-to-obj.md#create-a-filesystem-from-an-uploaded-snapshot "mention")

## Edit a filesystem

You can modify the filesystem parameters according to your demand changes over time. The parameters you can modify include filesystem name, capacity, tiering, thin provisioning, and required authentication (but not encryption).

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to modify, and select **Edit**.

![Filesystem menu](../../.gitbook/assets/wmng\_edit\_fs\_menu.png)

3. In the **Edit Filesystem** dialog, modify the parameters according to your requirements. (See the parameter descriptions in the [Add a filesystem](managing-filesystems.md#add-a-filesystem) topic.)

<figure><img src="../../.gitbook/assets/wmng_edit_fs.png" alt=""><figcaption><p>Edit a filesystem</p></figcaption></figure>

4. Select **Save**.

## Delete a filesystem

You can delete a filesystem if its data is no longer required. Deleting a filesystem does not delete the data in the tiered object store bucket.

{% hint style="info" %}
If you must also delete the data in the tiered object store bucket, see the [Delete a filesystem](managing-filesystems-1.md#delete-a-filesystem) topic in the CLI section.
{% endhint %}

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to delete, and select **Remove**.
3. To confirm the filesystem deletion, enter the filesystem name and select **Confirm**.

![Delete a filesystem](../../.gitbook/assets/wmng\_delete\_fs\_animated.gif)
