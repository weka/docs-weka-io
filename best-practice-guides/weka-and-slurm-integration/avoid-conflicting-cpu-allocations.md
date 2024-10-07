# Avoid conflicting CPU allocations

In a WEKA and Slurm integration, efficient CPU allocation is crucial to prevent conflicts between the WEKA filesystem and Slurm job scheduling. Improper CPU allocation can lead to performance degradation, CPU starvation, or resource contention. This section outlines best practices to ensure WEKA and Slurm coexist harmoniously by carefully managing CPUsets and NUMA node allocations.

### 1. Disable WEKA CPUset isolation

Ensure that WEKA's default CPUset isolation is disabled to avoid conflicts with Slurm.

```bash
[root@example01 ~]# grep 'isolate_cpusets=' /etc/wekaio/service.conf
isolate_cpusets = false
```

### 2. Verify hyperthreading and NUMA configuration

Verify your system's hyperthreading and NUMA configuration. Typically, hyperthreading is disabled in most Slurm-managed environments. In this example, hyperthreading is disabled, and there are four NUMA nodes.

```bash
[root@example01 ~]# lscpu | egrep 'Thread|NUMA'
Thread(s) per core:  1
NUMA node(s):        4
NUMA node0 CPU(s):   0-13
NUMA node1 CPU(s):   14-27
NUMA node2 CPU(s):   28-41
NUMA node3 CPU(s):   42-55
```

### 3. Identify the NUMA node of the dataplane network interface

Determine the NUMA node associated with the dataplane network interface. For instance, `ib0` is located in NUMA node 1.

```bash
[root@example01 ~]# cat /sys/class/net/ib0/device/numa_node
1
[root@example01 ~]# cat /sys/class/net/ib0/device/local_cpulist
14-27
```

### 4. Assign CPU cores to WEKA

When mounting the WEKA filesystem, specify the CPU cores for the WEKA client to use. These cores should be in the same NUMA node as the network interface.

Avoid using core 0. Typically, the last cores in the NUMA node are chosen. For example:

{% code overflow="wrap" %}
```bash
[root@example01 ~]# mount -t wekafs -o core=24,core=25,core=26,core=27,net=ib0 /mnt/wekafs
```
{% endcode %}

After mounting, confirm the cores and network interfaces used by WEKA:

```bash
[root@example01 ~]# weka local resources | head
ROLES       NODE ID  CORE ID
MANAGEMENT  0        <auto>
FRONTEND    1        24
FRONTEND    2        25
FRONTEND    3        26
FRONTEND    4        27

NET DEVICE  IDENTIFIER    DEFAULT GATEWAY  IPS  NETMASK  NETWORK LABEL
ib0         0000:4b:00.0                        19
```

### 5. Configure Slurm to exclude WEKA's cores

Configure Slurm to exclude WEKA's cores from those available for user jobs by setting the `CPUSpecList` parameter.

Verify the configuration with:

```bash
[root@example01 ~]# scontrol show node $(hostname -s) | grep CPUSpecList
CoreSpecCount=4 CPUSpecList=24-27 MemSpecLimit=20480
```

### 6. Verify CPUset configuration

Ensure that the Slurm CPUset excludes the cores assigned to the WEKA client.

```bash
[root@example01 ~]# grep "" /sys/fs/cgroup/cpuset/weka-client/*cpus
/sys/fs/cgroup/cpuset/weka-client/cpuset.cpus:24-27
/sys/fs/cgroup/cpuset/weka-client/cpuset.effective_cpus:24-27

[root@example01 ~]# grep "" /sys/fs/cgroup/cpuset/slurm/system/*cpus
/sys/fs/cgroup/cpuset/slurm/system/cpuset.cpus:0-23,28-55
/sys/fs/cgroup/cpuset/slurm/system/cpuset.effective_cpus:0-23,28-55
```

### 7. Manage hyperthreading

