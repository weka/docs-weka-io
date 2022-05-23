---
description: >-
  The page described specific configuration of the performance tests
  environments.
---

# Test environment details

## AWS

### **AWS cluster**&#x20;

* Stripe Size: 4+2
* 8 backend servers instances of [i3en.12xlarge](https://aws.amazon.com/ec2/instance-types/i3en/)
* Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* Backend servers are placed in the same placement group
* 7 dedicated cores for Weka&#x20;
  * 4 compute
  * 2 drives
  * 1 frontend

### AWS clients

* [c5n.18xlarge](https://aws.amazon.com/ec2/instance-types/c5/) instances&#x20;
* For the aggregated results 8 clients have been used
* Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* 4 frontend cores
* DPDK networking
* Mount options: using system defaults

## SuperMicro

### **SuperMicro cluster**&#x20;

* Stripe Size: 4+2
* 8 backend servers (SYS-2029BT-HNR / X11DPT-B), each:
  * **OS**: CentOS Linux release 7.8.2003 (3.10.0-1127.el7.x86\_64)
  * **Memory**: 384 GB Memory
  * **Drives**: 6 Micron 9300 drives (MTFDHAL3T8TDP)
  * **Network**: Dual 100 Gbps Ethernet
  * **Cpu/Threads**: 24/48 (Intel(R) Xeon(R) Gold 6126 CPU @ 2.60GHz)
  * 19 dedicated cores for Weka&#x20;
    * 12 compute
    * 6 drives
    * 1 frontend

### SuperMicro clients

* SYS-2029BT-HNR / X11DPT-B servers
* For the aggregated results 8 clients have been used
* **OS**: CentOS Linux release 7.8.2003 (3.10.0-1127.el7.x86\_64)
* **Memory**: 192 GB Memory
* **Network**: Dual 100 Gbps Ethernet
* **Cpu/Threads**: 24/48 (Intel(R) Xeon(R) Gold 6126 CPU @ 2.60GHz)
* 6 frontend cores
* DPDK networking
* Mount options: using system defaults
