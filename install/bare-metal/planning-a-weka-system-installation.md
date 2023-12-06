# Plan the WEKA system hardware requirements

The planning of a WEKA system is essential before the actual installation process. It involves the planning of the following:

1. Total SSD net capacity and performance requirements
2. SSD resources
3. Memory resources
4. CPU resources
5. Network

{% hint style="info" %}
When implementing an AWS configuration, it is possible to go to the [Self-Service Portal in start.weka.io](../aws/weka-installation-on-aws-using-the-cloud-formation/self-service-portal.md) to map capacity and performance requirements into various configurations automatically.
{% endhint %}

## Total SSD net capacity and performance planning

A WEKA system cluster runs on a group of servers with local SSDs. To plan these servers, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. The data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy scheme:** Define the optimal redundancy scheme required for the WEKA system, as explained in [Selecting a Redundancy Scheme](../../overview/about.md#selecting-a-redundancy-scheme).
3. **Failure domains:** Determine whether to use failure domains (optional), and if yes, determine the number of failure domains and the potential number of servers in each failure domain, as described in [Failure Domains](../../overview/ssd-capacity-management.md#failure-domains-optional), and plan accordingly.
4. **Hot spare**: Define the required hot spare count described in [Hot Spare](../../overview/ssd-capacity-management.md#hot-spare).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly, as defined in the [SSD Capacity Management formula](../../overview/ssd-capacity-management.md#formula-for-calculating-ssd-net-storage-capacity). Adhere to the following information, which is required during the installation process:

1. Cluster size (number of servers).
2. SSD capacity for each server, for example, 12 servers with a capacity of 6 TB each.
3. Planned protection scheme, for example, 6+2.
4. Planned failure domains (optional).
5. Planned hot spare.

{% hint style="info" %}
This is an iterative process. Depending on the scenario, some options can be fixed constraints while others are flexible.
{% endhint %}

## SSD resource planning

SSD resource planning involves how the defined capacity is implemented for the SSDs. For each server, the following has to be determined:

* The number of SSDs and capacity for each SSD (where the multiplication of the two should satisfy the required capacity per server).
* The selected technology, NVME, SAS, or SATA, and the specific SSD models have implications on SSD endurance and performance.

{% hint style="info" %}
For on-premises planning, it is possible to consult with the Customer Success Team to map between performance requirements and the recommended WEKA system configuration.
{% endhint %}

## Memory resource planning <a href="#memory-resource-planning" id="memory-resource-planning"></a>

### Backend servers memory requirements

The total per server memory requirements is the sum of the following requirements:

| Purpose                           | Per-server memory                                                                                                                                  |
| --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| Fixed                             | 2.8 GB                                                                                                                                             |
| Frontend processes                | 2.2 GB x # of Frontend processes                                                                                                                   |
| Compute processes                 | 3.9 GB x # of Compute processes                                                                                                                    |
| Drive processes                   | 2 GB x # of Drive processes                                                                                                                        |
| SSD capacity management           | <p><em>ServerSSDSize/10,000</em><br><em>(ServerSSDSize = Total SSD raw capacity / # of Servers)</em></p>                                           |
| Operating System                  | The maximum between 8 GB and 2% from the total RAM                                                                                                 |
| Additional protocols (NFS/SMB/S3) | 8 GB                                                                                                                                               |
| RDMA                              | 2 GB                                                                                                                                               |
| Metadata (pointers)               | <p>20 Bytes x # Metadata units per server<br>See <a href="../../overview/filesystems.md#metadata-calculations">Metadata units calculation</a>.</p> |

{% hint style="warning" %}
The maximum memory per **container** is 384 GB.
{% endhint %}

#### Example 1: A system with large files

A system with 16 servers with the following details:

* Number of Frontend processes: 1
* Number of Compute processes: 13
* Number of Drive processes: 6
* Total raw capacity: 983 TB
* Total net capacity: 725 TB
* NFS/SMB services
* RDMA
* Average file size: 1 MB (potentially up to 755 million files for all servers; \~47 million files per server)

Calculations:

* Frontend processes: 1 x 2.2 = 2.2 GB
* Compute processes: 13 x 3.9 = 50.7 GB
* Drive processes: 6 x 2 = 12 GB
* SSD capacity management: 983 TB / 16 / 10K = \~6.3 GB
* Metadata: 20 Bytes x 47 million files x 2 units = \~1.9 GB

Total memory requirement per server= 2.8 + 2.2 + 55.7 + 12 + 6.3 + 8 + 2 + 1.9 = \~91 GB

#### Example 2: A system with small files

For the same system as in example 1, but with smaller files, the required memory for metadata would be larger.

For an average file size of 64 KB, the number of files is potentially up to:

* \~12 billion files for all servers.
* \~980 million files per server.

Required memory for metadata: 20 Bytes x 980 million files x 1 unit = \~19.6 GB

Total memory requirement per server = 2.8 + 2.2 + 55.7 + 12 + 6.3 + 8 + 2 + 19.6 = \~109 GB

{% hint style="info" %}
The memory requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to receive an estimate for your specific configuration.
{% endhint %}

### Client's memory requirements

The WEKA software on a client requires 5 GB minimum additional memory.&#x20;

## CPU resource planning

### CPU allocation strategy

The WEKA system implements a Non-Uniform Memory Access (NUMA) aware CPU allocation strategy to maximize the overall performance of the system. The cores allocation uses all NUMAs equally to balance memory usage from all NUMAs.

Consider the following regarding the CPU allocation strategy:

* The code allocates CPU resources by assigning individual cores to tasks in a cgroup.
* Cores in a cgroup are not available to run any other user processes.
* On systems with Intel hyper-threading enabled, the corresponding sibling cores are placed into a cgroup along with the physical ones.

### Backend servers

Plan the number of physical cores dedicated to the WEKA software according to the following guidelines and limitations:

* Dedicate at least one physical core to the operating system; the rest can be allocated to the WEKA software.
  * Generally, it is recommended to allocate as many cores as possible to the WEKA system.
  * A backend server can have as many cores as possible. However, a container within a backend server can have a maximum of 19 physical cores.
  * Leave enough cores for the container serving the protocol if it runs on the same server.
* Allocate enough cores to support performance targets.
  * Generally, use 1 drive process per SSD for up to 6 SSDs and 1 drive process per 2 SSDs for more, with a ratio of 2 compute processes per SSD process.
  * For finer tuning, please contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
* Allocate enough memory to match core allocation, as discussed above.
* Running other applications on the same server (converged WEKA system deployment) is supported. For details, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

### Clients

On the client side, the WEKA software consumes a single physical core by default. The WEKA software consumes two logical cores if the client is configured with hyper-threading.

If the client networking is defined as UDP, dedicated CPU core resources are not allocated to WEKA. Instead, the operating system allocates CPU resources to the WEKA processes like any other.

## Network planning

### Backend servers

WEKA backend servers can be connected to both InfiniBand or Ethernet networks. For each network technology used, all backends must be connected by this technology. If backends are connected through Infiniband and Ethernet, the WEKA system favors the Infiniband links for traffic unless there are connectivity issues with the Infiniband network. In that case, the system uses the Ethernet links (clients connecting to the system can connect by Infiniband or Ethernet).

{% hint style="info" %}
A network port can either be dedicated to the WEKA system or run the WEKA system with other applications.
{% endhint %}

### Clients

You can configure clients with networking as described above, which provides the highest performance and lowest latency but requires compatible hardware and dedicated core resources. If compatible hardware is unavailable or a physical core cannot be allocated to the WEKA system, you can configure the client networking to use the kernel UDP service. In such cases, the performance is reduced, and the latency increases.

## What to do next?

[obtaining-the-weka-install-file.md](obtaining-the-weka-install-file.md "mention") (all paths)
