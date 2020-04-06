---
description: >-
  This page describes a series of tests for measuring performance after
  installation of the WEKA system. The same tests can be used to test the
  performance of any other storage solution.
---

# Testing WEKA Performance

## About WEKA Performance Testing

There are 3 main performance metrics when measuring a storage system performance:

1. Latency, which is the time from operation initiation to completion.
2. The number of IO operations that the system can process concurrently.
3. The bandwidth of data that the system can process concurrently.

Each of these performance metrics applies to read operations, write operations or a mixture of read and write operations.

‌When measuring the WEKA system performance, different [mount modes](../overview/weka-client-and-mount-modes.md) produce different performance characteristics. Additionally, client network configuration \(using either user-space DPDK networking or kernel UDP\) also have a significant effect on performance.

{% hint style="info" %}
**Note:** All performance tests listed here are generic and not specific to the WEKA system. They can be used to compare the WEKA storage system to other storage systems or to a local storage device.
{% endhint %}

{% hint style="info" %}
**Note:** There is a difference between single client performance to aggregated performance. When running the tests listed below from one client, the client will limit the performance of the test. In general, several clients will be required to maximize the performance of a WEKA cluster.
{% endhint %}

## The FIO Utility

The [FIO Utility](https://linux.die.net/man/1/fio) is a generic open source storage performance testing tool which can be defined as described [here](https://github.com/axboe/fio). In this documentation, the usage of FIO version 3.5 is assumed.

## WEKA Client Performance Testing

{% hint style="info" %}
**Note:** All performance tests and numbers listed here have been conducted using an AWS WEKA cluster with six [i3.16xlarge ](https://aws.amazon.com/ec2/instance-types/i3/)instances, a single [c5n.18xlarge](https://aws.amazon.com/ec2/instance-types/c5/) client, and using DPDK networking.
{% endhint %}

### Laying Out Files and File Structure for Testing

#### Description

**‌**The following script will count the number of cores \(n\) in the client, create n-2 directories and layout one 10 GB file in each directory. Depending on the number of client cores, this may take a relatively long time since FIO lays out the files sequentially.

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=Create_Files
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
mkdir -p $WORKING_DIR && cd $WORKING_DIR && seq 0 $JOBS | xargs mkdir
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --rw=rw --rwmixread=0 \
     --blocksize=1m --numjobs=$JOBS --create_only=1
```

### Testing Read Throughput

#### Description

**‌**This test measures the client throughput for large \(1 MB\) reads. The scripts below will try to maximize the read throughput from a single client. The test utilizes multiple threads, each one performing 1 MB reads.

{% hint style="info" %}
**Note:** If the client uses a 100 Gbps NIC or above, mounting the WEKA filesystem with more than one core is required to maximize client throughput.
{% endhint %}

{% hint style="info" %}
**Note:** To maximize system throughput, multiple clients are required in most cases..
{% endhint %}

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=FioReads1MMultiThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=100 --blocksize=1m \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 18 processes
Jobs: 18 (f=18): [r(18)][100.0%][r=6562MiB/s,w=0KiB/s][r=6561,w=0 IOPS][eta 00m:00s]
FioReads1MMultiThread: (groupid=0, jobs=18): err= 0: pid=72745: Wed Feb 19 00:21:07 2020
   read: IOPS=6493, BW=6494MiB/s (6809MB/s)(381GiB/60003msec)
    slat (nsec): min=0, max=221000, avg=6072.91, stdev=3963.38
    clat (usec): min=1417, max=30834, avg=2760.42, stdev=490.92
     lat (usec): min=1432, max=30838, avg=2766.49, stdev=490.99
    clat percentiles (usec):
     |  1.00th=[ 2024],  5.00th=[ 2212], 10.00th=[ 2311], 20.00th=[ 2442],
     | 30.00th=[ 2540], 40.00th=[ 2606], 50.00th=[ 2704], 60.00th=[ 2769],
     | 70.00th=[ 2868], 80.00th=[ 2999], 90.00th=[ 3261], 95.00th=[ 3556],
     | 99.00th=[ 4293], 99.50th=[ 4752], 99.90th=[ 5669], 99.95th=[ 6063],
     | 99.99th=[ 9372]
   bw (  KiB/s): min=339968, max=397312, per=5.56%, avg=369433.14, stdev=8626.54, samples=2160
   iops        : min=  332, max=  388, avg=360.75, stdev= 8.42, samples=2160
  lat (msec)   : 2=0.85%, 4=97.30%, 10=1.84%, 20=0.01%, 50=0.01%
  cpu          : usr=0.95%, sys=0.67%, ctx=389923, majf=0, minf=1346
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=389654,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=6494MiB/s (6809MB/s), 6494MiB/s-6494MiB/s (6809MB/s-6809MB/s), io=381GiB (409GB), run=60003-60003msec
```

In this test output example, results show a bandwidth of 6.49 Gigabytes/second from a single client.

### Testing Read IOPS

#### Description

This test measures the ability of the client to deliver concurrent 4 KB reads. The following scripts will try to maximize the system read IOPS from a single client. The test utilizes multiple threads, each one performing 4 KB reads.

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=IOPSRead4KMultiThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=100 --blocksize=4k \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 70 processes
Jobs: 70 (f=70): [r(70)][100.0%][r=632MiB/s,w=0KiB/s][r=162k,w=0 IOPS][eta 00m:00s]
IOPSRead4KMultiThread: (groupid=0, jobs=70): err= 0: pid=73323: Wed Feb 19 00:27:22 2020
   read: IOPS=159k, BW=623MiB/s (653MB/s)(36.5GiB/60003msec)
    slat (nsec): min=0, max=346000, avg=3066.13, stdev=2021.66
    clat (usec): min=64, max=30043, avg=434.83, stdev=110.45
     lat (usec): min=175, max=30046, avg=437.90, stdev=110.51
    clat percentiles (usec):
     |  1.00th=[  289],  5.00th=[  330], 10.00th=[  351], 20.00th=[  375],
     | 30.00th=[  392], 40.00th=[  408], 50.00th=[  424], 60.00th=[  441],
     | 70.00th=[  465], 80.00th=[  494], 90.00th=[  537], 95.00th=[  570],
     | 99.00th=[  635], 99.50th=[  660], 99.90th=[  725], 99.95th=[  766],
     | 99.99th=[ 1565]
   bw (  KiB/s): min= 7512, max=10352, per=1.43%, avg=9113.49, stdev=359.31, samples=8374
   iops        : min= 1878, max= 2588, avg=2278.23, stdev=89.81, samples=8374
  lat (usec)   : 100=0.01%, 250=0.08%, 500=81.20%, 750=18.65%, 1000=0.04%
  lat (msec)   : 2=0.01%, 4=0.01%, 10=0.01%, 20=0.01%, 50=0.01%
  cpu          : usr=1.07%, sys=1.58%, ctx=9571971, majf=0, minf=17361
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=9563534,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=623MiB/s (653MB/s), 623MiB/s-623MiB/s (653MB/s-653MB/s), io=36.5GiB (39.2GB), run=60003-60003msec
```

In this test output example, results show 159,461 IOPS from a single client.

### Testing Read Latency

This test measures the minimal achievable read latency under a light load. The test measures the latency over a single threaded sequence of 4 KB reads across multiple files. Each read is executed only after the previous read has been served.

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=FioReads4KSingleThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=1
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=100 --blocksize=4k \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 1 process
Jobs: 1 (f=1): [r(1)][100.0%][r=18.1MiB/s,w=0KiB/s][r=4624,w=0 IOPS][eta 00m:00s]
FioReads4KSingleThread: (groupid=0, jobs=1): err= 0: pid=73478: Wed Feb 19 00:28:46 2020
   read: IOPS=4583, BW=17.9MiB/s (18.8MB/s)(1074MiB/60001msec)
    slat (nsec): min=0, max=328000, avg=3428.06, stdev=1561.88
    clat (usec): min=163, max=25862, avg=213.65, stdev=84.56
     lat (usec): min=165, max=25866, avg=217.08, stdev=84.62
    clat percentiles (usec):
     |  1.00th=[  176],  5.00th=[  186], 10.00th=[  194], 20.00th=[  200],
     | 30.00th=[  204], 40.00th=[  208], 50.00th=[  212], 60.00th=[  215],
     | 70.00th=[  219], 80.00th=[  223], 90.00th=[  231], 95.00th=[  239],
     | 99.00th=[  285], 99.50th=[  310], 99.90th=[  400], 99.95th=[  799],
     | 99.99th=[ 3097]
   bw (  KiB/s): min=17285, max=19608, per=99.97%, avg=18327.63, stdev=264.11, samples=119
   iops        : min= 4321, max= 4902, avg=4581.82, stdev=66.04, samples=119
  lat (usec)   : 250=97.23%, 500=2.71%, 750=0.01%, 1000=0.02%
  lat (msec)   : 2=0.01%, 4=0.03%, 10=0.01%, 50=0.01%
  cpu          : usr=2.93%, sys=3.27%, ctx=275158, majf=0, minf=341
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=275018,0,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=17.9MiB/s (18.8MB/s), 17.9MiB/s-17.9MiB/s (18.8MB/s-18.8MB/s), io=1074MiB (1126MB), run=60001-60001msec
```

In this test output example, results show an average latency of 213 microseconds, where 99.5% of the writes terminated in 310 microseconds or less.

{% hint style="info" %}
**Note:** Different hardware and networking configurations may yield different latency results, which can be as low as 150 microseconds for 100 Gbit networking and NVMe drives.
{% endhint %}

### Testing Write Throughput

#### Description

This test measures the client throughput for large \(1 MB\) writes. The scripts below will try to maximize the write throughput from a single client. The test utilizes multiple threads, each one performing 1 MB reads.

{% hint style="info" %}
**Note:** If the client uses a 100 Gbps NIC or above, mounting the WEKA filesystem with more than one core is required to maximize client throughput.
{% endhint %}

{% hint style="info" %}
**Note:** To maximize system throughput, multiple clients are required in most cases.
{% endhint %}

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=FioWrite1MMultiThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=0 --blocksize=1m \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 14 processes
Jobs: 14 (f=14): [w(14)][100.0%][r=0KiB/s,w=3488MiB/s][r=0,w=3488 IOPS][eta 00m:00s]
FioWrite1MMultiThread: (groupid=0, jobs=14): err= 0: pid=640: Wed Feb 19 00:33:07 2020
  write: IOPS=3481, BW=3481MiB/s (3650MB/s)(204GiB/60007msec)
    slat (usec): min=12, max=868, avg=53.24, stdev=28.97
    clat (usec): min=1987, max=28643, avg=3961.76, stdev=735.85
     lat (usec): min=2022, max=28701, avg=4015.00, stdev=737.33
    clat percentiles (usec):
     |  1.00th=[ 2900],  5.00th=[ 3228], 10.00th=[ 3359], 20.00th=[ 3556],
     | 30.00th=[ 3687], 40.00th=[ 3818], 50.00th=[ 3916], 60.00th=[ 4015],
     | 70.00th=[ 4113], 80.00th=[ 4293], 90.00th=[ 4490], 95.00th=[ 4752],
     | 99.00th=[ 5735], 99.50th=[ 6456], 99.90th=[14091], 99.95th=[17171],
     | 99.99th=[21627]
   bw (  KiB/s): min=233472, max=270336, per=7.14%, avg=254649.03, stdev=5875.48, samples=1677
   iops        : min=  228, max=  264, avg=248.66, stdev= 5.74, samples=1677
  lat (msec)   : 2=0.01%, 4=58.67%, 10=41.13%, 20=0.18%, 50=0.02%
  cpu          : usr=1.94%, sys=0.31%, ctx=209041, majf=0, minf=8162
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,208902,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=3481MiB/s (3650MB/s), 3481MiB/s-3481MiB/s (3650MB/s-3650MB/s), io=204GiB (219GB), run=60007-60007mse
```

In this test output example, results show a bandwidth of 3.48 Gigabytes/second.

### Testing Write IOPS

#### Description

This test measures the ability of the client to deliver concurrent 4 KB reads. The following scripts try to maximize the system read IOPS from a single client. The test utilizes multiple threads, each one performing 4 KB reads.

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=IOPSWrite4KMultiThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=0 --blocksize=4k \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 70 processes
Jobs: 70 (f=70): [w(70)][100.0%][r=0KiB/s,w=654MiB/s][r=0,w=167k IOPS][eta 00m:00s]
IOPSWrite4KMultiThread: (groupid=0, jobs=70): err= 0: pid=737: Wed Feb 19 00:36:40 2020
  write: IOPS=164k, BW=642MiB/s (674MB/s)(37.6GiB/60003msec)
    slat (nsec): min=0, max=224000, avg=2812.54, stdev=1413.73
    clat (usec): min=171, max=30140, avg=421.73, stdev=220.73
     lat (usec): min=173, max=30142, avg=424.54, stdev=220.76
    clat percentiles (usec):
     |  1.00th=[  281],  5.00th=[  322], 10.00th=[  343], 20.00th=[  363],
     | 30.00th=[  379], 40.00th=[  392], 50.00th=[  404], 60.00th=[  420],
     | 70.00th=[  441], 80.00th=[  465], 90.00th=[  498], 95.00th=[  537],
     | 99.00th=[  766], 99.50th=[ 1020], 99.90th=[ 1303], 99.95th=[ 1729],
     | 99.99th=[11731]
   bw (  KiB/s): min= 7182, max=10336, per=1.43%, avg=9406.65, stdev=228.11, samples=8382
   iops        : min= 1795, max= 2584, avg=2351.36, stdev=56.95, samples=8382
  lat (usec)   : 250=0.25%, 500=89.85%, 750=8.85%, 1000=0.52%
  lat (msec)   : 2=0.49%, 4=0.01%, 10=0.02%, 20=0.01%, 50=0.01%
  cpu          : usr=1.01%, sys=1.42%, ctx=9873571, majf=0, minf=12191
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,9867269,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=642MiB/s (674MB/s), 642MiB/s-642MiB/s (674MB/s-674MB/s), io=37.6GiB (40.4GB), run=60003-60003msec
```

In this test output example, results show 164,595 IOPS from a single client.

### Testing Write Latency

#### Description

This test measures the minimal achievable write latency under a light load. The test measures the latency over a single threaded sequence of 4 KB writes across multiple files. Each write is executed only after the previous write has been served.

#### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export BENCHMARK_ID=FioWrites4KSingleThread
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=1
```

#### Running the Benchmark

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
     --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
     --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
     --time_based=1 --iodepth=1 --rw=randrw --rwmixread=0 --blocksize=4k \
     --numjobs=$JOBS
```

#### Example of Test Output

```text
Starting 1 process
Jobs: 1 (f=1): [w(1)][100.0%][r=0KiB/s,w=17.7MiB/s][r=0,w=4538 IOPS][eta 00m:00s]
IOPSWrite4KMultiThread: (groupid=0, jobs=1): err= 0: pid=908: Wed Feb 19 00:38:31 2020
  write: IOPS=4401, BW=17.2MiB/s (18.0MB/s)(1032MiB/60001msec)
    slat (nsec): min=1000, max=304000, avg=3596.91, stdev=1580.30
    clat (usec): min=170, max=21337, avg=222.54, stdev=238.03
     lat (usec): min=171, max=21347, avg=226.13, stdev=238.05
    clat percentiles (usec):
     |  1.00th=[  186],  5.00th=[  194], 10.00th=[  200], 20.00th=[  204],
     | 30.00th=[  208], 40.00th=[  210], 50.00th=[  212], 60.00th=[  215],
     | 70.00th=[  219], 80.00th=[  223], 90.00th=[  231], 95.00th=[  243],
     | 99.00th=[  285], 99.50th=[  318], 99.90th=[ 3490], 99.95th=[ 6456],
     | 99.99th=[10028]
   bw (  KiB/s): min=15408, max=18704, per=99.94%, avg=17594.27, stdev=678.27, samples=119
   iops        : min= 3852, max= 4676, avg=4398.52, stdev=169.53, samples=119
  lat (usec)   : 250=96.44%, 500=3.38%, 750=0.02%, 1000=0.01%
  lat (msec)   : 2=0.03%, 4=0.03%, 10=0.08%, 20=0.01%, 50=0.01%
  cpu          : usr=3.03%, sys=3.00%, ctx=264216, majf=0, minf=345
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwt: total=0,264078,0, short=0,0,0, dropped=0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: bw=17.2MiB/s (18.0MB/s), 17.2MiB/s-17.2MiB/s (18.0MB/s-18.0MB/s), io=1032MiB (1082MB), run=60001-60001msec
```

In this test output example, results show an average latency of 224 microseconds, where 99.5% of the writes terminated in 318 microseconds or less.

{% hint style="info" %}
**Note:** Different hardware and networking configurations may yield different latency results, which can be as low as 150 microseconds for 100 Gbit networking and NVMe drives.
{% endhint %}

## **Running All Benchmark Tests Together**

If it is preferred to run all the tests sequentially and review the results afterwards, follow the instructions below.

### Preparation

```text
export WEKA_MOUNT=/mnt/weka
export WEKA_CLIENT=`/bin/hostname`
export WORKING_DIR=$WEKA_MOUNT/$WEKA_CLIENT/
export JOBS=$((`lscpu | grep ^"CPU(s)" | awk '{print $2}'` - 2))
mkdir -p $WORKING_DIR && cd $WORKING_DIR && seq 0 $JOBS | xargs mkdir
```

### **Running the Benchmark**

Copy the FIOmaster file to your host and run the benchmark using the the following command:

```text
DIRECTORY=$WORKING_DIR fio FIOmaster --output=FIOmaster.out
```

{% file src="../.gitbook/assets/fiomaster.txt" caption="FIOmaster" %}

