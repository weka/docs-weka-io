---
description: >-
  Configure, operate, and recover asynchronous replication between NeuralMesh
  clusters.
---

# Manage asynchronous replication

All procedures require ClusterAdmin privileges. Manage asynchronous replication through this workflow:

1. Prepare the S3 transport infrastructure.
2. Establish trust between the clusters.
3. Create a replication pair.

After you create a pair, use the on-demand procedures to monitor, modify, pause, or remove replication, manage file hydration, and fail over to the target site.

## Set up and prepare for replication

Prepare both clusters with the S3 infrastructure that asynchronous replication uses as its transport layer.

Replication transfers data through the S3 infrastructure of the clusters. The object store bucket serves as a transport mechanism only and does not store the replicated data.

**Before you begin**

Ensure the clusters can reach each other over the network.

### What `weka cluster peer init` provisions

You do not set up the S3 transport by hand. Running `weka cluster peer init` provisions
everything replication needs on that cluster: the S3 service, the replication user and
bucket, and the object store filesystem (default: `weka-repl-fs`).

The only decision is which containers serve the S3 traffic:

* To create a new S3 cluster from all backend servers, run `weka cluster peer init --all-servers`.
* To reuse an existing S3 cluster, pass its containers with `weka cluster peer init --container <container-ids>`.

The two options are mutually exclusive.

The local object store tier that replication uses is created automatically when you register a cluster peer. The default tier name is `<peer name>-obs`. It stores the peer cluster's replication S3 credentials.

**Related topics**

