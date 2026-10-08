---
description: >-
  Configure, operate, and recover asynchronous replication between NeuralMesh
  clusters.
---

# Manage asynchronous replication

All procedures require ClusterAdmin privileges. Manage asynchronous replication through this workflow:

1. Prepare both clusters.
2. Link the clusters.
3. Create a replication pair.

After you create a pair, use the on-demand procedures to monitor, modify, pause, or remove replication, manage file hydration, fail over to the target cluster, and fail back to the original source cluster.

The procedures use `weka cluster link` and `weka fs replication`. The same commands are also available under `weka replication`, as `weka replication link` and `weka replication fs-pair`.

## Set up and prepare for replication

Prepare both clusters for replication. Replication traffic passes through the S3 service of each cluster, over a dedicated replica route. Replication creates no bucket, S3 user, or object store filesystem of its own.

**Before you begin**

* Ensure both clusters are licensed for cross-cluster replication. Run `weka cluster license` and check that **Cross-Cluster Replication** under **Installed License** shows **Licensed**. Linking checks the license of each cluster, so both clusters need the entitlement. To add the entitlement, contact your WEKA account team.
* Ensure the clusters can reach each other over the management network (port 14000 by default) and over the S3 port of each cluster.
* Ensure each cluster has a cluster name. The link is named after the cluster at the other end. To set the name, run `weka cluster update --cluster-name <name>`.
* Ensure each cluster has an S3 cluster with at least one server serving S3. To create one, run `weka s3 cluster add`. See [Manage the S3 cluster using the CLI](../../additional-protocols/s3/s3-cluster-management/s3-cluster-management-1.md).
* Ensure each cluster has a configuration filesystem for its protocol containers, typically named `.config_fs`. Protocol or S3 setup creates it.
* For Selective copy - critical paths (`--copy-path` with specific directories), set up a Data Services container on the **target** cluster. Full data copy and Selective copy - metadata only copy do not need it. See [Set up a Data Services container for background tasks](../../operation-guide/set-up-a-data-services-container-for-background-tasks.md).

## Link the clusters

Link the two clusters so they can authenticate each other and replicate filesystems.

One `weka cluster link add` command, run on either cluster, creates the link on both clusters. It authenticates to the other cluster with a cluster admin account on that cluster, pins the TLS certificate the other cluster presents, and creates the replication credentials for both clusters.

**Before you begin**

* Complete the preparation on both clusters.
* Get the management hostname or IP address of the other cluster, and the username and password of a cluster admin on it.

The source cluster hosts the filesystem being replicated. The target cluster receives the replicated filesystem. This procedure runs the link command on the source cluster.

**Procedure**

1. On the **target cluster**, display the fingerprint of its TLS certificate, and record the colon-separated hexadecimal value:

```bash
weka security tls status
```

2. On the **source cluster**, link to the target cluster:

```bash
weka cluster link add \
  --peer-host <target management host> \
  --username <cluster admin on the target> \
  --fingerprint <target fingerprint>
```

Provide the password with `--password`, with the `WEKA_PEER_PASSWORD` environment variable, or at the prompt. On success, the command reports the ID of the new link: `Cluster link added with ID <ID>.`

3. Verify the link on either cluster:

```bash
weka cluster link
```

Confirm that **Connection** shows `connected` and **Pairing** shows `mutual`. Record the link **ID**. You use it to create replication pairs.

**Parameters**

<table><thead><tr><th width="266.5703125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--peer-host</code>*</td><td>Management hostname or IP address of the cluster to link to.</td></tr><tr><td><code>--username</code>*</td><td>Cluster admin username on the other cluster.</td></tr><tr><td><code>--password</code></td><td>Password for <code>--username</code>. Alternatively, use the <code>WEKA_PEER_PASSWORD</code> environment variable or the interactive prompt.</td></tr><tr><td><code>--fingerprint</code></td><td>Expected SHA-256 fingerprint of the TLS certificate of the other cluster, as shown by <code>weka security tls status</code> on that cluster. Required in non-interactive mode unless you use <code>--auto-accept-peer-cert</code>.</td></tr><tr><td><code>--auto-accept-peer-cert</code></td><td>Accepts the TLS certificate the other cluster presents, without confirming its fingerprint. The certificate is still pinned and checked on every later connection.</td></tr><tr><td><code>--peer-port</code></td><td>Management API port of the other cluster. Default: <code>14000</code>.</td></tr></tbody></table>

