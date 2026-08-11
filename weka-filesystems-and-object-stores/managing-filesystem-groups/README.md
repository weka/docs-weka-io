---
description: >-
  Learn how filesystem groups control the tiering behavior of the filesystems
  that belong to them.
---

# Manage filesystem groups

A filesystem group defines the tiering policy applied to its filesystems. It sets two parameters:

* **Drive Retention Period**: The time to keep data on the SSD after it is copied to the object store. When this period ends, the copy of the data is deleted from the SSD.
* **Tiering Cue**: The time to wait after the last update before the data is copied from the SSD to the object store.

Every filesystem must belong to a filesystem group. The system provides the `default` filesystem group, which you can use as is or edit. Create additional filesystem groups when you want to apply a different tiering policy to specific filesystems.

NeuralMesh supports up to eight filesystem groups.

{% hint style="info" %}
The tiering policy applies only to tiered filesystems. For an SSD-only filesystem, the filesystem group is still required, but its parameters have no effect.
{% endhint %}

**Related topics**

[Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/)

[Manage data lifecycle for tiered systems](../tiering.md)

[Manage filesystem groups using the GUI](managing-filesystem-groups.md)

[Manage filesystem groups using the CLI](manage-filesystem-groups-using-the-cli.md)
