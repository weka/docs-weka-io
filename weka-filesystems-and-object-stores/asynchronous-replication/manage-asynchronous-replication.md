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

After you create a pair, use the on-demand procedures to monitor, modify, pause, or remove replication, manage file hydration, and fail over to the target cluster.

## Set up and prepare for replication

Prepare both clusters with the S3 infrastructure that asynchronous replication uses as its transport layer.

Replication transfers data through the S3 infrastructure of the clusters. The object store bucket serves as a transport mechanism only and does not store the replicated data.

**Before you begin**

* Ensure the clusters can reach each other over the network.
* Ensure each cluster has a configuration filesystem for its protocol containers, typically named `.config_fs`. Protocol or S3 setup creates it. `weka cluster peer init` validates this filesystem but does not create it, so a cluster that has never run protocol setup must have it created first.

### What `weka cluster peer init` provisions

You do not set up the S3 transport by hand. Running `weka cluster peer init` provisions the S3 service, the replication user and bucket, and the object store filesystem (default: `weka-repl-fs`). It does not create the configuration filesystem; that must already exist.

The only decision is which containers serve the S3 traffic:

* To create a new S3 cluster from all backend servers, run `weka cluster peer init --all-servers`.
* To reuse an existing S3 cluster, pass its containers with `weka cluster peer init --container <container-ids>`.

The two options are mutually exclusive.

Two optional parameters control which existing resources the command uses:

<table><thead><tr><th width="278.05859375">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--config-fs-name</code> &#x3C;filesystem></td><td>Names the configuration filesystem to use. Needed only when the cluster's configuration filesystem is not the one the command resolves by default. On a cluster that is already initialized, the name is read from the live S3 configuration; if you supply it, it must match.</td></tr><tr><td><code>--fs-group</code> &#x3C;filesystem-group></td><td>Names the filesystem group for the replication object store filesystem. Defaults to the cluster's default group, falling back to the first group. Applies only on first-time provisioning.</td></tr></tbody></table>

The local object store tier that replication uses is created automatically when you register a cluster peer. The default tier name is `<peer name>-obs`. It stores the peer cluster's replication S3 credentials.

**Related topics**

