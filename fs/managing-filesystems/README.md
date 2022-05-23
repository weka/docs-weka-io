---
description: This page describes how to view and manage filesystems using the GUI.
---

# Manage filesystems

The management of filesystems is an integral part of the successful running and performance of the Weka system and overall data lifecycle management.

**Related topics**

[filesystems.md](../../overview/filesystems.md "mention")

## Manage filesystems using the GUI

Using the GUI, you can perform the following actions:

* [View filesystems](./#view-filesystems)
* [Add a filesystem](./#create-a-filesystem)
* [Edit a filesystem](./#edit-a-filesystem)
* [Delete a filesystem](./#delete-a-filesystem)

### View filesystems

The filesystems are displayed on the **Filesystems** page. Each filesystem indicates the x status, tiering status, backup status, encryption status, SDD capacity, total capacity, and the filesystem group used.

**Procedure**

1. From the menu, select **Manage > Filesystems**.

The following example shows the predefined default filesystem.

![View filesystems](../../.gitbook/assets/wmng\_view\_filesystems.png)

### Add a filesystem

A newly created Weka system contains a default filesystem, which is provisioned with the maximum capacity. If your deployment requires more filesystems with different settings, such as tiering, thin provisioning, and encryption, you can first reduce the provisioned capacity of the default filesystem, and then add a filesystem with the parameters that meet your specific needs.

**Before you begin**

Verify that the system has free capacity.

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the **+Create** button.
3. In the **Create Filesystem** dialog, set the parameters relevant to your deployment.

![Create a filesystem](../../.gitbook/assets/wmng\_add\_fs\_animated.gif)

4\. Select **Save**.

The filesystem is created. You can modify its parameters later, if necessary.

## Edit a filesystem

You can modify the filesystem parameters according to your demand changes over time. The parameters that you can modify include, filesystem name, capacity, tiering, and thin provisioning (but not encryption).

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to modify, and select **Edit**.

![Filesystem menu](../../.gitbook/assets/wmng\_edit\_fs\_menu.png)

3\. In the **Edit Filesystem** dialog, modify the parameters according to your requirements.

![Edit a filesystem](../../.gitbook/assets/wmng\_edit\_fs.png)

4\. Select **Save**.

### Delete a filesystem

You can delete a filesystem if it is no longer required.&#x20;

**Procedure**

1. From the menu, select **Manage > Filesystems**.
2. Select the three dots on the right of the filesystem you want to modify, and select **Remove**.
3. To confirm the filesystem deletion, enter the filesystem name and select **Confirm**.

![Delete a filesystem](../../.gitbook/assets/wmng\_delete\_fs\_animated.gif)
