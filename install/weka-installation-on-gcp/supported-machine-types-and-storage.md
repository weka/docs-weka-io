# Supported machine types and storage

WEKA supports the following compute-optimized machine types:&#x20;

* **c2-standard-8:**
  *   Resources: 8 vCPUs, 32 GB memory

      Target use case: light use workloads, demos, or test environments

      Networking: supports 4 network interfaces, 16 Gbps
* **c2-standard-16:**
  * Resources: 16 vCPUs, 64 GB memory
  * Targeted use case: performance and production environments
  * Networking: supports up to 7 network interfaces, 32 Gbps

Each machine type supports 1, 2, 4, or 8 local SSD drives. Each drive has 375 GB (maximum 3 TB per instance). These drives are not individual SSDs but partitions locally to the physical server.

{% hint style="info" %}
The data in a WEKA cluster is protected with N+2 or N+4. However, use snap-to-object if the data needs further protection from multiple server failures.
{% endhint %}
