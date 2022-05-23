---
description: >-
  This page describes the management of background tasks running on Weka
  clusters.‌
---

# Background tasks

‌The Weka system has some internal/external asynchronous operations and maintenance tasks, such as migrating an object store and downloading/uploading snapshots. These tasks are performed in the background and should not interfere nor starve the Weka system from serving IOs with high performance.‌

The Weka system limits the CPU resources these tasks consume to 5% per host CPU.

{% hint style="info" %}
**Note:** When the CPU is idle, background tasks can use more than the configured resources, but they are immediately freed if needed for serving IOs.
{% endhint %}

{% hint style="info" %}
**Note:** The configured limit affects both external tasks (that are visible using the GUI/CLI) and internal low priority asynchronous operations.‌
{% endhint %}

## Manage background tasks <a href="#managing-background-tasks" id="managing-background-tasks"></a>

### View running background tasks <a href="#viewing-running-background-tasks" id="viewing-running-background-tasks"></a>

It is possible to view currently-running background tasks, including their status and progress.‌

#### Viewing background tasks using the CLI <a href="#viewing-background-tasks-using-the-cli" id="viewing-background-tasks-using-the-cli"></a>

‌**Command:** `weka cluster tasks`‌

This command is used for viewing all background tasks. For each task, a range of data can be displayed, as shown in the following example:

```
# weka cluster tasks
Type       | State   | Progress | Description
-----------+---------+----------+-----------------------------------------------------------
OBS_DETACH | RUNNING | 94       | Detaching Object Storage `obs_1` from filesystem `default`
```

### ‌Limit background task resources

It is possible to limit the resources being used by background tasks.

#### **Limit background tasks using the CLI**

**Command:** `weka cluster tasks limits`

This command is used to view the defined limits.

**Command:** `weka cluster tasks limits set [--cpu-limit cpu-limit]`

This command is used to update the CPU limit.

### Pause/Resume/Abort a background task

It is possible to pause and later resume a background task, as well as completely abort it. This is useful in case there are other tasks/activities that are of higher priority.

#### **Pause/Resume/Abort a background task using the CLI**

**Command:** `weka cluster tasks pause / resume / abort <task-id>`

This command is used to pause/resume/abort the running of a specific task.

{% hint style="info" %}
**Note:** Up to 16 background tasks can run in parallel. A paused (or aborting) task still consumes one of these spots.
{% endhint %}
