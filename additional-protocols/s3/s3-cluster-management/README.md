---
description: This page describes how to set up, update, monitor, and delete an S3 cluster.
---

# S3 cluster management

## Considerations

* **Performance scale:** The S3 service can be exposed from the cluster containers**.** The service performance scales linearly as the S3 cluster scales. Depending on the workload, you may need several Frontend cores to gain maximum performance.
* **Redundancy:** A minimum of two containers is required for the S3 cluster to ensure redundancy and fault tolerance. However, creating a single-container S3 cluster is possible, so there will be no redundancy.
* **Cluster-wide configuration filesystem:** Verify that the dedicated filesystem for persistent protocol configurations is created. If not, create it. For details, see [#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention").
* **Interfaces:** The S3 protocol can be accessed using the assigned port (default: 9000) on all configured interfaces on each WEKA server where the protocol is enabled. It does not use dedicated or floating IPs.  &#x20;

## Round-robin DNS or load balancer **configuration**

To distribute S3 client traffic across WEKA servers with the S3 protocol enabled, it is recommended to set up a round-robin DNS entry that resolves to the IP addresses of the servers. If the WEKA servers have multiple network interfaces, ensure that the DNS entry uses the IPs corresponding to the network(s) intended for S3 traffic.

For added resilience, consider using a DNS server that supports health checks to detect unresponsive servers. Keep in mind that even robust DNS servers or load balancers may become overwhelmed under extreme load conditions.

Alternatively, a client-side load balancer can be used, allowing each client to check the health of S3 containers in the cluster. Configure the load balancer to probe the following endpoint: `/wekas3api/health/ready`.

An example of a suitable load balancer is the open-source **Sidekick Load Balancer**.

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS)&#x20;

[Sidekick Load Balancer](https://github.com/minio/sidekick)



**Related topics**

[s3-cluster-management.md](s3-cluster-management.md "mention")

[s3-cluster-management-1.md](s3-cluster-management-1.md "mention")