If hyperthreading is enabled, identify the sibling CPUs and include them in both the WEKA mount options and Slurm’s `CPUSpecList`. For clarity, even though WEKA automatically reserves these CPUs, explicitly specifying them can help avoid potential issues.

In this example, hyperthreading is disabled, so no additional CPUs are required:

{% code overflow="wrap" %}
```bash
[root@example01 ~]# grep "" /sys/devices/system/cpu/*/topology/thread_siblings_list | egrep 'cpu24|cpu25|cpu26|cpu27'
/sys/devices/system/cpu/cpu24/topology/thread_siblings_list:24
/sys/devices/system/cpu/cpu25/topology/thread_siblings_list:25
/sys/devices/system/cpu/cpu26/topology/thread_siblings_list:26
/sys/devices/system/cpu/cpu27/topology/thread_siblings_list:27
```
{% endcode %}

### 8. Address logical and physical CPU index mismatch

In certain situations, environmental factors like BIOS or hypervisor settings may cause discrepancies between logical CPU numbers and the physical or OS-assigned numbers. This can result in the Slurm CPUset mistakenly including CPUs that should be reserved for the WEKA client, potentially leading to resource conflicts such as CPU starvation.

For example, if the CPUset configuration shows that Slurm is not correctly excluding the WEKA-assigned CPUs, you might see something like this, where CPUs 56, 58, 60, and 62 are listed in _both_ CPUsets, which will cause conflicts:

```bash
[root@example01 ~]# grep "" /sys/fs/cgroup/cpuset/weka*/cpuset.effective_cpus
56-63
[root@example01 ~]# grep "" /sys/fs/cgroup/cpuset/slurm/system/cpuset.effective_cpus
0-48,50,52,54,56,58,60,62
```

The issue may arise from non-sequential CPU numbering, where CPUs are interleaved between NUMA nodes:

```bash
[root@example01 ~]# lscpu | egrep 'Thread|NUMA'
Thread(s) per core:  1
NUMA node(s):        2
NUMA node0 CPU(s):   0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62
NUMA node1 CPU(s):   1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55,57,59,61,63
```

To address this, use `hwloc-ls` to map the logical index (L#) to the physical/OS index (P#) for the CPUs assigned to WEKA. If the logical and physical indexes don’t match, use the logical index numbers in Slurm’s `CPUSpecList` parameter.

In this example, the output indicates a mismatch between the L# and P#:

```bash
[root@example01 ~]# weka local resources | egrep 'FRONTEND' | awk '{print "hwloc-ls | grep P\\#"$3}' | bash
      L2 L#28 (2048KB) + L1d L#28 (48KB) + L1i L#28 (32KB) + Core L#28 + PU L#28 (P#56)
      L2 L#29 (2048KB) + L1d L#29 (48KB) + L1i L#29 (32KB) + Core L#29 + PU L#29 (P#58)
      L2 L#30 (2048KB) + L1d L#30 (48KB) + L1i L#30 (32KB) + Core L#30 + PU L#30 (P#60)
      L2 L#31 (2048KB) + L1d L#31 (48KB) + L1i L#31 (32KB) + Core L#31 + PU L#31 (P#62)
      L2 L#60 (2048KB) + L1d L#60 (48KB) + L1i L#60 (32KB) + Core L#60 + PU L#60 (P#57)
      L2 L#61 (2048KB) + L1d L#61 (48KB) + L1i L#61 (32KB) + Core L#61 + PU L#61 (P#59)
      L2 L#62 (2048KB) + L1d L#62 (48KB) + L1i L#62 (32KB) + Core L#62 + PU L#62 (P#61)
      L2 L#63 (2048KB) + L1d L#63 (48KB) + L1i L#63 (32KB) + Core L#63 + PU L#63 (P#63)
```

Although WEKA uses _physical_ cores `56-63`, set Slurm’s `CPUSpecList` to `28-31,60-63` to correctly allocate the CPUs based on their _logical_ index.

**Related information**

[Slurm GRES documentation](https://slurm.schedmd.com/gres.conf.html) (for more details on logical and physical core index mapping)
