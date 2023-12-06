# Optimize redundancy in WEKA deployments

Redundancy in WEKA system deployments can vary, ranging from 3+2 to 16+4. Choosing the most suitable configuration involves several key considerations, including redundancy levels, data stripe width, hot spare capacity, and the performance required during data rebuilds.

### **Redundancy levels**

Redundancy can be configured as N+2 or N+4, directly impacting capacity and performance. A redundancy level of 2 is typically sufficient for most configurations, while redundancy levels of 4 are reserved for larger clusters with 100 or more backends or critical data scenarios.

### **Data stripe width**

Data stripe width, ranging from 3 to 16, is crucial in optimizing net capacity. Larger stripe widths offer more net capacity but may affect performance during data rebuilds, particularly for highly critical data. Consultation with the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) is recommended in such cases.

### **Hot spare capacity**

The required hot spare capacity depends on how quickly faulty components can be replaced. Systems with faster response times or guaranteed 24/7 service require less hot spare capacity than systems with less frequent component replacement schedules.

### **Performance required during data rebuilds**

The performance required during a data rebuild from a failure primarily relates to read rebuild operations. Unlike many other storage systems, write performance remains unaffected by failures and rebuilds in WEKA systems because they continue to write to functioning backends within the cluster. However, read performance can be impacted when reading data from a failed component, as this process requires retrieving data from the entire stripe. It requires simultaneous operations and immediate priority for data read operations.\
\
For instance, consider a scenario where a single failure occurs in a cluster of 100 backends. In this case, the overall performance is affected by a relatively modest 1%. However, in a cluster of 100 backends with a stripe width of 16, the initial phase of the rebuild can lead to a more significant reduction in performance, up to 16%.\
\
In large clusters, the cluster size may exceed the stripe width or the number of failure domains. To maintain optimal performance during rebuilds, it is advisable to ensure that the stripe width is carefully chosen relative to the cluster size.

As a general guideline for large clusters, it's recommended that the stripe width should not exceed 25% of the cluster size. For example, in a cluster composed of 40 backends, an 8+2 protection scheme is advisable. This configuration helps mitigate the impact on performance in case of a failure, ensuring that it does not exceed 25%.

#### **Enhance write performance with a larger stripe width**

Write performance in the WEKA system improves as the stripe width increases. This improvement is due to the system having to compute a smaller proportion of protected data than actual data. This effect is particularly notable in scenarios involving substantial write operations, such as systems accumulating data for the first time.
