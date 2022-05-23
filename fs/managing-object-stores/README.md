---
description: >-
  This page describes how to view and manage object stores using the GUI and the
  CLI.
---

# Manage object stores

As described in the [Object Stores Overview](../../overview/filesystems.md#about-object-stores) page, Weka utilizes object stores for either tiering or backup when attaching object-store buckets to a filesystem.

Since object-store buckets may reside in different physical object stores, for better QoS between them, Weka requires the mapping between the bucket to the physical object-store.

Object-store in Weka generally represents a physical entity (on-premises or in the cloud), grouping several object-store buckets. An object-store or object-store bucket can be either `local` (used for tiering+snapshots) or `remote` (used for snapshots only). An object-store bucket must be added to an object-store with the same type.&#x20;

This grouping under a physical object-store allows:

* Better QoS when more than one physical object-store is involved
* Restrictions on downloading from a remote object-store
  * By default, very low bandwidth is configured for downloading from a remote bucket since this may incur extra charges for on-premises systems where the remote bucket is in the cloud.
* Ease-of adding new buckets
  * It is possible to configure the connection parameters on the object-store level and, if not specified differently, automatically use them for added buckets.

{% hint style="info" %}
**Note:** Initially, the system comes up with two pre-configured object-stores, one for grouping`local` buckets for tiering and snapshots (named`default`) and one for grouping `remote` buckets for snapshots-only (named `remote_default`).
{% endhint %}

{% hint style="info" %}
**Note:** Currently, only one local and one remote object store are supported in general operation. It is only transiently supported to have more than one local object store when there is a need to recover from a remote snapshot (this recovery might incur significant charges when working with a cloud backup). If there is no other way (snapshot is not present locally) it is possible to use this procedure to [recover from a remote snapshot](../snap-to-obj.md#recovering-from-a-remote-snapshot).

Support for more than one local/remote object-stores planned in a future version.
{% endhint %}

## Manage object stores using the GUI

Using the GUI, you can perform the following actions:

* [View object store buckets](./#view-object-store-buckets-using-the-gui)
* [Add an object store bucket](./#add-an-object-store-bucket-using-the-gui)
* [Edit an object store bucket](./#edit-an-object-store-bucket-using-the-gui)
* [Delete an object store bucket](./#delete-an-object-store-bucket)

### View object store buckets

The main object store screen in the GUI lists all existing object-store buckets and can also display information about a specific object-store bucket, including the bucket name, status and region.

![Main Object Store View Screen](<../../.gitbook/assets/OBS main screen 3.5.png>)

### Add an object store bucket

From the main object store view screen, click the "+" button at the top left-hand side of the screen. The Configure Object Store dialog box will be displayed.

![Configure Object Store Dialog Box](<../../.gitbook/assets/OBS add dialog 3.5.png>)

Enter the relevant parameters and click Configure to add the object store bucket.

If the object store is misconfigured, the Error in Object Store Configuration window will be displayed.

![Object Store Configuration Error Window](<../../.gitbook/assets/OBS add error 3.5.png>)

Click Save Anyway in order to save the configured object store.

### Edit an object store bucket

From the main object store view screen, click the Edit button of the object store bucket to be edited.

![Edit Object Store Screen](<../../.gitbook/assets/OBS edit Screen 3.5.png>)

The Update Object Store dialog box (which is similar to the Configure Object Store dialog box) will be displayed with the current specifications for the object store bucket.

![Update Object Store Dialog Box](<../../.gitbook/assets/OBS edit dialog 3.5.png>)

Make the relevant changes and click Update to update the object store bucket.

### Delete an object store bucket

From the main object store view screen, click the Delete button of the object-store bucket to be deleted.

![Delete Object Store Screen](<../../.gitbook/assets/OBS delete screen 3.5.png>)

The Deletion of Object Store window will be displayed.

![Deletion of Object Store Window](<../../.gitbook/assets/OBS delete dialog 3.5.png>)

Click Yes to delete the object-store bucket.
