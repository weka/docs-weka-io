---
description: >-
  This section details the specific hardware and software configurations used to
  generate the example performance results.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/performance/testing-weka-system-performance/test-environment-details
---

# Performance test environment configurations

## **AWS configuration**

#### **AWS cluster**

* Stripe Size: 4+2
* 8 backend server instances of [i3en.12xlarge](https://aws.amazon.com/ec2/instance-types/i3en/), placed in the same placement group
* OS: Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* 7 dedicated cores for WEKA (4 compute, 2 drives, 1 frontend)

#### **AWS clients**

* [c5n.18xlarge](https://aws.amazon.com/ec2/instance-types/c5/) instances; 8 clients were used for aggregated results
* OS: Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* 4 frontend cores
* DPDK networking
* Mount options: system defaults

## **SuperMicro configuration**

#### **SuperMicro cluster**

* Stripe Size: 4+2
* 8 backend servers (SYS-2029BT-HNR / X11DPT-B)
* OS: CentOS Linux release 7.8.2003
* CPU: 24/48 Threads (Intel Xeon Gold 6126 CPU @ 2.60GHz)
* Memory: 384 GB
* Drives: 6x Micron 9300 drives
* Network: Dual 100 Gbps Ethernet
* 19 dedicated cores for WEKA (12 compute, 6 drives, 1 frontend)

#### **SuperMicro clients**

* SYS-2029BT-HNR / X11DPT-B servers; 8 clients were used for aggregated results
* OS: CentOS Linux release 7.8.2003
* CPU: 24/48 Threads (Intel Xeon Gold 6126 CPU @ 2.60GHz)
* Memory: 192 GB
* Network: Dual 100 Gbps Ethernet
* 6 frontend cores
* DPDK networking
* Mount options: system defaults
