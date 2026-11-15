---
description: >-
  Identify the maximum values that apply to each tenant and to the shared
  cluster resources when you plan a multi-tenant deployment.
---

# Multi-tenancy maximums

These maximums define how far a multi-tenant deployment scales. Some apply to each tenant separately, and others are cluster-wide pools that all tenants share.

## Per-tenant maximums

| Item                                  | Maximum                                                   | Details                                                                                                        |
| ------------------------------------- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| Tenants per cluster                   | 256, including the root tenant                             | Up to 255 tenants in addition to the root tenant.                                                              |
| Tenant name length                    | 64 bytes                                                   | The name must be unique.                                                                                       |
| SSD capacity quota                    | Minimum 1 GiB, with no upper bound                         | See [multi-tenancy-cluster-level-administration.md](multi-tenancy-cluster-level-administration.md "mention").  |
| Total capacity quota                  | Minimum 1 GiB, and at least the SSD quota                  | The quota is bounded by the cluster capacity that is not allocated to other tenants.                           |
| QoS                                   | No upper bound on the maximum throughput and IOPS values   | See [multi-tenancy-cluster-level-administration.md](multi-tenancy-cluster-level-administration.md "mention").  |
| Security policies a tenant can create | 128                                                        | The root tenant is not bound by this maximum.                                                                  |
| Security policies attached to a tenant | 16                                                        |                                                                                                                |
| Network spaces                        | 256 per cluster                                            | Sized 1:1 with the tenant maximum. A tenant can be assigned several network spaces.                            |
| KMS configurations                    | 1 per tenant                                               | Each tenant sets its own KMS configuration.                                                                    |
| User directory (LDAP) configurations  | 1 per tenant                                               | Each tenant sets its own user directory.                                                                       |
| S3 configurations                     | 1 per tenant                                               | Includes the tenant's default filesystem, anonymous UID and GID, admin credentials, and OIDC settings.         |

The root tenant has no capacity quota. It implicitly owns the capacity that is not allocated to any tenant.

## Cluster-wide maximums

The resources in this table are drawn from a single cluster-wide pool that all tenants share. There is no per-tenant reservation, so plan each pool across all tenants together.

| Resource                                    | Cluster-wide maximum                                     |
| ------------------------------------------- | -------------------------------------------------------- |
| Filesystems                                 | 1,024                                                    |
| Directory quotas                            | 51,200, nested up to four levels deep                    |
| Filesystem groups                           | 8                                                        |
| Snapshots (user-visible)                    | 24,576                                                   |
| Snapshot policies                           | 1,025, with up to 10 per filesystem                      |
| Users                                       | 150,000                                                  |
| NFS exports                                 | 1,024                                                    |
| NFS client groups                           | 50                                                       |
| NFS client-group rules                      | 200                                                      |
| SMB shares                                  | 1,024                                                    |
| S3 buckets                                  | 50,000 (a lower cluster-wide maximum can be configured)  |
| Object store configurations                 | 8                                                        |
| Object store buckets                        | 2,048                                                    |
| Floating IP addresses (NFS interface groups) | 200                                                     |
| Subnets                                     | 10                                                       |
| Servers in a cluster                        | 56,320                                                   |

Filesystem groups, snapshot policies, object stores, and SMB shares are managed by cluster administrators. For the operations available to tenant administrators, see [multi-tenancy-tenant-level-administration.md](multi-tenancy-tenant-level-administration.md "mention").

## Client and mount scale

A tenant's clients connect through the network spaces assigned to that tenant, and mounting a tenant's filesystem is supported with stateless clients only.

No maximum applies specifically to a tenant's clients or mounts. The maximums that apply are:

* **Mounts per frontend process:** 3,072.
* **Open files per frontend process:** 520,192.
* Clients count toward the 56,320 servers-in-a-cluster maximum.

**UDP flows per network space:** a network space supports up to 65,533 concurrent UDP flows. Each connected client consumes one flow per process: one for the management process, plus one for each frontend process. A tenant that needs more client scale can be assigned additional network spaces. In releases earlier than 5.1.32.19, a network space supports up to 1,024 concurrent UDP flows.

**Network spaces with RoCE:** the number of network spaces that can use RDMA over Converged Ethernet (RoCE) on a single NIC is bounded by the NIC's GID table, typically 125. The cluster discovers this value from the NIC at runtime. The RDMA column in the `weka cluster network-space` output shows the RDMA state of each network space.

## Maximums during a rolling upgrade

{% hint style="info" %}
During a rolling upgrade, the cluster enforces each maximum at the lowest value among the software versions active in the cluster. Complete the upgrade on all servers to apply the new release's maximums.
{% endhint %}

**Related topics**

[multi-tenancy-cluster-level-administration.md](multi-tenancy-cluster-level-administration.md "mention")

[multi-tenancy-tenant-level-administration.md](multi-tenancy-tenant-level-administration.md "mention")

[s3-limitations.md](../../additional-protocols/s3/s3-limitations.md "mention")
