---
description: >-
  This page describes a series of tests for measuring performance after
  installation of the Weka system.
---

# Testing Weka System Performance

## About Weka System Performance Testing

There are 3 main performance metrics when measuring a storage system performance:

1. Latency, which is the time from operation initiation to completion.
2. The number of IO operations that the system can process concurrently.
3. The bandwidth of data that the system can process concurrently.

Each of these performance metrics apply to read operations, write operations or a mixture of read and write operations.

When measuring the Weka system performance, different [mount modes](../overview/weka-client-and-mount-modes.md) produce different performance characteristics. Additionally, client network configuration \(using either space networking or kernel UDP\) also have a significant effect on performance.

{% hint style="info" %}
**Note:** All performance tests listed here are generic and not specific to the Weka system. They can be used to compare the Weka storage system to other storage systems or to a local storage device.
{% endhint %}

## The FIO Utility

The FIO Utility \([https://linux.die.net/man/1/fio](https://linux.die.net/man/1/fio) , [https://github.com/axboe/fio](https://github.com/axboe/fio)\) is a generic open source storage performance testing tool. In this documentation, the usage of FIO version TBD is assumed.

## Weka System Performance Testing

### Small Write Latency Test

#### Description

This test measures the minimal achievable write latency under a light load. The test measures the latency over a single threaded sequence of 4 KB writes across multiple files. Each write is executed only after the previous write has been acknowledged.

#### Preparation

`export WEKA_MOUNT=/mnt/weka  
export BENCHMARK_ID=FioWrites4KSingleThread  
export WORKING_DIR=$WEKA_MOUNT/$BENCHMARK_ID  
mkdir -p $WORKING_DIR`

#### Run Benchmark

`fio --name=$BENCHMARK_ID --directory=$WORKING_DIR --filesize=104857600   
    --group_reporting --numjobs=1 --ioengine=posixaio --nrfiles=32 --invalidate=0   
    --iodepth=1 --max-jobs=1 --rwmixread=0 --create_serialize=0 --runtime=70 --time_based  
     --direct=1`

`--randrepeat=1 '--filename_format=$jobnum/$filenum' --clat_percentiles=1 --blocksi`

`ze=4096 --readwrite=randwrite`

#### Example of Test Output

`FioWrites4KSingleThread: Laying out IO files (32 files / total 3200MiB)`

`Jobs: 1 (f=32): [w(1)][100.0%][r=0KiB/s,w=7547KiB/s][r=0,w=1886 IOPS][eta 00m:00s]`

`FioWrites4KSingleThread: (groupid=0, jobs=1): err= 0: pid=34320: Sun Jun 24 13:25:43 2018`

  `write: IOPS=1879, BW=7518KiB/s (7698kB/s)(514MiB/70001msec)`

    `slat (nsec): min=712, max=55571, avg=2141.28, stdev=676.96`

    `clat (usec): min=408, max=3428,` **`avg=529.00`**`, stdev=60.83`

     `lat (usec): min=410, max=3429, avg=531.15, stdev=60.82`

    `clat percentiles (usec):`

     `|  1.00th=[  437],  5.00th=[  461], 10.00th=[  474], 20.00th=[  490],`

     `| 30.00th=[  502], 40.00th=[  515], 50.00th=[  529], 60.00th=[  537],`

     `| 70.00th=[  545], 80.00th=[  562], 90.00th=[  578], 95.00th=[  603],`

     `| 99.00th=[  717],` _**`99.50th=[  766]`**_`, 99.90th=[ 1020], 99.95th=[ 1500],`

     `| 99.99th=[ 2089]`

   `bw (  KiB/s): min= 5327, max= 7904, per=100.00%, avg=7595.96, stdev=249.71, samples=139`

   `iops        : min= 1331, max= 1976, avg=1898.73, stdev=62.42, samples=139`

  `lat (usec)   : 500=30.18%, 750=69.17%, 1000=0.55%`

  `lat (msec)   : 2=0.09%, 4=0.01%`

  `cpu          : usr=0.43%, sys=0.78%, ctx=131626, majf=0, minf=15`

  `IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%`

     `submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%`

     `complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%`

     `issued rwts: total=0,131562,0,0 short=0,0,0,0 dropped=0,0,0,0`

     `latency   : target=0, window=0, percentile=100.00%, depth=1`

`Run status group 0 (all jobs):`

  `WRITE: bw=7518KiB/s (7698kB/s), 7518KiB/s-7518KiB/s (7698kB/s-7698kB/s), io=514MiB (539MB), run=70001-70001msec`

In this test output example, an AWS Weka cluster of 6 instances of type i3.16xl was tested. Results showed an average latency of 529 microseconds, where 99.9% of the writes terminated in 766 microseconds or less.

{% hint style="info" %}
**Note:** Different hardware and networking configurations may yield different latency results, which can be as low as 150 microseconds for 100 Gbit networking and NVMe drives.
{% endhint %}



