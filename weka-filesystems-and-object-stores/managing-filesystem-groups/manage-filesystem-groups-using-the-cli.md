---
description: View, create, edit, and remove filesystem groups using the CLI.
---

# Manage filesystem groups using the CLI

## View filesystem groups

Lists the filesystem groups on the cluster with the SSD retention and demote timers each one applies.

**Command:** `weka fs group`

```sh
weka fs group
```

## Add a filesystem group

Creates a filesystem group. The retention and demote timers set here govern when the filesystems in the group release SSD data to the object store.

**Command:** `weka fs group add`

```sh
weka fs group add <name> [--ssd-retention <duration>] [--start-demote <duration>]
```

**Parameters**

| Parameter                     | Description                                             |
| ----------------------------- | ------------------------------------------------------- |
| `name`\* | Name of the filesystem group. |
| `--ssd-retention` \<duration> | How long to keep an SSD copy of the data. |
| `--start-demote` \<duration> | How long to wait before copying data to object storage. |

## Edit a filesystem group

Changes a filesystem group's name or its SSD retention and demote timers.

**Command:** `weka fs group update`

```sh
weka fs group update <name> [--new-name <filesystem-group>] [--ssd-retention <duration>] [--start-demote <duration>]
```

**Parameters**

| Parameter                        | Description                                             |
| -------------------------------- | ------------------------------------------------------- |
| `name`\* | Name of the filesystem group. |
| `--new-name` \<filesystem-group> | Rename the filesystem group. |
| `--ssd-retention` \<duration> | How long to keep an SSD copy of the data. |
| `--start-demote` \<duration> | How long to wait before copying data to object storage. |

## Remove a filesystem group

Removes a filesystem group from the cluster.

**Command:** `weka fs group remove`

```sh
weka fs group remove <name>
```

**Parameters**

| Parameter | Description                   |
| --------- | ----------------------------- |
| `name`\* | Name of the filesystem group. |
