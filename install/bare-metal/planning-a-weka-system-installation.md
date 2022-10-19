# Planning a Weka System Installation

The planning of a Weka system is essential prior to the actual installation process. It involves the planning of the following:

1. Total SSD net capacity and performance requirements
2. SSD resources
3. Memory resources
4. CPU resources
5. Network

{% hint style="info" %}
**Note:** When implementing an AWS configuration, it is possible to go to the [Self-Service Portal in start.weka.io](../aws/self-service-portal.md) in order to automatically map capacity and performance requirements into various configurations.
{% endhint %}

## Total SSD net capacity and performance planning

A Weka system cluster runs on a group of servers with local SSDs. To plan these servers, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. Note that data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy scheme:** Define the optimal redundancy scheme required for the Weka system, as explained in [Selecting a Redundancy Scheme](../../overview/about.md#selecting-a-redundancy-scheme).
3. **Failure domains:** Determine whether failure domains are going to be used (this is optional) and if yes determine the number of failure domains and the potential number of servers in each failure domain, as described in [Failure Domains](../../overview/ssd-capacity-management.md#failure-domains-optional), and plan accordingly.
4. **Hot spare**: Define the required hot spare count, as described in [Hot Spare](../../overview/ssd-capacity-management.md#hot-spare).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly, as defined in the [SSD Capacity Management formula](../../overview/ssd-capacity-management.md#formula-for-calculating-ssd-net-storage-capacity). You should also have the following information which will be used during the installation process:

1. Cluster size (number of servers).
2. SSD capacity for each server, e.g., 12 servers with a capacity of 6 TB each.
3. Planned protection scheme, e.g., 6+2.
4. Planned failure domains (optional).
5. Planned hot spare.

{% hint style="info" %}
**Note:** This is an iterative process. Depending on the scenario, some options can be fixed constraints while others are flexible.
{% endhint %}

## SSD resource planning

SSD resource planning involves how the defined capacity is going to be implemented for the SSDs. For each server, the following has to be determined:

* The number of SSDs and capacity for each SSD (where the multiplication of the two should satisfy the required capacity per server).
* The technology to be used (NVME, SAS, or SATA) and the specific SSD models, which have implications on SSD endurance and performance.

{% hint style="info" %}
**Note:** For on-premises planning, it is possible to consult with the Weka Support Team in order to map between performance requirements and the recommended Weka system configuration.
{% endhint %}

## Memory resource planning <a href="#memory-resource-planning" id="memory-resource-planning"></a>

### Backend servers memory requirements

The total per server memory requirements is the sum of the following requirements:

| **Purpose**                       | **Per-server memory**                                                                                                                              |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Fixed                             | 2.3 GB                                                                                                                                             |
| Frontend processes                | 2.3 GB x # of Frontend processes                                                                                                                   |
| Compute processes                 | 3.3 GB x # of Compute processes                                                                                                                    |
| Drive processes                   | 2.3 GB x # of Drive processes                                                                                                                      |
| SSD capacity management           | <p><em>ServerSSDSize/10,000</em><br><em>(ServerSSDSize = Total SSD raw capacity / # of Servers)</em></p>                                           |
| Operating System                  | The maximum between 8 GB and 2% from the total RAM                                                                                                 |
| Additional protocols (NFS/SMB/S3) | 8 GB                                                                                                                                               |
| RDMA                              | 2 GB                                                                                                                                               |
| Metadata (pointers)               | <p>20 Bytes x # Metadata units per server<br>See <a href="../../overview/filesystems.md#metadata-calculations">Metadata units calculation</a>.</p> |

#### Example 1: A system with large files

A system with 16 servers with the following details:

* Number of Frontend processes: 1&#x20;
* Number of Compute processes: 13
* Number of Drive processes: 6
* Total raw capacity: 983 TB
* Total net capacity: 725 TB
* NFS/SMB services
* RDMA
* Average file size: 1 MB (potentially up to 755 million files for all servers; \~47 million files per server)

Calculations:

* Frontend processes:   1    x 2.3 = 2.3 GB
* Compute processes:   13 x 3.3 = 33.9 GB
* Drive processes:         6   x 2.3 = 13.8 GB
* SSD capacity management:    983 TB / 16 / 10K = \~6.3 GB
* Metadata:                                 20 Bytes x 47 million files x 2 units = \~1.9 GB

Total memory requirement per server= 2.3 + 2.3 + 33.9 + 13.8 + 6.3 + 8 + 2 + 1.9 = \~71 GB

#### Example 2: A system with small files

For the same system as in example 1, but with smaller files, the required memory for metadata would be larger.

For an average file size of 64 KB, the number of files is potentially up to \~12 billion files for all servers; \~980 million files per server.

Required memory for metadata: 20 Bytes x 980 million files x 1 unit = \~19.6 GB

Total memory requirement per server = 2.3 + 2.3 + 33.9 + 13.8 + 6.3 + 8 + 2 + 19.6 = \~88 GB

{% hint style="info" %}
**Note:** The memory requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to receive an estimate for your specific configuration.
{% endhint %}

### Client's memory requirements

The Weka software on a client requires 4 GB of additional memory.

## CPU resource planning

### CPU allocation strategy

The Weka system implements a Non-Uniform Memory Access (NUMA) aware CPU allocation strategy to maximize the overall performance of the system. The allocation of cores utilizes all NUMAs equally to balance memory usage from all NUMAs.

The following should be noted with regard to the CPU allocation strategy:

* The code allocates CPU resources by assigning individual cores to tasks in a cgroup
* Cores in a Weka cgroup won't be available to run any other user processes
* On systems with Intel hyperthreading enabled, the corresponding sibling cores will be placed into a cgroup along with the physical ones.

### Backend servers

Plan the number of physical cores dedicated to the Weka software according to the following guidelines and limitations:

* Dedicate at least one physical core to the operating system; the rest can be allocated to the Weka software.
  * In general, it is recommended to allocate as many cores as possible to the Weka system.
  * A backend server can have as many as possible cores. However, a backend container can have a maximum of 19 physical cores.
  * Take into account leaving enough cores for the protocol container if it runs on the same server.
* Allocate enough cores to support performance targets.
  * In general, use 1 drive process per SSD for up to 6 SSDs and 1 drive process per 2 SSDs for more, with a ratio of 2 compute processes per SSD process.
  * For finer tuning, please contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
* Allocate enough memory to match core allocation, as discussed above.
* The running of other applications on the same server (converged Weka system deployment) is supported. However, this is not covered in this documentation. For further information, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

### Clients

On the client side, by default, the Weka software consumes a single physical core. If the client is configured with hyper-threading, the Weka software will consume two logical cores.

If the client networking is defined as based on UDP, there is no allocation of core resources and the CPU resources are allocated to the Weka processes by the operating system as any other process.

## Network planning

### Backend servers

Weka backend servers can be connected to both InfiniBand or Ethernet networks. For each network technology used, all backends must be connected via this technology. If backends are connected both through Infiniband and Ethernet, the Weka system will favor the Infiniband links for traffic, unless there are connectivity issues with the Infiniband network. In that case, the system will use the Ethernet links (clients connecting to the system can connect either via Infiniband or Ethernet).

{% hint style="info" %}
**Note:** A network port can either be dedicated to the Weka system or run the Weka system with other applications.
{% endhint %}

### Clients

Clients can be configured with networking as above, which provides the highest performance and lowest latency, but requires compatible hardware and dedicated core resources. If compatible hardware is not available, or if allocating a physical core to the Weka system is problematic, the client networking can be configured to use the kernel UDP service. In such cases, performance is reduced, and latency increases.
