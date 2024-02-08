---
description: This page describes how to set up, update, monitor, and delete an S3 cluster.
---

# S3 cluster management

## Considerations

* **Performance scale:** The S3 service can be exposed from the cluster containers**.** The service performance scales linearly as the S3 cluster scales. Depending on the workload, you may need several Frontend cores to gain maximum performance.
* **Redundancy:** A minimum of two containers is required for the S3 cluster to ensure redundancy and fault tolerance. However, creating a single-container S3 cluster is possible, so there will be no redundancy.
* **Cluster-wide configuration filesystem:** Verify that the dedicated filesystem for persistent protocol configurations is created. If not, create it. For details, see [#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention").
* **Interfaces:** The S3 protocol can be accessed using the assigned port (default: 9000) on all configured interfaces on each WEKA server where the protocol is enabled. It does not use dedicated or floating IPs.  &#x20;

## Round-robin DNS or load balancer

To ensure load balancing between the S3 clients on the WEKA servers where the S3 protocol has been enabled, it is recommended to configure a round-robin DNS entry that resolves to the list of servers' IPs.   If the WEKA servers have multiple interfaces, use the IP addresses that match the network(s) you wish the S3 traffic to flow over.

To ensure resiliency, if any servers serving S3 become unresponsive, consider a DNS server that supports health checks. However, even a robust DNS server or load-balancer may become overloaded with an extreme load. You can also use a client-side load balancer, where each client checks the health of each S3 container in the cluster. An example of such a load balancer is the open-source _Sidekick Load Balancer_.

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS)&#x20;

[Sidekick Load Balancer](https://github.com/minio/sidekick)



**Related topics**

[s3-cluster-management.md](s3-cluster-management.md "mention")

[s3-cluster-management-1.md](s3-cluster-management-1.md "mention")
