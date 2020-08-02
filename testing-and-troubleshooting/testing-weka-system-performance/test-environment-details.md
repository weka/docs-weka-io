---
description: >-
  The page described specific configuration of the performance tests
  environments.
---

# Test Environment Details

## AWS

### **AWS Cluster** 

* Stripe Size: 4+2
* 8 backend servers instances of [i3en.12xlarge](https://aws.amazon.com/ec2/instance-types/i3en/)
* Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* 7 dedicated cores for Weka 
  * 4 compute
  * 2 drives
  * 1 frontend

### AWS Clients

* [c5n.18xlarge](https://aws.amazon.com/ec2/instance-types/c5/) instances 
* For the aggregated results 8 clients have been used
* Amazon Linux AMI 2017.09.0.20170930 x86\_64 HVM
* 4 frontend cores
* DPDK networking
* Mount options: using system defaults

