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

The [FIO Utility](https://linux.die.net/man/1/fio) is a generic open source storage performance testing tool which can be defined as described [here](https://github.com/axboe/fio). In this documentation, the usage of FIO version 3.5 is assumed.

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
    --direct=1 --randrepeat=1 '--filename_format=$jobnum/$filenum' --clat_percentiles=1  
    --blocksi ze=4096 --readwrite=randwrite`

#### Example of Test Output

{% hint style="warning" %}
The following is an example of the test output for an AWS Weka cluster of 6 instances of type i3.16xl.
{% endhint %}

![Example of test output for an AWS Weka cluster of 6 instances of type i3.16xl](../.gitbook/assets/example-output3-page-001%20%282%29.jpg)

In this test output example, results show an average latency of 529 microseconds, where 99.5% of the writes terminated in 766 microseconds or less.

{% hint style="info" %}
**Note:** Different hardware and networking configurations may yield different latency results, which can be as low as 150 microseconds for 100 Gbit networking and NVMe drives.
{% endhint %}



