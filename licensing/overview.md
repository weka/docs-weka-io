---
description: This page describes how licensing works in a WEKA cluster.
---

# License overview

A license is a legal instrument governing the usage terms of the WEKA cluster. When a license is applied to a WEKA cluster, the cluster verifies the license validity by comparing the license properties and the actual cluster usage.

The license terms include the following properties:

* Cluster GUID that is created during the installation
* Expiry date (usage period)
* Raw or usable hot-tier (SSD) capacity
* Object store capacity
* Data Efficiency Option (DEO) license (if provided)

## Display the license status using the GUI

The WEKA cluster license page displays the license properties: license mode, expiry date, raw or usable drive capacity, and object store capacity.

{% hint style="info" %}
The following example shows a classic license mode. The Pay As You Go (PAYG) license is deprecated and is no longer available to new customers.
{% endhint %}

**Procedure**

1. From the menu, select **Configure > Cluster Settings**.
2. From the Cluster Settings pane, select **License**.

![Weka cluster license status](../.gitbook/assets/wmng\_license.png)

## Display the license status using the CLI

You can display the license status using one of the following commands:

* `weka cluster license`: Displays the license properties.
* `weka status`: Displays the weka status, license status, and expiry date.
* `weka alerts`: If no license is assigned to the cluster, the command displays a relevant alert.&#x20;

**Example: License status using the `weka cluster license` command**

```
# weka cluster license
Licensing status: Classic

Current usage:
    1932 GB raw drive capacity
    963 GB usable capacity
    49 GB object-store capacity
    Disabled data reduction

Installed license:
    Valid from 2023-07-01T08:17:24Z
    Expires at 2023-07-31T08:17:24Z
    1932 GB raw drive capacity
    0 GB usable capacity
    1000000000000000 GB object-store capacity
    Enabled data reduction
    
```

**Example: Display the license status using the `weka status` command**

```
WekaIO v4.2.0 (CLI build 4.2.0)

...
       license: OK, valid thru 2023-07-19T09:22:34Z
...
```

**Example: License status when the cluster does not have a valid license**

```
# weka status
Weka v4.2.0 (CLI build 4.2.0)
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
