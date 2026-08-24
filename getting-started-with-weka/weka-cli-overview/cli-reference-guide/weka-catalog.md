---
description: Manage the data catalog service and indexed filesystem metadata.
---

# weka catalog

Manage the Data Catalog service and indexed filesystem data.

```sh
weka catalog
```

## weka catalog cluster

Manage the catalog cluster infrastructure and status.

```sh
weka catalog cluster
```

### weka catalog cluster add

Create a catalog cluster.

```sh
weka catalog cluster add <indexfs> [--all-servers] [--containers <container-ids>…]
```

| Parameter                        | Description                                                                                                                                               |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `indexfs`\*                      | Name of the filesystem to store the catalog metadata.                                                                                                     |
| `--all-servers`                  | Use all dataservice containers to form the catalog cluster.                                                                                               |
| `--containers` \<container-ids>… | Dataservice containers that will be used to form the catalog cluster. Multiple values may be supplied separated by commas, or the option may be repeated. |

### weka catalog cluster remove

Destroy the catalog cluster.

```sh
weka catalog cluster remove [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka catalog cluster status

Get catalog cluster status.

```sh
weka catalog cluster status
```

**Columns:** `servicename`, `id`, `hostname`, `container`, `ip`, `status`, `role`

### weka catalog cluster update

Update an existing catalog cluster.

```sh
weka catalog cluster update [--add-containers <container-ids>…] [--remove-containers <container-ids>…]
```

| Parameter                               | Description                                                                                                                                          |
| --------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--add-containers` \<container-ids>…    | Add specific dataservice containers to the catalog cluster. Multiple values may be supplied separated by commas, or the option may be repeated.      |
| `--remove-containers` \<container-ids>… | Remove specific dataservice containers from the catalog cluster. Multiple values may be supplied separated by commas, or the option may be repeated. |

## weka catalog config

Manage the configuration settings for the Data Catalog service.

```sh
weka catalog config
```

### weka catalog config show

View the current catalog cluster settings and indexing policies.

```sh
weka catalog config show
```

**Columns:** `index_enabled`, `index_filesystem`, `coordinator`, `coordinator_ip`, `port`, `index_interval`, `retention_period`, `max_ingest_tasks`

### weka catalog config update

Update catalog configuration including index policy.

```sh
weka catalog config update [--index-enabled] [--index-interval <duration>] [--max-ingest-tasks <uint16>] [--retention-period <duration>]
```

| Parameter                        | Description                                                                                                    |
| -------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `--index-enabled`                | Enable or disable catalog indexing.                                                                            |
| `--index-interval` \<duration>   | Index task execution interval. Default: 1 day. Supports time units: s (seconds), m (minutes), h (hours).       |
| `--max-ingest-tasks` \<uint16>   | Maximum number of ingest tasks that can run in parallel (default: 2).                                          |
| `--retention-period` \<duration> | Retention period for index snapshots. Default: 30 days. Supports time units: m (minutes), h (hours), d (days). |

## weka catalog fs

Manage filesystem catalog status and metadata.

```sh
weka catalog fs
```

### weka catalog fs status

Show which filesystems have catalog enabled, which have metadata, last ingested time, and last ingest task errors.

```sh
weka catalog fs status
```

**Columns:** `name`, `indexing`, `metadata`, `snapshots`, `latest`, `oldest`, `last_ingest`, `error`

## weka catalog metadata

Manage catalog metadata on a per-filesystem basis.

```sh
weka catalog metadata
```

### weka catalog metadata delete

Delete catalog metadata for a filesystem.

```sh
weka catalog metadata delete <fs-name> [--force]
```

| Parameter       | Description                                                     |
| --------------- | --------------------------------------------------------------- |
| `fs-name`\*     | Filesystem name.                                                |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |

### weka catalog metadata show

Show ingestion history for a filesystem.

```sh
weka catalog metadata show <fs-name>
```

| Parameter   | Description      |
| ----------- | ---------------- |
| `fs-name`\* | Filesystem name. |

**Columns:** `seq`, `snap`, `access`, `snaptime`, `ref`, `start`, `done`, `task`, `events_id`, `view_id`, `fsmeta_id`, `metrics_id`
