---
description: >-
  Learn how filesystem groups control the tiering behavior of the filesystems
  that belong to them.
---

# Manage filesystem groups

A filesystem group defines the tiering policy applied to its filesystems. It sets two parameters:

* **Drive Retention Period**: The time to keep data on the SSD after it is copied to the object store. When this period ends, the copy of the data is deleted from the SSD.
* **Tiering Cue**: The time to wait after the last update before the data is copied from the SSD to the object store.

A filesystem group is optional. It is required only for a filesystem with a local object store attached, because the group carries the tiering policy that governs it. The system provides the `default` filesystem group, which you can use as is or edit. Create additional filesystem groups when you want to apply a different tiering policy to specific filesystems.

NeuralMesh supports up to eight filesystem groups.

{% hint style="info" %}
The tiering policy applies only to filesystems with a local object store attached. A filesystem without one, such as an SSD-only filesystem, does not need a filesystem group. If you do place it in a group, the group's parameters have no effect on it.
{% endhint %}

**Related topics**

[Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/)

[Manage data lifecycle for tiered systems](../tiering.md)

[Manage filesystem groups using the GUI](managing-filesystem-groups.md)

[Manage filesystem groups using the CLI](manage-filesystem-groups-using-the-cli.md)
