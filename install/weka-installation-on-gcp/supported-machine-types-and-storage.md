# Supported machine types and storage

Weka supports the following compute-optimized machine types:&#x20;

* **c2-standard-8:**
  *   Resources: 8 vCPUs, 32 GB memory

      Target use case: light use workloads, demos, or test environments

      Networking: supports 4 network interfaces, 16 Gbps
* **c2-standard-16:**
  * Resources: 16 vCPUs, 64 GB memory
  * Targeted use case: performance and production environments
  * Networking: supports up to 7 network interfaces, 32 Gbps

Each machine type supports 1, 2, 4, or 8 local SSD drives. Each drive has 375 GB (maximum 3 TB per instance). These drives are not individual SSDs but partitions local to the physical server.

{% hint style="info" %}
The data in a Weka cluster is protected with +2 or +4 failure domains. However, if the data needs to be further protected from multiple server failures, use [snap-to-object](../../fs/snap-to-obj/).
{% endhint %}
