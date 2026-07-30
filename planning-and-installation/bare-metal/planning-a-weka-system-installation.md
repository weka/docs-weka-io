---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/planning-and-installation/bare-metal/planning-a-weka-system-installation
---

# Plan hardware requirements

The planning of a WEKA system is essential before the actual installation process. It involves the planning of the following:

1. Total SSD net capacity and performance requirements
2. SSD resources
3. Memory resources
4. CPU resources
5. Network

{% hint style="info" %}
When implementing an AWS configuration, it is possible to go to the [Self-Service Portal in start.weka.io](/broken/pages/-L7Tv_d53m7ZQP8937LL) to map capacity and performance requirements into various configurations automatically.
{% endhint %}

## Total SSD net capacity and performance planning

A WEKA system cluster runs on a group of servers with local SSDs. To plan these servers, the following information must be clarified and defined:

1. **Capacity:** Plan your net SSD capacity. The data management to object stores can be added after the installation. In the context of the planning stage, only the SSD capacity is required.
2. **Redundancy scheme:** Define the optimal redundancy scheme required for the WEKA system, as explained in [Selecting a Redundancy Scheme](../../weka-system-overview/about.md#selecting-a-redundancy-scheme).
3. **Failure domains:** Determine whether to use failure domains (optional), and if yes, determine the number of failure domains and the potential number of servers in each failure domain, as described in [Failure Domains](/broken/pages/-L7yY2QmpKSIOpgDhBFf#failure-domains-optional), and plan accordingly.
4. **Hot spare**: Define the required hot spare count (see [#hot-spare-capacity](../../weka-system-overview/cluster-capacity-and-redundancy-management.md#hot-spare-capacity "mention")).

Once all this data is clarified, you can plan the SSD net storage capacity accordingly (see [#ssd-net-storage-capacity-calculation](../../weka-system-overview/cluster-capacity-and-redundancy-management.md#ssd-net-storage-capacity-calculation "mention")). Adhere to the following information, which is required during the installation process:

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

The total per server memory requirements are the sum of the following requirements:

<table><thead><tr><th width="247">Purpose</th><th>Per-server memory</th></tr></thead><tbody><tr><td>Fixed</td><td>2.61 GiB</td></tr><tr><td>Frontend processes</td><td>2.05 GiB × # of Frontend processes</td></tr><tr><td>Compute processes</td><td>3.63 GiB × # of Compute processes</td></tr><tr><td>Drive processes</td><td>1.86 GiB × # of Drive processes</td></tr><tr><td>SSD capacity management</td><td>(Total SSD raw capacity in GiB ÷ Number of Servers ÷ 2,000) + (Number of Cores × 2.79 GiB)</td></tr><tr><td>Operating System</td><td>The maximum between 7.45 GiB and 2% of the total RAM</td></tr><tr><td>Additional protocols (NFS/SMB/S3)</td><td>14.9 GiB</td></tr><tr><td>RDMA</td><td>1.86 GiB</td></tr><tr><td>Metadata (pointers)</td><td>20 Bytes × # Metadata units per server<br>See <a href="../../weka-system-overview/filesystems-object-stores-and-filesystem-groups/#metadata-calculations">Metadata units calculation</a>.</td></tr><tr><td>Dedicated Data Services container</td><td><p>If you intend to add a <a data-footnote-ref href="#user-content-fn-1">Data Services container for background tasks</a>, it requires additional memory:</p><ul><li>3.26 GiB (without dedicated core)</li><li>5.12 GiB (with dedicated core)</li></ul></td></tr></tbody></table>

{% hint style="warning" %}
Contact the Customer Success Team to explore options for configurations requiring more than 357.6 GiB of memory per server.
{% endhint %}

#### Example 1: A system with large files

A system with 16 servers with the following details:

* Fixed: 2.61 GiB\
  Number of Frontend processes: 1
* Number of Compute processes: 13
* Number of Drive processes: 6
* Total raw capacity: 915,490.1 GiB
* Total net capacity: 675,208.9 GiB
* NFS/SMB services
* RDMA
* Average file size: 1 MB (potentially up to 755 million files for all servers; \~47 million files per server)

Calculations:

* Frontend processes: 1 × 2.05 = 2.05 GiB
* Compute processes: 13 × 3.63 = 47.2 GiB
* Drive processes: 6 × 1.86 = 11.2 GiB
* SSD capacity management: 915,490.1 GiB ÷ 16 ÷ 2,000 + 20 × 2.79 GiB = \~84.5 GiB
* Additional protocols = 14.9 GiB
* RDMA = 1.86 GiB
* Metadata: 20 Bytes × 47 million files × 2 units = \~1.8 GiB

Total memory requirement per server = 2.61 + 2.05 + 47.2 + 11.2 + 84.5 + 14.9 + 1.86 + 1.8 = \~166.1 GiB

#### Example 2: A system with small files

For the same system as in example 1, but with smaller files, the required memory for metadata would be larger.

For an average file size of 64 KB, the number of files is potentially up to:

* \~12 billion files for all servers.
* \~980 million files per server.

Required memory for metadata: 20 Bytes × 980 million files × 1 unit = \~18.3 GiB

Total memory requirement per server = 2.61 + 2.05 + 47.2 + 11.2 + 84.5 + 14.9 + 1.86 + 18.3 = \~182.6 GiB

{% hint style="info" %}
The memory requirements are conservative and can be reduced in some situations, such as in systems with mostly large files or a system with files 4 KB in size. Contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team) to receive an estimate for your specific configuration.
{% endhint %}

### Client's memory requirements

The minimum memory requirement for a WEKA client is 5 GiB. This minimum supports a single frontend (FE) process with a minimal HugePages allocation, but limits the number of concurrent I/Os WEKA can perform.

For a typical client deployment, the total memory requirement is the sum of the following:

<table><thead><tr><th width="284">Purpose</th><th>Per-client memory</th></tr></thead><tbody><tr><td>Base</td><td>3 GiB</td></tr><tr><td>Frontend (FE) processes</td><td>2.5 GiB × number of FE processes</td></tr><tr><td>HugePages (configured)</td><td>Container HugePages</td></tr><tr><td>HugePages (default)</td><td>1.4 GiB × number of FE processes</td></tr><tr><td>OS and kernel cache</td><td>See note below</td></tr></tbody></table>

{% hint style="info" %}
The WEKA client uses the Linux kernel page cache to accelerate read and write operations. The kernel cache grows to fill available memory, so leaving additional RAM beyond the WEKA process requirements improves I/O performance. The recommended headroom matches the working set size of your workload, though this varies by application. Leave as much free RAM as the system allows.
{% endhint %}

**Example 1: Client with default HugePages**

A client with the following details:

* Number of FE processes: 2

Calculations:

* Base: 3 GiB
* FE processes: 2× 2.5 = 5 GiB
* HugePages: 1.4 x 2 = 2.8 GiB

Total WEKA process memory = 3 + 5 + 2.8 = **10.8 GiB**, plus additional RAM for OS and kernel cache.

**Example 2: Client with configured HugePages**

A client with the following details:

* Number of FE processes: 2
* Configured HugePages: 6 GiB

Calculations:

* Base: 3 GiB
* FE processes: 2 × 2.5 = 5 GiB

Total WEKA process memory = 3 + 5 + 6 = **14 GiB**, plus additional RAM for the OS and kernel cache.

{% hint style="warning" %}
Clients running workloads that consume all available RAM, such as Slurm jobs with no memory reservation, leave no RAM for the kernel cache. This results in degraded I/O performance even for workloads that are not I/O intensive. Reserve sufficient RAM for the OS and kernel cache outside of job schedulers. For Slurm specific guidance, see [weka-and-slurm-integration](../../best-practice-guides/weka-and-slurm-integration/ "mention").
{% endhint %}

## CPU resource planning

Learn about the CPU allocation strategy and resource planning for backend, additional protocols, and client processes.

### CPU allocation strategy

The WEKA system implements a Non-Uniform Memory Access (NUMA) aware CPU allocation strategy to maximize the overall performance of the system. The cores allocation uses all NUMAs equally to balance memory usage from all NUMAs.

Consider the following regarding the CPU allocation strategy:

* The code allocates CPU resources by assigning individual cores to tasks in a cgroup.
* Cores in a cgroup are not available to run any other user processes.

### Backend CPU usage

Plan the number of physical cores dedicated to the WEKA software according to the following guidelines and limitations:

* Dedicate at least one physical core to the operating system; the rest can be allocated to the WEKA software.
  * Generally, it is recommended to allocate as many cores as possible to the WEKA system.
  * A backend server can have as many cores as possible. However, a container within a backend server can have a maximum of 19 physical cores.
  * Leave enough cores for the container serving the protocol if it runs on the same server.
* Allocate enough cores to support performance targets.
  * Generally, use 1 drive process per SSD for up to 6 SSDs and 1 drive process per 2 SSDs for more, with a ratio of 2 compute processes per drive process.
  * For finer tuning, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).
* Allocate enough memory to match core allocation, as discussed above.
* Running other applications on the same server (converged WEKA system deployment) is supported. For details, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

### Additional protocols CPU usage

The SMB, NFS, and S3 protocol services run in dedicated protocol containers alongside frontend containers and consume CPU resources.

Allocating additional CPU cores to protocol and frontend containers generally improves protocol performance. However, CPU scaling is effective only up to the network limit.

For detailed sizing guidelines and performance tuning recommendations tailored to your specific protocol workloads, contact the [Customer Success Team](../../support/getting-support-for-your-weka-system.md#contact-customer-success-team).

### Client CPU usage

The WEKA client software requires one physical CPU core by default. When running on systems with hyper-threading enabled, WEKA consumes two logical cores.

In UDP networking, the operating system pins WEKA processes to specific CPU cores. These processes maintain guaranteed access to their assigned cores, but the operating system can still schedule other processes to run on the same cores. This contrasts with exclusive CPU allocation, where WEKA reserves cores solely for its processes.

## Network planning

### Backend servers

WEKA backend servers support connections to both InfiniBand and Ethernet networks, using [compatible network interface cards](../prerequisites-and-compatibility.md#networking-ethernet) (NICs). When deploying backend servers, ensure that all servers in the WEKA system are connected using the same network technology for each type of network.

InfiniBand connections are prioritized over Ethernet links for data traffic. Both network types must be operational to ensure system availability, so consider adding redundant ports for each network type.

Clients can connect to the WEKA system over either InfiniBand or Ethernet.

A network port can be dedicated exclusively to the WEKA system or shared between the WEKA system and other applications.

### Clients

Clients can be configured with networking as described above to achieve the highest performance and lowest latency; however, this setup requires compatible hardware and dedicated CPU core resources. If compatible hardware is not available or a dedicated CPU core cannot be allocated to the WEKA system, client networking can instead be configured to use the kernel’s UDP service. This configuration results in reduced performance and increased latency.

## What to do next?

[obtaining-the-weka-install-file.md](obtaining-the-weka-install-file.md "mention") (both paths)

[^1]: For details, see [set-up-a-data-services-container-for-background-tasks.md](../../operation-guide/background-tasks/set-up-a-data-services-container-for-background-tasks.md "mention")
