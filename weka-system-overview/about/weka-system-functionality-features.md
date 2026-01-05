---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/weka-system-overview/about/weka-system-functionality-features
---

# WEKA system functionality features

The WEKA system offers a range of powerful functionalities designed to enhance data protection, scalability, and efficiency, making it a versatile solution for various storage requirements.

## Protection

The WEKA system employs N+2 or N+4 protection, ensuring data protection even in the face of concurrent drive or backend failures. This complex protection scheme is determined during cluster formation and can vary, offering configurations starting from 3+2 up to 16+2 for larger clusters.

## Distributed network scheme

The WEKA system incorporates an any-to-any protection scheme that ensures the rapid recovery of data in the event of a backend failure. Unlike traditional storage architectures, where redundancy is often established across backend servers (backends), WEKA's approach leverages groups of datasets to protect one another within the entire cluster of backends.

Here's how it works:

* **Data recovery process:** If a backend within the cluster experiences a failure, the WEKA system initiates a rebuilding process using all the other operational backends. These healthy backends work collaboratively to recreate the data that originally resided on the failed backend. Importantly, all this occurs in parallel, with multiple backends simultaneously reading and writing data.
* **Speed of rebuild:** This approach results in a speedy rebuild process. In a traditional storage setup, only a small subset of backends or drives actively participate in rebuilding, often leading to slow recovery. In contrast, in the WEKA system, all but the failed backend are actively involved, ensuring swift recovery and minimal downtime.
* **Scalability benefits:** The advantages of this distributed network scheme become even more apparent as the cluster size grows. In larger clusters, the rebuild process is further accelerated, making the WEKA system an ideal choice for organizations that need to handle substantial data volumes without sacrificing data availability.

In summary, the WEKA system's distributed network scheme transforms data recovery by involving all available backends in the rebuild process, ensuring speedy and efficient recovery, and this efficiency scales with larger clusters, making it a robust and scalable solution for data storage and protection.

## **Efficient component replacement**

In the WEKA system, a hot spare is configured within the cluster to provide the additional capacity needed for a full recovery after a rebuild across the entire cluster. This differs from traditional approaches, where specific physical components are designated hot spares. For instance, in a 100-backend cluster, sufficient capacity is allocated to rebuild the data and restore full redundancy even after two failures. The system can withstand two additional failures depending on the protection policy and cluster size.

This strategy for replacing failed components does not compromise system reliability. In the event of a system failure, there's no immediate need to physically replace a failed component with a functional one to recreate the data. Instead, data is promptly regenerated, while replacing the failed component with a working one is a background process.

## **Enhanced fault tolerance with failure domains**

In the WEKA system, failure domains are groups of backends that could fail due to a single underlying issue. For instance, if all servers within a rack rely on a single power circuit or connect through a single [ToR switch](#user-content-fn-1)[^1], that entire rack can be considered a failure domain. Imagine a scenario with ten racks, each containing five WEKA backends, resulting in a cluster of 50 backends.

To enhance fault tolerance, you can configure a protection scheme, such as 6+2 protection, during the cluster setup. This makes the WEKA system aware of these possible failure domains and creates a protection stripe across the racks. This means the 6+2 stripe is distributed across different racks, ensuring that the system remains operational even in case of a complete rack failure, preventing data loss.

It's important to note that the [stripe width](#user-content-fn-2)[^2] must be less than or equal to the count of failure domains. For instance, if there are ten racks, and one rack represents a single point of failure, having a 16+4 cluster protection is not feasible. Therefore, the level of protection and support for failure domains depends on the stripe width and the chosen protection scheme.

## Prioritized data rebuild process

In the event of a failure in the WEKA system, the data recovery process begins by reading all affected data stripes, reconstructing the lost data, and restoring full protection. If multiple failures occur, the affected stripes can be categorized as follows:

* Stripes unaffected by any of the failed components, requiring no action.
* Stripes affected by one of the failed components.
* Stripes affected by multiple failed components.

Typically, the number of stripes affected by multiple failed components is significantly smaller than those affected by a single failed component. However, if any of these multi-affected stripes remain unrecovered, additional failures could lead to data loss.

To mitigate this risk, the WEKA system employs a **prioritized rebuild process**. The system first restores stripes affected by the greatest number of failed components, depending on the data protection level, as these are fewer in number and can be recovered quickly. Once these high-risk stripes are rebuilt, the system proceeds with restoring stripes impacted by fewer failures. This structured approach ensures that the probability of data loss remains low while maintaining system performance and availability.

## **Seamless distribution, scaling, and enhanced performance**

In the WEKA system, every client installed on an application server directly connects to the relevant WEKA backends that store the required data. There's no intermediary backend that forwards access requests. Each WEKA client maintains a synchronized map, specifying which backend holds specific data types, creating a unified configuration shared by all clients and backends.

When a WEKA client attempts to access a particular file or offset in a file, a cryptographic hash function guides it to the appropriate backend containing the needed data. This unique mechanism enables the WEKA system to achieve linear performance growth. It synchronizes scaling size with scaling performance, providing remarkable efficiency.

For instance, when new backends are added to double the cluster's size, the system instantly redistributes part of the filesystem data between the backends, resulting in an immediate double performance increase. Complete data redistribution is unnecessary even in modest cluster growths, such as moving from 100 to 110 backends. Only a fraction (10% in this example) of the existing data is copied to the new backends, ensuring a balanced distribution and active participation of all backends in read operations.

The speed of these seamless operations depends on the capacity of the backends and network bandwidth. Importantly, ongoing operations remain unaffected, and the system's performance improves as data redistribution occurs. The finalization of the redistribution process optimizes both capacity and performance, making the WEKA system an ideal choice for scalable and high-performance storage solutions.

## **Efficient data reduction**

WEKA offers a cluster-wide data reduction feature that can be activated for individual filesystems. This capability employs block-variable differential compression and advanced de-duplication techniques across all filesystems to significantly reduce the storage capacity required for user data, resulting in substantial cost savings for customers.

The effectiveness of the compression ratio depends on the specific workload. It is particularly efficient when applied to text-based data, large-scale unstructured datasets, log analysis, databases, code repositories, and sensor data. For more information, see [#data-reduction-in-weka-filesystems](../filesystems/#data-reduction-in-weka-filesystems "mention").

[^1]: **ToR switch**

    Top-of-Rack switching (ToR) is a type of network infrastructure that uses network switches to connect servers and other devices in the same rack. This type of switching allows for faster data transfer between devices and improved performance.

[^2]: **Stripe width**

    The number of protected data units.
