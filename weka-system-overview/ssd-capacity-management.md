---
description: >-
  Understand the key terms of WEKA system capacity management and the formula
  for calculating the net data storage capacity.
---

# SSD capacity management

## Raw capacity

Raw capacity is the total capacity of all SSDs assigned to a WEKA system cluster. For example, 10 SSDs of one terabyte each provide a total raw capacity of 10 terabytes. This represents the total capacity available for the WEKA system. This capacity automatically adjusts when more servers or SSDs are added.

## Net capacity

Net capacity is the space available for user data on the SSDs in a configured WEKA system. It is derived from the raw capacity minus the WEKA filesystem overheads for redundancy protection and other requirements. This capacity automatically adjusts when more servers or SSDs are added.

## Stripe width

The stripe width is the number of blocks within a common protection set, ranging from 3 to 16. The WEKA system employs distributed any-to-any protection. In a system with a stripe width of 8, many groups of 8 data units spread across various servers protect each other, rather than a fixed group of 8 servers forming a protection group.

The stripe width is set during cluster formation and cannot be changed. The choice of stripe width impacts performance and net capacity.

If not configured, the stripe width is automatically set to: #Failure Domains - Protection Level -1.

## Protection level

Protection level refers to the number of extra protection blocks added to each data stripe in your storage system. These blocks help protect your data against hardware failures. The protection levels available are:

* **Protection level 2**: Can survive 2 concurrent disk or server failures.
* **Protection level 4**: Can survive 4 concurrent disk failures or 2 concurrent server failures.

A higher protection level means better data durability and availability but requires more storage space and can affect performance.

**Key points:**

* **Durability**:
  * Higher protection levels offer better data protection.
  * Level 4 is more durable than level 2.
* **Availability**:
  * Ensures system availability during hardware failures.
  * Level 4 maintains availability through more extensive failures compared to level 2.
* **Space and performance**:
  * Higher protection levels use more storage space.
  * They can also slow down the system due to additional processing.
* **Configuration**:
  * The protection level is set during cluster formation and cannot be changed later.
  * If not configured, the system defaults to protection level 2.

### Resilience to serial failures

Beyond the +2 or +4 concurrent failure protection, a WEKA cluster is also resilient[^1] to [serial failures](#user-content-fn-2)[^2] of additional failure domains. Providing that each data rebuild completes successfully, a cluster is resilient to an additional server failure, even if the failure would reduce the number of available servers beyond what is expected by the concurrent protection level.

#### **Example of failure resilience after rebuild completion**

Consider a cluster of 20 servers with a stripe width of 18 (16+2). After rebuilding from a concurrent failure of 2 servers, this 18-server cluster is healthy and still resilient to two additional concurrent server failures.

In the event of subsequent server failures, the cluster rebuilds with the remaining healthy servers to support a stripe width of 18. When the number of active servers drops below 18, the system remains resilient to a single server failure until only 9 servers are left. Failures beyond this point result in the filesystem going offline.

#### **Benefits for customers**

* **Continued operation**: Despite multiple failures, your data remains protected, allowing for continued operation.
* **Data integrity**: Ensures data integrity through sequential rebuilds, maintaining data availability even in degraded states.

#### **Action plan in the event of serial failures**

1. **Monitor cluster health**: Regularly monitor the cluster's health to preemptively identify potential failures.
2. **Ensure free capacity**: Maintain sufficient free capacity to allow for complete rebuilds without impacting performance.
3. **Avoid overloading maintenance windows**: Remove only one server from a running cluster at a time. Begin maintenance on the next server once the cluster returns to an OK status.

#### Resilience level and minimum required protection groups

In a storage system, data protection is achieved using protection groups, which include both data and parity. The formula to determine the number of minimum required protection groups is:

$$
H = Ceil(D+P)/P
$$

Where:

* D is the data amount.
* P is the parity amount.
* H is the number of minimum required protection groups.

This formula ensures that all data is adequately protected by rounding up the total number of protection groups to the nearest whole number.

The following are a few examples:

| Resilience level (D+P) | Minimum required protection groups (H) |
| ---------------------- | -------------------------------------- |
| 3+2                    | 3                                      |
| 16+2                   | 9                                      |
| 5+4                    | 3                                      |
| 16+4                   | 5                                      |

## Failure domains (optional)

A failure domain is a set of WEKA servers susceptible to simultaneous failure due to a single root cause, such as a power circuit or network switch malfunction.

A cluster can be configured with either explicit or implicit failure domains:

* **Explicit failure domains:** In this setup, blocks that offer mutual protection are distributed across distinct failure domains.
* **Implicit failure domains:** Here, blocks are distributed across multiple servers, with each server considered a separate failure domain. Additional failure domains and servers can be integrated into existing or new failure domains.

{% hint style="info" %}
This documentation assumes a homogeneous WEKA system deployment, meaning an equal number of servers and identical SSD capacities per server in each failure domain. For guidance on heterogeneous configurations, contact the [Customer Success Team](../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
{% endhint %}

## Hot spare

A hot spare is reserved capacity designed to handle data rebuilds while maintaining the system’s net capacity, even in the event of failure domains being lost. It represents the number of failure domains the system can afford to lose and still perform a complete data rebuild successfully.

All failure domains actively contribute to data storage, and the hot spare capacity is evenly distributed among them. While a higher hot spare count requires additional hardware to maintain the same net capacity, it provides greater flexibility for IT maintenance and hardware replacements.

{% hint style="info" %}
The default hot spare setting in a WEKA cluster is 1 for 6 failure domains and 2 for more⁠⁠. The hot spare can be configured during cluster formation and reconfigured anytime.
{% endhint %}

## WEKA filesystem overhead

After accounting for protection and hot spare capacity, only 90% of the remaining capacity is available as net user capacity, with the other 10% reserved for the WEKA filesystems. This is a fixed formula and cannot be configured.

## Provisioned capacity

Provisioned capacity is the total capacity assigned to filesystems, including both SSD and object store capacity.

## Available capacity

Available capacity is the total capacity used to allocate new filesystems, calculated as net capacity minus provisioned capacity.

## Deductions from raw capacity to obtain net storage capacity

The net capacity of the WEKA system is determined by making the following three deductions during configuration:

* **Protection level:** Storage capacity dedicated to system protection.
* **Hot spare(s):** Storage capacity reserved for redundancy and rebuilding following component failures.
* **WEKA filesystem overhead:** Storage capacity allocated to enhance overall performance.&#x20;

## SSD net storage capacity calculation

<figure><img src="../.gitbook/assets/NetSSD_Capacity_Formula_with_Failure_Domains.png" alt=""><figcaption></figcaption></figure>

**Examples:**

{% hint style="success" %}
**Scenario 1:** A homogeneous system of 10 servers, each with one terabyte of Raw SSD Capacity, one hot spare, and a protection scheme of 6+2.
{% endhint %}

$$
SSD Net Capacity = 10 TB * (10-1) / 10 * 6/(6+2) * 0.9 = 6.075 TB
$$

{% hint style="success" %}
**Scenario 2:** A homogeneous system of 20 servers, each with one terabyte of Raw SSD Capacity, two hot spares, and a protection scheme of 16+2.
{% endhint %}

$$
SSD Net Capacity = 20 TB * (20-2) / 20 * 16/(16+2) * 0.9 = 14.4 TB
$$

[^1]: **Cluster resiliency**: A WEKA cluster with more hosts than the total protection stripe width returns to full redundancy once the rebuild completes.

[^2]: **Serial failures:** Refers to a sequence where each data rebuild finishes before another server fails, ensuring one-at-a-time failure handling.
