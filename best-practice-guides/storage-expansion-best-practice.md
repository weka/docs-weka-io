---
description: >-
  Explore the best practices for expanding WEKA clusters, focusing on
  maintaining optimal performance in heterogeneous environments.
---

# Storage expansion best practice

## **Heterogeneous systems**

For new installations, it is recommended to create a fully homogeneous cluster with identical failure domains and NVMe drives. Considerations for heterogeneity arise during expansion, serving purposes such as adding flash capacity, improving performance, or facilitating a tech refresh.

### **Expansion guidelines**

WEKA's primary guidance for expansions is to use similar server types and identical drive capacities, ensuring equal or greater capability than the existing cluster regarding CPU speed, core count, RAM, and NIC throughput. NVMe drives in the expansion should ideally match the capacity and performance of the existing cluster.

### Drive capacity considerations

Under specific considerations, exploring various drive capacities is a viable option; however, it's essential to be mindful of potential underutilization risks.

The configuration must align with optimizing performance and maximizing capacity usage. This approach allows flexibility in adapting to the availability of current NVMe capacities while ensuring optimal performance and capacity usage.

## **Example scenario**

In a scenario where a 10-server WEKA cluster has 10x 7.68TB NVMe drives per failure domain, a 50% capacity expansion is considered. The preferred option is to use the same capacity per failure domain and drive capacity as the main cluster. If 7.68TB capacities are unavailable, the next best option is to use a higher-capacity drive, usually twice the original capacity.

### **New failure domains**

When adding new failure domains during expansion, matching the total capacity of old failure domains is essential. The preference is for the expansion cluster to use the same NVMe drive capacity and drive count as the existing cluster to avoid stranded capacity.

### **Performance considerations**

In a heterogeneous cluster, ensuring the new failure domain has the same total performance as the old failure domain. New drives must be capable of twice the throughput of older drives to prevent performance bottlenecks.

## **Summary**

* Primary cluster installs require identical server and NVMe drive types.
* Expansion clusters must have servers equal to or better than those in the existing cluster.
* New failure domains in expansions must match old failure domains' total capacity and performance.
* In specific circumstances, different drive capacities require approval and careful consideration.
* For performance in heterogeneous clusters, ensure new drives can handle twice the throughput of older drives.

{% hint style="warning" %}
Contact the Product Management team (pm@weka.io) for approval and guidance in such heterogeneous scenarios.
{% endhint %}
