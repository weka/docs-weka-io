---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-system-overview/cluster-capacity-and-redundancy-management
---

# Cluster capacity and redundancy management

Effective cluster capacity and redundancy management are crucial for ensuring data protection, availability, and optimal performance in WEKA systems. This involves understanding key capacity metrics, redundancy configurations, and the system's mechanisms for handling failures.

## Key capacity terms

Understanding the terminology related to storage capacity is fundamental:

* **Raw capacity**: This represents the total physical storage capacity of all SSDs assigned to a WEKA cluster. For example, if a cluster has 10 SSDs, each with 1 terabyte of capacity, the raw capacity is 10 terabytes. This figure automatically updates when more SSDs are added (or removed) from the cluster.
* **Net (usable) capacity**: This is the actual space available on the SSDs for storing user data. The net capacity is derived from the raw capacity and is influenced by several factors:
  * The chosen stripe width and protection level, which dedicate some capacity to system protection.
  * The allocation for hot spares, reserved for redundancy and rebuilds.
  * The WEKA cluster reserved capacity, allocated for internal system operations.
* **Provisioned capacity**: This refers to the total capacity that has been assigned to filesystems within the WEKA cluster. It includes capacity from both SSDs and any configured object stores.
* **Available capacity**: This is the remaining net capacity that can be used to allocate additional capacity to existing filesystems and create new filesystems . It is calculated by subtracting the provisioned capacity from the net capacity.

## Redundancy and protection levels

WEKA employs a distributed RAID system that supports a range of redundancy configurations. These are based on a **D+P model**, where D is the number of data blocks and P is the number of parity blocks. Together they form a **stripe**, the unit WEKA protects and rebuilds. A 6+2 configuration, for example, writes every stripe as 6 data blocks and 2 parity blocks.

The **data stripe width** (D) is the number of data blocks per stripe. A configuration written as 6+P has 6 data blocks per stripe, 16+P has 16 data blocks per stripe, and so on, where P is the selected protection level. Data blocks in a stripe are accessed in parallel by the cluster. A higher D value increases the theoretical I/O speed for a file.

The **protection level** (P) is the number of parity blocks written per stripe. A configuration written as D+2 has two parity blocks per stripe, D+3 has three parity blocks per stripe, and so on (where D is equal to whichever number of data blocks you choose).

The number of data blocks must always be greater than the number of parity blocks, so a 3+3 configuration is not allowed.

**What a protection level protects against**

The protection level is the number of **failure domains** the cluster can lose at the same time without losing data. Each block in a stripe is written to exactly one failure domain, so in a 6+2 cluster, when writing a new stripe, data for a file is written to **8** unique failure domains.

## Failure domains

A **failure domain** is a **user-defined set** of WEKA servers that are susceptible to **simultaneous** failure due to a single root cause. This could be, for example, a shared power circuit or a common network switch malfunction.

Usually, each backend server is its own failure domain, so a protection level of 2 means the cluster will survive 2 servers failing simultaneously.

A failure domain can be configured to instead span **several** servers; for example, a rack whose servers share a power circuit and/or a top-of-rack switch. The protection level would then cover the simultaneous failure of that many racks.

This is why the protection level is not a count of drives. A failure domain can hold several servers, and each server holds several drives, so the number of individual drives the cluster can lose within these failure domains is larger than the protection level. With protection level 2, one server per failure domain, and 10 drives per server, the cluster tolerates the simultaneous loss of all 20 drives in those 2 servers.

For instructions on how to define failure domains, see [planning-a-weka-system-installation.md](../planning-and-installation/bare-metal/planning-a-weka-system-installation.md "mention").

### **Choosing a level**

The selection of an appropriate redundancy level is a balance between fault tolerance, usable storage capacity, and system performance:

* **D+2**: This is the recommended level for most environments, providing a standard degree of fault tolerance. A system with protection level 2 survives the simultaneous loss of 2 failure domains (typically 2 servers).
* **D+3**: This level offers increased data protection and is suitable for environments with higher availability requirements. A system with protection level 3 survives the simultaneous loss of 3 failure domains, (typically 3 servers).
* **D+4**: Designed for very large-scale clusters (typically 100+ backend servers) or for scenarios involving critical data that demands maximum redundancy. A system with protection level 4 survives the simultaneous loss of 4 failure domains, (typically 4 servers).

Higher protection levels inherently provide better data durability and availability. However, they also consume more raw storage space for parity blocks, and add a small amount of overhead due to the additional parity calculations for each write.

The protection level for a WEKA cluster is determined at the time of its formation and **cannot be changed later**. If no specific protection level is configured, the system defaults to protection level 2.

