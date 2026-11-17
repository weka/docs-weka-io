---
description: >-
  Plan the network between two clusters for asynchronous replication: latency,
  bandwidth, and ports.
---

# Network requirements for asynchronous replication

Asynchronous replication sends metadata and data from the source cluster to the target cluster over the management path and the data path of each cluster. The network between the clusters determines whether each replication cycle completes within the replication interval, and therefore how far the target lags the source.

### Network parameters

* **Round-trip time (RTT):** Keep RTT at 300 ms or less. RTT is supported up to 700 ms, but replication performs best at 300 ms or less.
* **Bandwidth:** Provide 10 Gbps or more. Use a dedicated link, or a QoS class that guarantees bandwidth for replication traffic. See [Bandwidth sizing](network-requirements-for-asynchronous-replication.md#bandwidth-sizing).
* **Jitter:** Keep jitter below 10 ms. Jitter is the RTT variation between consecutive packets. High jitter reduces each connection's effective throughput.
* **Packet loss:** Keep packet loss below 0.01%. Between 0.01% and 0.1%, replication runs with reduced throughput. Low packet loss helps cycles complete within the replication interval.

The target always lags the source by at least the replication interval. See the Considerations in Asynchronous replication.

### Bandwidth sizing

Size the bandwidth so that each replication cycle completes within half of the replication interval. This keeps the replication lag at or below 1.5 times the interval.

Required bandwidth = 2 × data changed per interval ÷ replication interval

To estimate the data changed per interval, create a snapshot of the filesystem and wait one replication interval. The snapshot's estimated reclaimable size counts the data overwritten or deleted since the snapshot; view it with `weka fs snapshot -o est_reclaimable_size`. Add the filesystem's growth in used capacity over the same interval to include new data.

**Example**

A filesystem changes 100 GB during a 5-minute replication interval.

Required bandwidth = 2 × 100 GB ÷ 300 s ≈ 667 MB/s ≈ 5.3 Gbps

A 10 Gbps link carries this change rate with headroom for metadata, for retransmissions, and for the first replication cycle.

The first replication cycle copies the entire filesystem. Estimate its duration as the filesystem size divided by the effective bandwidth. For example, a 100 TB filesystem takes about 22 hours over a 10 Gbps link.

{% hint style="info" %}
Replication sends data as it is stored, without compression or deduplication on the network. Size the bandwidth for the data as written, including data that compresses well.
{% endhint %}

### Connectivity between the clusters

Replication uses two paths between the clusters. Open the following ports in both directions through every firewall between the clusters.

| Path            | Port                                | Direction                                                                                                                                                           |
| --------------- | ----------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Management path | TCP 14000 (default)                 | Between all backend servers of each cluster and the management IP addresses of the other cluster, in both directions                                                |
| Data path       | TCP 9000, or the configured S3 port | Between all backend servers of each cluster, and the servers that run a Data Services container, and the data IP addresses of the other cluster, in both directions |

Each cluster discovers the management and data IP addresses of the other cluster when you add the cluster link. These addresses must be reachable directly from the other cluster. If the clusters can reach each other only through NAT or public addresses, contact the Customer Success Team before you link them.

Replication traffic between the clusters is encrypted with TLS, on both the management path and the data path.

### Verify the network before you link the clusters

**Procedure**

1. From a backend server of the source cluster, measure the RTT, jitter, and packet loss to a management IP address of the target cluster, and compare the results with Network parameters:

```bash
mtr --report --report-cycles 100 <target management IP>
```

2. Verify that the management port and the data port of the target cluster are reachable:

```bash
nc -zv <target management IP> 14000
nc -zv <target data IP> 9000
```

**Related topics**

[Asynchronous replication](./)

[Manage asynchronous replication](manage-asynchronous-replication.md)
