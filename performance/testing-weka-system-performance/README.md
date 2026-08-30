---
description: >-
  Measure the key performance metrics of a storage system—latency, IOPS, and
  bandwidth—using standardized testing procedures.
---

# System performance tests

## Overview

When evaluating a storage system’s performance, three primary metrics are considered:

* **Latency:** The time between the initiation and completion of an I/O operation.
* **IOPS:** The number of I/O operations (read, write, or metadata) that the system can process per second.
* **Bandwidth:** The amount of data transferred per second during I/O operations.

Each metric applies to read, write, or mixed workloads. Performance characteristics may vary depending on the mount mode and network configuration (for example, user-space DPDK vs. kernel UDP).

It is important to distinguish between single-client and aggregated performance. A single client may be limited by its local resources, so for accurate cluster-wide measurements, run tests from multiple clients simultaneously.

To ensure that results reflect the filesystem’s true capabilities rather than client-side caching, all benchmarks use direct I/O (O\_DIRECT) and clear Linux caches between tests.

## Test performance with wekatester

Use the `wekatester` command-line utility to perform manual performance testing across multiple client hosts. The tool runs FIO (Flexible I/O) workloads on client systems, also referred to as compute nodes, that are connected to a shared network filesystem.

This approach enables consistent, reproducible, and comparable (“apples-to-apples”) performance benchmarking across different storage systems.

{% hint style="info" %}
Unlike previous versions, automatic cluster and client discovery (`wekatester -c`) is no longer available.

All servers must now be specified manually when running tests.
{% endhint %}

#### **Before you begin**

Ensure that FIO is installed on all client hosts participating in the tests.

FIO is included in most Linux distributions and can typically be installed using your system’s package manager, for example:

```
dnf install fio
# or
apt install fio
```

For more information on installation and usage, see [FIO documentation](https://fio.readthedocs.io/en/latest/fio_doc.html).

#### **Procedure**

1. Log in to a client with access to the system under test.
2. Clone the tools repository:

```bash
   git clone --depth 1 https://github.com/weka/tools.git
```

3. Navigate to the `wekatester` directory:

```bash
cd tools/wekatester
```

3. Run the performance test manually using the following syntax:

```bash
./wekatester.py -d <directory> [-w <workload>] [--fio-bin <path>] [server ...]
```

#### **Command properties**

All command properties are optional except the `server` property.

<table><thead><tr><th width="192.7734375">Option</th><th>Description</th></tr></thead><tbody><tr><td><code>server</code>*</td><td>Required. One or more server hostnames or IPs to use as workers.</td></tr><tr><td><code>-d, --directory</code></td><td><p>Target directory on the workers where test files will be created. The target filesystem must be mounted at this directory or at a parent directory.</p><p>Default: <code>/mnt/weka</code>.</p></td></tr><tr><td><code>-w, --workload</code></td><td><p>Specifies the workload definition directory from the <code>fio-jobfiles</code> subdirectory structure.</p><p>Default: <code>default</code></p><p>Built-in workload options:</p><ul><li><strong><code>default</code></strong>: Four-corners test suite covering read/write bandwidth, latency, and IOPS</li><li><strong><code>mixed</code></strong>: 70/30 read/write mixed workload patterns</li></ul><p>You can create custom workload directories under <code>fio-jobfiles/</code> and reference them with this option.</p><p>Example:</p><pre class="language-bash"><code class="lang-bash">./wekatester.py -d /mnt/weka -w mixed server1 server2 server3
</code></pre></td></tr><tr><td><code>--fio-bin</code></td><td><p>Specifies the path to the <code>fio</code> binary on target servers.</p><p>Default: <code>/usr/bin/fio</code></p><p>Use this option when <code>fio</code> is installed in a non-standard location or when you want to use a specific <code>fio</code> version.</p><p>Example:</p><pre class="language-bash"><code class="lang-bash">./wekatester.py -d /mnt/weka --fio-bin /opt/fio/bin/fio server1 server2
</code></pre></td></tr><tr><td><code>-v, --verbosity</code></td><td><p>Increases output verbosity for debugging and detailed monitoring.</p><p>Verbosity levels:</p><ul><li><code>-v</code>: Basic verbose output</li><li><code>-vv</code>: Detailed verbose output</li><li><code>-vvv</code>: Maximum verbosity with debug information</li></ul></td></tr><tr><td><code>-V, --version</code></td><td>Displays the <code>wekatester</code> version number.</td></tr></tbody></table>

#### Example default usage

```bash
./wekatester server1 server2 server3... 
```

During execution, `wekatester` distributes and runs FIO workloads on the specified servers, collects performance data, and summarizes the results.

#### Example output

The command displays a summary of the performance results, providing a clear overview of the cluster's capabilities.

```
starting test run for job 011-bandwidthR.job on <hostname> with <n> workers:
    read bandwidth: 9.37 GiB/s
    total bandwidth: 9.37 GiB/s
    average bandwidth: 2.34 GiB/s per host

starting test run for job 012-bandwidthW.job on <hostname> with <n> workers:
    write bandwidth: 7.72 GiB/s
    total bandwidth: 7.72 GiB/s
    average bandwidth: 1.93 GiB/s per host

starting test run for job 021-latencyR.job on <hostname> with <n> workers:
    read latency: 237 us

starting test run for job 022-latencyW.job on <hostname> with <n> workers:
    write latency: 180 us
```

Raw FIO results are stored as JSON files, for example:

```
results_2025-10-07_1112.json
```

These files contain the full FIO output for detailed analysis.

### Wekatester FIO job definitions

The `wekatester` tool uses a standardized set of Flexible I/O (FIO) tester jobs to ensure consistent and comparable results. These job definitions are provided for users who want to review the testing methodology or run the tests manually.

All jobs use a 2G file size for testing consistency.

#### **Read throughput job definition**

This job measures the maximum read bandwidth.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=32

[fio-createfiles-00]
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-bandwidthSR-00]
stonewall
description='Sequential Read bandwidth workload'
blocksize=1Mi
rw=read
iodepth=1
```

#### **Write throughput job definition**

This job measures the maximum write bandwidth.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=32

[fio-createfiles-00]
stonewall
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-bandwidthSW-00]
stonewall
description='Sequential Write bandwidth workload'
blocksize=1Mi
rw=write
iodepth=1
```