{% hint style="info" %}
The documentation generally assumes a homogeneous WEKA system deployment, meaning an equal number of servers and identical SSD capacities per server in each failure domain. For guidance on heterogeneous configurations, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

## Stripe width

**Stripe width** refers to the total number of blocks, both data and parity, that constitute a common protection set. In a WEKA cluster, the stripe width can range from 5 to 20 blocks. This total is composed of 3 to 16 data blocks and 2 to 4 parity blocks. For instance, a stripe width of 18 could represent a configuration of 16 data blocks and 2 parity blocks (16+2).

WEKA uses a **distributed any-to-any protection** scheme. This means that instead of data and parity blocks being confined to fixed protection groups - for example, a specific set of drives - they are distributed across multiple **failure-domains** in the cluster. For example, in a configuration with a stripe width of 8 (6 data blocks and 2 parity blocks), these 8 blocks are spread across various servers to enhance resilience.

Like the protection level, the stripe width is also determined during the initial cluster formation and **cannot be altered subsequently**. The stripe width has a direct impact on both system performance (especially write throughput) and the usable storage capacity. Larger stripe widths generally improve write throughput because they reduce the proportion of parity overhead in write operations. This is particularly beneficial for high-ingest workloads, such as initial data loading or applications where most of the work involves writing new data.

## Hot spare capacity

WEKA clusters can be configured to proactively reserve a portion of the total storage space as **virtual hot spare capacity** to ensure that sufficient space is immediately available for data rebuilds in the event of component failures.

The **hot spare capacity** represents the number of failure domains the system can afford to lose and still successfully perform a complete data rebuild, whilst maintaining the system's net capacity. All failure domains in the cluster actively contribute to data storage, and this hot spare capacity is evenly distributed among them.

If not explicitly configured by the administrator, the hot spare value is automatically set to 1. While a higher hot spare count provides greater flexibility for IT maintenance and hardware replacements when the cluster is at capacity, it also necessitates additional hardware to achieve the same net usable capacity.

The number of hot spares configured for a cluster is often represented as a third value in the stripe size calculation. For example, a cluster stripe size of 16 + 2 + 1 represents 16 data blocks, 2 parity blocks and 1 hot spare block per stripe. Unlike the other stripe size options, the hot spare configuration can be adjusted after cluster creation.

## WEKA cluster reserved capacity ratio

After accounting for the capacity dedicated to data protection (parity) and hot spares, an additional **10 percent** of the remaining capacity is reserved for WEKA cluster internal use.

## SSD net storage capacity calculation

The formula for calculating the SSD net storage capacity is:

<div data-with-frame="true"><figure><img src="../.gitbook/assets/SSD_net_capacity_calculation.png" alt=""><figcaption></figcaption></figure></div>

**Examples**:

**Scenario 1**: A homogeneous system of 10 servers, each with 1 terabyte of raw SSD capacity (total 10TB raw capacity). The system is configured with 1 hot spare and a protection scheme of 6+2 (6 data blocks, 2 parity blocks).

<div data-with-frame="true"><figure><img src="../.gitbook/assets/SSD_net_capacity_example1.png" alt="" width="563"><figcaption></figcaption></figure></div>

**Scenario 2**: A homogeneous system of 20 servers, each with 1 terabyte of raw SSD capacity (total 20TB raw capacity). The system is configured with 2 hot spares and a protection scheme of 16+2 (16 data blocks, 2 parity blocks).

<div data-with-frame="true"><figure><img src="../.gitbook/assets/SSD_net_capacity_example2.png" alt="" width="563"><figcaption></figcaption></figure></div>

## Performance and resilience during failures

### **Data rebuilds**

When drives fail either individually or in aggregate (due to a missing or offline component like a drive or server), WEKA initiates a rebuild process to reconstruct the missing data. Rebuild operations are primarily **read-intensive:** the system reads data from the remaining drives in the affected stripes to reconstruct the lost information, which is then written to available failure domain(s).

A key optimization in WEKA's rebuild process is its behavior when a failed component comes back online. If a failed drive or server returns to an operational state **after** a rebuild has commenced, the rebuild is **automatically aborted**, and the cluster will **redistribute** data back to the returned drives at a lower priority.

This intelligent approach prevents unnecessary data movement and allows the system to quickly restore normal operations, especially in cases of transient failures (for example, servers returning from a brief maintenance window). This significantly differentiates WEKA from traditional systems that often continue lengthy rebuild processes even after the underlying fault has been resolved.

### **Resilience to serial failures**