[Manage the S3 protocol](https://docs.weka.io/additional-protocols/s3)

[User management](https://docs.weka.io/operation-guide/user-management)

[Manage object stores](https://docs.weka.io/weka-filesystems-and-object-stores/managing-object-stores)

## Establish trust between clusters

Establish a trust relationship between two NeuralMesh clusters so they can authenticate each other and replicate filesystems.

Establish mutual trust by exchanging pairing tokens between the clusters. Complete the pairing steps on both clusters before creating a replication pair.

**Before you begin**

Complete the preceding S3 transport setup on both clusters.

The source cluster hosts the filesystem being replicated. The target cluster receives the replicated filesystem.

**Procedure**

1. On the **source cluster**, generate a pairing token:

```bash
weka cluster peer init
```

2. On the **target cluster**, register the source cluster as a peer. Provide a name and the token from the source cluster:

```bash
weka cluster peer add source-cluster <token>
```

Registering a peer also creates its local object store tier. Replication uses this tier. Its default name is `<peer name>-obs`.

Optional flags override values in the decoded token:

* Network settings: `--join-ips`, `--s3-hostnames`, `--s3-port`, and `--http-port`.
* Object store settings: `--s3-bucket` and `--obs-tier-name`.
* Peer identity: `--guid`.

Use `--dry-run` to test the command without affecting the system.

3. On the **target cluster**, generate a pairing token:

```bash
weka cluster peer init
```

4. On the **source cluster**, register the target cluster as a peer. Provide a name and the token from the target cluster:

```bash
weka cluster peer add target-cluster <token>
```

5. Verify the peer status on either cluster:

```bash
weka cluster peer
```

**Example output:**

```
   ╭────┬───────┬─────────────────────────┬───────────────┬────────────┬─────────┬───────────────────────╮
   │ ID │ Name  │ Peer Cluster GUID       │ OBS Bucket ID │ Connection │ Pairing │ S3 Hostnames          │
   ├────┼───────┼─────────────────────────┼───────────────┼────────────┼─────────┼───────────────────────┤
   │  1 │ target-cluster │ da6eb79f-d41a-4802-b3c… │             0 │ connected  │ mutual  │ 10.108.71.30, 10.108… │
   ╰────┴───────┴─────────────────────────┴───────────────┴────────────┴─────────┴───────────────────────╯
```

Confirm that **Connection** shows `connected` and **Pairing** shows `mutual`. A `degraded` connection indicates that some peer endpoints are unreachable. For bucket counts and the HTTP port, run `weka cluster peer -v`.

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

The target filesystem is created automatically on the target cluster. It must not already exist. If it does, the command fails. On success, the command returns the new pair and its ID:

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

<table><thead><tr><th width="266.5703125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--source-filesystem</code></td><td>Name of the local source filesystem.</td></tr><tr><td><code>--target-cluster</code></td><td>Name of the configured cluster peer.</td></tr><tr><td><code>--target-filesystem</code></td><td>Name of the filesystem on the remote cluster.</td></tr><tr><td><code>--interval</code></td><td>Replication interval, for example, <code>5m</code> or <code>1h</code>. The minimum is 5 minutes.</td></tr><tr><td><code>--copy-path</code></td><td>Specifies up to 10 paths to copy proactively, each up to 2 KB long. Separate paths with commas or repeat the option. Use <code>full</code>, <code>all</code>, or <code>/</code> to copy all data. Use <code>none</code> or <code>null</code> to replicate metadata only. Default: metadata-only replication.</td></tr><tr><td><code>--access-strategy</code></td><td>Controls when a target snapshot becomes accessible. <code>INSTANT_ACCESS</code> (default) exposes the snapshot immediately. Data not copied locally is retrieved on demand. <code>COPY_FIRST</code> exposes the snapshot only after the <code>--copy-path</code> data is local.</td></tr><tr><td><code>--apply-strategy</code></td><td>Controls when the target applies a replicated snapshot. <code>AUTOMATIC</code> applies the snapshot after the prerequisite phase completes.</td></tr><tr><td><code>--snapshots-to-keep</code></td><td>Number of snapshots to retain, from 2 to 25. Default: 3. Retaining more snapshots requires more storage. Enforced only while the pair is running; see <a href="manage-asynchronous-replication.md#pause-and-resume-replication">Pause and resume replication</a>.</td></tr><tr><td><code>--target-total-capacity</code></td><td>Total capacity for the target filesystem. Default: same as the source filesystem. A smaller target is allowed for a partial or metadata-only copy. A full copy requires at least the source size.</td></tr><tr><td><code>--now</code></td><td>Triggers the first replication cycle immediately instead of waiting one full interval.</td></tr></tbody></table>

**Examples**

Create a full data copy pair for disaster recovery, replicating every 5 minutes:

```bash
weka fs replication add --source-filesystem data_fs --target-cluster target-cluster --target-filesystem data_fs_dest --interval 5m --copy-path full --snapshots-to-keep 25
```

Replicate only selected directories:

```bash
weka fs replication add --source-filesystem data_fs3 --target-cluster target-cluster --target-filesystem data_fs3_dest --interval 5m --copy-path "/dir1,/dir2" --snapshots-to-keep 10
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
│  0 │ RUNNING │ data_fs   │ target-cluster │ data_fs_dest  │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ FULL    │ 2026-08-05T16:58:32+03:00 │ IDLE       │
│  1 │ RUNNING │ data_fs2  │ target-cluster │ data_fs2_dest │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ NONE    │ 2026-08-05T16:57:08+03:00 │ IDLE       │
│  2 │ RUNNING │ data_fs3  │ target-cluster │ data_fs3_dest │ 5 minutes │ AUTOMATIC │ INSTANT_ACCESS │ PARTIAL │ 2026-08-05T16:57:19+03:00 │ IDLE       │
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

### Monitor RPO compliance

The replication interval is also the RPO target for the pair. There is no separate RPO setting. The system times each cycle from its start and raises an alert when the cycle overruns the interval by more than one minute.

<table><thead><tr><th width="235">Alert</th><th width="120">Severity</th><th>Raised when the current cycle has been running longer than</th></tr></thead><tbody><tr><td>Replication behind schedule</td><td>Minor</td><td>The configured interval, plus one minute</td></tr><tr><td>Replication behind schedule</td><td>Major</td><td>Three times the configured interval, plus one minute</td></tr></tbody></table>

The alert names the filesystem and the peer, and reports the interval, how long the cycle has run, by how much it exceeds the target, and the time of the last completed cycle. Use the alert history as the compliance record.

No RPO alert is raised for a pair that is paused, not running, or still in its first replication cycle.

View active alerts:

```bash
weka alerts
```

If an RPO alert fires, inspect the cycle:

```bash
weka fs replication --verbose
```

Common causes are a slow or broken link to the peer, or low free capacity on the target. Repair the link or free space. If the source change rate consistently outpaces the link, lengthen the interval or add bandwidth.

### Troubleshoot S3 authentication failures

Resolve S3 authentication failures that set a replication pair to `ERROR`.

1. Check whether the peer cluster ran `weka cluster peer init --reinit`.
2. If it did, refresh the peer credentials by following [Reset S3 credentials](../../operation-guide/user-management/user-management.md#reset-s3-credentials).
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

{% hint style="info" %}
Snapshot pruning runs only while a pair is running. A paused pair, or one in an error state, retains all of its snapshots until it resumes, so the `--snapshots-to-keep` limit is not enforced during that time. Expect snapshot count and capacity use to grow while a pair is left paused or unattended in error.
{% endhint %}

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
weka fs replication release <path> [<path> ...]
```

Each `<path>` is a local mount path. Release several files in one command by listing more than one path. Monitor progress with `weka fs replication hydration status`.

This command runs on the container that holds the mount, so it cannot be directed at another cluster with `--HOST`.

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

The target filesystem remains write-protected after the pair is removed. To make it writable, run this command on the target cluster:

```bash
weka fs update <target filesystem> --access rw
```

Do this only when you intend to promote the target, such as during failover. See [Activate the target cluster during failover](manage-asynchronous-replication.md#activate-the-target-cluster-during-failover).

## Remove trust between clusters

Remove the trust relationship between two clusters when replication between them is no longer required.

**Before you begin**

Remove every replication pair that uses the trust relationship. Identify the peer ID or name:

```bash
weka cluster peer
```

**Procedure**

1. On the **source** cluster, pause and remove each replication pair that uses this peer:

```bash
weka fs replication pause <pair ID>
weka fs replication remove <pair ID>
```

All pair configuration lives on the source cluster, so run these commands there. The target cluster holds no pair row and has nothing to remove.

2. Remove the peer entry on **each** cluster. Trust is mutual, and every cluster stores its own entry naming the other one, so run `weka cluster peer remove` twice — once per cluster, each time naming the peer that cluster sees:

```bash
# On the source cluster, naming the target
weka cluster peer remove <target peer name>

# On the target cluster, naming the source
weka cluster peer remove <source peer name>
```

Run `weka cluster peer` on each cluster first if you are unsure of the name it uses for the other.

{% hint style="info" %}
If the command reports that the peer is in use by a cluster task, a replication cycle was running at that moment. Wait a few seconds and run it again.
{% endhint %}

3. Verify on both clusters that the peer is gone:

```bash
weka cluster peer
```

Removing trust does not restore write access to the target filesystems. They stay write-protected until you promote them, as described in [Activate the target cluster during failover](manage-asynchronous-replication.md#activate-the-target-cluster-during-failover).

## Activate the target cluster during failover

Activate the target filesystem when the source cluster becomes unavailable, and redirect clients to it.

{% hint style="warning" %}
Failover is a manual procedure. Because replication is asynchronous, the target reflects the last replicated snapshot. Writes made on the source after that snapshot are lost.
{% endhint %}

### Considerations

* Reverse replication from the target cluster after recovery is not confirmed for this release.
* The trust relationship behavior when the source cluster returns online requires verification.

**Before you begin**

* Confirm the recovery point. On the source cluster, if it is still reachable, check the **Last Replication** timestamp:

```bash
weka fs replication
```

* Confirm that the target contains the data you need:
  * With `COPY_FIRST` and `--copy-path full`, all data is local. No action is required.
  * Hydrate data before breaking any other pair type. This includes `INSTANT_ACCESS`, partial copies, and smaller targets.
  * These pairs can reference source-only data. Breaking the pair makes that data permanently unreadable.
  * Run `weka fs replication fetch <path>` for each required path. Reading files does not hydrate them. See [Manage file hydration on the target](manage-asynchronous-replication.md#manage-file-hydration-on-the-target).

{% hint style="info" %}
`weka fs replication` returns no rows on the target cluster. This is expected: all pair configuration lives on the source cluster, and the target only executes the work sent to it. The target still tracks the relationship internally. It is not exposed by any command today.
{% endhint %}

**Procedure**

The steps differ depending on whether the source cluster is still reachable.

_Planned failover, source cluster reachable:_

1. On the **source** cluster, pause the pair and remove it. A pair that is running, or that is mid-cycle, cannot be removed:

```bash
weka fs replication pause <pair ID>
weka fs replication remove <pair ID>
```

2. On the **target** cluster, remove the peer:

```bash
weka cluster peer remove <source peer name>
```

_Disaster failover, source cluster unavailable:_

1. On the **target** cluster, force the peer removal. The source is unreachable, so trust cannot be torn down cooperatively:

```bash
weka cluster peer remove <source peer name> --force
```

{% hint style="info" %}
If the command reports that the peer is in use by a cluster task, a replication cycle was running at that moment. Wait a few seconds and run it again.
{% endhint %}

_Both cases, to promote the target:_

2. Remove write protection from the target filesystem. On the target cluster:

```bash
weka fs update <name> --access rw
```

3. Mount the filesystem on a client and verify the data before redirecting production traffic to it.
