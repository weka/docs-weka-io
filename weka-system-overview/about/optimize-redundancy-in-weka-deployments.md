# Redundancy optimization in WEKA

## **Redundancy levels**

WEKA’s distributed RAID supports a range of redundancy configurations, from 3+2 to 16+4. It uses a D+P model, where _D_ is the number of data drives and _P_ is the number of parity drives. This is represented as N+2, N+3, or N+4, all supported by WEKA. The number of data drives must be greater than the number of parity drives. Configurations like 3+3 are not allowed.

Choosing the appropriate redundancy level balances fault tolerance, usable capacity, and performance:

* **N+2:** Recommended for most environments; provides standard fault tolerance.
* **N+3:** Offers increased protection; suitable for higher availability requirements.
* **N+4:** Designed for large-scale clusters (100+ backends) or critical data scenarios requiring maximum redundancy.

## **Stripe width** and capacity optimization

Stripe width, the number of drives participating in each distributed RAID stripe, is configurable between 3 and 16, affects both capacity efficiency and rebuild performance. Wider stripes increase net usable capacity by reducing parity overhead but may degrade rebuild speed, as more drives must be read from concurrently during recovery operations.

For deployments with stringent performance or data protection requirements, it is recommended to consult with the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to determine the optimal configuration.

## **Hot spare capacity**

By default, WEKA allocates 1/N of the total space as virtual hot spare capacity. For example, a 3+2 configuration is deployed as 3+2+1, reserving one-sixth of the cluster’s capacity for redundancy. This proactive provisioning ensures availability for immediate failure tolerance.

In cases where hardware failures persist and components are not replaced promptly, WEKA employs a mechanism called failure domain folding to maintain write availability. This mechanism temporarily relaxes the requirement that each RAID stripe must span only distinct failure domains (for example, one per backend storage server). It allows a single failure domain to appear multiple times in a stripe, enabling the system to allocate new stripes and continue accepting write operations even in degraded states.

### Failure domain folding process

Failure domain folding is automatically triggered when the number of active failure domains becomes insufficient to satisfy the original stripe width, typically due to server deactivation or loss of multiple drives. This approach ensures that the system can remain operational during extended fault conditions without immediate hardware replacement.

The following illustration demonstrates how WEKA maintains write capability during sustained component failures by applying failure domain folding. It shows three stages:

* **Stage A: Normal operation with all drives active:** In the initial state, all backend storage servers are operational. Each server is treated as a distinct failure domain, represented vertically in the diagram. RAID stripes span horizontally across all failure domains, combining data (yellow) and parity (purple) blocks. Although each block is shown as one NVMe drive for clarity, actual allocation occurs at the stripe level.\
  To tolerate hardware failures, WEKA is configured with hot spare capacity, equivalent to the capacity of two full servers (6 drives). This reserve is not tied to specific drives but is notionally allocated across the system. At this stage, new stripe allocations proceed normally using free space across all failure domains.
* **Stage B: Write blocking after a drive failure:** When a single drive fails, any new stripe that must span all failure domains can no longer be allocated if any one domain lacks space. Even though only one drive has failed, this strict requirement effectively blocks new writes, since the allocation rule cannot be satisfied. This results in a disproportionate loss of writable capacity relative to the size of the failure, particularly in systems with fewer drives per server.
* **Stage C: Write recovery through failure domain folding:** To mitigate the blocked write condition, the affected storage server can be manually deactivated. This allows WEKA to apply failure domain folding, which permits the reuse of the same failure domain within a stripe. By relaxing the one-domain-per-stripe rule, new stripes can once again be allocated despite the failed drive. This folding mechanism restores write capability without immediate hardware replacement, ensuring continued system operation under degraded conditions.

<figure><img src="../../.gitbook/assets/failure_domain_folding.png" alt=""><figcaption><p>Failure domain in action (example)</p></figcaption></figure>

## **Performance during data rebuilds**

Rebuild operations in WEKA are primarily read-intensive, as the system reconstructs missing data by reading from all drives in the stripe. While read performance may degrade slightly during this process, **write performance remains unaffected**, as the system continues writing to available backends.

WEKA provides a critical optimization during rebuilds. If a failed component, such as drive or server, comes back online after a rebuild has started, the rebuild is automatically aborted. This approach prevents unnecessary data movement and quickly restores normal operations in the case of temporary failures, such as servers returning from maintenance. This behavior significantly differentiates WEKA from traditional systems that continue rebuilding even after transient faults are resolved.

### **Write performance and stripe width**

Larger stripe widths improve write throughput by reducing the proportion of parity overhead in write operations. This benefit is especially important for high-ingest workloads, such as initial data loading or write-heavy applications.
