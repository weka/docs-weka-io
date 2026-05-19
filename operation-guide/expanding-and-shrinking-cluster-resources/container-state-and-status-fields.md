---
description: >-
  Learn how to interpret how state and status in container and process output
  from the CLI and REST API.
---

# Container state and status fields

Use these fields to separate cluster intent from live process health during maintenance, expansion, deactivation, and troubleshooting.

* `state`: the container lifecycle requested by the cluster.
* `status`: the current health of the container's internal processes.

The values can differ. For example, a container can remain `ACTIVE` in `state` while reporting `DOWN` in `status`. Read both fields together to get a complete picture of a container's condition.

### Where to view the fields

You can view `state` and `status` in the CLI and REST API.

**CLI**

All containers:

```bash
weka cluster container
```

A specific container:

```bash
weka cluster container <container-id>
```

**REST API**

All containers:

```
GET /containers
```

A specific container:

```
GET /containers/{uid}
```

### `state`: Administrative lifecycle

`state` tracks the lifecycle of the container as directed by the cluster.

<table><thead><tr><th width="197">Value</th><th>Description</th></tr></thead><tbody><tr><td><code>ACTIVE</code></td><td>The container is a full participating member of the cluster.</td></tr><tr><td><code>ADDING</code></td><td>The container is joining the cluster for the first time.</td></tr><tr><td><code>DEACTIVATING</code></td><td>The cluster has received a deactivation request and is processing it. The container is winding down its cluster participation.</td></tr><tr><td><code>INACTIVE</code></td><td>The container is deactivated. It remains registered but contributes no resources.</td></tr><tr><td><code>DRAINING</code></td><td>The cluster is moving data and responsibilities away from the container before it can be safely deactivated or removed.</td></tr><tr><td><code>DRAINED</code></td><td>Draining is complete. The container holds no cluster data or responsibilities and can be safely deactivated or removed.</td></tr><tr><td><code>REMOVING</code></td><td>The container is being permanently removed from the cluster.</td></tr></tbody></table>

### `status`: Live health

`status` tracks whether the container's internal processes are connected at this moment. Some values mirror an active administrative transition. Others report process health directly.

<table><thead><tr><th width="198">Value</th><th>Description</th></tr></thead><tbody><tr><td><code>UP</code></td><td>All container processes are connected and healthy.</td></tr><tr><td><code>DEGRADED</code></td><td>Some container processes are connected. The container is partially functional.</td></tr><tr><td><code>DOWN</code></td><td>No container processes are reachable. The container is not contributing to the cluster.</td></tr><tr><td><code>ADDING</code></td><td>The container is still joining the cluster. Mirrors the <code>ADDING</code> state.</td></tr><tr><td><code>DEACTIVATING</code></td><td>The container is being deactivated. Mirrors the <code>DEACTIVATING</code> state.</td></tr><tr><td><code>REMOVING</code></td><td>The container is being removed. Mirrors the <code>REMOVING</code> state.</td></tr><tr><td><code>INACTIVE</code></td><td>The container is deactivated. Mirrors the <code>INACTIVE</code> state.</td></tr><tr><td><code>DRAINING</code></td><td>The container is draining while its processes are still up or partially up.</td></tr><tr><td><code>DRAINED (UP)</code></td><td>Draining is complete. All processes are still running.</td></tr><tr><td><code>DRAINED (DEGRADED)</code></td><td>Draining is complete. Some processes are still running.</td></tr><tr><td><code>DRAINED (DOWN)</code></td><td>Draining is complete. All processes are offline.</td></tr></tbody></table>

### Common field combinations

<table data-header-hidden><thead><tr><th width="123">state</th><th width="154">status</th><th>Meaning</th></tr></thead><tbody><tr><td><code>ACTIVE</code></td><td><code>UP</code></td><td>The container is active and all processes are healthy.</td></tr><tr><td><code>ACTIVE</code></td><td><code>DEGRADED</code></td><td>The container is active but some processes have lost connectivity.</td></tr><tr><td><code>ACTIVE</code></td><td><code>DOWN</code></td><td>The container is registered as active but all processes are unreachable and it is not contributing to the cluster.</td></tr><tr><td><code>DRAINING</code></td><td><code>DRAINING</code></td><td>The cluster is migrating workloads off the container and its processes are still available.</td></tr><tr><td><code>DRAINED</code></td><td><code>DRAINED (DOWN)</code></td><td>Draining is complete and all processes are offline. The container can be safely deactivated or removed.</td></tr></tbody></table>

### Process `status`: Individual process health

Each container runs one or more processes. The cluster leader tracks the status of each process independently. Container `status` is derived from the combined health of these individual processes.

You can view process status in the CLI and REST API.

**CLI**

All processes:

```bash
weka cluster process
```

A specific process:

```bash
weka cluster process <process-id>
```

**REST API**

```
GET /api/v2/processes
```

The five process status values fall into two groups.

**Unmonitored:** the process is not an active cluster member.

<table><thead><tr><th width="125">Value</th><th>Description</th></tr></thead><tbody><tr><td><code>DOWN</code></td><td>The process is not an active cluster member. This is the stable state after fencing completes, or before a process has ever joined.</td></tr><tr><td><code>FENCING</code></td><td>The leader is isolating the process. Other members are being instructed to stop trusting it. This is a short transition state before the process moves to <code>DOWN</code>.</td></tr></tbody></table>

**Monitored:** the process is in the join pipeline or fully active.

<table><thead><tr><th width="130">Value</th><th>Description</th></tr></thead><tbody><tr><td><code>SYNCING</code></td><td>The leader has accepted the process for rejoin but it is waiting for link connectivity prerequisites and a slot in the joining batch.</td></tr><tr><td><code>JOINING</code></td><td>The process is in the active rejoin batch. The leader is validating connectivity and session before promoting it to <code>UP</code>.</td></tr><tr><td><code>UP</code></td><td>The process is a full cluster member, trusted for IO, heartbeats, and role-specific work.</td></tr></tbody></table>

The typical progression after a restart or network event is `DOWN` → `SYNCING` → `JOINING` → `UP`. A process that leaves `UP` due to a failure is fenced first (`FENCING`) before returning to `DOWN`. A healthy cluster has almost all processes in `UP`.

**Related topics**

* [Expand specific resources of a container](expansion-of-specific-resources.md)
* [Shrink a cluster](shrinking-a-cluster.md)
* [WEKA REST API and equivalent CLI commands](../../getting-started-with-weka/weka-rest-api-and-equivalent-cli-commands.md)
