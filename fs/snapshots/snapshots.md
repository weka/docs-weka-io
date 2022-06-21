---
description: This page describes how to manage snapshots using the GUI.
---

# Manage snapshots using the GUI

Using the GUI, you can:

* [View snapshots](snapshots.md#view-snapshots)
* [Create a snapshot](snapshots.md#create-a-snapshot)
* [Duplicate a snapshot](snapshots.md#undefined)
* [Delete a snapshot](snapshots.md#delete-a-snapshot)
* [Restore a snapshot to a filesystem or another snapshot](snapshots.md#restore-a-filesystem-from-a-snapshot)
* [Update a snapshot](snapshots.md#update-a-snapshot)

## View snapshots

**Procedure**

1. To display all snapshots, select **Manage > Snapshots** from the menu.\
   The Snapshots page opens.

![View all snapshots](../../.gitbook/assets/wmng\_view\_snapshots.png)

2\. To display a snapshot of a selected filesystem, do one of the following:

* Select the Filesystem filter. Then, select the filesystem from the list.
* From the menu, select **Manage > Filesystems**.\
  From the filesystem, select the three dots, and from the menu, select **Go To Snapshot**.

![View a snapshot of a specific filesystem](../../.gitbook/assets/wmng\_fs\_go\_to\_snapshot\_animated.gif)

## Create a snapshot

You can create a snapshot from the **Snapshots page** or directly from the **Filesystems** page.

**Before you begin**

Create a directory for filesystem-level snapshots that serves as the access point for snapshots.

**Procedure:**

1. Do one of the following:
   * From the menu, select **Manage > Snapshots**. From the Snapshots page, select **+Create**.\
     The Create Snapshot dialog opens.
   * From the menu, select **Manage > Filesystems**. From the Filesystems page, select the three dots, and from the menu, select **Create Snapshot**. (The source filesystem is automatically set.)

![Create a snapshot from the Snapshots page](../../.gitbook/assets/wmng\_create\_snapshot\_animated.gif)

![Filesystems menu: Create a snapshot directly from a filesystem](../../.gitbook/assets/wmng\_create\_snap\_from\_fs.png)

3\. On the Create Snapshot dialog set the following properties:

* **Name**: A unique name for the filesystem snapshot.
* **Access Point**: A name of the newly-created directory for filesystem-level snapshots that serves as the snapshot's access point.
* **Writable**: Determines whether to set the snapshot to be writable.
* **Source Filesystem**: The source filesystem from which to create the snapshot.
* **Upload to local object store**: Determines whether to upload the snapshot to a local object store. You can also upload the snapshot later (see [Snap-To-Object](../snap-to-obj/)).
* **Upload to remote object store**: Determines whether to upload the snapshot to a remote object store. You can also upload the snapshot later.

4\. Select **Create**.

## Duplicate a snapshot

You can duplicate a snapshot (clone), which enables creating a writable snapshot from a read-only snapshot.

**Procedure**

1. From the menu, select **Manage > Snapshots**.
2. From the Snapshots page, select the three dots of the snapshot you want to duplicate, and from the menu, select **Duplicate Snapshot**.&#x20;

![Snapshots menu: Duplicate Snapshot](../../.gitbook/assets/wmng\_duplicate\_snapshot.png)

3\. In the Duplicate Snapshot dialog, set the properties the same way you create a snapshot.\
&#x20;   The source filesystem and source snapshot are already set.

4\. Select **Duplicate**.

![Duplicate Snapshot dialog](../../.gitbook/assets/wmng\_duplicate\_snapshot\_dialog.png)

## Delete a snapshot

When deleting a snapshot, consider the following guidelines:

* Deleting a snapshot in parallel to a snapshot upload to the same filesystem is not possible. Uploading a snapshot to a remote object store can take time. Therefore, it is advisable to delete the desired snapshot before uploading it to the remote object store.
* When uploading snapshots to both local and remote object stores. While the local and remote uploads can progress in parallel, consider the case of a remote upload in progress, then a snapshot is deleted, and later a snapshot is uploaded to the local object store. In this scenario, the local snapshot upload waits for the pending deletion of the snapshot (which happens only once the remote snapshot upload is done).

**Procedure**

1. From the menu, select **Manage > Snapshots**.
2. From the Snapshots page, select the three dots of the snapshot you want to delete, and from the menu, select **Remove**.
3. In the Deletion Of Snapshot message, select **Yes** to delete the snapshot.

![Remove a snapshot](../../.gitbook/assets/wmng\_remove\_snapshot.png)

## Restore a snapshot to a filesystem or another snapshot&#x20;

Restoring a snapshot to a filesystem or another snapshot (target) modifies the data and metadata of the target.

**Before you begin**

If you restore the snapshot to a filesystem, make sure to stop the IO services of the filesystem during the restore operation.

**Procedure**

1. From the menu, select **Manage > Snapshots**.
2. From the Snapshots page, select the three dots of the snapshot you want to restore, and from the menu, select **Restore To**.
3. In the Restore To dialog, select the destination: **Filesystem** or **Snapshot**.
4. Select **Save**.

![Restore a snapshot to a filesystem ](../../.gitbook/assets/wmng\_restore\_snapshot.png)

## Update a snapshot

You can update the snapshot name and access point properties.

**Procedure**

1. From the menu, select **Manage > Snapshots**.
2. From the Snapshots page, select the three dots of the snapshot you want to update, and from the menu, select **Edit**.
3. Modify the **Name** and **Access Point** properties as required.
4. Select **Save**.

![Edit snapshot properties](../../.gitbook/assets/wmng\_edit\_snapshot.png)
