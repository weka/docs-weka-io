---
description: >-
  This page describes a series of tests for measuring performance after the
  installation of the Weka system. The same tests can be used to test the
  performance of any other storage solution.
---

# Testing Weka Performance

## About Weka Performance Testing

There are three main performance metrics when measuring a storage system performance:

1. Latency, which is the time from operation initiation to completion
2. The number of different IO operations (read/write/metadata) that the system can process concurrently
3. The bandwidth of data that the system can process concurrently

Each of these performance metrics applies to read operations, write operations, or a mixture of read and write operations.

‌When measuring the Weka system performance, different [mount modes](../../overview/weka-client-and-mount-modes.md) produce different performance characteristics. Additionally, client network configuration (using either user-space DPDK networking or kernel UDP) also significantly affects performance.

{% hint style="info" %}
**Note:** All performance tests listed here are generic and not specific to the Weka system. They can be used to compare the Weka storage system to other storage systems or a local storage device.
{% endhint %}

{% hint style="info" %}
**Note:** There is a difference between single client performance to aggregated performance. When running the tests listed below from one client, the client will limit the test's performance. In general, several clients will be required to maximize the performance of a Weka cluster.
{% endhint %}

## The FIO Utility

The [FIO Utility](https://linux.die.net/man/1/fio) is a generic open-source storage performance testing tool which can be defined as described [here](https://fio.readthedocs.io/en/latest/fio\_doc.html). In this documentation, the usage of FIO version 3.20 is assumed.

All FIO testing is done using the client/server capabilities of FIO. This makes multiple client testing easier since FIO reports aggregated results for all clients under the test. Single client tests are run the same way to keep the results consistent.

Start the FIO server on every one of the clients:

```
fio --server --daemonize=/tmp/fio.pid
```

Run the test command from one of the clients, note, the clients need to be mounted to a Weka filesystem.

An example of launching a test (`sometest`) on all clients in a file (`clients.txt`) using the server/client model:

```
fio --client=clients.txt sometest.txt
```

An example for the clients' file, when running multiple clients:

{% code title="clients.txt" %}
```
weka-client-01
weka-client-02
weka-client-03
weka-client-04
weka-client-05
weka-client-06
weka-client-07
weka-client-08
```
{% endcode %}

An example of aggregated test results:

```
All clients: (groupid=0, jobs=16): err= 0: pid=0: Wed Jun  3 22:10:46 2020
  read: IOPS=30.1k, BW=29.4Gi (31.6G)(8822GiB/300044msec)
    slat (nsec): min=0, max=228000, avg=6308.42, stdev=4988.75
    clat (usec): min=1132, max=406048, avg=16982.89, stdev=27664.80
     lat (usec): min=1147, max=406051, avg=16989.20, stdev=27664.25
   bw (  MiB/s): min= 3576, max=123124, per=93.95%, avg=28284.95, stdev=42.13, samples=287520
   iops        : min= 3576, max=123124, avg=28284.82, stdev=42.13, samples=287520
  lat (msec)   : 2=6.64%, 4=56.55%, 10=8.14%, 20=4.42%, 50=13.81%
  lat (msec)   : 100=7.01%, 250=3.44%, 500=0.01%
  cpu          : usr=0.11%, sys=0.09%, ctx=9039177, majf=0, minf=8088
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=9033447,0,0,0 short=0,0,0,0 dropped=0,0,0,0
```

The single-client or aggregated tests deffer in the clients participating in the test, as defined in the `clients.txt`.

## MDTest

MDTest is a generic open-source metadata performance testing tool. In this documentation, the usage of version 1.9.3 is assumed.

MDTest uses an MPI framework to coordinate the job across multiple nodes. The results presented here were generated using the [MPICH](https://www.mpich.org/downloads/) version 3.3.2 and can be defined as described [here](https://www.mpich.org/documentation/guides/). While it's possible to have variations with different MPI versions, most are based on the same ROMIO and will perform similarly.

## Weka Client Performance Testing

Overall, the tests contained on this page are designed to show off the sustainable peak performance of the filesystem. Care has been taken to make sure they are realistic and reproducible.

Where possible, the benchmarks try to negate the effects of caching. For file testing, `o_direct` calls are used to bypass the client's cache. In the case of metadata testing, each phase of testing uses different clients. Also, between each test, the Linux caches are flushed to ensure all data being accessed is not present in the cache. While applications will often take advantage of cached data and metadata, this testing focuses on the filesystem's ability to deliver data independent of caching on the client.

While we provide below the output of one iteration, we ran each test several times and provided the average results in the [Result Summary](./#results-summary).

### Results Summary

#### Single Client Results

| Benchmark        | [AWS](test-environment-details.md#aws)                 | [SuperMicro](test-environment-details.md#supermicro)      |
| ---------------- | ------------------------------------------------------ | --------------------------------------------------------- |
| Read Throughput  | 8.9 GiB/s                                              | 21.4 GiB/s                                                |
| Write Throughput | 9.4 GiB/s                                              | 17.2 GiB/s                                                |
| Read IOPS        | 393,333 ops/s                                          | 563,667 ops/s                                             |
| Write IOPS       | 302,333 ops/s                                          | 378,667 ops/s                                             |
| Read Latency     | <p>272 µs avg. </p><p>99.5% completed under 459 µs</p> | <p>144.76 µs avg. </p><p>99.5% completed under 260 µs</p> |
| Write Latency    | <p>298 µs avg. </p><p>99.5% completed under 432 µs</p> | <p>107.12 µs avg. </p><p>99.5% completed under 142 µs</p> |

#### Aggregated Cluster Results (with multiple clients)

| Benchmark        | [AWS](test-environment-details.md#aws) | [SuperMicro](test-environment-details.md#supermicro) |
| ---------------- | -------------------------------------- | ---------------------------------------------------- |
| Read Throughput  | 36.2 GiB/s                             | 123 GiB/s                                            |
| Write Throughput | 11.6 GiB/s                             | 37.6 GiB/s                                           |
| Read IOPS        | 1,978,330 ops/s                        | 4,346,330 ops/s                                      |
| Write IOPS       | 404,670 ops/s                          | 1,317,000 ops/s                                      |
| Creates          | 79,599 ops/s                           | 234,472 ops/s                                        |
| Stats            | 1,930,721 ops/s                        | 3,257,394 ops/s                                      |
| Deletes          | 117,644 ops/s                          | 361,755 ops/s                                        |

{% hint style="info" %}
**Note:** If the client uses a 100 Gbps NIC or above, mounting the Weka filesystem with more than one core is required to maximize client throughput.
{% endhint %}

### Testing Read Throughput

#### Description

This test measures the client throughput for large (1MB) reads. The job below tries to maximize the read throughput from a single client. The test utilizes multiple threads, each one performing 1 MB reads.

#### Job Definition

{% code title="read_throughput.txt" %}
```
[global]
filesize=128G
time_based=1
numjobs=32
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/bw.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[read_throughput]
bs=1m
rw=read
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
read_throughput: (groupid=0, jobs=32): err= 0: pid=70956: Wed Jul  8 13:27:48 2020
  read: IOPS=9167, BW=9167MiB/s (9613MB/s)(2686GiB/300004msec)
    slat (nsec): min=0, max=409000, avg=3882.55, stdev=3631.79
    clat (usec): min=999, max=14947, avg=3482.93, stdev=991.25
     lat (usec): min=1002, max=14949, avg=3486.81, stdev=991.16
    clat percentiles (usec):
     |  1.00th=[ 1795],  5.00th=[ 2147], 10.00th=[ 2376], 20.00th=[ 2671],
     | 30.00th=[ 2900], 40.00th=[ 3130], 50.00th=[ 3359], 60.00th=[ 3589],
     | 70.00th=[ 3851], 80.00th=[ 4178], 90.00th=[ 4752], 95.00th=[ 5342],
     | 99.00th=[ 6521], 99.50th=[ 7046], 99.90th=[ 8160], 99.95th=[ 8717],
     | 99.99th=[ 9896]
   bw (  MiB/s): min= 7942, max=10412, per=100.00%, avg=9179.14, stdev=12.41, samples=19168
   iops        : min= 7942, max=10412, avg=9179.14, stdev=12.41, samples=19168
  lat (usec)   : 1000=0.01%
  lat (msec)   : 2=2.76%, 4=72.16%, 10=25.07%, 20=0.01%
  cpu          : usr=0.55%, sys=0.34%, ctx=2751410, majf=0, minf=490
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=2750270,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show a bandwidth of 8.95 GiB/s from a single client.

### Testing Write Throughput

#### Description

This test measures the client throughput for large (1MB) writes. The job below tries to maximize the write throughput from a single client. The test utilizes multiple threads, each one performing 1MB writes.

#### Job Definition

{% code title="write_throughput.txt" %}
```
[global]
filesize=128G
time_based=1
numjobs=32
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/bw.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[write_throughput]
bs=1m
rw=write
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
write_throughput: (groupid=0, jobs=32): err= 0: pid=71903: Wed Jul  8 13:43:15 2020
  write: IOPS=7034, BW=7035MiB/s (7377MB/s)(2061GiB/300005msec); 0 zone resets
    slat (usec): min=12, max=261, avg=39.22, stdev=12.92
    clat (usec): min=2248, max=20882, avg=4505.62, stdev=1181.45
     lat (usec): min=2318, max=20951, avg=4544.84, stdev=1184.64
    clat percentiles (usec):
     |  1.00th=[ 2769],  5.00th=[ 2999], 10.00th=[ 3163], 20.00th=[ 3458],
     | 30.00th=[ 3752], 40.00th=[ 4047], 50.00th=[ 4359], 60.00th=[ 4686],
     | 70.00th=[ 5014], 80.00th=[ 5407], 90.00th=[ 5997], 95.00th=[ 6587],
     | 99.00th=[ 8160], 99.50th=[ 8979], 99.90th=[10945], 99.95th=[12125],
     | 99.99th=[14746]
   bw (  MiB/s): min= 5908, max= 7858, per=100.00%, avg=7043.58, stdev= 9.37, samples=19168
   iops        : min= 5908, max= 7858, avg=7043.58, stdev= 9.37, samples=19168
  lat (msec)   : 4=38.87%, 10=60.90%, 20=0.22%, 50=0.01%
  cpu          : usr=1.34%, sys=0.15%, ctx=2114914, majf=0, minf=473
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,2110493,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show a bandwidth of 6.87 GiB/s.

### Testing Read IOPS

#### Description

This test measures the ability of the client to deliver concurrent 4KB reads. The job below tries to maximize the system read IOPS from a single client. The test utilizes multiple threads, each one performing 4KB reads.

#### Job Definition

{% code title="read_iops.txt" %}
```
[global]
filesize=4G
time_based=1
numjobs=192
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/iops.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[read_iops]
bs=4k
rw=randread
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
read_iops: (groupid=0, jobs=192): err= 0: pid=66528: Wed Jul  8 12:30:38 2020
  read: IOPS=390k, BW=1525MiB/s (1599MB/s)(447GiB/300002msec)
    slat (nsec): min=0, max=392000, avg=3512.56, stdev=2950.62
    clat (usec): min=213, max=15496, avg=486.61, stdev=80.30
     lat (usec): min=215, max=15505, avg=490.12, stdev=80.47
    clat percentiles (usec):
     |  1.00th=[  338],  5.00th=[  375], 10.00th=[  400], 20.00th=[  424],
     | 30.00th=[  445], 40.00th=[  465], 50.00th=[  482], 60.00th=[  498],
     | 70.00th=[  519], 80.00th=[  545], 90.00th=[  586], 95.00th=[  619],
     | 99.00th=[  685], 99.50th=[  717], 99.90th=[  783], 99.95th=[  816],
     | 99.99th=[ 1106]
   bw (  MiB/s): min= 1458, max= 1641, per=100.00%, avg=1525.52, stdev= 0.16, samples=114816
   iops        : min=373471, max=420192, avg=390494.54, stdev=40.47, samples=114816
  lat (usec)   : 250=0.01%, 500=60.20%, 750=39.60%, 1000=0.19%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%
  cpu          : usr=1.24%, sys=1.52%, ctx=117366459, majf=0, minf=3051
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=117088775,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show 390,494 IOPS from a single client.

### Testing Write IOPS

#### Description

This test measures the ability of the client to deliver concurrent 4KB writes. The job below tries to maximize the system write IOPS from a single client. The test utilizes multiple threads, each one performing 4KB writes.

#### Job Definition

{% code title="write_iops.txt" %}
```
[global]
filesize=4G
time_based=1
numjobs=192
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/iops.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[write_iops]
bs=4k
rw=randwrite
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
write_iops: (groupid=0, jobs=192): err= 0: pid=72163: Wed Jul  8 13:48:24 2020
  write: IOPS=288k, BW=1125MiB/s (1180MB/s)(330GiB/300003msec); 0 zone resets
    slat (nsec): min=0, max=2591.0k, avg=5030.10, stdev=4141.48
    clat (usec): min=219, max=17801, avg=659.20, stdev=213.57
     lat (usec): min=220, max=17803, avg=664.23, stdev=213.72
    clat percentiles (usec):
     |  1.00th=[  396],  5.00th=[  441], 10.00th=[  474], 20.00th=[  515],
     | 30.00th=[  553], 40.00th=[  594], 50.00th=[  627], 60.00th=[  668],
     | 70.00th=[  701], 80.00th=[  750], 90.00th=[  840], 95.00th=[  971],
     | 99.00th=[ 1450], 99.50th=[ 1614], 99.90th=[ 2409], 99.95th=[ 3490],
     | 99.99th=[ 4359]
   bw (  MiB/s): min= 1056, max= 1224, per=100.00%, avg=1125.96, stdev= 0.16, samples=114816
   iops        : min=270390, max=313477, avg=288215.11, stdev=40.70, samples=114816
  lat (usec)   : 250=0.01%, 500=15.96%, 750=63.43%, 1000=16.05%
  lat (msec)   : 2=4.41%, 4=0.14%, 10=0.02%, 20=0.01%
  cpu          : usr=1.21%, sys=1.49%, ctx=86954124, majf=0, minf=3055
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,86398871,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show 288,215 IOPS from a single client.

### Testing Read Latency

This test measures the minimal achievable read latency under a light load. The test measures the latency over a single-threaded sequence of 4KB reads across multiple files. Each read is executed only after the previous read has been served.

#### Job Definition

{% code title="read_latency.txt" %}
```
[global]
filesize=4G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/iops.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[read_latency]
numjobs=1
bs=4k
rw=randread
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
read_latency: (groupid=0, jobs=1): err= 0: pid=71741: Wed Jul  8 13:38:06 2020
  read: IOPS=4318, BW=16.9MiB/s (17.7MB/s)(5061MiB/300001msec)
    slat (nsec): min=0, max=53000, avg=1923.23, stdev=539.64
    clat (usec): min=160, max=1743, avg=229.09, stdev=44.80
     lat (usec): min=162, max=1746, avg=231.01, stdev=44.80
    clat percentiles (usec):
     |  1.00th=[  174],  5.00th=[  180], 10.00th=[  182], 20.00th=[  188],
     | 30.00th=[  190], 40.00th=[  196], 50.00th=[  233], 60.00th=[  245],
     | 70.00th=[  255], 80.00th=[  269], 90.00th=[  289], 95.00th=[  318],
     | 99.00th=[  330], 99.50th=[  334], 99.90th=[  355], 99.95th=[  437],
     | 99.99th=[  529]
   bw (  KiB/s): min=16280, max=17672, per=100.00%, avg=17299.11, stdev=195.37, samples=599
   iops        : min= 4070, max= 4418, avg=4324.78, stdev=48.84, samples=599
  lat (usec)   : 250=66.18%, 500=33.80%, 750=0.02%, 1000=0.01%
  lat (msec)   : 2=0.01%
  cpu          : usr=0.95%, sys=1.44%, ctx=1295670, majf=0, minf=13
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=1295643,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show an average latency of 229 microseconds, where 99.5% of the writes terminated in 334 microseconds or less.

### Testing Write Latency

#### Description

This test measures the minimal achievable write latency under a light load. The test measures the latency over a single-threaded sequence of 4KB writes across multiple files. Each write is executed only after the previous write has been served.

#### Job Definition

{% code title="write_latency.txt" %}
```
[global]
filesize=4G
time_based=1
startdelay=5
exitall_on_error=1
create_serialize=0
filename_format=$jobnum/$filenum/iops.$jobnum.$filenum
directory=/mnt/weka/fio
group_reporting=1
clocksource=gettimeofday
runtime=300
ioengine=posixaio
disk_util=0
iodepth=1

[write_latency]
numjobs=1
bs=4k
rw=randwrite
direct=1
new_group
```
{% endcode %}

#### Example of Test Output

```
write_latency: (groupid=0, jobs=1): err= 0: pid=72709: Wed Jul  8 13:53:33 2020
  write: IOPS=4383, BW=17.1MiB/s (17.0MB/s)(5136MiB/300001msec); 0 zone resets
    slat (nsec): min=0, max=56000, avg=1382.96, stdev=653.78
    clat (usec): min=195, max=9765, avg=226.21, stdev=109.45
     lat (usec): min=197, max=9766, avg=227.59, stdev=109.46
    clat percentiles (usec):
     |  1.00th=[  208],  5.00th=[  212], 10.00th=[  215], 20.00th=[  217],
     | 30.00th=[  219], 40.00th=[  219], 50.00th=[  221], 60.00th=[  223],
     | 70.00th=[  225], 80.00th=[  229], 90.00th=[  233], 95.00th=[  243],
     | 99.00th=[  269], 99.50th=[  293], 99.90th=[  725], 99.95th=[ 2540],
     | 99.99th=[ 6063]
   bw (  KiB/s): min=16680, max=18000, per=100.00%, avg=17555.48, stdev=279.31, samples=599
   iops        : min= 4170, max= 4500, avg=4388.87, stdev=69.83, samples=599
  lat (usec)   : 250=96.27%, 500=3.61%, 750=0.03%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=0.03%, 10=0.03%
  cpu          : usr=0.93%, sys=1.52%, ctx=1315723, majf=0, minf=14
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=0,1314929,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1
```

In this test output example, results show an average latency of 226 microseconds, where 99.5% of the writes terminated in 293 microseconds or less.

### Testing Metadata Performance

#### Description

The test measures the rate of metadata operations (such as create, stat, delete) across the cluster. The test uses 20 million files: it uses 8 client hosts, and multiple threads per client are utilized (136), where each thread handles 18382 files. It is invoked 3 times and provides a summary of the iterations.

#### Job Definition

```
mpiexec -f <hostfile> -np 1088 mdtest -v -N 136 -i 3 -n 18382 -F -u -d /mnt/weka/mdtest
```

#### Example of Test Output

```
SUMMARY rate: (of 3 iterations)
   Operation                      Max            Min           Mean        Std Dev
   ---------                      ---            ---           ----        -------
   File creation     :      40784.448      40784.447      40784.448          0.001
   File stat         :    2352915.997    2352902.666    2352911.311          6.121
   File read         :     217236.252     217236.114     217236.162          0.064
   File removal      :      44101.905      44101.896      44101.902          0.004
   Tree creation     :          3.788          3.097          3.342          0.316
   Tree removal      :          1.192          1.142          1.172          0.022
```

## **Running All Benchmark Tests Together**

If it is preferred to run all the tests sequentially and review the results afterward, follow the instructions below.

### Preparation

From each client, create a mount point in `/mnt/weka` to a Weka filesystem and create there the following directories:

```
# create directories in the weka filesystem
mkdir /mnt/weka/fio
mkdir /mnt/weka/mdtest
```

Copy the `FIOmaster.txt` file to your host and create the `clients.txt` file with your clients' hostnames.

### **Running the Benchmark**

Run the benchmarks using the following commands:

```
# single client
fio FIOmaster.txt

# multiple clients
fio --client=clients.txt FIOmaster.txt

# mdtest
mpiexec -f clients.txt -np 1088 mdtest -v -N 136 -i 3 -n 18382 -F -u -d /mnt/weka/mdtest
```

{% file src="../../.gitbook/assets/FIOmaster (1).txt" %}

