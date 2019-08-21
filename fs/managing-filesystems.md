---
description: >-
  This page describes how to view and manage filesystems, filesystem groups and
  object stores using the GUI and the CLI.
---

# Managing Filesystems, Object Stores & Filesystem Groups

## Viewing Filesystems and Filesystem Groups

#### Viewing Filesystems / Filesystem Groups Using the GUI

The main filesystem screen in the GUI contains information about the filesystems and filesystem groups, including names, tiering status, encryption status, total capacity and used capacity.

![Main Filesystem / Filesystem Group View Screen](../.gitbook/assets/view-fs_fsg-screen.jpg)

#### Viewing Filesystems / Filesystem Groups Using the CLI

**Command:** `weka fs` or `weka fs group`

These commands are used to view the filesystems \(`weka fs`\) or filesystem groups \(`weka fs group`\). To perform this operation, use the following command lines:

`weka fs`or `weka fs group`

## Managing Object Stores

### Viewing Object Stores

#### Viewing Object Stores Using the GUI

The main object store screen in the GUI lists all existing object stores and can also display information  about a specific object store, including the object store name, status and region.

![Main Object Store View Screen](../.gitbook/assets/view-os-screen.jpg)

####  Viewing Object Stores Using the CLI

**Command:** `weka fs tier s3`

This command is used to view information on all the object stores configured to the WekaIO system. 

### Adding an Object Store

#### Adding an Object Store Using the GUI

From the main object store view screen, click the "+" button at the top left-hand side of the screen. The Configure Object Store dialog box will be displayed.

![Configure Object Store Dialog Box](../.gitbook/assets/configure-os-dialog-box.jpg)

Enter the relevant parameters and click Configure to create the object store.

If the object store is misconfigured, the Error in Object Store Configuration window will be displayed.

![Object Store Configuration Error Window](../.gitbook/assets/os-configuration-error-window%20%281%29.jpg)

 Click Save Anyway in order to save the configured object store.

####  Adding an Object Store Using the CLI

**Command:** `weka fs tier s3 add`

Use the following command line to add an object store:

