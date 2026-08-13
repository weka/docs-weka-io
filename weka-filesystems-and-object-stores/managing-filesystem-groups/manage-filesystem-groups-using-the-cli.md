---
description: This page describes how to view and manage filesystem groups using the CLI.
---

# Manage filesystem groups using the CLI

Using the CLI, you can perform the following actions:

* [View filesystem groups](manage-filesystem-groups-using-the-cli.md#view-filesystem-groups)
* [Add a filesystem group](manage-filesystem-groups-using-the-cli.md#add-a-filesystem-group)
* [Edit a filesystem group](manage-filesystem-groups-using-the-cli.md#edit-a-filesystem-group)
* [Remove a filesystem group](manage-filesystem-groups-using-the-cli.md#remove-a-filesystem-group)

## **View filesystem groups**

**Command:** `weka fs group`

Use this command to view information on the filesystem groups in the WEKA system.

## Add a filesystem group

**Command:** `weka fs group add`

Use the following command to add a filesystem group:

`weka fs group add <name> [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

| Name                   | Value                                                                                                                                                                                     | Default |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------- |
| `name`\*               | Set a meaningful name for the filesystem group.                                                                                                                                           | ​       |
| `target-ssd-retention` | <p>The time for keeping data on the SSD after it is copied to the object store. After this period, the copy of the data is deleted from the SSD.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</p> | 1d      |
| `start-demote`         | <p>The time to wait after the last update before the data is copied from the SSD and sent to the object store.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</p>                                   | 10s     |

## Edit a filesystem group

**Command:** `weka fs group update`

Use the following command to edit a filesystem group:

`weka fs group update <name> [--new-name=<new-name>] [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

| Name | Value |
| --- | --- |
| `name`* | Name of the filesystem group to edit.It must be a valid name. |
| `new-name` | New name for the filesystem group. |
| `target-ssd-retention` | The time for keeping data on the SSD after it is copied to the object store. After this period, the copy of the data is deleted from the SSD.Format: 3s, 2h, 4m, 1d, 1d5h, 1w. |
| `start-demote` | The time to wait after the last update before the data is copied from the SSD and sent to the object store.Format: 3s, 2h, 4m, 1d, 1d5h, 1w. |

## Remove a filesystem group

**Command:** `weka fs group remove`

Use the following command line to delete a filesystem group:

`weka fs group remove <name>`

**Parameters**

| Name | Value |
| --- | --- |
| `name`* | Name of the filesystem group to delete |

**Related topics**

To learn about the tiering policy, see:

[tiering.md](../tiering.md "mention")
