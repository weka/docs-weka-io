---
description: >-
  Configure, freeze, and reset traces, and adjust protocols debug levels using
  the CLI.
---

# Manage traces and protocols debug level using the CLI

## Traces

### Initiate trace collection

**Command:** `weka debug traces start`

### Stop trace collection

**Command:** `weka debug traces stop`

### View traces configuration status

**Command:** `weka debug traces status`

### Modify traces retention settings

**Command:** `weka debug traces retention set [--server-max server-max] [--client-max client-max] [--server-ensure-free server-ensure-free] [--client-ensure-free client-ensure-free]`

**Parameters**

<table><thead><tr><th width="190.2265625">Parameter</th><th width="267.0234375">Description</th><th>Default</th></tr></thead><tbody><tr><td><code>server-max</code></td><td>Maximum capacity to retain per server.</td><td>50 GiB per I/O process, with a minimum of 100 GiB and a maximum of 1000 GiB per server.</td></tr><tr><td><code>client-max</code></td><td>Maximum capacity to retain per client.</td><td>50 GiB per I/O process, with a minimum of 100 GiB and a maximum of 1000 GiB per client.</td></tr><tr><td><code>server-ensure-free</code></td><td>Always maintain at least this much capacity to remain free on servers.</td><td>3 GiB</td></tr><tr><td><code>client-ensure-free</code></td><td>Always maintain at least this much capacity to remain free on clients.</td><td>3 GiB</td></tr></tbody></table>

{% hint style="info" %}
The available disk space also limits the effective trace usage. The system always keeps at least the ensure-free reserve available. If it cannot keep even that reserve, it deletes all rotatable traces.
{% endhint %}

To modify the trace retention setting of a single client, you can use the `traces_capacity_mb` mount option. See Additional mount options using the stateless clients feature.

### Restore default traces retention values

**Command:** `weka debug traces retention restore-default`

### Adjust traces verbosity level

**Command:** `weka debug traces level set <level>`

**Parameters**

<table><thead><tr><th width="160.3359375">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>level</code>*</td><td>Verbosity level.<br>Format: <code>low</code> or <code>high</code></td></tr></tbody></table>

### Manage the traces freeze period

**View the frozen trace period**

**Command:** `weka debug traces freeze show`

**Set the freeze period**

**Command:** `weka debug traces freeze set <comment> [--start-time start-time] [--end-time end-time] [--retention retention]`

**Parameters**

<table><thead><tr><th width="155.6015625">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>comment</code>*</td><td>A descriptive note providing context for easier tracking and review of debug traces.</td></tr><tr><td><code>start-time</code></td><td>The start time of the frozen period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>2019-Nov-17 11:11:00.309</code>, <code>9:15Z</code>, <code>10:00+2:00</code></td></tr><tr><td><code>end-time</code></td><td>The end time of the frozen period.<br>Format: <code>5m</code>, <code>-5m</code>, <code>-1d</code>, <code>-1w</code>, <code>1:00</code>, <code>01:00</code>, <code>18:30</code>, <code>18:30:07</code>, <code>2018-12-31 10:00</code>, <code>2018/12/31 10:00</code>, <code>2018-12-31T10:00</code>, <code>2019-Nov-17 11:11:00.309</code>, <code>9:15Z</code>, <code>10:00+2:00</code></td></tr><tr><td><code>retention</code></td><td>The time to retain the traces.<br>Format: <code>3s</code>, <code>2h</code>, <code>4m</code>, <code>1d</code>, <code>1d5h</code>, <code>1w</code>, <code>infinite</code>/<code>unlimited</code></td></tr></tbody></table>

**Reset the traces freeze period**

**Command:** `weka debug traces freeze reset`

{% hint style="warning" %}
Resetting the freeze period deletes the existing frozen traces.
{% endhint %}

## Protocols debug level

### Show S3 debug level

**Command:** `weka s3 log-level get`

### Show the NFS debug level

Shows the running debug level of each NFS server component, and the persisted level. A container whose NFS server is not running shows `not ready`.

**Command:** `weka nfs debug-level show`

```sh
weka nfs debug-level show [--full-list] [--nfs-components <strings>…] [--nfs-hosts <container-ids>…]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `--full-list` | Show all NFS server components. |
| `--nfs-components` | Components to show. |
| `--nfs-hosts` | IDs of the NFS containers to show. |

### Set the NFS debug level

Sets the debug level of the NFS server components. A level set for all NFS servers is persisted and requires the Cluster Admin role. With `--transient` or `--nfs-hosts`, the level applies to the running NFS servers until they restart, and requires the Tenant Admin role. For the scopes, see [#nfs-debug-level-scopes](./#nfs-debug-level-scopes "mention").

**Command:** `weka nfs debug-level set`

```sh
weka nfs debug-level set <level> [--full-list] [--nfs-components <strings>…] [--nfs-hosts <container-ids>…] [--transient]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `level`\* | Debug level: `EVENT`, `INFO`, `DEBUG`, `MID_DEBUG`, or `FULL_DEBUG`. |
| `--full-list` | Apply the level to all NFS server components. |
| `--nfs-components` | Components to apply the level to. |
| `--nfs-hosts` | IDs of the NFS containers to apply the level to. The level applies until each container restarts. |
| `--transient` | Apply the level to the running NFS servers only, without persisting it. |

When the investigation is complete, reset the debug level.

### Reset the NFS debug level

Clears the persisted NFS debug levels on all NFS servers. Each component returns to the level persisted for all components, or to `EVENT`. Requires the Cluster Admin role.

**Command:** `weka nfs debug-level reset`

```sh
weka nfs debug-level reset [--nfs-components <strings>…]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `--nfs-components` | Components to reset. Without this option, all components are reset. |

### List the NFS debug components and levels

Lists the NFS server components or the debug levels that `weka nfs debug-level set` accepts.

**Command:** `weka nfs debug-level list`

```sh
weka nfs debug-level list <what> [--full-list]
```

**Parameters**

| Parameter | Description |
| --- | --- |
| `what`\* | `components` or `levels`. |
| `--full-list` | Show the full list. |

### Set SMB debug level

**Command:** `weka smb cluster debug`

**Parameters**

<table><thead><tr><th width="146.0078125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>level</code></td><td>The debug level.<br>Format: <code>0..10</code></td></tr></tbody></table>
