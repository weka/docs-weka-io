---
description: Manage cross-cluster replication links and filesystem replication pairs.
---

# weka replication

Set up and manage cross-cluster replication on this cluster: links to remote clusters, and the filesystem pairs replicated over them.

```sh
weka replication
```

## weka replication fs-pair

List replication pairs with their current state and progress, both the pairs this cluster drives and the read-only mirrors of ones replicating into it.

```sh
weka replication fs-pair
```

**Columns:** `id`, `uid`, `state`, `role`, `source`, `link`, `link-id`, `target`, `interval`, `snapshots-to-keep`, `apply`, `access`, `copy`, `copy-paths`, `last-replication`, `current-status`, `last-error`, `last-error-time`

### weka replication fs-pair add

Create a new replication pair between a local filesystem and a filesystem on a linked cluster.

```sh
weka replication fs-pair add --interval <duration> --source-filesystem <filesystem> --target-filesystem <filesystem> [--access-strategy <access-strategy>] [--apply-strategy <apply-strategy>] [--copy-path <path>…] [--link-id <cluster-link-id>] [--now] [--snapshots-to-keep <count>] [--target-total-capacity <capacity>]
```

| Parameter | Description |
| --------- | ----------- |
| `--interval` &lt;duration&gt;* | Replication interval (e.g. 5m, 1h). Range: 5 minutes to 30 days. |
| `--source-filesystem` &lt;filesystem&gt;* | Name of the local source filesystem. |
| `--target-filesystem` &lt;filesystem&gt;* | Name of the filesystem on the remote cluster. |
| `--access-strategy` &lt;access-strategy&gt; | When users see the target filesystem: INSTANT_ACCESS (default) exposes the snapshot immediately and fetches data lazily; COPY_FIRST blocks the apply until --copy-path data is local. Valid values: instant_access, copy_first. |
| `--apply-strategy` &lt;apply-strategy&gt; | When the snapshot becomes visible on the target. AUTOMATIC (the default, and the only value supported in this release) applies it as soon as the prerequisite phase finishes. Valid value: automatic. |
| `--copy-path` &lt;path&gt;… | Eager-copy path. Keywords: 'full', 'all' or '/' for full copy; 'none' or 'null' for no eager copy. Default: no eager copy. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--link-id` &lt;cluster-link-id&gt; | ID of the cluster link to replicate over, as shown by 'weka cluster link'. |
| `--now` | Trigger the first replication cycle immediately instead of waiting one full interval. |
| `--snapshots-to-keep` &lt;count&gt; | Number of snapshots to retain. Default: 3. Range: 2 to 25. |
| `--target-total-capacity` &lt;capacity&gt; | Total capacity for the target filesystem (default: same as the source filesystem). A smaller target is allowed for partial or no eager copy (--copy-path); full copy requires at least the source size. |

### weka replication fs-pair fetch

Asynchronously fetch a file's lazy-data blocks from the source cluster. The fetch runs in the background; use 'weka fs replication hydration status' to monitor progress. Accepts either a local mount path or --filesystem NAME with an FS-relative path.

```sh
weka replication fs-pair fetch <path> [--filesystem <filesystem>] [--snapshot <snapshot>]
```

| Parameter | Description |
| --------- | ----------- |
| `path`* | Path to fetch. |
| `--filesystem` &lt;filesystem&gt; | Filesystem name; the positional path is treated as FS-relative. |
| `--snapshot` &lt;snapshot&gt; | Snapshot name; resolve path within this snapshot view instead of the live root. |

### weka replication fs-pair hydration

Per-file replication hydration commands.

```sh
weka replication fs-pair hydration
```

#### weka replication fs-pair hydration status

Show replication hydration status for a given file path: how much of the file is locally available and how much is still pending on the source cluster (lazy-data blocks not yet prefetched).

```sh
weka replication fs-pair hydration status <path> [--filesystem <filesystem>] [--snapshot <snapshot>]
```

| Parameter | Description |
| --------- | ----------- |
| `path`* | Path to get replication hydration status for. |
| `--filesystem` &lt;filesystem&gt; | Filesystem name; the positional path is treated as FS-relative. |
| `--snapshot` &lt;snapshot&gt; | Snapshot name; resolve path within this snapshot view instead of the live root. |

**Columns:** `path`, `type`, `size`, `local`, `pending`, `progress`, `status`

### weka replication fs-pair pause

Pause an active replication pair.

```sh
weka replication fs-pair pause <id>
```

| Parameter | Description |
| --------- | ----------- |
| `id`* | Replication pair ID. |

### weka replication fs-pair release

Asynchronously return a file's data blocks to lazy mode. The release runs in the background; use 'weka fs replication hydration status' to monitor progress.

```sh
weka replication fs-pair release
```

### weka replication fs-pair remove

Remove an existing replication pair.

```sh
weka replication fs-pair remove <id> [--force] [--local-only]
```

| Parameter | Description |
| --------- | ----------- |
| `id`* | Replication pair ID. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--local-only` | Remove the pair on this cluster only, leaving the remote cluster untouched. Use when the remote cluster is unreachable or gone; it is also the only way to remove an incoming pair. |

