---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/additional-protocols/s3/s3-cluster-management
---

# S3 cluster management

## S3 considerations

The WEKA S3 service is designed for scalable performance and resilient operation across distributed containers.

* **Performance and scalability:** The S3 service runs in WEKA cluster containers and scales near-linearly as additional containers join the cluster.\
  Throughput and concurrency increase proportionally with cluster size. In appropriately sized deployments, performance reaches millions of requests per second on medium clusters (approximately 30 servers) and tens of millions on larger clusters (approximately 100 servers).
* **Redundancy:** The S3 service requires a minimum of two containers to provide redundancy and fault tolerance. A single-container deployment is supported when redundancy is not required.
* **Configuration filesystem:** The S3 service requires a dedicated filesystem to persist protocol configuration across the cluster. Verify that this filesystem exists before enabling the S3 service (see the related topic below).
* **Interfaces and access:** The S3 service is accessible through the assigned port (default: 9000) on all configured interfaces of each WEKA server where the protocol is enabled.\
  S3 does not use dedicated or floating IP addresses.

## Per-tenant S3 configuration

Manage S3 bucket placement and anonymous access identity using cluster-wide settings with limited tenant overrides.

* **Configuration scope:** The S3 cluster configuration defines cluster-wide settings such as the service port and the default filesystem. Tenants cannot override these settings. Tenants can override only the anonymous POSIX UID and GID for their own workloads. Tenant 0 uses the cluster-level anonymous POSIX UID and GID values.

When a bucket creation request does not specify a filesystem, the system resolves the target filesystem using the tenant's default filesystem. To create a bucket this way, ensure the tenant has a default filesystem configured.

**Related topics**

[#update-per-tenant-s3-configuration](s3-cluster-management-1.md#update-per-tenant-s3-configuration "mention")

[#dedicated-filesystem-requirement-for-persistent-protocol-configurations](../../additional-protocols-overview.md#dedicated-filesystem-requirement-for-persistent-protocol-configurations "mention").

## Load balancer configuration

A load balancer distributes incoming S3 client requests across WEKA servers. It directs each new connection to the most appropriate backend based on availability and current load.

Health checks are central to this setup. Configure the load balancer to probe `/wekas3api/health/ready`. The endpoint returns HTTP `200` when the server is healthy and HTTP `503` when it has exceeded its capacity threshold. This prevents routing requests to unavailable or overloaded containers.

The endpoint also acts as a load probe. Every response includes an `x-weka-score` header with a normalized load score from `0.0` to `1.0`. A score of `0.0` indicates no load. A score of `1.0` indicates full saturation. The service derives the score from active requests and memory usage relative to their maximums.

Append `?c=json` to receive the same values in the body: `/wekas3api/health/ready?c=json`.

```json
{"score":0.73,"rq.active":1500,"rq.max":2048,"mem.active":1473,"mem.max":4096}
```

This data enables Global Server Load Balancing (GSLB). GSLB routes traffic across multiple sites or clusters, typically through DNS. Use the score for weighted routing so healthy, lower-loaded servers receive more traffic. Solutions that support header-based routing can read `x-weka-score` directly without parsing the JSON body. One example is [loadbalancer.org](https://www.loadbalancer.org/).

## Round-robin DNS configuration

Round-robin DNS maps one hostname to multiple IP addresses. DNS responses rotate through those addresses so successive clients connect to different servers.

To distribute S3 traffic with this method, create a DNS entry that resolves to the IP addresses of all servers with the S3 protocol enabled. If the WEKA servers have multiple network interfaces, use the IP addresses on the network intended for S3 traffic.

For added resilience, use a DNS service that supports health checks to detect and remove unresponsive servers from rotation automatically. Keep in mind that DNS-level health checks are coarser than those of a dedicated load balancer and may be less effective under extreme load.

**Related topics**

[s3-cluster-management.md](s3-cluster-management.md "mention")

[s3-cluster-management-1.md](s3-cluster-management-1.md "mention")
