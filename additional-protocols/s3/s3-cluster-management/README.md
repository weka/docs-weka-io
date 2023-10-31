---
description: This page describes how to set up, update, monitor, and delete an S3 cluster.
---

# S3 cluster management

## Considerations

* **Performance scale:** The S3 service can be exposed from the cluster containers**.** The service performance scales linearly as the S3 cluster scales. Depending on the workload, you may need several Frontend cores to gain maximum performance.
* **Redundancy:** To ensure redundancy and fault tolerance a minimum of two containers is required for the S3 cluster. However, it is possible to create a single-container S3 cluster, which means there will be no redundancy.
* **Cluster-wide configuration filesystem:** The S3 protocol requires a persistent cluster-wide configuration filesystem (see [Set the global configuration filesystem](../../nfs-support/nfs-support-1.md#configure-the-nfs-configuration-filesystem)).

## Round-robin DNS or load balancer

To ensure load balancing between the S3 clients on the different WEKA servers serving S3, it is recommended to configure a round-robin DNS entry that resolves to the list of servers' IPs.

A DNS server that supports health checks can help with resiliency if any servers serving S3 become unresponsive.

Even a robust DNS server or load-balancer may become overloaded with an extreme load. You can also use a client-side load balancer, where each client checks the health of each S3 container in the cluster. An example of such a load balancer is the open-source _Sidekick Load Balancer_.

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin\_DNS)&#x20;

[Sidekick Load Balancer](https://github.com/minio/sidekick)



**Related topics**

[s3-cluster-management.md](s3-cluster-management.md "mention")

[s3-cluster-management-1.md](s3-cluster-management-1.md "mention")
