---
description: Allocate CPU resources between WEKA and Slurm workloads.
---

# Manage CPU allocations for WEKA and Slurm

Configure efficient CPU allocation to prevent conflicts between the WEKA filesystem and Slurm job scheduling. Improper CPU allocation can lead to performance degradation, CPU starvation, or resource contention.

Follow these steps to ensure WEKA and Slurm coexist by managing CPUsets and NUMA node allocations.

### 1. Disable WEKA CPUset isolation

Ensure WEKA's default CPUset isolation is disabled to avoid conflicts with Slurm's resource management.

{% hint style="warning" %}
**For Cgroups v2 + Slurm GRES:** Simply setting this to `false` may not be enough if Slurm is using automated GRES discovery. Ensure Slurm's `TaskPlugin` is configured to respect the manual `CPUSpecList` defined in [#id-5.-configure-slurm-to-exclude-wekas-cores](avoid-conflicting-cpu-allocations.md#id-5.-configure-slurm-to-exclude-wekas-cores "mention").
{% endhint %}

```bash
grep 'isolate_cpusets=' /etc/wekaio/service.conf
```

**Example result:**

```bash
isolate_cpusets = false
```

### 2. Verify hyperthreading and NUMA configuration

Verify the server's topology. Hyperthreading is typically disabled in Slurm-managed environments.

```bash
lscpu | egrep 'Thread|NUMA'
```

**Example result:** (Hyperthreading disabled, four NUMA nodes)

```bash
Thread(s) per core:  1
NUMA node(s):        4
NUMA node0 CPU(s):   0-13
NUMA node1 CPU(s):   14-27
NUMA node2 CPU(s):   28-41
NUMA node3 CPU(s):   42-55
```

### 3. Identify the dataplane network NUMA node

Determine the NUMA node associated with the dataplane network interface (for example: `ib0`).

```bash
cat /sys/class/net/ib0/device/numa_node
# Example result: 1

cat /sys/class/net/ib0/device/local_cpulist
# Example result: 14-27
```

### 4. Assign CPU cores to WEKA

When mounting, select cores in the same NUMA node as the network interface. **Avoid core 0** and select the last cores in the node.

{% code overflow="wrap" %}
```bash
mount -t wekafs -o core=24,core=25,core=26,core=27,net=ib0 /mnt/wekafs
```
{% endcode %}

Verify with:

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

Set the `CPUSpecList` parameter in Slurm to exclude the cores reserved for WEKA.

**Verify the configuration**

```bash
scontrol show node $(hostname -s) | grep CPUSpecList
```

**Example result:**

```bash
CoreSpecCount=4 CPUSpecList=24-27 MemSpecLimit=20480
```

{% hint style="warning" %}
**CPU index verification:** Ensure there is no mismatch between logical and physical CPU indexes. If a mismatch is detected, Slurm may inadvertently schedule jobs on WEKA cores.

* **Action:** If indexes differ, see [#id-8.-address-logical-and-physical-cpu-index-mismatch](avoid-conflicting-cpu-allocations.md#id-8.-address-logical-and-physical-cpu-index-mismatch "mention").
* **Reference:** See the /pages/C9Kb5Lk2YdpptwlNlLSx#id-2.-allocate-cores-and-memory-for-the-weka-agent.
{% endhint %}

### 6. Verify CPUset configuration (v1 and v2)

Ensure the Slurm CPUset correctly excludes the WEKA cores. Check the path corresponding to your OS cgroup version.

**WEKA client:**

* **v1:**

```bash
grep "" /sys/fs/cgroup/cpuset/weka-client/*cpus
```

* **v2:**

```bash
cat /sys/fs/cgroup/weka.slice/cpuset.cpus.effective (path may vary by distro)
```

* **Example result:** The Slurm list should not contain the cores listed in the WEKA client list.

```bash
/sys/fs/cgroup/cpuset/weka-client/cpuset.cpus:24-27
/sys/fs/cgroup/cpuset/weka-client/cpuset.effective_cpus:24-27
```

**Slurm:**

* **v1:**

```bash
grep "" /sys/fs/cgroup/cpuset/slurm/system/*cpus
```

* **v2:**

```bash
cat /sys/fs/cgroup/system.slice/slurmstepd.scope/cpuset.cpus.effective
```

* **Example result:** The Slurm list should not contain the cores listed in the WEKA client list.

```bash
/sys/fs/cgroup/cpuset/slurm/system/cpuset.cpus:0-23,28-55
/sys/fs/cgroup/cpuset/slurm/system/cpuset.effective_cpus:0-23,28-55
```

### 7. Manage hyperthreading

If hyperthreading is enabled, identify the sibling CPUs and include them in both the WEKA mount options and the Slurm `CPUSpecList`. Although WEKA automatically reserves these CPUs, explicit specification helps prevent potential issues.

```bash
grep /sys/devices/system/cpu/*/topology/thread_siblings_list | egrep 'cpu24|cpu25|cpu26|cpu27'
```

**Example result:**

{% code overflow="wrap" %}
```bash
/sys/devices/system/cpu/cpu24/topology/thread_siblings_list:24
/sys/devices/system/cpu/cpu25/topology/thread_siblings_list:25
/sys/devices/system/cpu/cpu26/topology/thread_siblings_list:26
/sys/devices/system/cpu/cpu27/topology/thread_siblings_list:27
```
{% endcode %}

### 8. Address logical and physical CPU index mismatch

Environmental factors (BIOS/Hypervisor) may cause logical CPU numbers to differ from physical/OS-assigned numbers. This causes Slurm to mistakenly include WEKA-reserved CPUs.

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

1. **Re-verify Step 1:** Ensure `isolate_cpuset=false` is set and the agent is restarted.
2. **Map Indexes:** Use `hwloc-ls` to map Logical (L#) to Physical (P#).

```bash
weka local resources | awk '/FRONTEND/ {print "hwloc-ls | grep --color -w \"P#"$3"\""}' | bash
```

{% hint style="warning" %}
**Important:** Before you start any WEKA container or mount WEKA filesystems, verify the output of `hwloc-ls` or `lstopo-no-graphics`. Failure to perform this check can result in incorrect logical index mappings, leading to configuration or performance issues.
{% endhint %}

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

3. **Correct Slurm configuration:** If a mismatch exists, you must use the Logical Index numbers in the Slurm `CPUSpecList`.
   * **Example:** WEKA uses physical cores 56-63, but `hwloc` shows these are logical 28-31 and 60-63. Set `CPUSpecList=28-31,60-63`.

If the logical and physical indexes do not match, use the logical index numbers in the Slurm `CPUSpecList` parameter.

**Related information**

[Slurm GRES documentation](https://slurm.schedmd.com/gres.conf.html) (for more details on logical and physical core index mapping)
