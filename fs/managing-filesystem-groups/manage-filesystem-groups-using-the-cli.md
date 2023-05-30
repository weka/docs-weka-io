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

| **Name**               | **Type** | **Value**                                                               | **Limitations**        | **Mandatory** | **Default**      |
| ---------------------- | -------- | ----------------------------------------------------------------------- | ---------------------- | ------------- | ---------------- |
| `name`                 | String   | Name of the filesystem group being created                              | Must be a valid name   | Yes           | ​                |
| `target-ssd-retention` | Number   | Target retention period (in seconds) before tiering to the object store | Must be a valid number | No            | 86400 (24 hours) |
| `start-demote`         | Number   | Target tiering cue (in seconds) before tiering to the object store      | Must be a valid number | No            | 10               |

## Edit a filesystem group

**Command:** `weka fs group update`

Use the following command to edit a filesystem group:

`weka fs group update <name> [--new-name=<new-name>] [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters**

<table data-header-hidden><thead><tr><th width="187">Name</th><th width="168">Type</th><th>Value</th><th>Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code></td><td>String</td><td>Name of the filesystem group being edited</td><td>Must be a valid name</td><td>Yes</td><td>​</td></tr><tr><td><code>new-name</code></td><td>String</td><td>New name for the filesystem group</td><td>Must be a valid name</td><td>Yes</td><td></td></tr><tr><td><code>target-ssd-retention</code></td><td>Number</td><td>New target retention period (in seconds) before tiering to the object store</td><td>Must be a valid number</td><td>No</td><td></td></tr><tr><td><code>start-demote</code></td><td>Number</td><td>New target tiering cue (in seconds) before tiering to the object store</td><td>Must be a valid number</td><td>No</td><td></td></tr></tbody></table>

## Delete a filesystem group

**Command:** `weka fs group delete`

Use the following command line to delete a filesystem group:

`weka fs group delete <name>`

**Parameters**

<table data-header-hidden><thead><tr><th>Name</th><th>Type</th><th>Value</th><th width="200">Limitations</th><th>Mandatory</th><th>Default</th></tr></thead><tbody><tr><td><strong>Name</strong></td><td><strong>Type</strong></td><td><strong>Value</strong></td><td><strong>Limitations</strong></td><td><strong>Mandatory</strong></td><td><strong>Default</strong></td></tr><tr><td><code>name</code></td><td>String</td><td>Name of the filesystem group to delete</td><td>Must be a valid name</td><td>Yes</td><td>​</td></tr></tbody></table>

**Related topics**

To learn about the tiring policy, see:

[tiering](../tiering/ "mention")
