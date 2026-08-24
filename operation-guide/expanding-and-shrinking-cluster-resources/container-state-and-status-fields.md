---
description: >-
  Interpret container and process state and status fields in CLI and REST API
  output.
---

# Container state and status fields

Use the `state` and `status` fields together to understand both the intended lifecycle of a container and the current health of its internal processes. These fields help identify whether a container is operating normally, transitioning between administrative operations, or experiencing connectivity or process failures.

* `state`: the container lifecycle.
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

`state` tracks the container lifecycle managed by the cluster leader.

| Value          | Description                                                                                                                    |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| `ACTIVE`       | The container is a full participating member of the cluster.                                                                   |
| `ADDING`       | The container is joining the cluster for the first time.                                                                       |
| `DEACTIVATING` | The cluster has received a deactivation request and is processing it. The container is winding down its cluster participation. |
| `INACTIVE`     | The container is deactivated. It remains registered but contributes no resources.                                              |
| `DRAINING`     | The cluster is moving data and responsibilities away from the container before it can be safely deactivated or removed.        |
| `DRAINED`      | Draining is complete. The container holds no cluster data or responsibilities and can be safely deactivated or removed.        |
| `REMOVING`     | The container is being permanently removed from the cluster.                                                                   |

### `status`: Live health

`status` tracks whether the container's internal processes are connected at this moment. Some values mirror an active administrative transition. Others report process health directly.

| Value                | Description                                                                             |
| -------------------- | --------------------------------------------------------------------------------------- |
| `UP`                 | All container processes are connected and healthy.                                      |
| `DEGRADED`           | Some container processes are connected. The container is partially functional.          |
| `DOWN`               | No container processes are reachable. The container is not contributing to the cluster. |
| `ADDING`             | The container is still joining the cluster. Mirrors the `ADDING` state.                 |
| `DEACTIVATING`       | The container is being deactivated. Mirrors the `DEACTIVATING` state.                   |
| `REMOVING`           | The container is being removed. Mirrors the `REMOVING` state.                           |
| `INACTIVE`           | The container is deactivated. Mirrors the `INACTIVE` state.                             |
| `DRAINING`           | The container is draining while its processes are still up or partially up.             |
| `DRAINED (UP)`       | Draining is complete. All processes are still running.                                  |
| `DRAINED (DEGRADED)` | Draining is complete. Some processes are still running.                                 |
| `DRAINED (DOWN)`     | Draining is complete. All processes are offline.                                        |

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

| Value     | Description                                                                                                                                                       |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `DOWN`    | The process is not an active cluster member. This is the stable state after fencing completes, or before a process has ever joined.                               |
| `FENCING` | The leader is isolating the process. Other members are being instructed to stop trusting it. This is a short transition state before the process moves to `DOWN`. |

**Monitored:** the process is in the join pipeline or fully active.

| Value     | Description                                                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| `SYNCING` | The leader has accepted the process for rejoin but it is waiting for link connectivity prerequisites and a slot in the joining batch. |
| `JOINING` | The process is in the active rejoin batch. The leader is validating connectivity and session before promoting it to `UP`.             |
| `UP`      | The process is a full cluster member, trusted for IO, heartbeats, and role-specific work.                                             |

The typical progression after a restart or network event is `DOWN` → `SYNCING` → `JOINING` → `UP`. A process that leaves `UP` due to a failure is fenced first (`FENCING`) before returning to `DOWN`. A healthy cluster has almost all processes in `UP`.

**Related topics**

* [Expand specific resources of a container](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/operation-guide/expanding-and-shrinking-cluster-resources/expansion-of-specific-resources)
* [Shrink a cluster](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/operation-guide/expanding-and-shrinking-cluster-resources/shrinking-a-cluster)
* [WEKA REST API and equivalent CLI commands](https://app.gitbook.com/s/ZW262oqYA8pNNfGvXjHa/getting-started-with-weka/weka-rest-api-and-equivalent-cli-commands)