If you run the command interactively without `--fingerprint`, it displays the fingerprint the other cluster presents and asks you to confirm it. Compare it with the `weka security tls status` output from the other cluster before you continue.

A link is identified by its ID. Its name follows the name of the other cluster, so two links can have the same name. Every link command, and `weka fs replication add --link-id`, takes the ID.

If a link to the other cluster already exists on either cluster, the command reports which cluster holds it and makes no change. Remove the existing link, then add it again. See [Remove a cluster link](manage-asynchronous-replication.md#remove-a-cluster-link).

If the clusters can reach each other only through public addresses, contact the Customer Success Team before you link them.

{% hint style="info" %}
The `weka replication link` command group runs the same commands as `weka cluster link`.
{% endhint %}

### Refresh a cluster link

Refresh a link when the other cluster changes its name, management addresses, or S3 endpoints. Both clusters replace what they hold about each other with what the other cluster now reports. The refresh runs over the existing authenticated link and requires no password.

```bash
weka cluster link refresh <link ID> [--peer-host <hostname>] [--peer-port <port>]
```

Use `--peer-host` and `--peer-port` to reach the other cluster for this run when its recorded addresses no longer work. The command does not store these values.

If a different cluster answers at the recorded address, the refresh stops. Remove the link and add it again.

## Create a replication pair

Create a replication pair between a local filesystem and a filesystem on a linked cluster, and define its replication policy.

The replication policy determines the replication interval, which paths are copied proactively, when snapshots become visible on the target, and how many snapshots are retained.

**Before you begin**

* Choose the copy option and access strategy for the workload. See [.](./ "mention"). For a full data copy, ensure the target capacity is at least the source filesystem size.
* Ensure the link to the target cluster shows **Pairing** `mutual` and **Connection** `connected` or `degraded` in `weka cluster link`.
* Ensure the target cluster has a filesystem group with the same name as the group of the source filesystem. The target filesystem is created in that group.

**Procedure**

1. Create the replication pair on the source cluster:

```bash
weka fs replication add \
  --source-filesystem <filesystem> \
  --link-id <link ID> \
  --target-filesystem <name> \
  --interval <duration> \
  [--copy-path <paths>] \
  [--access-strategy <INSTANT_ACCESS | COPY_FIRST>] \
  [--apply-strategy <AUTOMATIC>] \
  [--snapshots-to-keep <number>] \
  [--target-total-capacity <capacity>] \
  [--now]
```

The target filesystem is created automatically on the target cluster during the first replication cycle. It must not already exist. If it does, the command fails. On success, the command returns the new pair and its ID:

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

<table><thead><tr><th width="266.5703125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>--source-filesystem</code></td><td>Name of the local source filesystem.</td></tr><tr><td><code>--link-id</code></td><td>ID of the cluster link to the target cluster, as shown by <code>weka cluster link</code>.</td></tr><tr><td><code>--target-filesystem</code></td><td>Name of the filesystem on the remote cluster. It can be the same as the source filesystem name.</td></tr><tr><td><code>--interval</code></td><td>Replication interval, for example, <code>5m</code> or <code>1h</code>. From 5 minutes to 30 days.</td></tr><tr><td><code>--copy-path</code></td><td>Specifies up to 10 paths to copy proactively. Each path can be up to 1,023 characters long, and all paths together up to 2,048 characters. Separate paths with commas or repeat the option. Use <code>full</code>, <code>all</code>, or <code>/</code> to copy all data. Use <code>none</code> or <code>null</code> to replicate metadata only. Default: metadata-only replication.</td></tr><tr><td><code>--access-strategy</code></td><td>Controls when a target snapshot becomes accessible. <code>INSTANT_ACCESS</code> (default) exposes the snapshot immediately. Data not copied locally is retrieved on demand. <code>COPY_FIRST</code> exposes the snapshot only after the <code>--copy-path</code> data is local.</td></tr><tr><td><code>--apply-strategy</code></td><td>Controls when the target applies a replicated snapshot. <code>AUTOMATIC</code> applies the snapshot after the prerequisite phase completes.</td></tr><tr><td><code>--snapshots-to-keep</code></td><td>Number of snapshots to retain, from 2 to 25. Default: 3. Retaining more snapshots requires more storage. Enforced only while the pair is running; see <a href="manage-asynchronous-replication.md#pause-and-resume-replication">Pause and resume replication</a>.</td></tr><tr><td><code>--target-total-capacity</code></td><td>Total capacity for the target filesystem. Default: same as the source filesystem. A smaller target is allowed for a selective copy. A full copy requires at least the source size.</td></tr><tr><td><code>--now</code></td><td>Triggers the first replication cycle immediately instead of waiting one full interval.</td></tr></tbody></table>

**Examples**

Create a full data copy pair for disaster recovery over link 1, replicating every 5 minutes:

```bash
weka fs replication add --source-filesystem data_fs --link-id 1 --target-filesystem data_fs_dest --interval 5m --copy-path full --snapshots-to-keep 25
```

Replicate only selected directories:

```bash
weka fs replication add --source-filesystem data_fs3 --link-id 1 --target-filesystem data_fs3_dest --interval 5m --copy-path "/dir1,/dir2" --snapshots-to-keep 10
```

## Monitor replication status

Monitor the state, progress, and health of replication pairs and cluster links.

### View replication pairs

List the replication pairs and their current status:

```bash
weka fs replication
```

The output shows for each pair:

* **Role**: `SOURCE` for a pair this cluster drives, or `TARGET` for a pair that another cluster replicates into this one. A `TARGET` row is read-only. To change the pair, run the command on the source cluster.
* **State**: The overall state of the pair, such as `RUNNING` or `ERROR`.
* **Link**: The name of the linked cluster.
* **Interval, Apply, Access, Copy**: The configured replication policy.
* **Last Replication**: The timestamp of the last completed replication cycle. Use it to assess the current recovery point.
* **Current Status**: The current activity of the pair, such as `COPY`, `IDLE`, or `ERROR`. If a copy task is stuck, the status includes the reason.

Each cluster assigns its own pair IDs, so the same pair can have different IDs on the source and the target clusters.

For the pair UID, the link ID, and the number of snapshots to keep, run:

```bash
weka fs replication -v
```

To customize the output, use the `--output`, `--filter`, and `--sort` options with any of the available columns, including `last-error` and `last-error-time` for troubleshooting.

### Monitor replication interval compliance

The replication interval sets the target for each pair. There is no separate setting. The system times each cycle from its start and raises an alert when the cycle overruns the interval by more than one minute.

<table><thead><tr><th width="235">Alert</th><th width="120">Severity</th><th>Raised when the current cycle has been running longer than</th></tr></thead><tbody><tr><td>Replication behind schedule</td><td>Minor</td><td>The configured interval, plus one minute</td></tr><tr><td>Replication behind schedule</td><td>Major</td><td>Three times the configured interval, plus one minute</td></tr></tbody></table>

The alert names the filesystem and the linked cluster, and reports the interval, how long the cycle has run, by how much it exceeds the target, and the time of the last completed cycle. Use the alert history as the compliance record.

No replication interval alert is raised for a pair that is paused, not running, or still in its first replication cycle.

View active alerts:

```bash
weka alerts
```

If a replication interval alert fires, inspect the cycle:

```bash
weka fs replication --verbose
```

Common causes are a slow or broken connection to the linked cluster, an S3 service problem on the linked cluster, or low free capacity on the target. Repair the connection or the S3 service, or free space. If the source change rate consistently outpaces the connection, lengthen the interval or add bandwidth.

### View cluster link health

Check the connection and pairing status of the cluster links:

```bash
weka cluster link
```

* **Connection**: `connected` when every management endpoint of the other cluster answers, `degraded` when some answer, and `disconnected` when none answer.
* **Pairing**: `mutual` when the other cluster holds a link back to this one. `local-only` means only this cluster holds the link. To repair it, remove the link and add it again. `unknown` means no management endpoint answered, so the pairing could not be checked.

For the link UID, data IPs, and data port, run `weka cluster link -v`.

`weka cluster link` checks the management endpoints of the other cluster, not its S3 service. To detect an S3 service problem on the other cluster, watch the **Last Error** column of the pairs that use the link, and the replication interval alerts.

Each cluster link has its own replication credentials. `weka cluster link add` creates them and stores them on both clusters, so there are no S3 users or keys to manage for replication. If **Last Error** reports an S3 authentication failure for a pair, or if you need to rotate the credentials of a link, contact the Customer Success Team.

## Modify the replication policy

Modify the policy of an existing replication pair without recreating it. Run the commands on the source cluster.

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
* `--add-copy-path` adds paths to the copy path set. Separate multiple paths with commas or repeat the option.
* `--remove-copy-path` removes paths from the copy path set. Separate multiple paths with commas or repeat the option.

2. Verify the updated policy:

```bash
weka fs replication
```

**Example**

Switch a pair to Selective copy - metadata only copy and lengthen its interval:

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

With a selective copy policy, file data is retrieved from the source cluster when files are accessed on the target. Use the hydration commands to control this behavior per file: fetch a file before a workload needs it, or release local data to free capacity on the target.

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
Removing a pair stops further snapshot replication for the filesystem pair, including the retrieval of data on demand. If the target filesystem was created with a selective copy policy, files that were never hydrated become inaccessible after removal. Verify the hydration state before removal. Pause the pair, then run `weka fs replication` and confirm that **Current Status** shows `IDLE`.
{% endhint %}

**Before you begin**

Identify the replication pair ID on the source cluster:

```bash
weka fs replication
```

**Procedure**

1. On the **source** cluster, pause the replication pair. A running pair cannot be removed. A pair in the `ERROR` state can be removed without pausing it:

```bash
weka fs replication pause <pair ID>
```

Wait until the pair finishes its current cycle and **Current Status** shows `IDLE`.

2. Remove the pair:

```bash
weka fs replication remove <pair ID> [--force]
```

The command removes the pair from both clusters, and reports success only after both are done. It prompts for confirmation. Use `--force` to skip the confirmation prompt, for example, in scripts.

If the target cluster is unreachable, the removal fails and the pair stays on both clusters. Retry when the target is reachable again. To remove the pair from the source cluster only, add `--local-only`, and then remove it on the target cluster as well.

3. Verify that the pair is no longer listed:

```bash
weka fs replication
```

The target filesystem remains write-protected after the pair is removed. To make it writable, run this command on the target cluster:

```bash
weka fs update <target filesystem> --access rw
```

Do this only when you intend to promote the target, such as during failover. See [Activate the target cluster during failover](manage-asynchronous-replication.md#activate-the-target-cluster-during-failover).

### Remove a pair on the target cluster

On the target cluster, `weka fs replication remove` removes an incoming pair (role `TARGET`) only with `--local-only`. Use it when the source cluster is unavailable. The pair does not need to be paused:

```bash
weka fs replication remove <pair ID on the target> --local-only
```

If the source cluster is still running, its next replication cycle for the pair moves to the error state. Remove the pair on the source cluster as well.

## Remove a cluster link

Remove a cluster link when replication between the two clusters is no longer required. One command removes the link from both clusters.

**Before you begin**

Remove every replication pair that uses the link, in both directions. See [Remove a replication pair](manage-asynchronous-replication.md#remove-a-replication-pair). Identify the link ID:

```bash
weka cluster link
```

**Procedure**

1. Remove the link on either cluster:

```bash
weka cluster link remove <link ID> [--force]
```

The command prompts for confirmation. Use `--force` to skip the confirmation prompt.

2. Verify on both clusters that the link is gone:

```bash
weka cluster link
```

If the command reports that the link is in use, a replication pair or a task still uses it, or a filesystem on this cluster still receives a replica over it. Remove the remaining pairs, or wait for the task to finish, and run the command again.

To remove the link on this cluster only, add `--local-only`. Use it when the other cluster is unreachable or no longer exists, or when the link exists on only one of the clusters. `--local-only` also removes a link that a target filesystem still receives a replica over.

Removing a link does not restore write access to the target filesystems. They stay write-protected until you promote them, as described in [Activate the target cluster during failover](manage-asynchronous-replication.md#activate-the-target-cluster-during-failover).

## Activate the target cluster during failover

Activate the target filesystem when the source cluster becomes unavailable, and redirect clients to it.

{% hint style="warning" %}
Failover is a manual procedure. Because replication is asynchronous, the target reflects the last replicated snapshot. Writes made on the source after that snapshot are lost.
{% endhint %}

**Before you begin**

* Confirm the recovery point. On the source cluster, if it is still reachable, check the **Last Replication** timestamp:

```bash
weka fs replication
```

* Confirm that the target contains the data you need:
  * With `COPY_FIRST` and `--copy-path full`, all data is local. No action is required.
  * Hydrate data before breaking any other pair type. This includes `INSTANT_ACCESS`, Selective copy - critical paths pairs, and smaller targets.
  * These pairs can reference source-only data. Breaking the pair makes that data permanently unreadable.
  * Run `weka fs replication fetch <path>` for each required path. Reading files does not hydrate them. See [Manage file hydration on the target](manage-asynchronous-replication.md#manage-file-hydration-on-the-target).

{% hint style="info" %}
On the target cluster, `weka fs replication` lists the pair with the role `TARGET`. Its pair ID on the target can differ from its ID on the source.
{% endhint %}

**Procedure**

The steps differ depending on whether the source cluster is still reachable.

_Planned failover, source cluster reachable:_

1. On the **source** cluster, pause the pair, wait until **Current Status** shows `IDLE`, and remove it. The removal clears the pair on both clusters:

```bash
weka fs replication pause <pair ID>
weka fs replication remove <pair ID>
```

_Disaster failover, source cluster unavailable:_

1. On the **target** cluster, remove the incoming pair. The source is unreachable, so the pair is removed on the target only:

```bash
weka fs replication remove <pair ID on the target> --local-only
```

_Both cases, to promote the target:_

2. Remove write protection from the target filesystem. On the target cluster:

```bash
weka fs update <name> --access rw
```

3. Mount the filesystem on a client and verify the data before redirecting production traffic to it.

When the source cluster returns, its pair moves to the error state on the next cycle. Remove the pair on the source cluster with `weka fs replication remove <pair ID>`.

## Fail back to the original source cluster

After a failover, return replication and clients to the original source cluster by creating a replication pair in the reverse direction, from the former target to the original source. Keep the cluster link: one link carries replication in both directions. The new pair starts with a full first replication cycle.

**Before you begin**

* Confirm that the original source cluster is running. On the former target cluster, run `weka cluster link` and check that the link shows **Connection** `connected` or `degraded` and **Pairing** `mutual`.
* After a disaster failover, the original source cluster still lists the old pair, in the `ERROR` state. Remove it on that cluster with `weka fs replication remove <pair ID>`. A pair in the `ERROR` state does not need to be paused. After a planned failover, the pair is already removed from both clusters.
* Choose the filesystem name on the original source cluster. The replication pair creates this filesystem in its first cycle, so the name must not exist there. Use a new name, or remove the original filesystem first.

**Procedure**

1. On the former target cluster, identify the link ID:

```bash
weka cluster link
```

2. On the former target cluster, create the pair. Use a full data copy with `COPY_FIRST`, so all data is local on the original source cluster before you move clients back:

```bash
weka fs replication add --source-filesystem <name> --link-id <link ID> --target-filesystem <name on the original source> --interval 5m --copy-path full --access-strategy COPY_FIRST
```

3. Wait until **Last Replication** shows a completed cycle:

```bash
weka fs replication
```

4. Move clients back by following [Activate the target cluster during failover](manage-asynchronous-replication.md#activate-the-target-cluster-during-failover), with the original source cluster as the target.
