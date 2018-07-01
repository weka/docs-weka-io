---
description: This page describes how licensing works in a WekaIO cluster
---

# Overview

## License Metrics

A WekaIO license measures your usage at the cluster level and contains the following properties:

1. Cluster GUID \(created at the time of installation\)
2. Expiry date
3. Raw hot-tier \(SSD\) capacity
4. Object store capacity

When applied, the cluster verifies that the license is valid by comparing  the properties above and the actual usage of your cluster.

## Cluster Licensing Status

To see your cluster licensing status, run the `weka status` command:

```text
# weka status
WekaIO v3.1.7.2 (CLI build 2.5.3)
...
       license: OK, valid thru 2018-07-31T07:14:05Z
...
```

In this case we can see that the cluster has a valid license which expires at July 31st 2018.

When the cluster doesn't have a license, you will see the licensing status as:

```text
# weka status
WekaIO v3.1.7.2 (CLI build 2.5.3)
...
       license: Unlicensed
...
```

In addition, an alert would indicate that your cluster doesn't have an assigned license. You can see the cluster alerts by running the `weka alerts` command:

```text
# weka alerts
...
No License Assigned
This cluster does not have a license assigned, please go to https://get.weka.io to obtain your license
```

## Getting a License

There are two ways to get a license for your cluster:

1. Classic licensing: In this method you are paying for a predetermined amount of time \(e.g. one year\). See [the Classic Licensing page](classic-licensing.md) for learn more about this method.
2. Pay-as-you-go \(PAYG\) licensing: In this method you are paying for your usage by the hour. See [the Pay As You Go page](pay-as-you-go.md) to learn more about this method.



