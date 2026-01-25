---
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/best-practice-guides/weka-and-slurm-integration/avoid-conflicting-cpu-allocations
---

# Manage CPU allocations for WEKA and Slurm

Configure efficient CPU allocation to prevent conflicts between the WEKA filesystem and Slurm job scheduling. Improper CPU allocation can lead to performance degradation, CPU starvation, or resource contention.

Follow these steps to ensure WEKA and Slurm coexist by managing CPUsets and NUMA node allocations.

### 1. Disable WEKA CPUset isolation

Ensure that WEKA's default CPUset isolation is disabled to avoid conflicts with Slurm.

```bash
grep 'isolate_cpusets=' /etc/wekaio/service.conf
```

**Example result:**

```bash
isolate_cpusets = false
```

### 2. Verify hyperthreading and NUMA configuration

Verify the hyperthreading and NUMA configuration of the server. Hyperthreading is typically disabled in Slurm-managed environments.

```bash
lscpu | egrep 'Thread|NUMA'
```

**Example result:** In this example, hyperthreading is disabled (1 thread per core), and there are four NUMA nodes.

```bash
Thread(s) per core:  1
NUMA node(s):        4
NUMA node0 CPU(s):   0-13
NUMA node1 CPU(s):   14-27
NUMA node2 CPU(s):   28-41
NUMA node3 CPU(s):   42-55
```

### 3. Identify the NUMA node of the dataplane network interface

Determine the NUMA node associated with the dataplane network interface.

```bash
cat /sys/class/net/ib0/device/numa_node
```

**Example result:** In this example, the interface `ib0` is located in NUMA node 1.

```bash
1
```

Verify the local CPU list for the interface:

```bash
cat /sys/class/net/ib0/device/local_cpulist
```

**Example result:**

```bash
14-27
```

### 4. Assign CPU cores to WEKA

When you mount the WEKA filesystem, specify the CPU cores for the WEKA client.

* Select cores located in the same NUMA node as the network interface.
* Avoid using core 0.
* Select the last cores in the NUMA node.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o core=24,core=25,core=26,core=27,net=ib0 /mnt/wekafs
```
{% endcode %}

Run the following command to confirm the cores and network interfaces used by WEKA:

```bash
weka local resources | head
```

**Example result:**

```bash
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

Configure Slurm to exclude the cores assigned to WEKA from user jobs by setting the `CPUSpecList` parameter.

Run the following command to verify the configuration:

```bash
scontrol show node $(hostname -s) | grep CPUSpecList
```

**Example result:**

```bash
CoreSpecCount=4 CPUSpecList=24-27 MemSpecLimit=20480
```

### 6. Verify CPUset configuration

Ensure that the Slurm CPUset excludes the cores assigned to the WEKA client.

**WEKA client:**

```bash
grep "" /sys/fs/cgroup/cpuset/weka-client/*cpus
```

**Example result:**

```bash
/sys/fs/cgroup/cpuset/weka-client/cpuset.cpus:24-27
/sys/fs/cgroup/cpuset/weka-client/cpuset.effective_cpus:24-27
```

**Slurm:**

```bash
grep "" /sys/fs/cgroup/cpuset/slurm/system/*cpus
```

**Example result:**

```bash
/sys/fs/cgroup/cpuset/slurm/system/cpuset.cpus:0-23,28-55
/sys/fs/cgroup/cpuset/slurm/system/cpuset.effective_cpus:0-23,28-55
```

### 7. Manage hyperthreading

If hyperthreading is enabled, identify the sibling CPUs and include them in both the WEKA mount options and the Slurm `CPUSpecList`. Although WEKA automatically reserves these CPUs, explicit specification helps prevent potential issues.

```bash
grep /sys/devices/system/cpu/*/topology/thread_siblings_list | egrep 'cpu24|cpu25|cpu26|cpu27'
```

Example result:

{% code overflow="wrap" %}
```bash
/sys/devices/system/cpu/cpu24/topology/thread_siblings_list:24
/sys/devices/system/cpu/cpu25/topology/thread_siblings_list:25
/sys/devices/system/cpu/cpu26/topology/thread_siblings_list:26
/sys/devices/system/cpu/cpu27/topology/thread_siblings_list:27
```
{% endcode %}

