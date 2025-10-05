---
description: >-
  Measure the key performance metrics of a WEKA cluster—latency, IOPS, and
  bandwidth—using standardized testing procedures.
---

# WEKA performance tests

## Overview

When measuring a storage system's performance, there are three primary metrics:

* **Latency**: The time from the initiation of an operation to its completion.
* **IOPS**: The number of I/O operations (such as read, write, or metadata) that the system can process concurrently.
* **Bandwidth**: The amount of data that the system can process concurrently.

Each metric applies to read operations, write operations, or a mixture of both. Different [mount modes](../../weka-system-overview/weka-client-and-mount-modes.md) can produce different performance characteristics. Additionally, the client's network configuration, such as using user-space DPDK networking or kernel UDP, significantly affects performance.

It is important to distinguish between single-client and aggregated performance. Running tests from a single client will likely be limited by the client's own performance capabilities. In general, maximizing the performance of a WEKA cluster requires running tests from several clients simultaneously.

To ensure that test results reflect the filesystem's ability to deliver data independent of client-side caching, the benchmarks are designed to negate the effects of caching where possible. This is achieved by using `o_direct` calls to bypass the client's cache for file testing and by flushing Linux caches between tests.

## Testing WEKA performance with wekatester

Use the `wekatester` command-line utility to measure the performance of a WEKA cluster. This tool automates a series of standardized FIO tests to measure key performance indicators (KPIs), such as throughput, IOPS, and latency.

Using `wekatester` is the recommended approach for performance testing as it provides consistent, reproducible, and easy-to-interpret results.

**Before you begin**

* Ensure [FIO](https://linux.die.net/man/1/fio) is installed on all client hosts participating in the test ([FIO documentation](https://fio.readthedocs.io/en/latest/fio_doc.html)).

**Procedure**

1. Log in to a client with access to the WEKA cluster.
2. Clone the the **tools** repository:\
   `git clone --depth 1` [`https://github.com/weka/tools.git`](https://github.com/weka/tools.git)
3. Change directory to **tools/wekatester**.
4.  Run the performance test suite using the following command:

    ```bash
    ./wekatester -c
    ```

    The tool automatically discovers the cluster and clients, prepares the hosts for testing, runs the full suite of performance tests, and reports the aggregated results.

**Result example**

The command displays a summary of the performance results, providing a clear overview of the cluster's capabilities.

```
read bandwidth: 434.52 GiB/s
total bandwidth: 434.52 GiB/s
average bandwidth: 27.16 GiB/s per host

write bandwidth: 258.49 GiB/s
total bandwidth: 258.49 GiB/s
average bandwidth: 16.16 GiB/s per host

read latency: 143 us

write latency: 134 us

read iops: 16,526,081/s
total iops: 16,526,081/s
average iops: 1,032,880/s per host

write iops: 4,089,720/s
total iops: 4,089,720/s
average iops: 255,607/s per host
```

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

MDTest uses an MPI framework to coordinate jobs across multiple nodes. The examples shown here assume the use of MDTest version 1.9.3 with [MPICH](https://www.mpich.org/downloads/) version 3.3.2 ([MPITCH documentation](https://www.mpich.org/documentation/guides/)).

**Procedure**

Run the MDTest benchmark from a client machine with access to the WEKA filesystem. The following command runs the test across multiple clients defined in a hostfile. It uses 8 clients with 136 threads each to test the performance on 20 million files.

**Job definition**

```bash
mpiexec -f <hostfile> -np 1088 mdtest-v-N 136i 3 n 18382 -F -u-d /mnt/weka/mdtest
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

<table><thead><tr><th width="203.96484375">Benchmark</th><th width="230.95703125">AWS</th><th>SuperMicro</th></tr></thead><tbody><tr><td><strong>Read Throughput</strong></td><td>8.9 GiB/s</td><td>21.4 GiB/s</td></tr><tr><td><strong>Write Throughput</strong></td><td>9.4 GiB/s</td><td>17.2 GiB/s</td></tr><tr><td><strong>Read IOPS</strong></td><td>393,333 ops/s</td><td>563,667 ops/s</td></tr><tr><td><strong>Write IOPS</strong></td><td>302,333 ops/s</td><td>378,667 ops/s</td></tr><tr><td><strong>Read Latency</strong></td><td>272 µs avg.&#x26;lt;br>99.5% completed under 459 µs</td><td>144.76 µs avg.&#x26;lt;br>99.5% completed under 260 µs</td></tr><tr><td><strong>Write Latency</strong></td><td>298 µs avg.&#x26;lt;br>99.5% completed under 432 µs</td><td>107.12 µs avg.&#x26;lt;br>99.5% completed under 142 µs</td></tr></tbody></table>

### **Aggregated cluster results (with multiple clients)**

<table><thead><tr><th width="203.94921875">Benchmark</th><th width="232.93359375">AWS</th><th>SuperMicro</th></tr></thead><tbody><tr><td><strong>Read Throughput</strong></td><td>36.2 GiB/s</td><td>123 GiB/s</td></tr><tr><td><strong>Write Throughput</strong></td><td>11.6 GiB/s</td><td>37.6 GiB/s</td></tr><tr><td><strong>Read IOPS</strong></td><td>1,978,330 ops/s</td><td>4,346,330 ops/s</td></tr><tr><td><strong>Write IOPS</strong></td><td>404,670 ops/s</td><td>1,317,000 ops/s</td></tr><tr><td><strong>Creates</strong></td><td>79,599 ops/s</td><td>234,472 ops/s</td></tr><tr><td><strong>Stats</strong></td><td>1,930,721 ops/s</td><td>3,257,394 ops/s</td></tr><tr><td><strong>Deletes</strong></td><td>117,644 ops/s</td><td>361,755 ops/s</td></tr></tbody></table>
