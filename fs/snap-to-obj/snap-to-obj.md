---
description: >-
  This page describes the Snap-To-Object feature, which enables the committing
  of all the data of a specific snapshot to an object store.
---

# Manage Snap-To-Object using the GUI

Using the GUI, you can:

* [Upload a snapshot](snap-to-obj.md#upload-a-snapshot)
* [Create a filesystem from an uploaded snapshot](snap-to-obj.md#create-a-filesystem-from-an-uploaded-snapshot)



**Related topics**

To learn about how to view, create, update, delete, and restore snapshots, see [Manage snapshots using the GUI](../snapshots/snapshots.md).

## Upload a snapshot

You can upload a snapshot to a local, remote, or both object store buckets.

**Procedure**

1. From the menu, select **Manage > Snapshots**.
2. Select the three dots on the right of the required snapshot. From the menu, select **Upload To Object Store**.

![Upload a snapshot to obejct store](../../.gitbook/assets/wmng\_upload\_snapshot\_menu.png)

3\. In the Upload Snapshot dialog, select the target object store bucket: Local, Remote, or Both.

![Upload a snapshot](../../.gitbook/assets/wmng\_upload\_snapshot.png)

4\. Select **Upload**.

5\. In the confirmation message, select **Yes**.\
&#x20;   The snapshot is uploaded to the target object store bucket.

6\. To copy the snapshot locator, select the three dots on the right of the required snapshot.\
&#x20;    From the menu, select **Copy Locator to Clipboard**. Then, save the locator in a dedicated file.

![Copy snapshot locator](../../.gitbook/assets/wmng\_copy\_snapshot\_locator.gif)

****

**Related topics**

[#pause-resume-abort-a-background-task](../../usage/background-tasks.md#pause-resume-abort-a-background-task "mention")

## Create a filesystem from an uploaded snapshot

You can create a filesystem from an uploaded snapshot, for example, when you need to migrate the filesystem data from one location to another.

When creating a filesystem from a snapshot, adhere to the following guidelines:

* **Pay attention to upload and download costs**: Due to the bandwidth characteristics and potential costs when interacting with remote object stores it is not allowed to download a filesystem from a remote object store bucket. If a snapshot on a local object store bucket exists, it is advisable to use that one, otherwise, follow the procedure in the [Recover from a remote snapshot](snap-to-obj.md#recover-from-a-remote-snapshot) topic.
* **Use the same KMS master key**: For an encrypted filesystem, to decrypt the snapshot data, use the same KMS master key as used in the encrypted filesystem. See the [KMS Management Overview](../kms-management/#overview) topic.

**Before you begin**

Verify that the locator of the required snapshot is available. If not, see the last step in the [Upload a snapshot](snap-to-obj.md#upload-a-snapshot) procedure for how to copy the locator to the clipboard.&#x20;

**Procedure**

1. From the menu, select **Manage > Filesystems**, and select **+Create**.
2. In the Create Filesystem, do the following:
   * Set the filesystem name, group, and tiering properties.
   * Select **Create From Uploaded Snapshot** (it only appears when you select **Tiering**). Paste the copied snapshot locator.
3. Select **Save**.&#x20;

![Create a filesystem from an uploaded snapshot](../../.gitbook/assets/wmng\_Create\_fs\_from\_snapshot\_animated.gif)

**Related topics**

[#add-a-filesystem](../managing-filesystems/managing-filesystems.md#add-a-filesystem "mention")