Beyond the configured **simultaneous failure protection** (N+2, N+3, or N+4), a WEKA cluster also exhibits resilience to [**serial failures**](#user-content-fn-1)[^1] of additional failure domains. This means that as long as each data rebuild operation completes successfully **and** there is sufficient **available** SSD capacity in the cluster, the system can tolerate subsequent serial failure domain losses.

For example: consider a cluster of 20 servers with a stripe width of 18 (16+2). After successfully rebuilding from a simultaneous failure of 2 failure domains, the cluster is **again** resilient to two additional simultaneous server failures. If further serial server failures occur, the system attempts to rebuild its data stripes using the remaining healthy servers to maintain the required stripe width (for example, 18).

Theoretically, this process can continue - subject to sufficient available SSD capacity - until a lower limit of healthy servers is reached. Failures beyond this critical threshold will result in the filesystem going offline.

In the event of serial server failures coupled with insufficient SSD capacity to complete rebuilds, the cluster attempts to **tier data** that currently resides on SSD out to its configured object stores. This is called [**backpressure mode**](#user-content-fn-2)[^2] where the tiering does not consider the age of the data (unlike normal, orderly tiering) but instead tiers data in an approximately random fashion. This process prioritizes data integrity by offloading data to an object store when SSD available capacity is critically low.

### Failure domain folding

{% hint style="warning" %}
Folded failure domains present additional risk to a cluster's availability beyond the configured protection level. Ensure your cluster contains at least as many failure domains as the cluster stripe width + 1 (for example, **19** for a cluster with stripe size of 16 + 2).
{% endhint %}

In scenarios where hardware failures persist and components are not replaced promptly, WEKA employs a process called **failure domain folding** to maintain write availability. This process temporarily relaxes the standard requirement that each RAID stripe must span only distinct failure domains (for example, one block per backend storage server within a stripe).

By allowing a single failure domain to effectively appear multiple times within a newly allocated stripe, the system can continue to allocate new stripes and accept write operations even when in a degraded state.

Failure domain folding is automatically triggered when the number of active (healthy) failure domains becomes insufficient to satisfy the original stripe width requirement, which typically occurs due to server deactivation or the loss of multiple drives. This adaptive approach ensures that the system can remain operational and continue to accept writes during extended fault conditions, without necessitating immediate hardware replacement.

The process can be visualized in three stages:

1. **Stage A: Normal operation (all drives active)**: In the initial state, all backend storage servers are operational. Each server is treated as a distinct failure domain. RAID stripes, consisting of data (yellow blocks) and parity (purple blocks), span horizontally across all available failure domains. New stripe allocations proceed normally, utilizing free space across all failure domains. The system is configured with hot spare capacity (equivalent to two full servers) allocated across the system.
2. **Stage B: write blocking after a drive failure**: When a single drive fails, any new stripe that must span all failure domains can no longer be allocated if any one domain lacks sufficient space due to the failure. Even though only one drive has failed, this strict allocation requirement can effectively block new writes. This results in a disproportionate loss of writable capacity relative to the actual size of the failure, particularly noticeable in systems with fewer drives per server.
3. **Stage C: Write recovery through failure domain folding**: To mitigate the blocked write condition, the affected storage server (failure domain) can be manually deactivated. This allows WEKA to apply failure domain folding. The system relaxes the one-domain-per-stripe rule, permitting the reuse of the same failure domain within a newly allocated stripe. This mechanism restores write capability without requiring immediate hardware replacement, ensuring continued system operation under degraded conditions.

<div data-with-frame="true"><figure><img src="../.gitbook/assets/failure_domain_folding.png" alt=""><figcaption><p>Failure domain in action (example)</p></figcaption></figure></div>

### Theoretical minimum required healthy servers

In the event of repeated serialized failures, a minimum number of healthy failure-domains is required for the cluster to remain operational. This is represented by the following formula:

<div data-with-frame="true"><figure><img src="../.gitbook/assets/Healthy_servers_calculation.png" alt="" width="531"><figcaption></figcaption></figure></div>

**Examples:**

| Stripe data width + protection level | Minimum required healthy failure domains |
| ------------------------------------ | ---------------------------------------- |
| 5+2                                  | 4                                        |
| 16+2                                 | 9                                        |
| 5+4                                  | 3                                        |
| 16+4                                 | 5                                        |

{% hint style="warning" %}
This minimum is theoretical and does not take into account availability of other required cluster resources.
{% endhint %}

[^1]: **Serial failures:** Refers to a sequence where each data rebuild finishes before another server fails, ensuring one-at-a-time failure handling.

[^2]: Backpressure mode is an emergency response that helps a system continue functioning by offloading data to secondary storage when primary storage is insufficient.
