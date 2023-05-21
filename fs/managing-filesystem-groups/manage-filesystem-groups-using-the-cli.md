---
description: This pages describes how to view and manage filesystem groups using the CLI.
---

# Manage filesystem groups using the CLI

Using the CLI, you can perform the following actions:

* [View filesystem groups](manage-filesystem-groups-using-the-cli.md#view-filesystem-groups)
* [Add filesystem groups](manage-filesystem-groups-using-the-cli.md#add-a-filesystem-group)
* [Edit filesystem groups](manage-filesystem-groups-using-the-cli.md#edit-a-filesystem-group)
* [Delete filesystem groups](manage-filesystem-groups-using-the-cli.md#delete-a-filesystem-group)

## **View filesystem groups**

**Command:** `weka fs group`

Use this command to view information on the filesystem groups in the WEKA system.

## Add a filesystem group

**Command:** `weka fs group create`

Use the following command to add a filesystem group:

`weka fs group create <name> [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

| Name                   | Value                                                                   | Default          |
| ---------------------- | ----------------------------------------------------------------------- | ---------------- |
| `name`\*               | Name of the filesystem group being created                              | ​                |
| `target-ssd-retention` | Target retention period (in seconds) before tiering to the object store | 86400 (24 hours) |
| `start-demote`         | Target tiering cue (in seconds) before tiering to the object store      | 10               |

## Edit a filesystem group

**Command:** `weka fs group update`

Use the following command to edit a filesystem group:

`weka fs group update <name> [--new-name=<new-name>] [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

| Name                   | Value                                                                        |
| ---------------------- | ---------------------------------------------------------------------------- |
| `name`\*               | <p>Name of the filesystem group to edit.<br>It must be a valid name.</p>     |
| `new-name`             | New name for the filesystem group.                                           |
| `target-ssd-retention` | New target retention period (in seconds) before tiering to the object store. |
| `start-demote`         | New target tiering cue (in seconds) before tiering to the object store.      |

## Delete a filesystem group

**Command:** `weka fs group delete`

Use the following command line to delete a filesystem group:

`weka fs group delete <name>`

**Parameters**

| Name     | Value                                  |
| -------- | -------------------------------------- |
| `name`\* | Name of the filesystem group to delete |

**Related topics**

To learn about the tiring policy, see:

[tiering](../tiering/ "mention")
