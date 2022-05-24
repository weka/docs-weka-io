---
description: >-
  This pages describes how to view and manage filesystem groups using the GUI
  and the CLI.
---

# Manage filesystem groups

A filesystem group defines the policy of the drive retention period and the tiering cue time. Weka system can include up to eight filesystem groups.

## Manage filesystem groups using the GUI&#x20;

Using the GUI, you can perform the following actions:

* [View filesystem groups](./#view-filesystem-groups)
* [Add filesystem groups](./#add-a-filesystem-group)
* [Edit filesystem groups](./#edit-a-filesystem-group)
* [Delete a filesystem group](./#delete-a-filesystem-group)

### View filesystem groups

The filesystem groups are displayed on the **Filesystems** page. Each filesystem group indicates the number of filesystems that use it.

**Procedure**

1. From the menu, select **Manage > Filesystems**.

The following example shows two filesystem groups defined in the system.

![Filesystem groups](../../.gitbook/assets/wmng\_view\_filesystem\_groups.png)

### Add a filesystem group

Adding a filesystem group is a good practice when you want to apply a different group policy on specific filesystems.

If no filesystem group is added, the file system uses the default filesystem group.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the + sign right to the Filesystem Groups title.
3. In the **Create Filesystem Group** dialog, set the following:
   * **Name:** Enter a meaningful name for the filesystem group.
   * **Drive Retention Period**: Set the number of days to keep the data on the SSD before it is copied to the object store. After this period, the copy of the data is deleted from the SSD.
   * **Tiering Cue**: Set the time to wait after the last update, before the data is copied from the SSD and sent to the object store.

![Add a filesystem group](../../.gitbook/assets/wmng\_add\_fsg.gif)

4\. Select **Create**.

**Related topics**

To learn more about the drive retention period and tiering cue, see**:**

[advanced-time-based-policies-for-data-storage-location.md](../tiering/advanced-time-based-policies-for-data-storage-location.md "mention")****

### Edit a filesystem group

You can edit the filesystem group policy according to your system requirements.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the filesystem group you want to edit.
3. Select the pencil sign right to the filesystem group name.
4. In the **Edit Filesystem Group** dialog, update the settings as you need. (See the parameter descriptions in the _Add a filesystem group_ topic.)

![Edit a filesystem group](../../.gitbook/assets/wmng\_edit\_fsg\_animated.gif)

4\. Select **Update**.

### Delete a filesystem group

You can delete a filesystem group that is no longer used by any filesystem.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the filesystem group you want to delete.
3. Verify that the filesystem group is not used by any filesystems (indicates 0 filesystems).

![Delete a filesystem group](../../.gitbook/assets/wmng\_delete\_fsg.png)

{% hint style="info" %}
If the filesystem group indicates that it is used by filesystems, edit these filesystems and select another filesystem group.
{% endhint %}

4\. Select the **Remove** icon. In the pop-up message, to delete the filesystem group, select **Yes**.
