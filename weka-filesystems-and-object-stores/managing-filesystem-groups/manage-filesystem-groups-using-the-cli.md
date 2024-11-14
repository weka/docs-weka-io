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

<table><thead><tr><th width="273">Name</th><th width="395.3333333333333">Value</th><th>Default</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Set a meaningful name for the filesystem group.</td><td>​</td></tr><tr><td><code>target-ssd-retention</code></td><td>The time for keeping data on the SSD after it is copied to the object store. After this period, the copy of the data is deleted from the SSD.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</td><td>1d</td></tr><tr><td><code>start-demote</code></td><td>The time to wait after the last update before the data is copied from the SSD and sent to the object store.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</td><td>10s</td></tr></tbody></table>

## Edit a filesystem group

**Command:** `weka fs group update`

Use the following command to edit a filesystem group:

`weka fs group update <name> [--new-name=<new-name>] [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

<table><thead><tr><th width="291.43669250645996">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the filesystem group to edit.<br>It must be a valid name.</td></tr><tr><td><code>new-name</code></td><td>New name for the filesystem group.</td></tr><tr><td><code>target-ssd-retention</code></td><td>The time for keeping data on the SSD after it is copied to the object store. After this period, the copy of the data is deleted from the SSD.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</td></tr><tr><td><code>start-demote</code></td><td>The time to wait after the last update before the data is copied from the SSD and sent to the object store.<br>Format: 3s, 2h, 4m, 1d, 1d5h, 1w.</td></tr></tbody></table>

## Delete a filesystem group

**Command:** `weka fs group delete`

Use the following command line to delete a filesystem group:

`weka fs group delete <name>`

**Parameters**

<table><thead><tr><th width="295">Name</th><th>Value</th></tr></thead><tbody><tr><td><code>name</code>*</td><td>Name of the filesystem group to delete</td></tr></tbody></table>

**Related topics**

To learn about the tiring policy, see:

[tiering](../tiering/ "mention")
