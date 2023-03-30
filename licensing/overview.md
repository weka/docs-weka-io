---
description: This page describes how licensing works in a WEKA cluster.
---

# License overview

A license is a legal instrument governing the usage terms of the WEKA cluster.

The license terms include the following properties:

* Cluster GUID that is created during the installation
* Expiry date (usage period)
* Raw or usable hot-tier (SSD) capacity
* Object store capacity

When a license is applied to a WEKA cluster, the cluster verifies the license validity by comparing the license properties and the actual cluster usage.&#x20;

To start in a newly configured cluster, you must set a valid license. WEKA supports two license types:

* **Classic license:** With this license type, the cost consists of a predetermined period (For example, one year) and the cluster capacity.
* **Pay-As-You-Go (PAYG) license:** With this license type, the cost consists of hourly usage and cluster capacity.



**Related topics**

[classic-licensing.md](classic-licensing.md "mention")

[pay-as-you-go.md](pay-as-you-go.md "mention")

## Display the license status using the GUI

The WEKA cluster license page displays the license properties: license mode, expiry date, raw or usable drives capacity, and object store capacity.

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the Cluster Settings pane, select **License**.

![Weka cluster license status](../.gitbook/assets/wmng\_license.png)

## Display the license status using the CLI

You can display the license status using one of the following commands:

* `weka cluster license`: Displays the license properties.
* `weka status`: Displays the weka status, including the license status and expiry date.
* `weka alerts`: If no license is assigned to the cluster, the command displays a relevant alert.&#x20;

**Example: License status using the `weka cluster license` command**

```
# weka cluster license
Licensing status: Classic
Current usage:
    2374 GB raw drive capacity
    1024 GB usable capacity
    0 GB object-store capacity
Installed license:
    Valid from 2022-06-21T09:22:34Z
    Expires at 2022-07-21T09:22:34Z
    2374 GB raw drive capacity
    0 GB usable capacity
    1000000000000000 GB object-store capacity
```

**Example: Display the license status using the `weka status` command**

```
WekaIO v4.0.1 (CLI build 4.0.1)

...
       license: OK, valid thru 2023-07-19T09:22:34Z
...
```

**Example: License status when the cluster does not have a valid license**

```
# weka status
Weka v4.0.0.1 (CLI build 4.0.1)
...
       license: Unlicensed
...
```

**Example: License status using the `weka alerts` command for a cluster without an assigned license**

```
# weka alerts
...
No License Assigned
This cluster does not have a license assigned, please go to https://get.weka.io to obtain your license
```