[Manage the S3 protocol](https://docs.weka.io/additional-protocols/s3)

[User management](https://docs.weka.io/operation-guide/user-management)

[Manage object stores](https://docs.weka.io/weka-filesystems-and-object-stores/managing-object-stores)

## Establish trust between clusters

Establish a trust relationship between two NeuralMesh clusters so they can authenticate each other and replicate filesystems.

Trust is established by a token exchange: you generate a pairing token on one cluster and register it on the peer cluster. Replication requires mutual trust, so you perform the exchange in both directions. There is no one-directional trust — until both sides have registered each other, the pairing is incomplete.

**Before you begin**

Complete the preceding S3 transport setup on both clusters.

**Procedure**

1. Generate a pairing token on site A:

```bash
weka cluster peer init
```

2. Register site A as a peer on site B. Provide a name for the peer and paste the token from the previous step:

```bash
weka cluster peer add siteA <token>
```

Registering a peer also creates the local object store tier that replication uses (default name: `<peer name>-obs`). Optional flags override individual fields from the decoded token, such as `--join-ips`, `--s3-hostnames`, `--s3-bucket`, `--s3-port`, `--http-port`, `--guid`, and `--obs-tier-name`. Use `--dry-run` to test the command without affecting the system.

3. Generate a pairing token on site B:

```bash
weka cluster peer init
```

4. Register the token on site A:

```bash
weka cluster peer add siteB <token>
```

5. Verify the peer status on either cluster:

```bash
weka cluster peer
```

**Example output:**

**After step 2 — site B knows site A, but site A does not yet know site B. The pairing is incomplete:**

```
╭────┬───────┬─────────────────────────┬───────────────┬────────────┬────────────┬───────────────────────╮
│ ID │ Name  │ Peer Cluster GUID       │ OBS Bucket ID │ Connection │ Pairing    │ S3 Hostnames          │
├────┼───────┼─────────────────────────┼───────────────┼────────────┼────────────┼───────────────────────┤
│  1 │ siteB │ da6eb79f-d41a-4802-b3c… │             0 │ connected  │ local-only │ 10.108.71.30, 10.108… │
╰────┴───────┴─────────────────────────┴───────────────┴────────────┴────────────┴───────────────────────╯
```

**After step 4 — both sides are registered and the pairing is complete:**

```
╭────┬───────┬─────────────────────────┬───────────────┬────────────┬─────────┬───────────────────────╮
│ ID │ Name  │ Peer Cluster GUID       │ OBS Bucket ID │ Connection │ Pairing │ S3 Hostnames          │
├────┼───────┼─────────────────────────┼───────────────┼────────────┼─────────┼───────────────────────┤
│  1 │ siteB │ da6eb79f-d41a-4802-b3c… │             0 │ connected  │ mutual  │ 10.108.71.30, 10.108… │
╰────┴───────┴─────────────────────────┴───────────────┴────────────┴─────────┴───────────────────────╯
```

Confirm that **Connection** shows `connected` and **Pairing** shows `mutual`. A `local-only` pairing is a warning, not a valid end state: it means the peer is reachable but has not registered this cluster in return, so you still need to complete the exchange in the other direction. A `degraded` connection indicates that some peer endpoints are unreachable. For bucket counts and the HTTP port, run `weka cluster peer -v`.

To modify the settings of an existing peer, such as its join IPs or S3 hostnames, use `weka cluster peer update`.

## Create a replication pair

Create a replication pair between a local filesystem and a filesystem on a trusted peer cluster, and define its replication policy.

The replication policy determines the replication interval, which paths are copied proactively, when snapshots become visible on the target, and how many snapshots are retained.

**Before you begin**

Choose the copy option and access strategy for the workload. See [.](./ "mention"). For a full data copy, ensure the target capacity is at least the source filesystem size.

**Procedure**

1. Create the replication pair on the source cluster:

```bash
weka fs replication add \
  --source-filesystem <filesystem> \
  --target-cluster <peer name> \
  --target-filesystem <name> \
  --interval <duration> \
  [--copy-path <paths>] \
  [--access-strategy <INSTANT_ACCESS | COPY_FIRST>] \
  [--apply-strategy <AUTOMATIC>] \
  [--snapshots-to-keep <number>] \
  [--target-total-capacity <capacity>] \
  [--now]
```

The target filesystem is created automatically on the target cluster. It must not already exist; if it does, the command fails. On success, the command returns the new pair and its ID:

```
╭────┬──────────────────────────────────────────────────────╮
│ ✅ │ Added replication pair data_fs → data_fs_dest (3).   │
╰────┴──────────────────────────────────────────────────────╯
```

2. Verify that the pair is created and running:

```bash
weka fs replication
```

**Parameters**

| Parameter                 | Description                                                                                                                                                                                                                                    |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `--source-filesystem`     | Name of the local source filesystem.                                                                                                                                                                                                           |
| `--target-cluster`        | Name of the configured cluster peer.                                                                                                                                                                                                           |
| `--target-filesystem`     | Name of the filesystem on the remote cluster.                                                                                                                                                                                                  |
| `--interval`              | Replication interval, for example, `5m` or `1h`. The minimum is 5 minutes.                                                                                                                                                                     |
| `--copy-path`             | Specifies up to 10 paths to copy proactively, each up to 2 KB long. Separate paths with commas or repeat the option. Use `full`, `all`, or `/` to copy all data. Use `none` or `null` to replicate metadata only. Default: metadata-only replication.              |
| `--access-strategy`       | Controls when a target snapshot becomes accessible. `INSTANT_ACCESS` (default) exposes the snapshot immediately. Data not copied locally is retrieved on demand. `COPY_FIRST` exposes the snapshot only after the `--copy-path` data is local. |
| `--apply-strategy`        | Controls when the target applies a replicated snapshot. `AUTOMATIC` applies the snapshot after the prerequisite phase completes.                                                                                                               |
| `--snapshots-to-keep`     | Number of snapshots to retain, from 2 to 25. Retaining more snapshots requires more storage.                                                                                                                                                   |
| `--target-total-capacity` | Total capacity for the target filesystem. Default: same as the source filesystem. A smaller target is allowed for a partial or metadata-only copy. A full copy requires at least the source size.                                              |
| `--now`                   | Triggers the first replication cycle immediately instead of waiting one full interval.                                                                                                                                                         |

**Examples**

Create a full data copy pair for disaster recovery, replicating every 5 minutes:

```bash
weka fs replication add --source-filesystem data_fs --target-cluster siteB --target-filesystem data_fs_dest --interval 5m --copy-path full --snapshots-to-keep 25
```

Replicate only selected directories:

```bash
weka fs replication add --source-filesystem data_fs3 --target-cluster siteB --target-filesystem data_fs3_dest --interval 5m --copy-path "/dir1,/dir2" --snapshots-to-keep 10
```

## Monitor replication status

Monitor the state, progress, and health of replication pairs and cluster peers.

### View replication pairs

List all replication pairs and their current status:

```bash
weka fs replication
```

**Example output:**

```
╭────┬─────────┬───────────┬─────────┬───────────────┬───────────┬───────────┬────────────────┬─────────┬───────────────────────────┬────────────╮
│ ID │ State   │ Source FS │ Target  │ Target FS     │ Interval  │ Apply     │ Access         │ Copy    │ Last Replication          │ Current    │
│    │         │           │ Cluster │               │           │           │                │         │                           │ Status     │
├────┼─────────┼───────────┼─────────┼───────────────┼───────────┼───────────┼────────────────┼─────────┼───────────────────────────┼────────────┤
│  0 │ RUNNING │ data_fs   │ siteB   │ data_fs_dest  │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ FULL    │ 2026-08-05T16:58:32+03:00 │ IDLE       │
│  1 │ RUNNING │ data_fs2  │ siteB   │ data_fs2_dest │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ NONE    │ 2026-08-05T16:57:08+03:00 │ IDLE       │
│  2 │ RUNNING │ data_fs3  │ siteB   │ data_fs3_dest │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ PARTIAL │ 2026-08-05T16:57:19+03:00 │ IDLE       │
╰────┴─────────┴───────────┴─────────┴───────────────┴───────────┴───────────┴────────────────┴─────────┴───────────────────────────┴────────────╯
```

The output shows for each pair:

* **State**: The overall state of the pair, such as `RUNNING` or `ERROR`.
* **Interval, Apply, Access, Copy**: The configured replication policy.
* **Last Replication**: The timestamp of the last completed replication cycle. Use it to assess the current recovery point.
* **Current Status**: The current activity of the pair, such as `COPY`, `IDLE`, or `ERROR`. If a copy task is stuck, the status includes the reason.

For the pair UID and number of snapshots to keep, run:

```bash
weka fs replication -v
```

To customize the output, use the `--output`, `--filter`, and `--sort` options with any of the available columns, including `last-error` and `last-error-time` for troubleshooting.

### Troubleshoot S3 authentication failures

Resolve S3 authentication failures that set a replication pair to `ERROR`.

1. Check whether the peer cluster ran `weka cluster peer init --reinit`.
2. If it did, refresh the peer credentials by following [Rotate replication S3 credentials](/broken/spaces/1tNqZ9KSl64GGavyeX1N/pages/533ef70aca4a392556c455eed0033c09e3ed7a6c).
3. Verify that the pair resumes:

```bash
weka fs replication
```

### View cluster peer health

Check the connection and pairing status of the cluster peers:

```bash
weka cluster peer
```

Confirm that **Connection** shows `connected` and **Pairing** shows `mutual`. A `degraded` connection indicates that some peer endpoints are unreachable.

## Modify the replication policy

Modify the policy of an existing replication pair without recreating it.

**Before you begin**

Identify the replication pair ID:

```bash
weka fs replication
```

**Procedure**

1. Update the pair policy:

```bash
weka fs replication update <pair ID> \
  [--interval <duration>] \
  [--copy-path <paths> | --add-copy-path <paths> --remove-copy-path <paths>] \
  [--access-strategy <INSTANT_ACCESS | COPY_FIRST>] \
  [--apply-strategy <AUTOMATIC>] \
  [--snapshots-to-keep <number>]
```

Use the parameter descriptions in the preceding table, with the following additions:

* `--copy-path` replaces the entire copy path set. Use `none` or `null` to clear the set. Mutually exclusive with `--add-copy-path` and `--remove-copy-path`.
* `--add-copy-path` adds paths to a partial copy set. Separate multiple paths with commas or repeat the option.
* `--remove-copy-path` removes paths from a partial copy set. Separate multiple paths with commas or repeat the option.

2. Verify the updated policy:

```bash
weka fs replication
```

**Example**

Switch a pair to a metadata-only copy and lengthen its interval:

```bash
weka fs replication update 3 --copy-path none --interval 6m
```

## Pause and resume replication

Pause a replication pair before maintenance or before removing it, and resume it to continue replication.

While a pair is paused, no new snapshot deltas are transferred to the target. On-demand data access on the target continues to work.

### Pause a replication pair

```bash
weka fs replication pause <pair ID>
```

### Resume a replication pair

```bash
weka fs replication resume <pair ID>
```

Replication continues from the last consistent state.

## Manage file hydration on the target

Fetch the data of individual files to the target cluster proactively, monitor hydration progress, and release file data back to on-demand mode.

With a metadata-only or partial copy policy, file data is retrieved from the source cluster when files are accessed on the target. Use the hydration commands to control this behavior per file: fetch a file before a workload needs it, or release local data to free capacity on the target.

### Fetch a file proactively

Fetch a file's data blocks from the source cluster in the background:

```bash
weka fs replication fetch <path> [--filesystem <name>] [--snapshot <name>]
```

* `<path>` is a local mount path. Alternatively, specify `--filesystem` and provide a path relative to the filesystem root.
* Use `--snapshot` to resolve the path within a snapshot view instead of the live filesystem.

### Monitor hydration progress

Fetch and release operations run in the background. Check the hydration status for a file:

```bash
weka fs replication hydration status <path> [--filesystem <name>] [--snapshot <name>]
```

### Release file data

Return a file's data blocks to on-demand mode to free capacity on the target. The release runs in the background:

```bash
weka fs replication release
```

## Remove a replication pair

Remove a replication pair when you no longer need to synchronize the source and target filesystems, or as part of a failover procedure.

{% hint style="warning" %}
Removing a pair stops further snapshot replication for the filesystem pair, including the retrieval of data on demand. If the target filesystem was created with a metadata-only or partial copy policy, files that were never hydrated become inaccessible after removal. Verify the hydration state before removal. Pause the pair, then run `weka fs replication` and confirm that **State** is not `RUNNING`.
{% endhint %}

**Before you begin**

Identify the replication pair ID:

```bash
weka fs replication
```

**Procedure**

1. Pause the replication pair. A running pair cannot be removed:

```bash
weka fs replication pause <pair ID>
```

2. Remove the pair:

```bash
weka fs replication remove <pair ID> [--force]
```

The command warns that removing the pair stops further snapshot replication and prompts for confirmation. Use `--force` to skip the confirmation prompt, for example, in scripts.

3. Verify that the pair is no longer listed:

```bash
weka fs replication
```

The target filesystem remains write-protected after removal. Remove write protection during failover.

## Remove trust between clusters

Remove the trust relationship between two clusters when replication between them is no longer required.

**Before you begin**

Remove every replication pair that uses the trust relationship. Identify the peer ID or name:

```bash
weka cluster peer
```

**Procedure**

1. Remove each replication pair that uses this peer. Pause the pair first:

```bash
weka fs replication pause <pair ID>
weka fs replication remove <pair ID>
```

2. Restore write access to each target filesystem. Run this command on the target cluster:

```bash
weka fs update <target filesystem> --access rw --force
```

The `--force` option overrides the replication write protection after pair removal.

3. Remove the peer:

```bash
weka cluster peer remove <peer>
```

4. Remove mutual trust. Repeat the command on the other cluster.
5. Verify peer removal:

```bash
weka cluster peer
```

## Activate the target site during failover

Activate the target filesystem on site B when the source site becomes unavailable, and redirect clients to it.

{% hint style="warning" %}
Failover is a manual procedure. Because replication is asynchronous, the target reflects the last replicated snapshot. Writes made on the source after that snapshot are lost.
{% endhint %}

### Considerations

* Reverse replication (resynchronizing site A from site B after recovery) is not confirmed for this release.
* The behavior of the trust relationship when site A returns online requires verification.

**Before you begin**

Confirm the recovery point. Check the **Last Replication** timestamp:

```bash
weka fs replication
```

**Procedure**

1. Remove write protection from the target filesystem.\
   On the target cluster:

```bash
weka fs update <name> --access rw
```
