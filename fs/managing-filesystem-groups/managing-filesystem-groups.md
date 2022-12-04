---
description: This pages describes how to view and manage filesystem groups using the GUI.
---

# Manage filesystem groups using the GUI

Using the GUI, you can perform the following actions:

* [View filesystem groups](managing-filesystem-groups.md#view-filesystem-groups)
* [Add filesystem groups](managing-filesystem-groups.md#add-a-filesystem-group)
* [Edit filesystem groups](managing-filesystem-groups.md#edit-a-filesystem-group)
* [Delete a filesystem group](managing-filesystem-groups.md#delete-a-filesystem-group)

## View filesystem groups

The filesystem groups are displayed on the **Filesystems** page. Each filesystem group indicates the number of filesystems that use it.

**Procedure**

1. From the menu, select **Manage > Filesystems**.

![Filesystem groups example](../../.gitbook/assets/wmng\_view\_filesystem\_groups.png)

## Add a filesystem group

Adding a filesystem group is required when adding a filesystem. You can create more filesystem groups if you want to apply a different tiering policy on specific filesystems.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the + sign right to the Filesystem Groups title.
3. In the **Create Filesystem Group** dialog, set the following:
   * **Name:** Enter a meaningful name for the filesystem group.
   * **Drive Retention Period**: Set the period to keep the data on the SSD after it is copied to the object store. After this period, the copy of the data is deleted from the SSD.
   * **Tiering Cue**: Set the time to wait after the last update before the data is copied from the SSD and sent to the object store.

![Add a filesystem group](../../.gitbook/assets/wmng\_add\_fsg.gif)

4\. Select **Create**.

****

**Related topics**

To learn more about the drive retention period and tiering cue, see**:**

[advanced-time-based-policies-for-data-storage-location.md](../tiering/advanced-time-based-policies-for-data-storage-location.md "mention")****

## Edit a filesystem group

You can edit the filesystem group policy according to your system requirements.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the filesystem group you want to edit.
3. Select the pencil sign right to the filesystem group name.
4. In the **Edit Filesystem Group** dialog, update the settings as you need. (See the parameter descriptions in the [Add a **** filesystem group](managing-filesystem-groups.md#add-a-filesystem-group) topic.)

![Edit a filesystem group](../../.gitbook/assets/wmng\_edit\_fsg\_animated.gif)

4\. Select **Update**.

## Delete a filesystem group

You can delete a filesystem group no longer used by any filesystem.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the filesystem group you want to delete.
3. Verify that the filesystem group is not used by any filesystems (indicates 0 filesystems).

![Delete a filesystem group](../../.gitbook/assets/wmng\_delete\_fsg.png)

4\. Select the **Remove** icon. In the pop-up message, select **Yes** to delete the filesystem group.
