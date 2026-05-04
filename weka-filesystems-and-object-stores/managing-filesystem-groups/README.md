---
description: This page provides an overview about managing filesystem groups.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-filesystems-and-object-stores/managing-filesystem-groups
---

# Manage filesystem groups

A filesystem group in the WEKA system is used specifically to manage tiering policies for filesystems. It defines key parameters, including the drive retention period and the tiering queue time, which determine how and when data is tiered.

When you add a filesystem, it must be associated with a filesystem group to apply these tiering behaviors. The WEKA system supports up to eight filesystem groups, allowing flexibility in managing tiering policies across different filesystems.

**Related topics**

[Filesystems, object stores, and filesystem groups](../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/)

[managing-filesystem-groups.md](managing-filesystem-groups.md "mention")

[manage-filesystem-groups-using-the-cli.md](manage-filesystem-groups-using-the-cli.md "mention")
