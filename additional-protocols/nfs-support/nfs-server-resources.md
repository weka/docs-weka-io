---
description: >-
  Understand the client connections, open files, and memory that each NFS
  container serves within, and what happens at each maximum.
---

# NFS server resources

Each NFS container serves clients within three resources: client connections, open files, and memory. Knowing these maximums helps you size the NFS service for your clients and workloads, and act before a container reaches a maximum and clients are affected.

The maximum of each resource applies to every NFS container on its own, not to the cluster, a tenant, or an export.

| Resource | Default | Accepted values | Setting |
| --- | --- | --- | --- |
| Client connections | Automatic: 1024 for each NFS server. With NFS multi-tenancy, the automatic value is sized from the number of NFS containers. | `0` (automatic), or 1024 to 65536 | `--max-client-connections` |
| Open files | 500000 | `0` (default), or 10000 to 10000000 | `--max-open-fds` |
| Memory ceiling | 32 GiB | 2 GiB to 512 GiB, in whole GiB | `--max-memory` |

## When a change to a maximum applies

The maximums take effect at different times, and the operating system of each server must allow the resulting file descriptor limit. Plan the memory ceiling before you deploy NFS, and check the kernel settings of the servers before you raise the other maximums.

Changes to the client connections and open files maximums apply to the running NFS servers. Set the memory ceiling before you configure the first NFS container. It then applies to every NFS container.

Each NFS server process has a file descriptor limit equal to the client connections maximum, plus the open files maximum, plus 4096. The kernel settings `fs.nr_open` and `fs.file-max` on each server must allow this value. If a server's kernel settings are lower, the cluster raises the `NfsResourceLimitNotApplied` alert, which names the setting to raise.

## Resource states

The state of each resource shows how close an NFS container is to the maximum, so you can act before the container reaches it.

| State | Usage of the maximum |
| --- | --- |
| `OK` | Below 70% |
| `HIGH` | 70% or more |
| `LIMIT` | 90% or more |

The cluster raises an alert for each resource that approaches its maximum. See [list-of-alerts-and-corrective-actions.md](../../operation-guide/alerts/list-of-alerts-and-corrective-actions.md "mention").

The `nfs_resources` statistics category records the same values over time. See [statistics-list.md](../../operation-guide/statistics/statistics-list.md "mention").

## Behavior at a maximum

Each resource affects clients differently when an NFS container reaches its maximum. Use this behavior to decide which maximums to raise first.

* **Client connections:** New connections wait until a connection closes. Existing connections continue.
* **Open files:** A request that needs another open file is delayed, and the client retries it.
* **Memory:** The NFS container restarts.

## Considerations

* Each `nconnect` channel that a client opens counts as one client connection.
* Lowering the client connections maximum below the current usage keeps the existing connections. The new maximum applies to new connections.
* Usage is reported for each NFS container. To find the clients that use a container's connections, run client-side tools such as `ss` on the clients.

**Related topics**

[#configure-the-nfs-global-settings](nfs-support-1.md#configure-the-nfs-global-settings "mention") (set the maximums)

[#view-nfs-server-resource-usage](nfs-support-1.md#view-nfs-server-resource-usage "mention") (view the usage)
