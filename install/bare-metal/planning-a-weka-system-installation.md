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

## Total SSD Net Capacity and Performance Planning

A Weka system cluster runs on a group of hosts with local SSDs. To plan these hosts, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. Note that data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy Scheme:** Define the optimal redundancy scheme required for the Weka system, as explained in [Selecting a Redundancy Scheme](../../overview/about.md#selecting-a-redundancy-scheme).
3. **Failure Domains:** Determine whether failure domains are going to be used (this is optional) and if yes determine the number of failure domains and the potential number of hosts in each failure domain, as described in [Failure Domains](../../overview/ssd-capacity-management.md#failure-domains-optional), and plan accordingly.
4. **Hot Spare**: Define the required hot spare count, as described in [Hot Spare](../../overview/ssd-capacity-management.md#hot-spare).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly, as defined in the [SSD Capacity Management formula](../../overview/ssd-capacity-management.md#formula-for-calculating-ssd-net-storage-capacity). You should also have the following information which will be used during the installation process:

1. Cluster size (number of hosts).
2. SSD capacity for each host, e.g., 12 hosts with a capacity of 6 TB each.
3. Planned protection scheme, e.g., 6+2.
4. Planned failure domains (optional).
5. Planned hot spare.

{% hint style="info" %}
**Note:** This is an iterative process. Depending on the scenario, some options can be fixed constraints while others are flexible.
{% endhint %}

## SSD Resource Planning

SSD resource planning involves how the defined capacity is going to be implemented for the SSDs. For each host, the following has to be determined:

* The number of SSDs and capacity for each SSD (where the multiplication of the two should satisfy the required capacity per host).
* The technology to be used (NVME, SAS, or SATA) and the specific SSD models, which have implications on SSD endurance and performance.

{% hint style="info" %}
**Note:** For on-premises planning, it is possible to consult with the Weka Support Team in order to map between performance requirements and the recommended Weka system configuration.
{% endhint %}

## Memory Resource Planning

### Backend Hosts

The total per host memory requirements is the sum of the following requirements:

| **Type**                      | **Per Host Memory**                                                                                          |
| ----------------------------- | ------------------------------------------------------------------------------------------------------------ |
| Fixed                         | 2.3 GB                                                                                                       |
| Core-based                    | <p>2.3 GB for each Frontend core</p><p>3.3 GB for each Compute core</p><p>2.3 GB for each Drive/SSD core</p> |
| SSD-based                     | _HostSSDSize/10KB_                                                                                           |
| Capacity requirement          | See below                                                                                                    |
| Reserved for Operating System | The maximum between 8 GB and 2% from the total RAM                                                           |
| Reserved for SMB/NFS services | 8 GB                                                                                                         |
| Reserved for RDMA             | 2 GB                                                                                                         |

#### Capacity Requirement Memory

On a dedicated host, all memory left after the reductions above is used for capacity. Otherwise, by default, `weka host memory` is set to 1.4 GB per compute-core, out of which 0.4 GB is used for the capacity requirement memory. If the default capacity requirement memory is not big enough to satisfy the total size of the filesystems, the least used metadata units will be paged to disk, as described in [metadata limitations](../../overview/filesystems.md#metadata-limitations). If more RAM is desired for metadata, the [memory allocation command](using-cli.md#stage-9-configuration-of-memory-optional) must be performed in the install process. Having sufficient system memory is not enough.

The per-host capacity requirement is calculated with the following formula:

![](<../../.gitbook/assets/Formula 1 21\_5\_18.jpg>)

{% hint style="info" %}
**Note:** System capacity/average file size is the number of files that can be used accordingly.
{% endhint %}

{% hint style="success" %}
**For Example:** 12 hosts, 10 Weka system cores per host (6 for compute, 4 for SSDs), 100 TB SSD system with 512 TB total system capacity (with object store), average file size 64 KB.
{% endhint %}

The capacity requirement for the host will be calculated according to the following formula:

![](<../../.gitbook/assets/3.7 Memory capacity example.png>)

Consequently, the overall requirement per host is: 4.6 + 6 \* 3.3 + 4\*2.3 + (100TB/10KB)/12 + 6.3 +8 +8 = 56.73 GB

{% hint style="info" %}
**Note:** The capacity requirement is according to the total size of all filesystems, including both SSDs and object stores.
{% endhint %}

{% hint style="info" %}
**Note:** These capacity requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the Weka Support Team to receive an estimate for your specific configuration.
{% endhint %}

### Client Hosts

The Weka software on a client host requires 4 GB of additional memory.

## CPU  Resource Planning

### CPU Allocation strategy

The Weka system implements a Non-Uniform Memory Access (NUMA) aware CPU allocation strategy to maximize the overall performance of the system. The allocation of cores utilizes all NUMAs equally to balance memory usage from all NUMA nodes.

The following should be noted with regards to the CPU allocation strategy:

* The code allocates CPU resources by assigning individual cores to tasks in a cgroup
* Cores in a Weka cgroup won't be available to run any other user processes
* On systems with Intel hyperthreading enabled, the corresponding sibling cores will be placed into a cgroup along with the physical ones.

### Backend Hosts

The number of physical cores dedicated to the Weka software should be planned according to the following guidelines and limitations:

* At least one physical core should be dedicated to the operating system; the rest can be allocated to the Weka software.
  * In general, it is recommended to allocate as many cores as possible to the Weka system.
  * No more than 19 physical cores can be assigned to Weka system processes.
* Enough cores should be allocated to support performance targets.
  * In general, use 1 drive core per SSD for up to 6 SSDs and 1 drive core per 2 SSDs for more, with a ratio of 2 compute cores per SSD core.
  * For finer tuning, please contact the Weka Support Team.
* Enough memory should be allocated to match core allocation, as discussed above.
* The running of other applications on the same host (converged Weka system deployment) is supported. However, this is not covered in this documentation. For further information, contact the Weka Support Team.

### Client Hosts

On a client host, by default, the Weka software consumes a single physical core. If the client host is configured with hyper-threading, the Weka software will consume two logical cores.

If the client networking is defined as based on UDP, there is no allocation of core resources and the CPU resources are allocated to the Weka processes by the operating system as any other process.

## Network Planning

### Backend Hosts

Weka backend hosts can be connected to both InfiniBand or Ethernet networks. For each network technology used, all backends must be connected via this technology. If backends are connected both through Infiniband and Ethernet, the Weka system will favor the Infiniband links for traffic, unless there are connectivity issues with the Infiniband network. In that case, the system will use the Ethernet links (clients connecting to the system can connect either via Infiniband or Ethernet).

{% hint style="info" %}
**Note:** A network port can either be dedicated to the Weka system or run the Weka system with other applications.
{% endhint %}

### Client Hosts

Client hosts can be configured with networking as above, which provides the highest performance and lowest latency, but requires compatible hardware and dedicated core resources. If compatible hardware is not available, or if allocating a physical core to the Weka system is problematic, the client networking can be configured to use the kernel UDP service. In such cases, performance is reduced, and latency increases.