`weka fs tier s3 add <name> [--hostname=<host>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the object store being created | Must be a valid name | Yes | ​ |
| `hostname` | String | The object store host identifier | Must be a valid name/IP | Yes |  |
| `port` | String | The object store port | Must be a valid name | Yes |  |
| `bucket` | Number | The object store bucket ID | Must be a valid name | Yes |  |
| `auth-method` | String | Authentication method | None, AWSSignature2 or AWSSignature4 | Yes |  |
| `region` | String | Region name |  | Yes |  |
| `access-key-id` | String | The object store access key ID |  | Yes \(can be left empty when using IAM role in AWS\) |  |
| `secret-key` | String | The object store secret key |  | Yes \(can be left empty when using IAM role in AWS\) |  |
| `bandwidth` | Number | Bandwidth limitation per core \(Mbps\) |  | No |  |
| `errors-timeout` | Number | If the OBS link is down for longer than this, all IOs that need data return with an error | 1-15 minutes, e.g: 5m or 300s | No | 300 |
| `prefetch-mib` | Number | How many MiB of data to prefetch when reading a whole MiB on object store |  | No | 0 |
| `max-concurrent-downloads` | Number | Maximum number of downloads we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |
| `max-concurrent-uploads` | Number | Maximum number of uploads we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |
| `max-concurrent-removals` | Number | Maximum number of removals we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |

{% hint style="info" %}
**Note:** By default, when using the CLI, a misconfigured object store will not be created. To create the object store even when it is misconfigured, use the option `--skip-verification`.
{% endhint %}

### Editing an Object Store

#### Editing an Object Store Using the GUI

From the main object store view screen, click the Edit button of the object store to be edited.

![Edit Object Store Screen](../.gitbook/assets/edit-os-screen.jpg)

The Update Object Store dialog box \(which is similar to the Configure Object Store dialog box\) will be displayed with the current specifications for the object store.

![Update Object Store Dialog Box](../.gitbook/assets/edit-os-dialog-box.jpg)

Make the relevant changes and click Update to update the object store.

#### Editing an Object Store Using the CLI

**Command:** `weka fs tier s3 update`

Use the following command line to edit an object store:

`weka fs tier s3 update <name> [--new-name=<new-name>] [--hostname=<host>] [--port=<port> [--bucket=<bucket>] [--auth-method=<auth-method>] [--region=<region>] [--access-key-id=<access-key-id>] [--secret-key=<secret-key>] [--protocol=<protocol>] [--bandwidth=<bandwidth>] [--errors-timeout=<errors-timeout>] [--prefetch-mib=<prefetch-mib>] [--max-concurrent-downloads=<max-concurrent-downloads>] [--max-concurrent-uploads=<max-concurrent-uploads>] [--max-concurrent-removals=<max-concurrent-removals>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the object store being edited | Must be a valid name | Yes | ​ |
| `new-name` | String  | The new name for the object store | Must be a valid name | No |  |
| `hostname` | String | The object store host identifier | Must be a valid name/IP | Yes |  |
| `port` | String | The object store port | Must be a valid name | Yes |  |
| `bucket` | String | The object store bucket name | Must be a valid name | Yes |  |
| `auth-method` | String | Authentication method | None, AWSSignature2 or AWSSignature4 | Yes |  |
| `region` | String | Region name |  | Yes |  |
| `access-key-id` | String | The object store access key ID |  | Yes \(can be left empty when using IAM role in AWS\) |  |
| `secret-key` | String | The object store secret key |  | Yes \(can be left empty when using IAM role in AWS\) |  |
| `bandwidth` | Number | Bandwidth limitation per core \(Mbps\) |  | No |  |
| `errors-timeout` | Number | If the OBS link is down for longer than this, all IOs that need data return with an error | 1-15 minutes, e.g: 5m or 300s | No | 300 |
| `prefetch-mib` | Number | How many MiB of data to prefetch when reading a whole MiB on object store |  | No | 0 |
| `max-concurrent-downloads` | Number | Maximum number of downloads we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |
| `max-concurrent-uploads` | Number | Maximum number of uploads we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |
| `max-concurrent-removals` | Number | Maximum number of removals we concurrently perform on this object store in a single IO node | 1-64 | No | 64 |

### Deleting an Object Store

#### Deleting an Object Store Using the GUI

From the main object store view screen, click the Delete button of the object store to be deleted.

![Delete Object Store Screen](../.gitbook/assets/delete-os-screen.jpg)

The Deletion of Object Store window will be displayed.  

![Deletion of Object Store Window](../.gitbook/assets/delete-os-window.jpg)

Click Yes to delete the object store.

#### Deleting an Object Store Using the CLI

**Command:** `weka fs tier s3 delete`

Use the following command line to delete an object store:

 `weka fs tier s3 delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the object store being deleted | Must be a valid name | Yes | ​ |

## Managing Filesystem Groups

### Adding a Filesystem Group

#### Adding a Filesystem Group Using the GUI

From the main filesystem / filesystem group view screen, click the Add Group button at the top left-hand side of the screen. The Add Filesystem group screen will be displayed.

![Add Filesystem Group Screen](../.gitbook/assets/fsg-add-screen.jpg)

The Create Filesystem Group dialog box will be displayed.

![Create Filesystem Group Dialog Box](../.gitbook/assets/fsg-create-dialog-box.jpg)

Enter the relevant parameters and click Create to create the filesystem group.

**Command:** `weka fs group create`

Use one of the following command lines to add a filesystem group:

#### Adding a Filesystem Group Using the CLI

For a non-tiered filesystem group:

`weka fs group create <name>`

 For a tiered filesystem group:

`weka fs group create <name> --is-tiered=yes --storage=<object-store-name> [--target-ssd-retention=<retention>] [--start-demote=<demote>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem group being created | Must be a valid name | Yes | ​ |
| `storage` | String | The ID of the object store for storage | Must be a valid name | Yes |  |
| `target-ssd-retention` | Number | The target retention period \(in seconds\) before tiering to the object store | Must be a valid number | No | 86400 \(24 hours\) |
| `start-demote` | Number | The target tiering cue \(in seconds\) before tiering to the object store. | Must be a valid number | No | 10 |

### Editing a Filesystem Group

#### Editing an Existing Filesystem Group Using the GUI

Click the Edit button of the filesystem group to be modified. The Configure Filesystem Group dialog box will be displayed.

![Configure Filesystem Group Dialog Box](../.gitbook/assets/fsg-edit-dialog-box.jpg)

A more in-depth explanation of the tiring policy appears in [Advanced Data Lifecycle Management](tiering.md).

Edit the existing filesystem group parameters and click Configure to execute the changes.

#### Editing an Existing Filesystem Group Using the CLI

**Command:** `weka fs group update --is-tiered`

Use one of the following command lines to edit a filesystem group:

For a non-tiered filesystem group:

`weka fs group update <name> [--new-name=<new-name>]`

To add a tier to a filesystem group:

`weka fs group update <name> <storage> [--new-name=<new-name>] --is-tiered=yes --storage=<object-store-name> [--target-ssd-retention=<retention>] [--start-demote=<demote>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem group being edited | Must be a valid name | Yes | ​ |
| `new-name` | String | The new name for the filesystem group | Must be a valid name | Yes |  |
| `storage` | String | The ID of the object store for storage | Must be a valid name | Yes |  |
| `target-ssd-retention` | Number | The new target retention period \(in seconds\) before tiering to the object store | Must be a valid number | No |  |
| `start-demote` | Number | The new target tiering cue \(in seconds\) before tiering to the object store | Must be a valid number | No |  |

### Deleting a Filesystem Group

#### Deleting a Filesystem Group Using the GUI

{% hint style="info" %}
**Note:** Before deleting a filesystem group, verify that it does not contain any filesystems. If it contains filesystems, first delete the filesystems.
{% endhint %}

Select the filesystem group to be deleted in the main filesystem / filesystem group view screen and click the Delete button below the group. The filesystem group deletion dialog box is displayed.

![Filesystem Group Deletion Dialog Box](../.gitbook/assets/fsg-deletion-dialog-box.jpg)

Click Yes to delete the filesystem group.

#### Deleting a Filesystem Group Using the CLI

**Command:** `weka fs group delete`

Use the following command line to delete a filesystem group:

`weka fs group delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem group to be deleted | Must be a valid name | Yes | ​ |

## Managing Filesystems

{% hint style="info" %}
**Note:**  The following sections describe how to add, edit and delete filesystems using the GUI and CLI.
{% endhint %}

### Adding a Filesystem

#### Adding a Filesystem Using the GUI

From the main filesystem / filesystem group view screen, click the Add Filesystem button at the top right-hand side of the screen. The Add Filesystem screen will be displayed.

![Add Filesystem Screen](../.gitbook/assets/add-filesystem-screen.jpg)

The Create Filesystem dialog box will be displayed.

![Create Filesystem Dialog Box](../.gitbook/assets/create-filesystem-screen.jpg)

Enter the relevant parameters and click Create to create the filesystem.

#### Adding a Filesystem Using the CLI

**Command:** `weka fs create`

Use the following command line to add a filesystem:

`weka fs create <name> <group-name> <total-capacity> [--ssd-capacity <ssd>] [--max-files <max-files>] [--filesystem-id <id>] [encrypted <encrypted>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem being created | Must be a valid name | Yes | ​ |
| `group-name` | String | The name of the filesystem group to which the new filesystem is to be connected | Must be a valid name | Yes |  |
| `total-capacity` | Number | The total capacity of the new filesystem; options are SSD capacity \(`ssd-capacity <ssd>`\), the filesystem ID \(`filesystem-id <id>`\) or a value that correlates with the percentage of SSD capacity from the total SSD capacity for the cluster \(`max-files <max-files>`\) | Must be a valid number | Yes |  |
| `ssd-capacity` | Number | For tiered filesystems, this is the SSD capacity. If not specified, the filesystem is pinned to SSD | Must be a valid number | No | SSD capacity will be set to total capacity |
| `max-files` | Number | Metadata allocation for this filesystem | Must be a valid number | No | Automatically calculated by the system based on the SSD capacity |
| `encrypted` | Boolean | Encryption of filesystem | Yes/No | No | No |

### Editing a Filesystem

#### Editing an Existing Filesystem Using the GUI

Select the filesystem to be modified in the main filesystem / filesystem group view screen and click the Edit button.

![Edit Filesystem Screen](../.gitbook/assets/edit-fs-screen.jpg)

 The Configure Filesystem dialog box will be displayed.

![Configure Filesystem Dialog Box](../.gitbook/assets/configure-fs-screen.jpg)

Edit the existing filesystem parameters and click Configure to execute the changes.

{% hint style="info" %}
**Note:** It is not possible to change the encryption configuration of a filesystem.
{% endhint %}

#### Editing an Existing Filesystem Using the CLI

**Command:** `weka fs update`

Use the following command line to edit an existing filesystem:

`weka fs update <name> [--new-name=<new-name>] [--total-capacity=<total>] [--ssd-capacity=<ssd>] [--max-files=<max-files>]`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem being edited | Must be a valid name | Yes | ​ |
| `new-name` | String | The new name for the filesystem | Must be a valid name | Optional | Keep unchanged |
| `total` | Number | The total capacity of the edited filesystem | Must be a valid number | Optional | Keep unchanged |
| `ssd` | Number | The SSD capacity of the edited filesystem | Must be a valid number | Optional | Keep unchanged |
| `max-files` | Number | The metadata limit for the filesystem | Must be a valid number | Optional | Keep unchanged |

### Deleting a Filesystem

#### Deleting a Filesystem Using the GUI

Select the filesystem to be deleted in the main filesystem / filesystem group view screen and click the Delete button.

![Filesystem Delete Screen](../.gitbook/assets/fs-delete-screen.jpg)

Then confirm the filesystem deletion by click Yes in the Filesystem Deletion dialog box.

![Filesystem Deletion Dialog Box](../.gitbook/assets/fs-deletion-dialog-box.jpg)

#### Deleting a Filesystem Using the CLI

**Command:** `weka fs delete`

Use the following command line to delete a filesystem:

`weka fs delete <name>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `name` | String | The name of the filesystem to be deleted | Must be a valid name | Yes |  |

