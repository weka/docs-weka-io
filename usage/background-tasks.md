---
description: >-
  This page describes the management of background tasks running on WekaIO
  clusters.‌
---

# Background Tasks

## Overview

‌The WekaIO system has some internal/external asynchronous operations and maintenance tasks, such as migrating an object store and downloading/uploading snapshots. These tasks are performed in the background and should not interfere nor starve the WekaIO system from serving IOs with high performance.‌

The WekaIO system limit the CPU resources these tasks consume to 5% ****per host CPU.

{% hint style="info" %}
**Note:** When the CPU is idle, background tasks can use more than the configured resources, but they are immediately freed if needed for serving IOs.
{% endhint %}

{% hint style="info" %}
**Note:** The configured limit affects both external tasks \(that are visible using the GUI/CLI\) and internal low priority asynchronous operations.‌
{% endhint %}

## Managing Background Tasks <a id="managing-background-tasks"></a>

### Viewing Running Background Tasks <a id="viewing-running-background-tasks"></a>

It is possible to view currently-running background tasks, including their status and progress.‌

#### Viewing Background Tasks Using the CLI <a id="viewing-background-tasks-using-the-cli"></a>

‌**Command:** `weka cluster tasks`‌

This command is used for viewing all background tasks. For each task, a range of data can be displayed, as shown in the following example:

```text
# weka cluster tasks
Type       | State   | Progress | Description
-----------+---------+----------+-----------------------------------------------------------
OBS_DETACH | RUNNING | 94       | Detaching Object Storage `obs_1` from filesystem `default`
```

‌

###   <a id="limiting-background-task-resources"></a>

