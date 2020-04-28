---
description: This page describes how licensing works in a Weka system cluster.
---

# Overview

## License Metrics

A Weka system license measures usage at the cluster level and contains the following properties:

1. Cluster GUID \(created at the time of installation\)
2. Expiry date
3. Raw hot-tier \(SSD\) capacity
4. Object store capacity

When applied, the cluster verifies that the license is valid by comparing these properties and actual cluster usage.

## Cluster Licensing Status

To view the cluster licensing status, run the `weka status` command:

```text
# weka status
WEKA v3.1.7.2 (CLI build 2.5.3)
...
       license: OK, valid thru 2018-07-31T07:14:05Z
...
```

In the example status above, it is possible to see that the cluster has a valid license which is due to expire on July 31st 2018. If the cluster does not have a valid license, the licensing status will appear as follows:

```text
# weka status
WEKA v3.1.7.2 (CLI build 2.5.3)
...
       license: Unlicensed
...
```

The system includes cluster alerts which also indicate if the cluster does not have an assigned license. Cluster alerts can be viewed by running the `weka alerts` command:

```text
# weka alerts
...
No License Assigned
This cluster does not have a license assigned, please go to https://get.weka.io to obtain your license
```

## Obtaining a License

There are two ways to obtain a license for your cluster:

1. **Classic Licensing:** In this method, payment is for a predetermined period of time, e.g., 1 year. See [Classic Licensing ](classic-licensing.md)for information more about this method.
2. **Pay-As-You-Go \(PAYG\) Licensing:** In this method, payment is according to hourly usage.  See [Pay As You Go](pay-as-you-go.md) for more information about this method.

