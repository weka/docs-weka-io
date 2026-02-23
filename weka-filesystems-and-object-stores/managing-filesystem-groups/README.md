---
description: >-
  Configure centralized tiering policies to enforce data lifecycle rules across
  multiple filesystems.
---

# Manage filesystem groups

A filesystem group functions as a policy engine for tiered storage, enforcing consistent data lifecycle rules across multiple filesystems. By grouping filesystems, you centrally manage how data transitions between the high-performance SSD tier and the object store.

**Lifecycle policy enforcement:** The filesystem group serves as the centralized configuration point for the tiering cue and the drive retention period. These settings dictate the timing for copying data to the object store and releasing it from the SSD cache. Any change to a group's configuration immediately applies the updated lifecycle policies to all its member filesystems.

**Association requirements:** To enable tiering, every filesystem must be associated with a filesystem group. The WEKA system supports up to eight distinct filesystem groups, allowing you to define and maintain separate tiering strategies for different workload types within the same cluster.

**Related topics**

[tiering.md](../tiering.md "mention")
