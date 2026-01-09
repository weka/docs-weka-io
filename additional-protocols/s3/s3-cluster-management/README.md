---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-cluster-management
---

# S3 cluster management

## S3 considerations

The WEKA S3 service is designed for scalable performance and resilient operation across distributed containers.

* **Performance and scalability:** The S3 service runs in WEKA cluster containers and scales near-linearly as additional containers join the cluster. \
  Throughput and concurrency increase proportionally with cluster size. In appropriately sized deployments, performance reaches millions of requests per second on medium clusters (approximately 30 servers) and tens of millions on larger clusters (approximately 100 servers).
* **Redundancy:** The S3 service requires a minimum of two containers to provide redundancy and fault tolerance. A single-container deployment is supported when redundancy is not required.
* **Configuration filesystem:** The S3 service requires a dedicated filesystem to persist protocol configuration across the cluster. Verify that this filesystem exists before enabling the S3 service (see the related topic below).
* **Interfaces and access:** The S3 service is accessible through the assigned port (default: 9000) on all configured interfaces of each WEKA server where the protocol is enabled.\
  S3 does not use dedicated or floating IP addresses.

**Related topic**

&#x20;[#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention").

## Round-robin DNS or load balancer **configuration**

To distribute S3 client traffic across WEKA servers with the S3 protocol enabled, it is recommended to set up a round-robin DNS entry that resolves to the IP addresses of the servers. If the WEKA servers have multiple network interfaces, ensure that the DNS entry uses the IPs corresponding to the network(s) intended for S3 traffic.

For added resilience, consider using a DNS server that supports health checks to detect unresponsive servers. Keep in mind that even robust DNS servers or load balancers may become overwhelmed under extreme load conditions.

Alternatively, a client-side load balancer can be used, allowing each client to check the health of S3 containers in the cluster. Configure the load balancer to probe the following endpoint: `/wekas3api/health/ready`.

An example of a suitable load balancer is the open-source **Sidekick Load Balancer**.

**Related information**

[Round-robin DNS](https://en.wikipedia.org/wiki/Round-robin_DNS)

[Sidekick Load Balancer](https://github.com/minio/sidekick)

**Related topics**

[s3-cluster-management.md](s3-cluster-management.md "mention")

[s3-cluster-management-1.md](s3-cluster-management-1.md "mention")