### weka replication fs-pair resume

Resume a paused replication pair.

```sh
weka replication fs-pair resume <id>
```

| Parameter | Description |
| --------- | ----------- |
| `id`* | Replication pair ID. |

### weka replication fs-pair update

Update an existing replication pair's configuration.

```sh
weka replication fs-pair update <id> [--access-strategy <access-strategy>] [--add-copy-path <path>…] [--apply-strategy <apply-strategy>] [--copy-path <path>…] [--interval <duration>] [--remove-copy-path <path>…] [--snapshots-to-keep <count>]
```

| Parameter | Description |
| --------- | ----------- |
| `id`* | Replication pair ID. |
| `--access-strategy` &lt;access-strategy&gt; | When users see the target filesystem: INSTANT_ACCESS or COPY_FIRST. Valid values: instant_access, copy_first. |
| `--add-copy-path` &lt;path&gt;… | Add a path to a PARTIAL copy set (repeatable). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--apply-strategy` &lt;apply-strategy&gt; | When the snapshot becomes visible on the target. AUTOMATIC is the only value supported in this release. Valid value: automatic. |
| `--copy-path` &lt;path&gt;… | Replace the entire copy set. Keywords: 'full', 'all' or '/' for full copy; 'none' or 'null' to clear. Mutually exclusive with --add-copy-path/--remove-copy-path. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--interval` &lt;duration&gt; | Replication interval (e.g. 5m, 1h). Range: 5 minutes to 30 days. |
| `--remove-copy-path` &lt;path&gt;… | Remove a path from a PARTIAL copy set (repeatable). Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--snapshots-to-keep` &lt;count&gt; | Number of snapshots to retain. Default: 3. Range: 2 to 25. |

## weka replication link

List and manage links to remote clusters for cross-cluster replication. Both clusters need an S3 cluster configured. Per-filesystem replication pairs are managed under 'weka fs replication'.

```sh
weka replication link [--link-id <cluster-link-id>] [--name <cluster-link>]
```

| Parameter | Description |
| --------- | ----------- |
| `--link-id` &lt;cluster-link-id&gt; | Show only the cluster link with this ID. |
| `--name` &lt;cluster-link&gt; | Show only cluster links with this name. Names can repeat, so more than one link may match. |

**Columns:** `id`, `uid`, `name`, `peer_guid`, `connection_status`, `pairing_status`, `mgmtIps`, `data_ips`, `data_port`

### weka replication link add

Link this cluster to a remote one for cross-cluster replication. Creates the link on both clusters, and may be run from either. Both must have an S3 cluster and a cluster name set — the link is named after the cluster at the other end.

```sh
weka replication link add --peer-host <hostname> --username <string> [--auto-accept-peer-cert] [--fingerprint <string>] [--password <string>] [--peer-port <port>]
```

| Parameter | Description |
| --------- | ----------- |
| `--peer-host` &lt;hostname&gt;* | Management hostname or IP of the cluster to link to. |
| `--username` &lt;string&gt;* | Cluster admin username on the peer cluster. |
| `--auto-accept-peer-cert` | Accept whatever TLS certificate the peer presents, without confirming its fingerprint. The certificate is still pinned and checked on every later connection. |
| `--fingerprint` &lt;string&gt; | Expected SHA256 fingerprint of the peer's TLS certificate (colon-separated hex), shown by 'weka security tls status' on the peer cluster. |
| `--password` &lt;string&gt; | Password for --username. Alternatively use the WEKA_PEER_PASSWORD env variable or the interactive prompt. |
| `--peer-port` &lt;port&gt; | Management API port of the peer cluster (default 14000). |

### weka replication link refresh

Refresh a cluster link: both clusters re-read each other's replication configuration.

```sh
weka replication link refresh <link-id> [--peer-host <hostname>] [--peer-port <port>]
```

| Parameter | Description |
| --------- | ----------- |
| `link-id`* | ID of the cluster link to refresh. |
| `--peer-host` &lt;hostname&gt; | Management hostname or IP to reach the peer on for this run, when its recorded addresses no longer do. Not stored. |
| `--peer-port` &lt;port&gt; | Management API port to reach the peer on for this run, when its recorded port no longer does. Not stored. |

### weka replication link remove

Remove a cluster link. Both clusters drop the link, so it need only be run from one of them. Per-filesystem replication pairs using the link must be removed first.

```sh
weka replication link remove <link-id> [--force] [--local-only]
```

| Parameter | Description |
| --------- | ----------- |
| `link-id`* | ID of the cluster link to remove. |
| `-f`, `--force` | Force action. Perform this action without further confirmation. |
| `--local-only` | Remove only this cluster's link, leaving the peer's in place. Use it to clear a link left on one side by a failed add, or when the peer is unreachable. |

