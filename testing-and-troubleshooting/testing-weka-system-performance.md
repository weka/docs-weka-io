---
description: >-
  This page describes a series of tests for measuring performance after
  installation of the WekaIO system. The same tests can be used to test the
  performance of any other storage solution.
---

# Testing WekaIO Performance

## About WekaIO Performance Testing

There are 3 main performance metrics when measuring a storage system performance:

1. Latency, which is the time from operation initiation to completion.
2. The number of IO operations that the system can process concurrently.
3. The bandwidth of data that the system can process concurrently.

Each of these performance metrics applies to read operations, write operations or a mixture of read and write operations.

‌When measuring the WekaIO system performance, different [mount modes](../overview/weka-client-and-mount-modes.md) produce different performance characteristics. Additionally, client network configuration \(using either space networking or kernel UDP\) also have a significant effect on performance.

{% hint style="info" %}
**Note:** All performance tests listed here are generic and not specific to the WekaIO system. They can be used to compare the WekaIO storage system to other storage systems or to a local storage device.
{% endhint %}

{% hint style="info" %}
**Note:** There is a difference between single client performance to aggregated performance. When running the tests listed below from one client, the client will limit the performance of the test. In general, several clients will be required to maximize the performance of a WekaIO cluster.
{% endhint %}

## The FIO Utility

The [FIO Utility](https://linux.die.net/man/1/fio) is a generic open source storage performance testing tool which can be defined as described [here](https://github.com/axboe/fio). In this documentation, the usage of FIO version 3.5 is assumed.

## WekaIO Client Performance Testing

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
**Note:** If the client uses a 100 Gbps NIC or above, mounting the WekaIO filesystem with more than one core is required to maximize client throughput.
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

![](../.gitbook/assets/bandwidth-reads.jpg)

In this test output example, results show a bandwidth of 2.8 Gigabytes/second.

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

{% hint style="info" %}
**Note:** To maximize system throughput, multiple clients are required in most cases..
{% endhint %}

```text
fio --name=$BENCHMARK_ID --clocksource=gettimeofday --group_reporting \
	 --directory=$WORKING_DIR --ioengine=posixaio --direct=1 \
	 --filename_format='$jobnum/FIOfile' --size=10GB --runtime=60 \
	 --time_based=1 --iodepth=1 --rw=randrw --rwmixread=100 --blocksize=4k \
	 --numjobs=$JOBS
```

#### Example of Test Output

![](../.gitbook/assets/iops-reads.jpg)

In this test output example, results show an average IOPS of 127,402.

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

{% hint style="info" %}
The following is an example of the test output for an AWS WekaIO cluster with 6 instances, type i3.16xlarge.
{% endhint %}

![](../.gitbook/assets/4k-latency-reads.jpg)

In this test output example, results show an average latency of 224 microseconds, where 99.5% of the writes terminated in 338 microseconds or less.

{% hint style="info" %}
**Note:** Different hardware and networking configurations may yield different latency results, which can be as low as 150 microseconds for 100 Gbit networking and NVMe drives.
{% endhint %}

### Testing Write Throughput

#### Description

This test measures the client throughput for large \(1 MB\) writes. The scripts below will try to maximize the write throughput from a single client. The test utilizes multiple threads, each one performing 1 MB reads.

{% hint style="info" %}
**Note:** If the client uses a 100 Gbps NIC or above, mounting the WekaIO filesystem with more than one core is required to maximize client throughput.
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

![](../.gitbook/assets/large-bandwidth-write-test-output-page-final.jpg)

In this test output example, results show a bandwidth of 2.8 Gigabytes/second.

### Testing Write IOPS

#### Description

This test measures the ability of the client to deliver concurrent 4 KB reads. The following scripts try to maximize the system read IOPS from a single client. The test utilizes multiple threads, each one performing 4 KB reads.

{% hint style="info" %}
**Note:** To maximize system throughput, multiple clients are required in most cases.
{% endhint %}

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

![](../.gitbook/assets/iops-write-test-output-page-001-1-_final-2%20%281%29.jpg)

In this test output example, results show an average IOPS of 127,402.

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

{% hint style="info" %}
The following is an example of the test output for an AWS WekaIO cluster with 6 instances, type i3.16xlarge.
{% endhint %}

![](../.gitbook/assets/4k-latency-write.jpg)

In this test output example, results show an average latency of 529 microseconds, where 99.5% of the writes terminated in 766 microseconds or less.

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

