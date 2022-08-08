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

A Weka system cluster runs on a group of hosts with local SSDs. To plan these hosts, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. Note that data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy scheme:** Define the optimal redundancy scheme required for the Weka system, as explained in [Selecting a Redundancy Scheme](../../overview/about.md#selecting-a-redundancy-scheme).
3. **Failure domains:** Determine whether failure domains are going to be used (this is optional) and if yes determine the number of failure domains and the potential number of hosts in each failure domain, as described in [Failure Domains](../../overview/ssd-capacity-management.md#failure-domains-optional), and plan accordingly.
4. **Hot spare**: Define the required hot spare count, as described in [Hot Spare](../../overview/ssd-capacity-management.md#hot-spare).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly, as defined in the [SSD Capacity Management formula](../../overview/ssd-capacity-management.md#formula-for-calculating-ssd-net-storage-capacity). You should also have the following information which will be used during the installation process:

1. Cluster size (number of hosts).
2. SSD capacity for each host, e.g., 12 hosts with a capacity of 6 TB each.
3. Planned protection scheme, e.g., 6+2.
4. Planned failure domains (optional).
5. Planned hot spare.

{% hint style="info" %}
**Note:** This is an iterative process. Depending on the scenario, some options can be fixed constraints while others are flexible.
{% endhint %}

## SSD resource planning

SSD resource planning involves how the defined capacity is going to be implemented for the SSDs. For each host, the following has to be determined:

* The number of SSDs and capacity for each SSD (where the multiplication of the two should satisfy the required capacity per host).
* The technology to be used (NVME, SAS, or SATA) and the specific SSD models, which have implications on SSD endurance and performance.

{% hint style="info" %}
**Note:** For on-premises planning, it is possible to consult with the Weka Support Team in order to map between performance requirements and the recommended Weka system configuration.
{% endhint %}

## Memory resource planning <a href="#memory-resource-planning" id="memory-resource-planning"></a>

### Backend hosts memory requirements

The total per host memory requirements is the sum of the following requirements:

| **Purpose**                       | **Per host memory**                                                                                                                              |
| --------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ |
| Fixed                             | 2.3 GB                                                                                                                                           |
| Frontend cores                    | 2.3 GB x # of Frontend cores                                                                                                                     |
| Compute cores                     | 3.3 GB x # of Compute cores                                                                                                                      |
| Drive cores                       | 2.3 GB x # of Drive cores                                                                                                                        |
| SSD capacity management           | <p><em>HostSSDSize/10,000</em><br><em>(HostSSDSize = Total SSD raw capacity / # of hosts)</em></p>                                               |
| Operating System                  | The maximum between 8 GB and 2% from the total RAM                                                                                               |
| Additional protocols (NFS/SMB/S3) | 8 GB                                                                                                                                             |
| RDMA                              | 2 GB                                                                                                                                             |
| Metadata (pointers)               | <p>20 Bytes x # Metadata units per host<br>See <a href="../../overview/filesystems.md#metadata-calculations">Metadata units calculation</a>.</p> |

#### Example 1: A system with large files

A system with 16 hosts with the following details:

* Number of Frontend cores: 1&#x20;
* Number of Compute cores: 13
* Number of Drive cores: 6
* Total raw capacity: 983 TB
* Total net capacity: 725 TB
* NFS/SMB services
* RDMA
* Average file size: 1 MB (potentially up to 755 million files for all hosts; \~47 million files per host)

Calculations:

* Frontend cores:   1    x 2.3 = 2.3 GB
* Compute cores:   13 x 3.3 = 33.9 GB
* Drive cores:         6   x 2.3 = 13.8 GB
* SSD capacity management:    983 TB / 16 / 10K = \~6.3 GB
* Metadata:                                 20 Bytes x 47 million files x 2 units = \~1.9 GB

Total memory requirement per host = 2.3 + 2.3 + 33.9 + 13.8 + 6.3 + 8 + 2 + 1.9 = \~71 GB

#### Example 2: A system with small files

For the same system as in example 1, but with smaller files, the required memory for metadata would be larger.

For an average file size of 64 KB, the number of files is potentially up to \~12 billion files for all hosts; \~980 million files per host.

Required memory for metadata: 20 Bytes x 980 million files x 1 unit = \~19.6 GB

Total memory requirement per host = 2.3 + 2.3 + 33.9 + 13.8 + 6.3 + 8 + 2 + 19.6 = \~88 GB

{% hint style="info" %}
**Note:** The memory requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to receive an estimate for your specific configuration.
{% endhint %}

### Client hosts memory requirements

The Weka software on a client host requires 4 GB of additional memory.

## CPU resource planning

### CPU allocation strategy

The Weka system implements a Non-Uniform Memory Access (NUMA) aware CPU allocation strategy to maximize the overall performance of the system. The allocation of cores utilizes all NUMAs equally to balance memory usage from all NUMA nodes.

The following should be noted with regards to the CPU allocation strategy:

* The code allocates CPU resources by assigning individual cores to tasks in a cgroup
* Cores in a Weka cgroup won't be available to run any other user processes
* On systems with Intel hyperthreading enabled, the corresponding sibling cores will be placed into a cgroup along with the physical ones.

### Backend hosts

The number of physical cores dedicated to the Weka software should be planned according to the following guidelines and limitations:

* At least one physical core should be dedicated to the operating system; the rest can be allocated to the Weka software.
  * In general, it is recommended to allocate as many cores as possible to the Weka system.
  * No more than 19 physical cores can be assigned to Weka system processes.
* Enough cores should be allocated to support performance targets.
  * In general, use 1 drive core per SSD for up to 6 SSDs and 1 drive core per 2 SSDs for more, with a ratio of 2 compute cores per SSD core.
  * For finer tuning, please contact the Weka Support Team.
* Enough memory should be allocated to match core allocation, as discussed above.
* The running of other applications on the same host (converged Weka system deployment) is supported. However, this is not covered in this documentation. For further information, contact the Weka Support Team.

### Client hosts

On a client host, by default, the Weka software consumes a single physical core. If the client host is configured with hyper-threading, the Weka software will consume two logical cores.

If the client networking is defined as based on UDP, there is no allocation of core resources and the CPU resources are allocated to the Weka processes by the operating system as any other process.

## Network planning

### Backend hosts

Weka backend hosts can be connected to both InfiniBand or Ethernet networks. For each network technology used, all backends must be connected via this technology. If backends are connected both through Infiniband and Ethernet, the Weka system will favor the Infiniband links for traffic, unless there are connectivity issues with the Infiniband network. In that case, the system will use the Ethernet links (clients connecting to the system can connect either via Infiniband or Ethernet).

{% hint style="info" %}
**Note:** A network port can either be dedicated to the Weka system or run the Weka system with other applications.
{% endhint %}

### Client hosts

Client hosts can be configured with networking as above, which provides the highest performance and lowest latency, but requires compatible hardware and dedicated core resources. If compatible hardware is not available, or if allocating a physical core to the Weka system is problematic, the client networking can be configured to use the kernel UDP service. In such cases, performance is reduced, and latency increases.
