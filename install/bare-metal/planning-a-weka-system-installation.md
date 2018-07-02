# Planning a Weka System Installation

The planning of a Weka system is essential prior to the actual installation process. It involves the planning of the following:

1.  Total SSD net capacity and performance requirements
2.  SSD resources
3.  Memory resources
4.  CPU resources
5.  Network

{% hint style="info" %}
**Note:** When implementing an AWS configuration, it is possible to go to the [Self-Service Portal in start.weka.io](https://docs.weka.io/aws/self-service-portal) in order to automatically map capacity and performance requirements into various configurations.
{% endhint %}

## Total SSD Net Capacity and Performance Planning

A Weka system cluster runs on a group of hosts with local SSDs. To plan these hosts, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. Note that data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy Scheme:** Define the optimal redundancy scheme required for the Weka system, as explained in [Selecting a Redundancy Scheme](https://docs.weka.io/what-is-wekaio#selecting-a-redundancy-scheme).
3. **Failure Domains:** Determine whether failure domains are going to be used \(this is optional\), and if yes determine the number of failure domains and potential number of hosts in each failure domain, as described in [Failure Domains](https://docs.weka.io/ssd-capacity-management#failure-domains), and plan accordingly.
4. **Hot Spare**: Define the required hot spare count, as described in [Hot Spare](https://docs.weka.io/ssd-capacity-management#hot-spare).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly, as defined in the [SSD Capacity Management formula](https://docs.weka.io/ssd-capacity-management#formula-for-calculating-ssd-net-storage-capacity). You should also have the following information which will be used during the installation process:

1.  Cluster size \(number of hosts\).
2.  SSD capacity for each host, e.g., 12 hosts with a capacity of 6 TB each.
3.  Planned protection scheme, e.g., 6+2.
4.  Planned failure domains \(optional\).
5.  Planned hot spare.

{% hint style="info" %}
**Note:** This is an iterative process. Depending on the scenario, some options can be fixed constraints while others are flexible.
{% endhint %}

## SSD Resource Planning

SSD resource planning involves how the defined capacity is going to be implemented for the SSDs. For each host, the following has to be determined:

* Number of SSDs and capacity for each SSD \(where the multiplication of the two should satisfy the required capacity per host\).
* The technology to be used \(NVME, SAS or SATA\) and the specific SSD models, which have implications on SSD endurance and performance.

{% hint style="info" %}
**Note:** For on-premises planning, it is possible to consult with the Weka Support Team in order to map between performance requirements and the recommended Weka system configuration.
{% endhint %}

## Memory Resource Planning

### Backend Hosts

The total per host memory requirements is the sum of the following requirements:

| **Type** | **Per Host Memory** |
| --- | --- | --- | --- |
| Fixed host | 5 GB |
| Core-based host | 6.3 GB for each core |
| Capacity requirement | See below. By default 1.4 GB |

The per host capacity requirement is calculated with the following formula:

![](../../.gitbook/assets/formula-1-21_5_18.jpg)

{% hint style="info" %}
**Note:** System capacity/average file size is the number of files that can be used accordingly.
{% endhint %}

{% hint style="warning" %}
**For Example:** 12 hosts, 6 Weka system cores per host, 100 TB SSD system with 512 TB total system capacity \(with object store\), average file size 64 KB.
{% endhint %}

The capacity requirement for the host will be calculated according to the following formula:

![](../../.gitbook/assets/formula-2-21_05_18.png)

Consequently, the overall requirement per host is: 5 + 6 \* 6.3 + 7.3 = 50.1 GB

{% hint style="info" %}
**Note:** If the default capacity requirement memory is not big enough to satisfy the total size of the filesystems, the [memory allocation command ](untitled.md#stage-8-configuration-of-memory-optional)must be performed in the install process. Having sufficient system memory is not enough.
{% endhint %}

{% hint style="info" %}
**Note:** The capacity requirement is according to the total size of filesystems, including both SSDs and object stores.
{% endhint %}

{% hint style="info" %}
**Note:** These capacity requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the Weka Support Team to receive an estimate for your specific configuration.
{% endhint %}

### Client Hosts

The Weka software on a client host requires 5 GB of memory.

## CPU  Resource Planning

### Backend Hosts

The number of physical cores dedicated to the Weka software should be planned according to the following guidelines:

* At least one physical core should be dedicated to the operating system; the rest can be allocated to the Weka software.
* Enough cores should be allocated to support the performance targets. For help on planning this, contact the Weka Support Team.
* Enough memory should be allocated to match core allocation, as discussed above.

In general, it is recommended to allocate as many cores as possible to the Weka system, with the following limitations:

1. There has to be one core for the operation system.
2. The running of other applications on the same host \(hyper-converged Weka system deployment\) is supported. However, this is not covered in this documentation. For further information, contact the Weka Support Team.
3. There has to be sufficient memory, as described above.
4. No more than 20 physical cores can be assigned to Weka system processes.

### Client Hosts

On a client host, by default the Weka software consumes a single physical core. If the client host is configured with hyper-threading, the Weka software will consume two logical cores.

If the client networking is defined as based on UDP, there is no allocation of core resources and the CPU resources are allocated to the Weka processes by the operating system as any other process.

## Network Planning

### Backend Hosts

The Weka system supports the following types of networking technologies:

1. InfiniBand \(IB\).
2. Ethernet directly for user space using DPDK supporting NIC.

The choice between IB and Ethernet is dictated by the currently-available networking infrastructure. It is mandatory to determine which one of these two types of networking technologies are to be used in order to proceed to the Weka system initialization/installation process.

{% hint style="info" %}
**Note:** A network port can either be dedicated to the Weka system or run the Weka system with other applications.
{% endhint %}

### Client Hosts

Client hosts can be configured with networking as above, which provides the highest performance and lowest latency, but requires compatible hardware and dedicated core resources. If a compatible hardware is not available, or if allocating a physical core to the Weka system is problematic, the client networking can be configured to use the kernel UDP service. In such cases, performance is reduced and latency  increases.

