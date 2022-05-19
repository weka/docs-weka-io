---
description: This pages describes how to view and manage filesystem groups using the CLI.
---

# Manage filesystem groups using the CLI

Using the CLI, you can perform the following actions:

* View filesystem groups
* Add filesystem groups
* Edit filesystem groups
* Delete filesystem groups

### **View filesystem groups**

**Command:** `weka fs group`

Use this command to view information on the filesystem groups in the Weka system.

### Add a filesystem group

**Command:** `weka fs group create`

Use the following command to add a filesystem group:

`weka fs group create <name> [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters in Command Line**

| **Name**               | **Type** | **Value**                                                               | **Limitations**        | **Mandatory** | **Default**      |
| ---------------------- | -------- | ----------------------------------------------------------------------- | ---------------------- | ------------- | ---------------- |
| `name`                 | String   | Name of the filesystem group being created                              | Must be a valid name   | Yes           | ​                |
| `target-ssd-retention` | Number   | Target retention period (in seconds) before tiering to the object store | Must be a valid number | No            | 86400 (24 hours) |
| `start-demote`         | Number   | Target tiering cue (in seconds) before tiering to the object store      | Must be a valid number | No            | 10               |

### Edit a filesystem group

**Command:** `weka fs group update`

Use the following command to edit a filesystem group:

`weka fs group update <name> [--new-name=<new-name>] [--target-ssd-retention=<target-ssd-retention>] [--start-demote=<start-demote>]`

**Parameters in Command Line**

| **Name**               | **Type** | **Value**                                                                   | **Limitations**        | **Mandatory** | **Default** |
| ---------------------- | -------- | --------------------------------------------------------------------------- | ---------------------- | ------------- | ----------- |
| `name`                 | String   | Name of the filesystem group being edited                                   | Must be a valid name   | Yes           | ​           |
| `new-name`             | String   | New name for the filesystem group                                           | Must be a valid name   | Yes           |             |
| `target-ssd-retention` | Number   | New target retention period (in seconds) before tiering to the object store | Must be a valid number | No            |             |
| `start-demote`         | Number   | New target tiering cue (in seconds) before tiering to the object store      | Must be a valid number | No            |             |

### Delete a filesystem group

**Command:** `weka fs group delete`

Use the following command line to delete a filesystem group:

`weka fs group delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value**                              | **Limitations**      | **Mandatory** | **Default** |
| -------- | -------- | -------------------------------------- | -------------------- | ------------- | ----------- |
| `name`   | String   | Name of the filesystem group to delete | Must be a valid name | Yes           | ​           |

**Related topics**

To learn about the tiring policy, see [Advanced Data Lifecycle Management](https://docs.weka.io/v/3.14/fs/tiering).