#### **Read IOPS job definition**

This job measures the maximum read IOPS using a 4k block size.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=64

[fio-createfiles-00]
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-iopsR-00]
stonewall
description='Read iops workload'
iodepth=8
bs=4k
rw=randread
```

#### **Write IOPS job definition**

This job measures the maximum write IOPS using a 4k block size.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=64

[fio-createfiles-00]
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-iopsW-00]
stonewall
description='Write iops workload'
iodepth=8
bs=4k
rw=randwrite
```

#### **Read latency job definition**

This job measures read latency using a 4k block size.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=1

[fio-createfiles-00]
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-latencyR-00]
stonewall
description='Read latency workload'
bs=4k
rw=randread
iodepth=1
```

#### **Write latency job definition**

This job measures write latency using a 4k block size.

```toml
[global]
filesize=2G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$filenum/$jobnum
directory=/mnt/weka
group_reporting=1
clocksource=gettimeofday
runtime=30
ioengine=libaio
disk_util=0
direct=1
numjobs=1

[fio-createfiles-00]
blocksize=1Mi
description='pre-create files'
create_only=1

[fio-latencyW-00]
stonewall
description='Write latency workload'
bs=4k
rw=randwrite
iodepth=1
```

## Testing metadata performance with MDTest

MDTest is an open-source tool designed to test metadata performance, measuring the rate of operations such as file creates, stats, and deletes across the cluster.

MDTest uses an MPI framework to coordinate jobs across multiple nodes. The examples shown here assume the use of MDTest version 1.9.3 with [MPICH](https://www.mpich.org/downloads/) version 3.3.2 ([MPICH documentation](https://www.mpich.org/documentation/guides/)).

**Procedure**

Run the MDTest benchmark from a client machine with access to the WEKA filesystem. The following command runs the test across multiple clients defined in a hostfile. It uses 8 clients with 136 threads each to test the performance on 20 million files.

**Job definition**

```bash
mpiexec -f <hostfile> -np 1088 mdtest -v -N 136 -i 3 -n 18382 -F -u -d /mnt/weka/mdtest
```

**Result example**

The following table shows an example summary from three test iterations.

| Operation         | Max         | Min         | Mean        | Std Dev |
| ----------------- | ----------- | ----------- | ----------- | ------- |
| **File creation** | 40784.448   | 40784.447   | 40784.448   | 0.001   |
| **File stat**     | 2352915.997 | 2352902.666 | 2352911.311 | 6.121   |
| **File read**     | 217236.252  | 217236.114  | 217236.162  | 0.064   |
| **File removal**  | 44101.905   | 44101.896   | 44101.902   | 0.004   |
| **Tree creation** | 3.788       | 3.097       | 3.342       | 0.316   |
| **Tree removal**  | 1.192       | 1.142       | 1.172       | 0.022   |

## Performance test results summary

The following tables show example results from tests run in specific AWS and SuperMicro environments.

### **Single client results**

| Benchmark | AWS | SuperMicro |
| --- | --- | --- |
| **Read Throughput** | 8.9 GiB/s | 21.4 GiB/s |
| **Write Throughput** | 9.4 GiB/s | 17.2 GiB/s |
| **Read IOPS** | 393,333 ops/s | 563,667 ops/s |
| **Write IOPS** | 302,333 ops/s | 378,667 ops/s |
| **Read Latency** | 272 µs avg.&#x26;lt;br>99.5% completed under 459 µs | 144.76 µs avg.&#x26;lt;br>99.5% completed under 260 µs |
| **Write Latency** | 298 µs avg.&#x26;lt;br>99.5% completed under 432 µs | 107.12 µs avg.&#x26;lt;br>99.5% completed under 142 µs |

### **Aggregated cluster results (with multiple clients)**

| Benchmark | AWS | SuperMicro |
| --- | --- | --- |
| **Read Throughput** | 36.2 GiB/s | 123 GiB/s |
| **Write Throughput** | 11.6 GiB/s | 37.6 GiB/s |
| **Read IOPS** | 1,978,330 ops/s | 4,346,330 ops/s |
| **Write IOPS** | 404,670 ops/s | 1,317,000 ops/s |
| **Creates** | 79,599 ops/s | 234,472 ops/s |
| **Stats** | 1,930,721 ops/s | 3,257,394 ops/s |
| **Deletes** | 117,644 ops/s | 361,755 ops/s |