### 8. Address logical and physical CPU index mismatch

Environmental factors, such as BIOS or hypervisor settings, may cause discrepancies between logical CPU numbers and physical or OS-assigned numbers. This mismatch can result in the Slurm CPUset mistakenly including CPUs that must remain reserved for the WEKA client.

**Identify conflicts**

If the CPUset configuration shows that Slurm does not correctly exclude the WEKA-assigned CPUs, you might observe an overlap. In the following troubleshooting example, WEKA is assigned physical cores 56-63, but they appear in the Slurm CPUset, causing conflicts.

**WEKA:**

```bash
grep "" /sys/fs/cgroup/cpuset/weka*/cpuset.effective_cpus
```

**Example result:**

```bash
56-63
```

**Slurm:**

```bash
grep "" /sys/fs/cgroup/cpuset/slurm/system/cpuset.effective_cpus
```

**Example result:**

```bash
0-48,50,52,54,56,58,60,62
```

This issue often arises from non-sequential CPU numbering where CPUs are interleaved between NUMA nodes:

```bash
lscpu | egrep 'Thread|NUMA'
```

**Example result:**

```bash
Thread(s) per core:  1
NUMA node(s):        2
NUMA node0 CPU(s):   0,2,4,6,8,10,...52,54,56,58,60,62
NUMA node1 CPU(s):   1,3,5,7,9,11,...53,55,57,59,61,63
```

**Resolve index mismatches**

To address this mismatch, perform the following actions:

1. Ensure that the WEKA agent `isolate_cpuset=false` setting is applied (see Step 1) and that you restart the agent.
2. Use `hwloc-ls` or `lstopo-no-graphics` to map the logical index (L#) to the physical/OS index (P#) for the CPUs assigned to WEKA.

{% hint style="warning" %}
**Important:** Before you start any WEKA container or mount WEKA filesystems, verify the output of `hwloc-ls` or `lstopo-no-graphics`. Failure to perform this check can result in incorrect logical index mappings, leading to configuration or performance issues.
{% endhint %}

Use the following command to verify the logical index numbers provided by user-space tools:

```bash
weka local resources | awk '/FRONTEND/ {print "hwloc-ls | grep --color -w \"P#"$3"\""}' | bash
```

**Example result:** The following output indicates a mismatch between the Logical Index (L#) and Physical Index (P#):

```bash
L2 L#28 (2048KB) + L1d L#28 (48KB) + L1i L#28 (32KB) + Core L#28 + PU L#28 (P#56)
L2 L#29 (2048KB) + L1d L#29 (48KB) + L1i L#29 (32KB) + Core L#29 + PU L#29 (P#58)
L2 L#30 (2048KB) + L1d L#30 (48KB) + L1i L#30 (32KB) + Core L#30 + PU L#30 (P#60)
L2 L#31 (2048KB) + L1d L#31 (48KB) + L1i L#31 (32KB) + Core L#31 + PU L#31 (P#62)
L2 L#60 (2048KB) + L1d L#60 (48KB) + L1i L#60 (32KB) + Core L#60 + PU L#60 (P#57)
L2 L#61 (2048KB) + L1d L#61 (48KB) + L1i L#61 (32KB) + Core L#61 + PU L#61 (P#59)
L2 L#62 (2048KB) + L1d L#62 (48KB) + L1i L#62 (32KB) + Core L#62 + PU L#62 (P#61)
L2 L#63 (2048KB) + L1d L#63 (48KB) + L1i L#63 (32KB) + Core L#63 + PU L#63 (P#63)
```

If the logical and physical indexes do not match, use the logical index numbers in the Slurm `CPUSpecList` parameter.

In this example, although WEKA uses physical cores **56-63**, you must set the Slurm `CPUSpecList` to **28-31,60-63** to correctly allocate the CPUs based on their logical index.

**Related information**

[Slurm GRES documentation](https://slurm.schedmd.com/gres.conf.html) (for more details on logical and physical core index mapping)
