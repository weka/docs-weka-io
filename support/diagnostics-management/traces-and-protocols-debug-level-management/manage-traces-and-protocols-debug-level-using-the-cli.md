---
description: >-
  Configure, freeze, and reset traces, and adjust protocols debug levels using
  the CLI.
---

# Manage traces and protocols debug level using the CLI

{% hint style="danger" %}
**INTERNAL - Nevo:** `weka debug` commands are hidden from the CLI help but documented on this page. Is that intentional, and if so, whose call? Also, verify the command set on this page against the 6.0 CLI given the wekactl migration.
{% endhint %}

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

### Manage NFS debug level

**Command:** `weka nfs debug-level show|set`

**Command options**

<table><thead><tr><th width="137.89453125">Option</th><th>Description</th></tr></thead><tbody><tr><td><code>show</code></td><td>Shows the debug level for the NFS servers.</td></tr><tr><td><code>set</code></td><td>Sets the debug level for the NFS servers. When you complete debugging, return the debug level to default (creates an event).</td></tr></tbody></table>

### Set SMB debug level

**Command:** `weka smb cluster debug`

**Parameters**

<table><thead><tr><th width="146.0078125">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>level</code></td><td>The debug level.<br>Format: <code>0..10</code></td></tr></tbody></table>
